library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.buses.all; 
use work.constants.all;
use work.ALU_H.all;

entity IDecoder is
    port(
        I: in instruction_bus; 
        RCJump: in data_bus; 
        REn: out register_address; 
        RSA: out register_address; 
        RSB: out register_address; 
        OpS: out Operation_Sel;
        IM: out data_bus; 
        J:out std_logic; 
        JA: out instruction_address; 
        L: out std_logic 
    );
end IDecoder;

architecture Behavioral of IDecoder is

signal IEn: std_logic_vector(1 downto 0); 
signal RCJ: std_logic_vector(3 downto 0);
constant Jump : std_logic := '1';
constant NotJump : std_logic := '0';

begin
    IEn <= I(11 downto 10); 
    RCJ <= RCJump;
    
    decode: process(IEn, RCJ, I)
    begin
        case IEn is
            when MOVI_OP => 
                J <= NotJump;
                IM <= I(3 downto 0); 
                L <= Immediate_Load; 
                REn <= I(9 downto 7);
            when ADD_OP => 
                J <= NotJump;
                OpS <= AU_ADD_SIGNAL;
                RSA <= I(9 downto 7);
                RSB <= I(6 downto 4);
                REn <= I(9 downto 7);
                L <= Register_Load;
            when NEG_OP => 
                J <= NotJump;
                OpS <= AU_SUB_SIGNAL;
                RSA <= "000";
                RSB <= I(9 downto 7);
                REn <= I(9 downto 7);
                L <= Register_Load;
            when JZR_OP => 
                RSA <= I(9 downto 7);
                REn <= "000";
                if RCJ = "0000" then
                    J <= Jump;
                    JA <= I(2 downto 0);
                else
                    J <= NotJump;
                end if;
            when others => 
                
        end case;



    end process decode;

end Behavioral;