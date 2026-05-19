library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Definição Comportamental de Módulo Gerador PWM de 10 Níveis:

entity PWM is
    port(
        Clk_P   : in std_logic;                      -- Clock (Determina Frequência de Saída).
        Clk_C   : in std_logic;                      -- Clock Contador.
        DC      : in std_logic_vector(3 downto 0);   -- Duty Cycle - 4 Bits.

        PWM     : out std_logic                      -- Sinal PWM de Saída.
    );
end PWM;

architecture Behavior of PWM is

    signal Cont_S : unsigned(3 downto 0) := (others => '0');
    signal DC_Reg : unsigned(3 downto 0) := (others => '0');

    begin

    process(Clk_P)
    begin
        if rising_edge(Clk_P) then
            DC_Reg <= unsigned(DC);
        end if;
    end process;

    process(Clk_C)
    begin
        if rising_edge(Clk_C) then
            if Cont_S = 9 then
                Cont_S <= (others => '0');
            else
                Cont_S <= Cont_S + 1;
            end if;

            if (Cont_S < DC_Reg) then
                PWM <= '1';
            else
                PWM <= '0';
            end if;
        end if;
    end process;
end Behavior;


