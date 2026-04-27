library IEEE;
use IEEE.std_logic_1164.all;

entity Testbench_ULA is
end Testbench_ULA;

architecture Behavior of Testbench_ULA is

    component ULA
        Port (
            A  : in  std_logic_vector(3 downto 0);
            B  : in  std_logic_vector(3 downto 0);
            OP : in  std_logic_vector(3 downto 0);
            
            Y  : out std_logic_vector(7 downto 0);
            
            C  : out std_logic
        );
    end component;

    signal a_s, b_s  : std_logic_vector(3 downto 0);
    signal op_s      : std_logic_vector(3 downto 0);
    signal y_s       : std_logic_vector(7 downto 0);
    signal c_s       : std_logic;

begin

    DUT: ULA 
        port map(
            A  => a_s, 
            B  => b_s, 
            OP => op_s, 
            Y  => y_s,
            C  => c_s
        );

    process is
    
    begin

        -- ADD
        a_s <= "0011"; b_s <= "0010"; op_s <= "0000";
        wait for 10 ns;

        -- SUB
        op_s <= "0001";
        wait for 10 ns;

        -- MUL
        op_s <= "0010";
        wait for 10 ns;

        -- DIV
        op_s <= "0011";
        wait for 10 ns;

        -- ABS
        a_s <= "1101"; op_s <= "0100"; -- -3
        wait for 10 ns;

        -- REM
        a_s <= "0111"; b_s <= "0011"; op_s <= "0101";
        wait for 10 ns;

        -- MOD
        op_s <= "0110";
        wait for 10 ns;

        -- LOGICAL TESTS
        op_s <= "0111"; wait for 10 ns; -- AND
        op_s <= "1000"; wait for 10 ns; -- OR
        op_s <= "1001"; wait for 10 ns; -- NOT
        op_s <= "1010"; wait for 10 ns; -- NAND
        op_s <= "1011"; wait for 10 ns; -- NOR
        op_s <= "1100"; wait for 10 ns; -- XOR
        op_s <= "1101"; wait for 10 ns; -- XNOR

    end process;

end architecture;