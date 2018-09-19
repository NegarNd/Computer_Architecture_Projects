
library IEEE;
use IEEE.std_logic_1164.all;

entity SAR is port
(
a : in std_logic_vector(7 downto 0);
shiftA : out std_logic_vector(7 downto 0)
);
end SAR;

architecture behavioral of SAR is
  signal shift :std_logic_vector(7 downto 0);
begin
 shift(6 downto 0)<=a(7 downto 1);
   shift(7)<= a(7);
    	 shiftA<=shift;
 
end behavioral;
