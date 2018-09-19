
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity data_array is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  wren: in std_logic;
  wrdata:in std_logic_vector(31 downto 0);
  data: out std_logic_vector(31 downto 0)
  
  
  );
end data_array;

architecture dataflow of data_array is
 type data_Array is array(63 downto 0) of std_logic_vector(31 downto 0);
 signal cache : data_Array;
 signal dataSignal : std_logic_vector(31 downto 0);
 
 
begin
 process(clk)
   begin
     if(clk'event and clk='1') then
     
	   if(wren ='0') then
	     
	dataSignal<=cache(to_integer(unsigned(address)));
	elsif(wren='1') then
cache(to_integer(unsigned(address))) <= wrdata;
else
  dataSignal <="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
	  end if;
	  end if;
	  end process;
	data <=dataSignal;
end dataflow;




