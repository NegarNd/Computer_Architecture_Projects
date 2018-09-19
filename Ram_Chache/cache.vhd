library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity cache  is port (
clk : in std_logic;
address : in std_logic_vector(9 downto 0);
wren0,wren1 , lruenable : in std_logic;
wrdata: in std_logic_vector(31 downto 0);
invalid0,invalid1: in std_logic;
data_out: out std_logic_vector(31 downto 0);
hit , lruOutput: out std_logic
  );
end cache;

architecture dataflow of cache is
--  signal dataS : std_logic_vector(31 downto 0);
  --signal hitS : std_logic;
  signal index : std_logic_vector(5 downto 0);
  signal tag : std_logic_vector(3 downto 0);
  
  component data_array is port (
  clk: in std_logic;
  address: in std_logic_vector(5 downto 0);
  wren: in std_logic;
  wrdata:in std_logic_vector(31 downto 0);
  data: out std_logic_vector(31 downto 0)
  );
end component;


component tag_valid_array is port (
  clk : in std_logic;
  reset_n :in  std_logic;
  wren : in std_logic;
  invalidate: in std_logic;
  wrdata : in std_logic_vector(3 downto 0);
  address : in std_logic_vector(5 downto 0);
  output : out std_logic_vector(4 downto 0)
   );
end component;

component lru_array is port (
  clk : in std_logic;
 address : in std_logic_vector(5 downto 0 );
  lruen : in std_logic;
 w1Valid: out std_logic
   );
 end component;
 
 component miss_hit_logic is port (
  tag : in std_logic_vector(3 downto 0);
  w0 : in std_logic_vector(4 downto 0);
  w1 : in std_logic_vector(4 downto 0);
  hit : out std_logic;
  w0_valid : out std_logic;
  w1_valid : out std_logic
  );
end component;

signal  w0_validS,w1_validS : std_logic;
signal tag_valid_output0 , tag_valid_output1 : std_logic_vector(4 downto 0);
signal outputWay0 , outputWay1 ,dataOutS: std_logic_vector(31 downto 0 );
signal hitS : std_logic; --bayad assign beshe

begin
  index <= address(5 downto 0);
  tag<=address( 9 downto 6);
  tag_valid0 :tag_valid_array port map(clk ,'0',  wren0, invalid0, tag ,index , tag_valid_output0);
  tag_valid1 :tag_valid_array port map(clk ,'0',wren1, invalid1 , tag ,index , tag_valid_output1);
    
  data_array0 :  data_array port map(clk , index, wren0 ,wrdata ,outputWay0);
  data_array1 :  data_array port map(clk , index, wren1 ,wrdata ,outputWay1);
  
  miss_hit : miss_hit_logic port map(tag , tag_valid_output0, tag_valid_output1,hitS ,  w0_validS , w1_validS);
    
     
 cacheLru :   lru_array port map(clk, index ,lruenable ,lruOutput);
 

process (hitS)
  begin
 if(hitS='1')then
 if(w1_validS = '1') then
   dataOutS <= outputWay1;
 elsif(w1_validS = '0') then
   dataOutS <= outputWay0;
end if;
end if;
end process;
data_out<=dataOutS;
hit<=hitS;
end dataflow;