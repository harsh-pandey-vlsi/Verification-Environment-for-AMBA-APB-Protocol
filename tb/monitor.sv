class apb_monitor;

   virtual apb_if vif;

   mailbox #(apb_transaction) mon2sb;

   function new(
      virtual apb_if vif,
      mailbox #(apb_transaction) mb
   );

      this.vif = vif;
      mon2sb = mb;

   endfunction

   task run();

      apb_transaction tr;

      forever
      begin

         @(posedge vif.PCLK);

         if(vif.PSEL &&
            vif.PENABLE &&
            vif.PREADY)
         begin

            tr = new();

            tr.write = vif.PWRITE;

            tr.addr = vif.PADDR;

            tr.data = vif.PWDATA;

            tr.rdata = vif.PRDATA;

            tr.error = vif.PSLVERR;

            mon2sb.put(tr);

         end

      end

   endtask

endclass
