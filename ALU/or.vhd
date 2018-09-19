library IEEE;
use IEEE.std_logic_1164.all;

entity ormodule is port
(
a , b : in std_logic_vector(7 downto 0);
aORb : out std_logic_vector(7 downto 0)
);
end ormodule;

architecture behavioral of ormodule is
  
begin
  aORb <= a or b;
  
end behavioral;
