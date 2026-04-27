library ieee;
use ieee.std_logic_1164.all;

entity Logic_AND is
    port(
        A : in std_logic;
        B : in std_logic;
        Y : out std_logic
    );
end Logic_AND;

architecture Behaviour of Logic_AND is 

begin

    Y <= (A and B);

end Behaviour;