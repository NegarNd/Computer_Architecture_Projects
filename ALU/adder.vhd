library IEEE;
use IEEE.std_logic_1164.all;

entity adder is port
(
a, b :in std_logic_vector(7 downto 0 );
cin : in std_logic;
sum : out std_logic_vector(7 downto 0 );
cout : out std_logic
);
end adder;


architecture behavioral of adder is


signal a1 , a2 , b1, b2: std_logic_vector(3 downto 0 );

signal sumsignal : std_logic_vector(7 downto 0);

signal carry:std_logic;

component fourbitadder is port
(
a  , b: in std_logic_vector(3 downto 0 );
cin : in std_logic; 
sum : out std_logic_vector(3 downto 0);
cout : out std_logic
);
end component;

begin

  a1<=a(3 downto 0);

  a2<= a(7 downto 4);

  b1<=b(3 downto 0);

  b2<=b(7 downto 4);

  adder1 : fourbitadder port map(a1 , b1 , '0' , sumsignal(3 downto 0 ) , carry);

    adder2:fourbitadder port map(a2,b2 , carry , sumsignal(7 downto 4) , cout);

      sum<=sumsignal;

      end behavioral;