

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Mux_8_to_1_4bit is
--  Port ( );
end TB_Mux_8_to_1_4bit;

architecture Behavioral of TB_Mux_8_to_1_4bit is
component Mux_8_to_1_4bit 
    Port ( S : in STD_LOGIC_VECTOR (2 downto 0);
           A0 : in STD_LOGIC_VECTOR (3 downto 0);
           A1 : in STD_LOGIC_VECTOR (3 downto 0);
           A2 : in STD_LOGIC_VECTOR (3 downto 0);
           A3 : in STD_LOGIC_VECTOR (3 downto 0);
           A4 : in STD_LOGIC_VECTOR (3 downto 0);
           A5 : in STD_LOGIC_VECTOR (3 downto 0);
           A6 : in STD_LOGIC_VECTOR (3 downto 0);
           A7 : in STD_LOGIC_VECTOR (3 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end component;
signal A0,A1,A2,A3,A4,A5,A6,A7,Y: STD_LOGIC_VECTOR (3 downto 0);
signal S : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT : Mux_8_to_1_4bit
     port map (
     S => S,
     A0 => A0,
     A1 => A1,
     A2 => A2,
     A3 => A3,
     A4 => A4,
     A5 => A5,
     A6 => A6,
     A7 => A7,
     Y => Y         );

    --- 240212R - 0b 1110 1010 1001 0101 00
    --- 240308R - 0b 1110 1010 1010 1101 00 
    --- 240216 -  0b 1110 1010 1001 0110 00
    --- 240385X - 0b 1110 1010 1100 0000 01 
     process
     begin
         A0 <= "1100";
         A1 <= "0001";
         A2 <= "1001";
         A3 <= "1000";
         A4 <= "0001";
         A5 <= "1101";
         A6 <= "1111";
         A7 <= "1101";
         S <= "000";
         
         wait for 10ns;
         S <= "001";
         
         wait for 10ns;
         S <= "010";
                  
         wait for 10ns;
         S <= "011";
                           
         wait for 10ns;
         S <= "100";
         
         wait for 10ns;
         S <= "101";
                  
         wait for 10ns;
         S <= "110";
         
         wait for 10ns;
         S <= "111";
         
         wait;
         
     end process;

end Behavioral;
