class apb_driver;

   virtual apb_if vif;

   mailbox #(apb_transaction) gen2drv;

   function new(
      virtual apb_if vif,
      mailbox #(apb_transaction) mb
   );

      this.vif = vif;
      gen2drv  = mb;

   endfunction

   task run();

      apb_transaction tr;

      forever
      begin

         gen2drv.get(tr);

         drive_transfer(tr);

      end

   endtask

   task drive_transfer(
      apb_transaction tr
   );

      @(posedge vif.PCLK);

      vif.addr  <= tr.addr;
      vif.wdata <= tr.data;
      vif.write <= tr.write;

      vif.start <= 1;

      @(posedge vif.PCLK);

      vif.start <= 0;

      wait(vif.done);

   endtask

endclass
