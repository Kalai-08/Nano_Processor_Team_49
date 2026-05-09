
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity TB_Mux_2_to_1_3bit is
--  Port ( );
end TB_Mux_2_to_1_3bit;

architecture Behavioral of TB_Mux_2_to_1_3bit is
component Mux_2_to_1_3bit 
    Port ( Sel : in STD_LOGIC;
           D0 : in STD_LOGIC_VECTOR (2 downto 0);
           D1 : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end component;
signal Sel : STD_LOGIC;
signal D0 : STD_LOGIC_VECTOR (2 downto 0);
signal D1 : STD_LOGIC_VECTOR (2 downto 0);
signal Y : STD_LOGIC_VECTOR (2 downto 0);
begin
UUT: Mux_2_to_1_3bit 
      port map (
           Sel=>Sel,
           D0=>D0,
           D1=>D1,
           Y=>Y   );

    --- 240212R - 0b 1110 1010 1001 0101 00
    --- 240308R - 0b 1110 1010 1010 1101 00 
    --- 240216 -  0b 1110 1010 1001 0110 00
    --- 240385X - 0b 1110 1010 1100 0000 01 

           
     process
     begin
          D0 <= "100";
          D1 <= "011";
          Sel <= '1';
               
          wait for 50ns;
          Sel <= '0';
               
          wait for 50ns;
          D0 <= "001";
          D1 <= "010";
          Sel <= '1';
          
          wait for 50ns;
          Sel <= '0';
          
          wait for 50ns;
          D0 <= "111";
          D1 <= "110";
          Sel <= '1';
            
          wait for 50ns;
          Sel <= '0';
          wait;
     end process;

end Behavioral;
