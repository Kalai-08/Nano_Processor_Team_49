library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_Comparator is
end TB_Comparator;

architecture Behavioral of TB_Comparator is

component Comparator
    Port (
        A : in STD_LOGIC_VECTOR (3 downto 0);
        B : in STD_LOGIC_VECTOR (3 downto 0);
        Difference : out STD_LOGIC_VECTOR (3 downto 0);
        Equal : out STD_LOGIC
    );
end component;

signal A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal Difference : STD_LOGIC_VECTOR (3 downto 0);
signal Equal : STD_LOGIC;

begin

UUT: Comparator
    port map (
        A => A,
        B => B,
        Difference => Difference,
        Equal => Equal
    );

process
begin

    -- 240212R ? 1 & 2
    A <= "0001";
    B <= "0010";
    wait for 100 ns;

    -- 240308R ? 0 & 8
    A <= "0000";
    B <= "1000";
    wait for 100 ns;

    -- 240216 ? 1 & 6
    A <= "0001";
    B <= "0110";
    wait for 100 ns;

    -- 240385X ? 8 & 5
    A <= "1000";
    B <= "0101";
    wait for 100 ns;

    -- Equal case
    A <= "0101";
    B <= "0101";
    wait for 100 ns;

    wait;

end process;

end Behavioral;