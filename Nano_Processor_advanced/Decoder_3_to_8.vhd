library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparator is
    Port (
        A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        Difference : out STD_LOGIC_VECTOR (3 downto 0);
        Equal : out STD_LOGIC
    );
end Comparator;

architecture Behavioral of Comparator is
begin

    process(A, B)
    begin
        if unsigned(A) >= unsigned(B) then
            Difference <= std_logic_vector(unsigned(A) - unsigned(B));
        else
            Difference <= std_logic_vector(unsigned(B) - unsigned(A));
        end if;
    end process;

    Equal <= '1' when A = B else '0';

end Behavioral;
