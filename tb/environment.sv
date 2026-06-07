class apb_env;

   apb_generator gen;

   apb_driver drv;

   apb_monitor mon;

   apb_scoreboard sb;

   apb_coverage cov;

   mailbox #(apb_transaction) gen2drv;

   mailbox #(apb_transaction) mon2sb;

   function new(
      virtual apb_if vif
   );

      gen2drv = new();

      mon2sb = new();

      gen = new(gen2drv);

      drv = new(vif,gen2drv);

      mon = new(vif,mon2sb);

      sb  = new(mon2sb);

      cov = new(vif);

   endfunction

   task run();

      fork

         gen.run();

         drv.run();

         mon.run();

         sb.run();

      join_none

   endtask
  
  task report();

   sb.report();

   cov.report();

  endtask

endclass
