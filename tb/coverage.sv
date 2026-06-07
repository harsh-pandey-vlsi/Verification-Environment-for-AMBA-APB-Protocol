class apb_coverage;

   virtual apb_if vif;

   covergroup apb_cg @(posedge vif.PCLK);

      cp_write :
      coverpoint vif.PWRITE
      {
         bins read  = {0};
         bins write = {1};
      }

      cp_addr :
      coverpoint vif.PADDR
      {
         bins low  = {[0:63]};
         bins mid  = {[64:127]};
         bins high = {[128:255]};
      }

      cp_error :
      coverpoint vif.PSLVERR
      {
         bins no_error = {0};
         bins error    = {1};
      }

      cross cp_write,
            cp_addr;

   endgroup
  

   function new(virtual apb_if vif);

      this.vif = vif;

      apb_cg = new();

   endfunction

   function void report();

      real cov;

      cov = apb_cg.get_inst_coverage();
     

      $display("\n================================");
      $display(" FUNCTIONAL COVERAGE REPORT");
      $display("================================");
      $display("Coverage = %0.2f %%", cov);
      $display("================================\n");

   endfunction

endclass
