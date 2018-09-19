library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity lru_array is port (
  clk : in std_logic;
 address : in std_logic_vector(5 downto 0 );
 lruen : in std_logic;
 w1Valid: out std_logic
   );
end lru_array;
architecture dataflow of lru_array is
  type integerArray is array (0 to 63)of integer;
  signal way0 , way1 : integerArray;
begin
  process(clk)
    begin 
       if(clk'event and clk='1') then
       if(lruen = '1')then
        if (way0(to_integer(unsigned(address)))) <= (way1(to_integer(unsigned(address)))) then
          w1Valid<= '0';
         way0(to_integer(unsigned(address))) <= way0(to_integer(unsigned(address)))+1;          
        else
          w1Valid <= '1';
          way1(to_integer(unsigned(address))) <= way1(to_integer(unsigned(address)))+1;
        end if;
         else
      w1Valid<='X';
      end if;
   
    end if;
    end process;
  end dataflow;
