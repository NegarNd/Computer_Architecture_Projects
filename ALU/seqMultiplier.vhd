
library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all; 
entity seqMultiplier is port
(
clk : in std_logic;
 b , q: in std_logic_vector(7 downto 0);
output : out std_logic_vector(7 downto 0);
avf : out std_logic
);
end  seqMultiplier;

architecture behavioral of seqMultiplier is
  
 component adder is port
(
a, b :in std_logic_vector(7 downto 0 );
cin : in std_logic;
sum : out std_logic_vector(7 downto 0 );
cout : out std_logic
);
end component;
  
  type state is(s0 ,s1,s2,s3,s4) ;
    signal thisState : state:= s0;
    signal nextState : state;
    signal a : std_logic_vector(8 downto 0);
    signal qRegister ,adderresult : std_logic_vector(7 downto 0);
    signal sc : integer;
    signal result : std_logic_vector( 15 downto 0);
    signal addercarry : std_logic;
    
    begin
      adder1 : adder port map(a(7 downto 0) , b , '0' , adderresult ,addercarry);
    process(thisState)
      begin
        case thisState is
        when s0=>
          a<= "000000000";
          qRegister <=q;
          sc<= 7;
          nextState <= s1;
        when s1=>
          if(qRegister(0) = '1')then
            nextState <= s3;
          elsif(qRegister(0) ='0') then
            nextState<= s2;
          end if;
        when s2=>
          qregister(6 downto 0)<= qregister(7 downto 1);
          qregister(7)<= a(0);
          a(7 downto 0)<=a(8 downto 1);
          a(8)<='0';
          sc<= sc-1;
          if(sc = 0) then
            nextState<= s4;
          else
            nextState<= s1;
          end if;
         when s3 =>
           a<= addercarry & adderresult;
           nextState<=s2;
      when s4 =>
        result<= a(7 downto 0) & qRegister;
when others=>

end case;
end process;

process(clk)
begin
  if(clk'event ) then
    thisState <= nextState;
  end if;

end process;
avf<=a(8);
output<= a(7 downto 0);
end behavioral;