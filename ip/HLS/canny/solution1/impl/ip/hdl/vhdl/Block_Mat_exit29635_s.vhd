-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC
-- Version: 2017.4
-- Copyright (C) 1986-2017 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Block_Mat_exit29635_s is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_continue : IN STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    rows_V : IN STD_LOGIC_VECTOR (31 downto 0);
    cols_V : IN STD_LOGIC_VECTOR (31 downto 0);
    col_packets_out_out_din : OUT STD_LOGIC_VECTOR (8 downto 0);
    col_packets_out_out_full_n : IN STD_LOGIC;
    col_packets_out_out_write : OUT STD_LOGIC;
    col_packets_cast_out_out_din : OUT STD_LOGIC_VECTOR (8 downto 0);
    col_packets_cast_out_out_full_n : IN STD_LOGIC;
    col_packets_cast_out_out_write : OUT STD_LOGIC;
    ap_return : OUT STD_LOGIC_VECTOR (19 downto 0) );
end;


architecture behav of Block_Mat_exit29635_s is 
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_ST_fsm_state2 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_ST_fsm_state3 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";
    constant ap_const_lv32_A : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001010";
    constant ap_const_lv20_0 : STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;

    signal ap_done_reg : STD_LOGIC := '0';
    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal col_packets_out_out_blk_n : STD_LOGIC;
    signal col_packets_cast_out_out_blk_n : STD_LOGIC;
    signal ap_block_state1 : BOOLEAN;
    signal col_packets_fu_76_p4 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_fu_96_p0 : STD_LOGIC_VECTOR (8 downto 0);
    signal grp_fu_96_p1 : STD_LOGIC_VECTOR (19 downto 0);
    signal grp_fu_96_p2 : STD_LOGIC_VECTOR (19 downto 0);
    signal grp_fu_96_ce : STD_LOGIC;
    signal ap_CS_fsm_state3 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state3 : signal is "none";
    signal ap_return_preg : STD_LOGIC_VECTOR (19 downto 0) := "00000000000000000000";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal grp_fu_96_p00 : STD_LOGIC_VECTOR (19 downto 0);

    component canny_edge_mul_mubkb IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        din0 : IN STD_LOGIC_VECTOR (8 downto 0);
        din1 : IN STD_LOGIC_VECTOR (19 downto 0);
        ce : IN STD_LOGIC;
        dout : OUT STD_LOGIC_VECTOR (19 downto 0) );
    end component;



begin
    canny_edge_mul_mubkb_U1 : component canny_edge_mul_mubkb
    generic map (
        ID => 1,
        NUM_STAGE => 3,
        din0_WIDTH => 9,
        din1_WIDTH => 20,
        dout_WIDTH => 20)
    port map (
        clk => ap_clk,
        reset => ap_rst,
        din0 => grp_fu_96_p0,
        din1 => grp_fu_96_p1,
        ce => grp_fu_96_ce,
        dout => grp_fu_96_p2);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_done_reg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_done_reg <= ap_const_logic_0;
            else
                if ((ap_continue = ap_const_logic_1)) then 
                    ap_done_reg <= ap_const_logic_0;
                elsif ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    ap_done_reg <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_return_preg_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_return_preg <= ap_const_lv20_0;
            else
                if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
                    ap_return_preg <= grp_fu_96_p2;
                end if; 
            end if;
        end if;
    end process;


    ap_NS_fsm_assign_proc : process (ap_start, ap_done_reg, ap_CS_fsm, ap_CS_fsm_state1, col_packets_out_out_full_n, col_packets_cast_out_out_full_n)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if ((not(((ap_start = ap_const_logic_0) or (col_packets_cast_out_out_full_n = ap_const_logic_0) or (col_packets_out_out_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_state2;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_state2 => 
                ap_NS_fsm <= ap_ST_fsm_state3;
            when ap_ST_fsm_state3 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXX";
        end case;
    end process;
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state3 <= ap_CS_fsm(2);

    ap_block_state1_assign_proc : process(ap_start, ap_done_reg, col_packets_out_out_full_n, col_packets_cast_out_out_full_n)
    begin
                ap_block_state1 <= ((ap_start = ap_const_logic_0) or (col_packets_cast_out_out_full_n = ap_const_logic_0) or (col_packets_out_out_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1));
    end process;


    ap_done_assign_proc : process(ap_done_reg, ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_done_reg;
        end if; 
    end process;


    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state3)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    ap_return_assign_proc : process(grp_fu_96_p2, ap_CS_fsm_state3, ap_return_preg)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state3)) then 
            ap_return <= grp_fu_96_p2;
        else 
            ap_return <= ap_return_preg;
        end if; 
    end process;


    col_packets_cast_out_out_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, col_packets_cast_out_out_full_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            col_packets_cast_out_out_blk_n <= col_packets_cast_out_out_full_n;
        else 
            col_packets_cast_out_out_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    col_packets_cast_out_out_din <= cols_V(10 downto 2);

    col_packets_cast_out_out_write_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, col_packets_out_out_full_n, col_packets_cast_out_out_full_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (col_packets_cast_out_out_full_n = ap_const_logic_0) or (col_packets_out_out_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            col_packets_cast_out_out_write <= ap_const_logic_1;
        else 
            col_packets_cast_out_out_write <= ap_const_logic_0;
        end if; 
    end process;

    col_packets_fu_76_p4 <= cols_V(10 downto 2);

    col_packets_out_out_blk_n_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, col_packets_out_out_full_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            col_packets_out_out_blk_n <= col_packets_out_out_full_n;
        else 
            col_packets_out_out_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    col_packets_out_out_din <= cols_V(10 downto 2);

    col_packets_out_out_write_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, col_packets_out_out_full_n, col_packets_cast_out_out_full_n)
    begin
        if ((not(((ap_start = ap_const_logic_0) or (col_packets_cast_out_out_full_n = ap_const_logic_0) or (col_packets_out_out_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1))) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            col_packets_out_out_write <= ap_const_logic_1;
        else 
            col_packets_out_out_write <= ap_const_logic_0;
        end if; 
    end process;


    grp_fu_96_ce_assign_proc : process(ap_start, ap_done_reg, ap_CS_fsm_state1, col_packets_out_out_full_n, col_packets_cast_out_out_full_n)
    begin
        if (((ap_const_logic_1 = ap_CS_fsm_state1) and ((ap_start = ap_const_logic_0) or (col_packets_cast_out_out_full_n = ap_const_logic_0) or (col_packets_out_out_full_n = ap_const_logic_0) or (ap_done_reg = ap_const_logic_1)))) then 
            grp_fu_96_ce <= ap_const_logic_0;
        else 
            grp_fu_96_ce <= ap_const_logic_1;
        end if; 
    end process;

    grp_fu_96_p0 <= grp_fu_96_p00(9 - 1 downto 0);
    grp_fu_96_p00 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(col_packets_fu_76_p4),20));
    grp_fu_96_p1 <= rows_V(20 - 1 downto 0);
end behav;