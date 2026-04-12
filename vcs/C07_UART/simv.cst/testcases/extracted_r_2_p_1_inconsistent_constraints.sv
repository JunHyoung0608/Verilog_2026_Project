class c_2_1;
    bit[7:0] data = 8'h1;
    rand bit[7:0] rand_data; // rand_mode = ON 

    constraint c_addr_this    // (constraint_mode = ON) (./tb/uart_seq_item.sv:23)
    {
       ((rand_data % 128) == 0);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (./tb/uart_sequence.sv:22)
    {
       (rand_data == data);
    }
endclass

program p_2_1;
    c_2_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00x0x0zxzxzxxxx0zzzz0x110x0xxzz1xxxxxzzzxzxxzxzzxzzxzxzzxxzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
