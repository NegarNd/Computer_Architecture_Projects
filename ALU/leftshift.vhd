library IEEE;
use IEEE.std_logic_1164.all;

entity leftshift is port
(
a , b : in std_logic_vector(7 downto 0);
 shiftA: out std_logic_vector(7 downto 0)
);
end leftshift;

architecture behavioral of leftshift is
  
begin
 shiftA(7 downto 1)<= a(6 downto 0);
 shiftA(0)<= '0';
  
end behavioral;
