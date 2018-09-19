library IEEE;
use IEEE.std_logic_1164.all;

entity multiplier is port
(
a , b : in std_logic_vector(7 downto 0);
multi : out std_logic_vector(7 downto 0)
);
end multiplier;

architecture behavioral of multiplier is

signal multisignal : std_logic_vector(15 downto 0);
signal b0a , b1a, b2a, b3a , b4a,b5a,b6a,b7a : std_logic_vector(7 downto 0);
signal result1, result2, result3,result4 , result5, result6 , result7 : std_logic_vector(8 downto 0);
--signal carry1, carry2,carry3,carry4,carry5,carry6 :std_logic;
component adder is port
(
a, b :in std_logic_vector(7 downto 0 );
cin : in std_logic;
sum : out std_logic_vector(7 downto 0 );
cout : out std_logic
);
end component;

begin
  b0a(7)<='0';
   for1 : for j in 0 to 6 generate
     b0a(j) <= b(0) and a(j+1);
   end generate;
  for2 : for I in 0 to 7 generate
   -- b0a(i) <= b(0) and a(i);
    b1a(i)<= b(1) and a(i);
    b2a(i)<= b(2) and a(i);
    b3a(i)<= b(3) and a(i);
    b4a(i)<= b(4) and a(i);
    b5a(i)<= b(5) and a(i);
    b6a(i)<= b(6) and a(i);
    b7a(i)<= b(7) and a(i);
  end generate;
  adder1 : adder port map (b0a(7 downto 0) , b1a , '0' , result1(7 downto 0) , result1(8));
    adder2 : adder port map(result1(8 downto 1) , b2a , '0' , result2(7 downto 0) , result2(8));
       adder3 : adder port map(result2(8 downto 1) , b3a , '0' , result3(7 downto 0) , result3(8));
          adder4 : adder port map(result3(8 downto 1) , b4a , '0' , result4(7 downto 0) , result4(8));
             adder5 : adder port map(result4(8 downto 1) , b5a , '0' , result5(7 downto 0) , result5(8));
                adder6 : adder port map(result5(8 downto 1) , b6a , '0' , result6(7 downto 0) , result6(8));
                   adder7 : adder port map(result6(8 downto 1) , b7a , '0' , result7(7 downto 0) , result7(8));
                  multisignal(0)<= b(0) and a(0);
                  multisignal(1)<= result1(0);
                  multisignal(2) <= result2(0);
                  multisignal(3) <= result3(0);
                  multisignal(4) <= result4(0);
                  multisignal(5) <= result5(0);
                  multisignal(6) <= result6(0);
                  multisignal(15 downto 7) <= result7(8 downto 0);
  multi <= multisignal(14 downto 7);
end behavioral;