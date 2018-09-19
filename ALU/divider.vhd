library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all; 
entity divider is port
(
clk : in std_logic;
b  , q :in  std_logic_vector( 7 downto 0);
qb : out std_logic_vector(7 downto 0);
avf : out std_logic
);
end divider;

architecture behavioral of divider is
  
  component  adder is port
(
a, b :in std_logic_vector(7 downto 0 );
cin : in std_logic;
sum : out std_logic_vector(7 downto 0 );
cout : out std_logic
);
end component;

component subtractor is port
(
a, b :in std_logic_vector(7 downto 0 );
bin : in std_logic;
sub : out std_logic_vector(7 downto 0 );
bout : out std_logic
);
end component;

  type state is(s0 ,s1,s2,s3,s4, s5, s6 ) ;
    signal thisState : state := s0;
    signal nextState : state;
    signal  a , qRegister , adderresult,  subresult  , result: std_logic_vector(7 downto 0);
    signal addercarry , subborrow:std_logic;
    signal sc: integer;
    
    begin
     adder1 : adder port map(a , b  ,'0' , adderresult ,addercarry);
       sub1 : subtractor port map(a , b , '0' , subresult , subborrow);
    process(thisState)
      begin
        case thisState is
        when s0=>
          a<= "00000000";
          qRegister <=q;
          sc<= 7;
          nextState <= s1;
        when s1=>
        
          a(7 downto 1) <= a(6 downto 0);
          a(0)<=  qRegister(7);
          qRegister(7 downto 1)<= qRegister(6 downto 0);
          qregister(0) <= '0';
          nextState<=s5;
        when s5 =>
          
          a<= subresult ;
       nextState<=s6;
     when s6 =>
          if(a (7) ='0') then
            nextState<= s2;
          elsif(a(7) ='1') then
            nextState<=s3;
          end if;
        when s2=>
         qRegister(0) <= '1';
         sc <= sc-1;
          if(sc = 0 ) then 
            nextState<= s4;
          else
            nextState<= s1;
          end if;
        when s3 =>
          qRegister(0)<= '0';
          a<= adderresult ;
          sc<= sc-1;
          if(sc = 0) then 
          nextState<= s4;
        else
          nextState<= s1;
        end if;
      when s4 =>
        result<=  qregister (7 downto 4) & a(7 downto 4);
        if(b ="00000000") then
avf<='1';
else
  avf<='0';
end if;
when others=>

end case;
end process;

process( clk)
begin
  if(clk'event) then
    thisState <= nextState;
  end if;

end process;

qb<= result;
end behavioral;