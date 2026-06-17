interface apb_if(input logic pclk, input logic presetn);
    logic [31:0] paddr;
    logic        psel;
    logic        penable;
    logic        pwrite;
    logic [31:0] pwdata;
    logic        pready;
    logic        pslverr;
    logic [31:0] prdata;
endinterface

class apb_transaction;
    rand bit [31:0] paddr;
    rand bit [31:0] pwdata;
    rand bit        pwrite;
    
    bit [31:0] prdata;
    bit        pslverr;

    constraint addr_c {
        paddr dist { [0:31] :/ 80, [32:100] :/ 20 }; 
    }

    function void display(string name);
        $display("[%s] Addr: %0d, Write: %0b, WData: %0h, RData: %0h, SlvErr: %0b", 
                 name, paddr, pwrite, pwdata, prdata, pslverr);
    endfunction
endclass

class generator;
    mailbox #(apb_transaction) gen2drv;
    int num_transactions = 20;

    function new(mailbox #(apb_transaction) gen2drv);
        this.gen2drv = gen2drv;
    endfunction

    task run();
        apb_transaction tr;
        
        tr = new();
        tr.paddr = 4; tr.pwrite = 1; tr.pwdata = 32'hAAAA_BBBB;
        gen2drv.put(tr);
        
        tr = new();
        tr.paddr = 4; tr.pwrite = 0;
        gen2drv.put(tr);

        for (int i = 0; i < num_transactions; i++) begin
            tr = new();
            if (!tr.randomize()) $fatal(1, "Randomization failed!");
            gen2drv.put(tr);
        end
    endtask
endclass

class driver;
    virtual apb_if vif;
    mailbox #(apb_transaction) gen2drv;

    function new(virtual apb_if vif, mailbox #(apb_transaction) gen2drv);
        this.vif = vif;
        this.gen2drv = gen2drv;
    endfunction

    task run();
        vif.psel <= 0;
        vif.penable <= 0;
        vif.pwrite <= 0;
        vif.paddr <= 0;
        vif.pwdata <= 0;

        wait(vif.presetn == 1); 

        forever begin
            apb_transaction tr;
            gen2drv.get(tr);
            
            @(posedge vif.pclk);
            vif.psel    <= 1;
            vif.penable <= 0;
            vif.paddr   <= tr.paddr;
            vif.pwrite  <= tr.pwrite;
            if (tr.pwrite) vif.pwdata <= tr.pwdata;

            @(posedge vif.pclk);
            vif.penable <= 1;

            do begin
                @(posedge vif.pclk);
            end while (vif.pready !== 1);

            vif.psel    <= 0;
            vif.penable <= 0;
        end
    endtask
endclass

class monitor;
    virtual apb_if vif;
    mailbox #(apb_transaction) mon2scb;

    function new(virtual apb_if vif, mailbox #(apb_transaction) mon2scb);
        this.vif = vif;
        this.mon2scb = mon2scb;
    endfunction

    task run();
        forever begin
            @(posedge vif.pclk);
            if (vif.psel && vif.penable && vif.pready) begin
                apb_transaction tr = new();
                tr.paddr   = vif.paddr;
                tr.pwrite  = vif.pwrite;
                tr.pwdata  = vif.pwdata;
                tr.prdata  = vif.prdata;
                tr.pslverr = vif.pslverr;
                mon2scb.put(tr);
            end
        end
    endtask
endclass

class scoreboard;
    mailbox #(apb_transaction) mon2scb;
    bit [31:0] ref_mem [32];
    
    int trans_count = 0; 

    function new(mailbox #(apb_transaction) mon2scb);
        this.mon2scb = mon2scb;
        foreach(ref_mem[i]) ref_mem[i] = 0; 
    endfunction

    task run();
        forever begin
            apb_transaction tr;
            mon2scb.get(tr);

            if (tr.paddr < 32) begin
                if (tr.pslverr !== 0) 
                    $error("[SCB FAIL] pslverr asserted on VALID address %0d", tr.paddr);

                if (tr.pwrite) begin
                    ref_mem[tr.paddr] = tr.pwdata;
                    $display("[SCB PASS] Wrote %0h to Address %0d", tr.pwdata, tr.paddr);
                end else begin
                    if (tr.prdata === ref_mem[tr.paddr])
                        $display("[SCB PASS] Read %0h from Address %0d MATCHES!", tr.prdata, tr.paddr);
                    else
                        $error("[SCB FAIL] Read Addr %0d. Expected: %0h, Got: %0h", tr.paddr, ref_mem[tr.paddr], tr.prdata);
                end
            end else begin
                if (tr.pslverr === 1 && tr.prdata === 32'hDEAD_BEEF)
                    $display("[SCB PASS] Out of bounds correctly flagged! Addr: %0d, pslverr: 1, prdata: DEAD_BEEF", tr.paddr);
                else
                    $error("[SCB FAIL] Out of bounds logic failed! Addr: %0d, pslverr: %0b, prdata: %0h", tr.paddr, tr.pslverr, tr.prdata);
            end
            
            trans_count++; 
        end
    endtask
endclass

class environment;
    generator  gen;
    driver     drv;
    monitor    mon;
    scoreboard scb;

    mailbox #(apb_transaction) gen2drv;
    mailbox #(apb_transaction) mon2scb;
    virtual apb_if vif;

    function new(virtual apb_if vif);
        this.vif = vif;
        gen2drv = new();
        mon2scb = new();

        gen = new(gen2drv);
        drv = new(vif, gen2drv);
        mon = new(vif, mon2scb);
        scb = new(mon2scb);
    endfunction

    task run();
        fork
            gen.run();
            drv.run();
            mon.run();
            scb.run();
        join_none
        
        wait(scb.trans_count == (gen.num_transactions + 2));
    endtask
endclass

module testbench;
    logic pclk;
    logic presetn;

    initial begin
        pclk = 0;
        forever #5 pclk = ~pclk; 
    end

    initial begin
        presetn = 0;
        #20 presetn = 1;
    end

    apb_if vif(pclk, presetn);

    apb_slave dut (
        .pclk(vif.pclk),
        .presetn(vif.presetn),
        .paddr(vif.paddr),
        .psel(vif.psel),
        .penable(vif.penable),
        .pwrite(vif.pwrite),
        .pwdata(vif.pwdata),
        .pready(vif.pready),
        .pslverr(vif.pslverr),
        .prdata(vif.prdata)
    );

    initial begin
        environment env;
        env = new(vif);
        
        $display("==================================================");
        $display("   STARTING APB SLAVE VERIFICATION   ");
        $display("==================================================");
        
        env.run();
        
        #50;
        
        $display("==================================================");
        $display("   TESTBENCH COMPLETE   ");
        $display("==================================================");
        $finish;
    end
endmodule