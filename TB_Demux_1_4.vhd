library ieee;
use ieee.std_logic_1164.all;

entity Testbench_Demux_1_4 is 
end entity;

architecture sim of Testbench_Demux_1_4 is
    
    component Demux_1_4 is
        port(
            A    : in std_logic;
            OP   : in std_logic_vector(1 downto 0);
            Y_1  : out std_logic;
            Y_2  : out std_logic;
            Y_3  : out std_logic;
            Y_4  : out std_logic
        );
    end component;

    signal a_s   : std_logic := '0';
    signal op_s  : std_logic_vector(1 downto 0) := "00";
    signal y1_s  : std_logic;
    signal y2_s  : std_logic;
    signal y3_s  : std_logic;
    signal y4_s  : std_logic;

begin

    DUT: Demux_1_4
        port map (
            A   => a_s,
            OP  => op_s,
            Y_1 => y1_s,
            Y_2 => y2_s,
            Y_3 => y3_s,
            Y_4 => y4_s
        );
	
    process is 
    
    begin

        op_s <= "00";
        a_s <= '0';
        wait for 1 ns;

        op_s <= "00";
        a_s <= '1';
        wait for 1 ns;

        op_s <= "01";
        a_s <= '0';
        wait for 1 ns;

        op_s <= "01";
        a_s <= '1';
        wait for 1 ns;
        
        op_s <= "10";
        a_s <= '0';
        wait for 1 ns;

        op_s <= "10";
        a_s <= '1';
        wait for 1 ns;

        op_s <= "11";
        a_s <= '0';
        wait for 1 ns;

        op_s <= "11";
        a_s <= '1';
        wait for 1 ns;

    end process;

end architecture;

