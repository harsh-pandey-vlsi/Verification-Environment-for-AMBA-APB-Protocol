class apb_generator;

   mailbox #(apb_transaction) gen2drv;

   int num_trans = 150;

   function new(mailbox #(apb_transaction) mb);

      gen2drv = mb;

   endfunction

   task run();

      apb_transaction tr;

      repeat(num_trans)
      begin

         tr = new();

         assert(tr.randomize());

         gen2drv.put(tr);

      end
