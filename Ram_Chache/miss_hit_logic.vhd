library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
--use std.standard.boolean.all;
entity miss_hit_logic is port (
  tag : in std_logic_vector(3 downto 0);
  w0 : in std_logic_vector(4 downto 0);
  w1 : in std_logic_vector(4 downto 0);
  hit : out std_logic;
  w0_valid : out std_logic;
  w1_valid : out std_logic
  );
end miss_hit_logic;

architecture dataflow of miss_hit_logic is
  signal w0S , w1S , orResult : std_logic;
  signal hitSignal : std_logic;
  signal tag0 , tag1 : std_logic_vector(3 downto 0);
  signal valid0 , valid1 : std_logic;
begin
  valid0 <= w0(4);
  tag0 <= w0(3 downto 0);
  valid1 <= w1(4);
  tag1 <= w1(3 downto 0);
  w0S<= (tag(0)xnor tag0(0))and (tag(1)xnor tag0(1))and(tag(2)xnor tag0(2))and(tag(3)xnor tag0(3))and valid0;
  w1S<= (tag(0)xnor tag1(0))and (tag(1)xnor tag1(1))and(tag(2)xnor tag1(2))and(tag(3)xnor tag1(3)) and valid1;
  orResult <= w0S or w1S;
hitSignal <= '0' when orResult = 'U' else
             '0' when orResult ='0' else
             '1' when orResult = '1';
  w0_valid<=w0S;
  w1_valid<=w1S;
  hit<= hitSignal;
end dataflow;