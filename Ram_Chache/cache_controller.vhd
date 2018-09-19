library IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
use IEEE.std_logic_textio.all; 
use std.textio.all;
entity cache_controller is port (
  clk : in std_logic;
  rw : in std_logic;
  hit : in std_logic;
  ram_ready : in std_logic;
  lruOutput : in std_logic;
  rwram , invalid0 , invalid1 , wren0 , wren1 , lruSignal : out std_logic
  
   );
end cache_controller;
architecture dataflow of cache_controller is
  type state_type is (s0 ,s1,s2,s3,s4,s5,s6);
    signal state : state_type := s0;
    signal wren0s , wren1s :std_logic;
  begin 
  process(clk)
      variable wren0var , wren1var : std_logic;  
    begin
        
       if(clk'event and clk='1') then

          case state is
        when s0 =>
          if(rw='1')then
          rwram<='1';
          invalid0<='1';
          invalid1<='1';
                       state<=s1;
          elsif(rw='0')then--rwram<='0'
            wren0var:='0';
            wren1var :='0';
           invalid0<='U';
            invalid1<='U';
            lrusignal<='0';
            state<=s6;
          end if;
      when s1=>
           wren0var :='U';
           wren1var:= 'U';
           lrusignal<='0';

        state<= s0;
      when s6 =>
        wren0var :='U';
           wren1var:= 'U';
        state<=s2;
      when s2 =>
        if(hit = '1')then
          state<=s0;
          
           lrusignal<='0';
        elsif(hit= '0')then
          rwram<='0';
           wren0var :='U';
           wren1var:= 'U';
           lruSignal<='1';
          state<=s3;
          
        end if;
      when s3=>
        lruSignal<='0';
        state<=s4;
    when s4 =>
       if(ram_ready = '1')then
          if(lruOutput = '1')then
          wren1var :='1';
          invalid1<='0';
         elsif(lruOutput = '0')then
          wren0var:='1';
          invalid0<='0';
        end if;
      end if;
        lruSignal<='0';
         state<=s5;
   when s5 =>
      state<=s0;
       wren0var :='U';
           wren1var:= 'U';
           lrusignal<='0';
      end case;
    end if;
    wren0s <=wren0var;
    wren1s <=wren1var;
  end process;
  wren0<=wren0s;
  wren1<=wren1s;
  
  end dataflow;