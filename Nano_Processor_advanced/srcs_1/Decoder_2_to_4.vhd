

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Add_Sub is
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Ctrl : in STD_LOGIC;
           C_out : out STD_LOGIC;
           S : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Z_out : out STD_LOGIC
           );
end Add_Sub;

architecture Behavioral of Add_Sub is

component RCA 
 Port (A : in STD_LOGIC_VECTOR (3 downto 0);
       B : in STD_LOGIC_VECTOR (3 downto 0);
       C_in : in STD_LOGIC;
       S : out STD_LOGIC_VECTOR (3 downto 0);
       C_out : out STD_LOGIC
       ); 
end component; 
SIGNAL X,Y: STD_LOGIC_VECTOR (3 downto 0);

begin
X(0) <= B(0) XOR Ctrl;
X(1) <= B(1) XOR Ctrl;
X(2) <= B(2) XOR Ctrl;
X(3) <= B(3) XOR Ctrl;
RCA_0 : RCA
    PORT MAP (
        A => A,
        B => X,
        C_in => Ctrl,
        S => Y,
        C_out => C_out
    );
Overflow <= (A(3) XNOR (Ctrl XOR B(3))) AND (A(3) XOR Y(3));
S <= Y;
Z_Out <= NOT( Y(0) OR Y(1) OR Y(2) OR Y(3));
end Behavioral; 
