module top_tb;

   logic PCLK;

   always #5 PCLK = ~PCLK;

   apb_if apb_vif(PCLK);

   apb_top dut(

   .PCLK(apb_vif.PCLK),
   .PRESETn(apb_vif.PRESETn),

   .start(apb_vif.start),
   .write(apb_vif.write),

   .addr(apb_vif.addr),
   .wdata(apb_vif.wdata),

   .rdata(apb_vif.rdata),
   .done(apb_vif.done),
   .error(apb_vif.error),

   .PSEL(apb_vif.PSEL),
   .PENABLE(apb_vif.PENABLE),
   .PWRITE(apb_vif.PWRITE),

   .PADDR(apb_vif.PADDR),
   .PWDATA(apb_vif.PWDATA),

   .PRDATA(apb_vif.PRDATA),

   .PREADY(apb_vif.PREADY),
   .PSLVERR(apb_vif.PSLVERR)
);
   apb_assertions sva(apb_vif);

   apb_env env;

   initial
   begin

      PCLK = 0;

      apb_vif.PRESETn = 0;

      repeat(5)
      @(posedge PCLK);

      apb_vif.PRESETn = 1;

      env = new(apb_vif);

      env.run();

      #5000;
     
     env.report();

      $display("TEST PASSED");

      $finish;

   end

endmodule
  
