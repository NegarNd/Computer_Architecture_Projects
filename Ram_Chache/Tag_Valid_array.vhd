library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity tag_valid_array is port (
  clk : in std_logic;
  reset_n :in  std_logic;
  wren : in std_logic;
  invalidate: in std_logic;
  wrdata : in std_logic_vector(3 downto 0);
  address : in std_logic_vector(5 downto 0);
  output : out std_logic_vector(4 downto 0)
   );
end tag_valid_array;
architecture dataflow of tag_valid_array is
  type twodvector is array(63 downto 0) of std_logic_vector(3 downto 0);
  signal tag : twodvector; 
  signal valid : std_logic_vector(63 downto 0);
  signal outSignal : std_logic_vector(4 downto 0);
  begin
 process(clk)
   begin
     if(clk'event and clk='1') then
     
	   if(wren ='0') then
	     outSignal<=valid(to_integer(unsigned(address))) & tag(to_integer(unsigned(address)));
 elsif(wren='1')then
  tag(to_integer(unsigned(address))) <= wrdata;
else
  outSignal<="XXXXX";
 
 end if;
 
   if(invalidate = '1')then
       valid(to_integer(unsigned(address)))<='0';
     elsif(invalidate='0') then
       valid(to_integer(unsigned(address)))<='1';
     end if;

	  end if;--if clk
	  end process;
 output <=outSignal;
end dataflow;





