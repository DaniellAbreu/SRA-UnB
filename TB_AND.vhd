library ieee;
use ieee.std_logic_1164.all;

entity Testbench_AND is
end entity;

architecture sim of Testbench_AND is

    component Logic_AND is
        port (
            A : in  std_logic;
            B : in  std_logic;
            Y : out std_logic
        );
    end component;

    signal a_s : std_logic := '0';
    signal b_s : std_logic := '0';
    signal y_s : std_logic;

begin

    DUT: Logic_AND
        port map (
            A => a_s,
            B => b_s,
            Y => y_s
        );
	
    process is 
    
    begin
    
        a_s <= '0';
        b_s <= '0';
        wait for 1 ns;

        a_s <= '0';
        b_s <= '1';
        wait for 1 ns;

        a_s <= '1';
        b_s <= '0';
        wait for 1 ns;

        a_s <= '1';
        b_s <= '1';
        wait for 1 ns;

    end process;

end architecture;