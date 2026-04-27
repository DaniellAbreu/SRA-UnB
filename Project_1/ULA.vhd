library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Definição Comportamental da Unidade Lógica Aritmética:

entity ULA is
    port(
        A   : in std_logic_vector(3 downto 0); -- Entrada 4 Bits (Numérico Unsigned e Lógico).
        B   : in std_logic_vector(3 downto 0); -- Entrada 4 Bits (Numérico Unsigned e Lógico).
        OP  : in std_logic_vector(3 downto 0); -- Seletor 4 Bits (Lógico).
        
        Y   : out std_logic_vector(7 downto 0); -- Saída 8 Bits | Máxima Capacidade de Saída [A * B].

        C   : out std_logic -- Flag de Carry / Borrow.
    );
end ULA;

architecture Behaviour of ULA is

begin

    process (A, B, OP) is
        
        -- Definição de Variáveis Para Operações Numéricas:
        variable a_u, b_u : unsigned(3 downto 0);

        -- Extensão Para Carry / Borrow:
        variable add_ext  : unsigned(4 downto 0);
        variable sub_ext  : unsigned(4 downto 0);

        -- Saída e Flag de Carry / Borrow:
        variable y_u      : unsigned(7 downto 0);
        variable c_flag   : std_logic;
    
    begin

        a_u := unsigned(A);
        b_u := unsigned(B);

        y_u := "00000000";
        c_flag   := '0';

        case OP is

            -- Adição:
            when "0000" =>
                add_ext := ('0' & a_u) + ('0' & b_u); 
                y_u(3 downto 0) := add_ext(3 downto 0);
                y_u(7 downto 4) := (others => '0');
                
                c_flag := add_ext(4);

            -- Subtração:
            when "0001" =>
                sub_ext := ('0' & a_u) - ('0' & b_u); 
                y_u(3 downto 0) := sub_ext(3 downto 0);
                y_u(7 downto 4) := (others => '0');

                if a_u >= b_u then
                    c_flag := '0'; -- Não Houve Borrow.
                else
                    c_flag := '1'; -- Houve Borrow: Resultado = [(A - B) mod 16].
                end if;

            -- Multiplicação:
            when "0010" => y_u := (a_u * b_u);

            -- Divisão:
            when "0011" =>
                if b_u /= 0 then
                    y_u(3 downto 0) := (a_u / b_u);
                else
                    y_u := (others => '0');
                end if;

            -- Absoluto:
            when "0100" => y_u(3 downto 0) := a_u; y_u(7 downto 4) := (others => '0');

            -- REM: (Para Entradas Naturais REM e MOD São Indênticas).
            when "0101" =>
                if b_u /= 0 then
                    y_u(3 downto 0) := (a_u rem b_u);
                else
                    y_u := (others => '0');
                end if;

            -- MOD:
            when "0110" =>
                if b_u /= 0 then
                    y_u(3 downto 0) := (a_u mod b_u);
                else
                    y_u := (others => '0');
                end if;

            when "0111" => y_u(3 downto 0) := a_u and b_u; y_u(7 downto 4) := (others => '0');        -- AND:
            when "1000" => y_u(3 downto 0) := a_u or  b_u; y_u(7 downto 4) := (others => '0');        -- OR:
            when "1001" => y_u(3 downto 0) := not a_u; y_u(7 downto 4) := (others => '0');            -- NOT(A):
            when "1010" => y_u(3 downto 0) := not (a_u and b_u); y_u(7 downto 4) := (others => '0');  -- NAND:  
            when "1011" => y_u(3 downto 0) := not (a_u or  b_u); y_u(7 downto 4) := (others => '0');  -- NOR:
            when "1100" => y_u(3 downto 0) := a_u xor b_u; y_u(7 downto 4) := (others => '0');        -- XOR:
            when "1101" => y_u(3 downto 0) := a_u xnor b_u; y_u(7 downto 4) := (others => '0');       -- XNOR:

            when others =>
                y_u := (others => '0');

        end case;

        C <= c_flag;
        Y <= std_logic_vector(y_u);
    
    end process;

end Behaviour;