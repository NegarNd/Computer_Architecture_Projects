library IEEE;
use IEEE.std_logic_1164.all;

entity andmodule is port
(
a , b : in std_logic_vector(7 downto 0);
aANDb : out std_logic_vector(7 downto 0)
);
end andmodule;

architecture behavioral of andmodule is
  
begin
  aANDb <= a and b;
  
end behavioral;