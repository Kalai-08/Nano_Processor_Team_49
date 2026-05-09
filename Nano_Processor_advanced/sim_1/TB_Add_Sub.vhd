

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Adder_3bit is
--  Port ( );
end TB_Adder_3bit;

architecture Behavioral of TB_Adder_3bit is
component Adder_3bit
     Port ( 
         A : in STD_LOGIC_VECTOR (2 downto 0);
         S: out STD_LOGIC_VECTOR (2 downto 0);
         C_out : out STD_LOGIC
       );
end component;
signal A,S : STD_LOGIC_VECTOR (2 downto 0);
signal C_out : STD_LOGIC;
begin
UUT: Adder_3bit
    PORT MAP (
           A => A,
           S => S,
           C_out => C_out
    );
    --- 240212R - 0b 1110 1010 1001 0101 00
    --- 240308R - 0b 1110 1010 1010 1101 00 
    --- 240216 -  0b 1110 1010 1001 0110 00
    --- 240385X - 0b 1110 1010 1100 0000 01 
    process
            begin 
                A <= "100";
                wait for 100ns;
                A <= "001";
                wait for 100ns;
                A <= "101";
                wait for 100ns;
                A <= "111";
                wait;
            end process;
    

end Behavioral;
