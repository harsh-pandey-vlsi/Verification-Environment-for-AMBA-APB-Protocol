class apb_transaction;

   rand bit write;

   rand bit [7:0] addr;

   rand bit [31:0] data;

   bit [31:0] rdata;

   bit error;

   constraint addr_c
   {
     addr inside {[0:255]};
   }

   function void display();

      $display("WRITE=%0d ADDR=%0h DATA=%0h",
                write,
                addr,
                data);

   endfunction

endclass



   endtask

endclass
