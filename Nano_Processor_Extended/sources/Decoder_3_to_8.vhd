
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoder_3_to_8 is
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is
 component Decoder_2_to_4
    Port ( I : in STD_LOGIC_VECTOR (1 downto 0);
            EN : in STD_LOGIC;
            Y : out STD_LOGIC_VECTOR (3 downto 0));
 
 end component;
 
 signal EN0,EN1,I0,I1,I2 : STD_LOGIC;

begin
Decoder_2_to_4_0 : Decoder_2_to_4
    PORT MAP (
        I(0) => I0,
        I(1) => I1,
        EN => EN0,
        Y =>  Y(3 downto 0) 
            
    );


 Decoder_2_to_4_1 : Decoder_2_to_4
    PORT MAP (
       I(0) => I0,
       I(1) => I1,
       EN => EN1, 
       Y =>  Y(7 downto 4)
    );
    
    I0 <= I(0);
    I1 <= I(1);
    EN0 <= NOT(I(2)) AND EN;
    EN1 <= I(2)AND EN; 

end Behavioral;
