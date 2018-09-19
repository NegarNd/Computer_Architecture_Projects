library IEEE;
use IEEE.std_logic_1164.all;

entity arithmaticunit is port
(
clk : std_logic;
a , b : in std_logic_vector(7 downto 0);
control :in std_logic_vector(3 downto 0 );
 avf , zeroflag : out std_logic;
output : out std_logic_vector (7 downto 0) 
);
end arithmaticunit;

architecture behavioral of arithmaticunit is 

component adder is port
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

component multiplier is port
(
a , b : in std_logic_vector(7 downto 0);
multi : out std_logic_vector(7 downto 0)
);
end component;

component seqMultiplier is port
(
clk : in std_logic;
 b , q: in std_logic_vector(7 downto 0);
output : out std_logic_vector(7 downto 0);
avf : out std_logic
);
end  component;

component divider is port
(
clk : in std_logic;
b  , q :in  std_logic_vector( 7 downto 0);
qb : out std_logic_vector(7 downto 0);
avf : out std_logic
);
end component;

signal adderresult , subresult , multiresult ,selectresult , dividerresult : std_logic_vector(7 downto 0);
signal carry_out , b_out ,zero : std_logic;
signal multi_avf , avfSignal,divider_avf : std_logic;
begin
  adder1 : adder port map (a , b ,'0' , adderresult , carry_out);
    sub1 : subtractor port map(a,b,'0' , subresult, b_out);
--      multi1: multiplier port map(a,b,multiresult);
   multi1: seqMultiplier port map(clk , a,b,multiresult , multi_avf);  
   divider1 : divider port map(clk , a , b ,dividerresult, divider_avf );    
  process(adderresult , subresult , multiresult, control)
              begin
                case control is
              when "0001" => selectresult<= adderresult;
                              avfSignal <= carry_out;
              when "0010" => selectresult<=subresult;
                              avfSignal <=b_out;
              when "0100" => selectresult <= multiresult;
                              avfSignal<=multi_avf;
              when "1000" => selectresult <= dividerresult;
                      avfSignal <= divider_avf ;
              when others => selectresult <="00000000";
                avfSignal<='0';
              end case;
              if(selectresult = "00000000") then
              zero<= '1';
            else
              zero<='0';
            end if;
            end process;
            output<=selectresult;
            avf<= avfSignal;
            zeroflag<=zero;
          end behavioral;              

