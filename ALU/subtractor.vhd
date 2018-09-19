
library IEEE;
use IEEE.std_logic_1164.all;

entity subtractor is port
(
a, b :in std_logic_vector(7 downto 0 );
bin : in std_logic;
sub : out std_logic_vector(7 downto 0 );
bout : out std_logic
);
end subtractor;


architecture behavioral of subtractor is


signal a1 , a2 , b1, b2: std_logic_vector(3 downto 0 );

signal subsignal : std_logic_vector(7 downto 0);

signal borrow:std_logic;

component fourbitsubtractor is port
(
a  , b: in std_logic_vector(3 downto 0 );
bin : in std_logic; 
sum : out std_logic_vector(3 downto 0);
bout : out std_logic
);

end component ; 

begin

  a1<=a(3 downto 0);

  a2<= a(7 downto 4);

  b1<=b(3 downto 0);

  b2<=b(7 downto 4);
  sub1: fourbitsubtractor port map(a1 , b1 , '0' , subsignal(3 downto 0 ) , borrow);

    sub2:fourbitsubtractor port map(a2,b2 , borrow , subsignal(7 downto 4) , bout);

     sub<=subsignal;

      end behavioral;
