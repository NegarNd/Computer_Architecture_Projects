library IEEE;
use IEEE.std_logic_1164.all;
entity cache_ram is
  port (
  clk , rw : in std_logic;
  dataIn : in std_logic_vector(31 downto 0);
  address : in std_logic_vector(9 downto 0);
  dataOut  :out std_logic_vector(31 downto 0)
  );
end cache_ram;

architecture dataflow of cache_ram is
  component cache_controller is port (
  clk : in std_logic;
  rw : in std_logic;
  hit : in std_logic;
  ram_ready : in std_logic;
  lruOutput : in std_logic;
  rwram , invalid0 , invalid1 , wren0 , wren1 , lruSignal : out std_logic
  
   );
end component;

component ram is port (
  clk : in std_logic;
  rw : in std_logic;
  address : in std_logic_vector(9 downto 0);
  data_in : in std_logic_vector(31 downto 0);
  data_out : out std_logic_vector(31 downto 0);
  data_ready: out std_logic
   );
end component;

component cache  is port (
clk : in std_logic;
address : in std_logic_vector(9 downto 0);
wren0,wren1 , lruenable : in std_logic;
wrdata: in std_logic_vector(31 downto 0);
invalid0,invalid1: in std_logic;
data_out: out std_logic_vector(31 downto 0);
hit , lruOutput: out std_logic
  );
end component;


--tarife signal ha
signal cachehit , ramreadySignal , lruoutputcache, rwRamSignal , invalidway0 , invalidway1, wrenway0 , wrenway1 , lrusignalcache : std_logic;
signal dataoutSignalram, dataoutSignalCache  :std_logic_vector(31 downto 0) ;
begin
    myController : cache_controller port map(clk, rw ,cachehit , ramreadySignal , lruoutputcache ,rwRamSignal , invalidway0 , invalidway1, wrenway0 , wrenway1 , lrusignalcache); 
      myCache : cache port map (clk , address ,  wrenway0 , wrenway1, lrusignalcache,dataoutSignalram, invalidway0 , invalidway1,dataoutSignalCache , cachehit,lruoutputcache);
        myRam : ram port map(clk,rwRamSignal,address,dataIn,dataoutSignalram,ramreadySignal);    
          
          dataOut<=dataoutSignalram;
  end dataflow;