library IEEE;
use IEEE.std_logic_1164.all;

entity control_unit is port
(
clk : in std_logic;
a, b : in std_logic_vector(7 downto 0);
control : in std_logic_vector( 2 downto 0);
output :out std_logic_vector(7 downto 0);
avf , zeroflag , signflag : out std_logic
);
end control_unit;

architecture behavioral of control_unit is
  
  component logic_unit is port 
(
control : in std_logic_vector(3 downto 0);
a , b : in std_logic_vector(7 downto 0);
zeroflag :out std_logic;
result : out std_logic_vector(7 downto 0)
);
end component;
  
component arithmaticunit is port
(
clk :in  std_logic;
a , b : in std_logic_vector(7 downto 0);
control :in std_logic_vector(3 downto 0 );
 avf , zeroflag  : out std_logic;
output : out std_logic_vector (7 downto 0) 
);
end component;
  
  
  signal control_signal : std_logic_vector(7 downto 0);
  signal logic_result , arithmatic_result: std_logic_vector(7 downto 0);
  signal arith_avf , arith_zero , logic_zero : std_logic;
  begin
    
    logic : logic_unit port map(control_signal(7 downto 4) , a, b,logic_zero, logic_result);
      arithmatic : arithmaticunit port map(clk, a, b, control_signal(3 downto 0) ,arith_avf ,arith_zero ,  arithmatic_result );
  with control select
    control_signal <= "00000001" when "000",
  "00000010" when "001",
     "00000100" when "010",
   "00001000" when "011",
    "00010000" when "100",
    "00100000" when "101",
     "01000000" when "110",
    "10000000" when "111",
   "00000000" when others;
  
  with control(2) select
  output <= logic_result when '1',
      arithmatic_result when '0',
      "00000000" when others;
   with control(2) select
   avf <='0' when '1',
           arith_avf when '0',
            '0' when others;
            
    with control(2) select
   zeroflag <=logic_zero when '1',
           arith_zero when '0',
            '0' when others;
            
    with control select
   signflag <= arith_avf when "000",
     arith_avf when "001",
           '0' when others;
    end behavioral;