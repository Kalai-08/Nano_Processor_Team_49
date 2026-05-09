

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TB_Mux_2_to_1_4bit is
--  Port ( );
end TB_Mux_2_to_1_4bit;

architecture Behavioral of TB_Mux_2_to_1_4bit is
component Mux_2_to_1_4bit 
    Port ( S : in STD_LOGIC;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           X : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal S : STD_LOGIC;
signal A : STD_LOGIC_VECTOR (3 downto 0);
signal B : STD_LOGIC_VECTOR (3 downto 0);
signal X : STD_LOGIC_VECTOR (3 downto 0);
begin
UUT : Mux_2_to_1_4bit
      port map (
           S=>S,
           A=>A,
           B=>B,
           X=>X   );
           
   --- 240212R - 0b 1110 1010 1001 0101 00
   --- 240308R - 0b 1110 1010 1010 1101 00 
   --- 240216 -  0b 1110 1010 1001 0110 00
   --- 240385X - 0b 1110 1010 1100 0000 01 

     process
     begin
          A <= "1100";
          B <= "0001";
          S <= '1';
          
          wait for 50ns;
          S <= '0';
          
          wait for 50ns;
          A <= "1001";
          B <= "1000";
          S <= '1';
          wait for 50ns;
          S <= '0';
          
          wait for 50ns;
          A <= "0001";
          B <= "1101";
          S <= '1';
          wait for 50ns;
          S <= '0';
          wait;
          
     end process;

end Behavioral;
