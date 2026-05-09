
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Register_Bank is
    Port ( Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR (3 downto 0);
           R0 : out STD_LOGIC_VECTOR (3 downto 0);
           R1 : out STD_LOGIC_VECTOR (3 downto 0);
           R2 : out STD_LOGIC_VECTOR (3 downto 0);
           R3 : out STD_LOGIC_VECTOR (3 downto 0);
           R4 : out STD_LOGIC_VECTOR (3 downto 0);
           R5 : out STD_LOGIC_VECTOR (3 downto 0);
           R6 : out STD_LOGIC_VECTOR (3 downto 0);
           R7 : out STD_LOGIC_VECTOR (3 downto 0);
           I : in STD_LOGIC_VECTOR (2 downto 0));
end Register_Bank;

architecture Behavioral of Register_Bank is

component Decoder_3_to_8
    PORT( I : in STD_LOGIC_VECTOR (2 downto 0);
          EN : in STD_LOGIC;
          Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component Register_4bit
    PORT ( D : in STD_LOGIC_VECTOR (3 downto 0);
           En : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0) );
end component;

signal EN,Reg_S : STD_LOGIC:='1';
signal Y : STD_LOGIC_VECTOR(7 downto 0);

begin
Decoder_3_to_8_new:Decoder_3_to_8
 PORT MAP (
        I=>I,
        EN=>EN,
        Y=>Y
        );

Register_4bit_0 : Register_4bit
 PORT MAP(
    D => "0000",
    En => Y(0),
    Clk => Clk,
    Reset => Reg_S,
    Q => R0    
    );      

Register_4bit_1 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(1),
    Clk => Clk,
    Reset => Reg_S,
    Q => R1    
    ); 
    
Register_4bit_2 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(2),
    Clk => Clk,
    Reset => Reg_S,
    Q => R2    
    ); 

Register_4bit_3 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(3),
    Clk => Clk,
    Reset => Reg_S,
    Q => R3    
    ); 

Register_4bit_4 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(4),
    Clk => Clk,
    Reset => Reg_S,
    Q => R4    
    ); 

Register_4bit_5 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(5),
    Clk => Clk,
    Reset => Reg_S,
    Q => R5    
    ); 
    
Register_4bit_6 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(6),
    Clk => Clk,
    Reset => Reg_S,
    Q => R6    
    ); 
        
Register_4bit_7 : Register_4bit
 PORT MAP(
    D => D,
    En => Y(7),
    Clk => Clk,
    Reset => Reg_S,
    Q => R7    
    ); 
Reg_S <= Reset;
end Behavioral;
