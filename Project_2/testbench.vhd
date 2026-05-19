library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Testbench_PWM is
end Testbench_PWM;

architecture Behavior of Testbench_PWM is

    component PWM
        port(
            Clk_P   : in std_logic;                      -- Clock (Determina Frequência de Saída).
            Clk_C   : in std_logic;                      -- Clock Contador.
            DC      : in std_logic_vector(3 downto 0);   -- Duty Cycle - 4 Bits.

            PWM     : out std_logic                      -- Sinal PWM de Saída.
        );
    end component;

    signal Clk_P_S : std_logic := '0';
    signal Clk_C_S : std_logic := '0';
    signal DC_S    : std_logic_vector(3 downto 0) := (others => '0');

    signal PWM_S : std_logic;

    constant Clk_P_Period : time := 100 ns;
    constant Clk_C_Period : time := 10 ns;

begin

    DUT : PWM
        port map(
            Clk_P => Clk_P_S,
            Clk_C => Clk_C_S,
            DC    => DC_S,
            PWM => PWM_S
        );

    process is
    begin
        while true loop
            Clk_P_S <= '0';
            wait for Clk_P_Period / 2;

            Clk_P_S <= '1';
            wait for Clk_P_Period / 2;
        end loop;
    end process;

    process is
    begin
        while true loop
            Clk_C_S <= '0';
            wait for Clk_C_Period / 2;

            Clk_C_S <= '1';
            wait for Clk_C_Period / 2;
        end loop;
    end process;

    process is
    
    begin
        ------------------------------------------------------------
        -- Duty Cycle = 0%
        ------------------------------------------------------------
        DC_S <= "0000";
        wait for 200 ns;

        ------------------------------------------------------------
        -- Duty Cycle = 20%
        ------------------------------------------------------------
        DC_S <= "0010";
        wait for 200 ns;

        ------------------------------------------------------------
        -- Duty Cycle = 50%
        ------------------------------------------------------------
        DC_S <= "0101";
        wait for 200 ns;

        ------------------------------------------------------------
        -- Duty Cycle = 80%
        ------------------------------------------------------------
        DC_S <= "1000";
        wait for 200 ns;

        ------------------------------------------------------------
        -- Duty Cycle = 90%
        ------------------------------------------------------------
        DC_S <= "1001";
        wait for 200 ns;

        ------------------------------------------------------------
        -- Invalid Value (Optional Test)
        ------------------------------------------------------------
        DC_S <= "1111";
        wait for 200 ns;

    end process;
end Behavior;