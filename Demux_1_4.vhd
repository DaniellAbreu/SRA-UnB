library ieee;
use ieee.std_logic_1164.all;

-- Demux Binário de 4 Bits.

entity Demux_1_4 is
    port(
        A    : in std_logic;
        OP   : in std_logic_vector(1 downto 0);
        Y_1  : out std_logic;
        Y_2  : out std_logic;
        Y_3  : out std_logic;
        Y_4  : out std_logic
    );
end Demux_1_4;

architecture Behaviour of Demux_1_4 is

begin

    process (A, OP) is 
    
    begin

        if (OP = "00") then
            Y_1 <= A;
        elsif (OP = "01") then
            Y_2 <= A;
        elsif (OP = "10") then
            Y_3 <= A;
        elsif (OP = "11") then
            Y_4 <= A;
        end if;

    end process;

end Behaviour;