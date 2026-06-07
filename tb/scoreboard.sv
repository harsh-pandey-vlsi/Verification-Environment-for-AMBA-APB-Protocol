class apb_scoreboard;

   mailbox #(apb_transaction) mon2sb;

  bit [31:0] ref_mem[256];

   int total_checks;
   int pass_count;
   int fail_count;

   function new(mailbox #(apb_transaction) mb);

      mon2sb = mb;

      total_checks = 0;
      pass_count   = 0;
      fail_count   = 0;

   endfunction

   task run();

      apb_transaction tr;

      forever begin

         mon2sb.get(tr);

         if(tr.write) begin

            ref_mem[tr.addr] = tr.data;

            $display("[SB] WRITE ADDR=%0h DATA=%0h",
                     tr.addr,
                     tr.data);

         end
         else begin

            total_checks++;

            if(tr.rdata === ref_mem[tr.addr]) begin

               pass_count++;

               $display(
               "[SB PASS] ADDR=%0h EXP=%0h GOT=%0h",
               tr.addr,
               ref_mem[tr.addr],
               tr.rdata);

            end
            else begin

               fail_count++;

               $error(
               "[SB FAIL] ADDR=%0h EXP=%0h GOT=%0h",
               tr.addr,
               ref_mem[tr.addr],
               tr.rdata);

            end

         end

      end

   endtask

   function void report();

      $display("\n================================");
      $display("      SCOREBOARD REPORT");
      $display("================================");
      $display("TOTAL CHECKS : %0d", total_checks);
      $display("PASS COUNT   : %0d", pass_count);
      $display("FAIL COUNT   : %0d", fail_count);
      $display("================================\n");

   endfunction

endclass

