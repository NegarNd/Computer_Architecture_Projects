library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity ram is port (
  clk : in std_logic;
  rw : in std_logic;
  address : in std_logic_vector(9 downto 0);
  data_in : in std_logic_vector(31 downto 0);
  data_out : out std_logic_vector(31 downto 0);
  data_ready: out std_logic
   );
end ram;
architecture dataflow of ram is
  type twodvector is array(1023 downto 0) of std_logic_vector(31 downto 0);
  signal ram : twodvector;
  signal data_out_signal: std_logic_vector(31 downto 0);
  signal data_readyS : std_logic;
  begin
    process(clk)
      begin
     if(clk'event and clk='1') then
      if(rw = '1')then
        ram(to_integer(unsigned(address))) <= data_in;
        
      elsif(rw = '0') then
        data_out_signal <=  ram(to_integer(unsigned(address)));
        data_readyS <= '1';
      else
        data_readyS <='0';
    end if;
    end if;
end process;
data_out<=data_out_signal;
data_ready <= data_readyS;
end dataflow;