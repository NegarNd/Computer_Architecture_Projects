library IEEE;
use IEEE.std_logic_1164.all;

entity logic_unit is port 
(
control : in std_logic_vector(3 downto 0);
a , b : in std_logic_vector(7 downto 0);
zeroflag :out std_logic;
result : out std_logic_vector(7 downto 0)
);
end logic_unit;

architecture behavioral of logic_unit is
  
  component andmodule is port
(
a , b : in std_logic_vector(7 downto 0);
aANDb : out std_logic_vector(7 downto 0)
);
end component;
 
component ormodule is port
(
a , b : in std_logic_vector(7 downto 0);
aORb : out std_logic_vector(7 downto 0)
);
end component;

component leftshift is port
(
a , b : in std_logic_vector(7 downto 0);
 shiftA: out std_logic_vector(7 downto 0)
);
end component;

component SAR is port
(
a: in std_logic_vector(7 downto 0);
shiftA : out std_logic_vector(7 downto 0)
);
end component;

signal andresult , orresult , shlresult , sarresult , selectresult : std_logic_vector(7 downto 0);
signal zero : std_logic;
  begin
    
   and1 : andmodule port map ( a, b , andresult);
      or1 : ormodule port map(a,b,orresult);
        shl : leftshift port map(a,b ,shlresult);
          sar1: SAR port map(a,sarresult);
            
            process(andresult , orresult , shlresult , sarresult , control)
              begin
                case control is
              when "0001" => selectresult<= andresult;
              when "0010" => selectresult<= orresult;
              when "0100" => selectresult <= shlresult;
              when "1000" => selectresult <= sarresult;
              when others => selectresult <="00000000";
              end case;
              if(selectresult<= "00000000") then
                zero <= '1';
              else
                zero<='0';
              end if;
            end process;
            zeroflag<=zero;
            result<=selectresult;
          end behavioral;                