library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity cache_controller is port (
  clk : in std_logic;
  wren: in std_logic;
  in_data: in std_logic_vector(31 downto 0);
  out_data : out std_logic_vector(31 downto 0);
  address : in std_logic_vector(9 downto 0)
  );
end cache_controller;

architecture dataflow of cache_controller is
  component data_array is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  wren: in std_logic;
  wrdata:in std_logic_vector(31 downto 0);
  data: out std_logic_vector(31 downto 0)
  );
end component;
  begin
    way0 : data_array port map(clk=>clk , address=>address(5 downto 0) , wren=> wren , wrdata=>in_data , data=>out_data);
    process(clk)
      if(clk'event and clk='1') then
        if(wren = '1')
        
    --end if;
  end dataflow;