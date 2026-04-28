library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

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

    signal s_a : unsigned(3 downto 0):= "0000";
    signal s_b : unsigned(3 downto 0):= "0000";

begin

    a_s <= std_logic_vector(s_a);
    b_s <= std_logic_vector(s_b);

    DUT: ULA 
        port map(
            A  => a_s, 
            B  => b_s, 
            OP => op_s, 
            Y  => y_s,
            C  => c_s
        );

    process is
    
    variable v_a : unsigned(3 downto 0) := "0000";
    variable v_b : unsigned(3 downto 0) := "0000";

    begin
		
        -- Tabela de Operações:
        -- Adição: 			"0000"
        -- Subtração:		"0001"
        -- Multiplicação:	"0010"
        -- Divisão:			"0011"
        -- ABS(A):			"0100"
        -- REM:				"0101"
        -- MOD:				"0110"
        -- AND:				"0111"
        -- OR:				"1000"
        -- NOT(A):			"1001"
        -- NAND:			"1010"
        -- NOR:				"1011"
        -- XOR:				"1100"
        -- XNOR:			"1101"
        
        op_s <= "0000"; -- Mudar Opção do Seletor de Acordo Com a Operação.

        for i in 0 to 15 loop
            s_a <= v_a;
            v_a := v_a + 1;

            for j in 0 to 15 loop
                s_b <= v_b;
                v_b := v_b + 1;
                wait for 1 ns; -- Mínimo de (16 * 16) = 256 ns. 
            end loop;
        end loop;

    end process;

end architecture;