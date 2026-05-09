

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_PC is
--  Port ( );
end TB_PC;

architecture Behavioral of TB_PC is
component PC
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (2 downto 0);
           O : out STD_LOGIC_VECTOR (2 downto 0));
end component;
signal Reset : STD_LOGIC;
signal D,O : STD_LOGIC_VECTOR (2 downto 0);
signal Clk : STD_LOGIC := '1';
begin
    UUT : PC
        PORT MAP(
            Clk => Clk,
            Reset => Reset,
            D => D,
            O => O
        );
    process
    begin
        wait for 10ns;
        Clk <= NOT(CLK);
    end process;

    --- 240212R - 0b 1110 1010 1001 0101 00
    --- 240308R - 0b 1110 1010 1010 1101 00 
    --- 240216 -  0b 1110 1010 1001 0110 00
    --- 240385X - 0b 1110 1010 1100 0000 01 
    
    process
    begin
        wait for 20ns;
        Reset <= '1';
        wait for 30ns;
        Reset <= '0';
        D <= "100";
        wait for 30ns;
        D <= "001";
        wait for 30ns;
        D <= "101";
        wait for 30ns;
        D <= "111";
        wait for 30ns;
        Reset <= '1';      
        wait;
    end process;



end Behavioral;
