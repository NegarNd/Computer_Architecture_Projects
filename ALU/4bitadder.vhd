library IEEE;
use IEEE.std_logic_1164.all;

entity fourbitadder is port
(
a  , b: in std_logic_vector(3 downto 0 );
cin : in std_logic; 
sum : out std_logic_vector(3 downto 0);
cout : out std_logic
);

end fourbitadder ; 

architecture behavioral of fourbitadder is
  
signal    g    : std_logic_vector(3 downto 0 );
signal    p    : std_logic_vector(3 downto 0 );
signal    carry_in : std_logic_vector(3 downto 0 );

begin 
    
    g <= a and b ;
    p <=a xor b;
    process(g,p,carry_in , cin)
    begin
    carry_in(0) <= g(0) or(p(0) and cin);
        inst: for i in 1 to 3 loop 
              carry_in(i) <= g(i) or (p(i) and carry_in(i-1));
              end loop;
    cout <= carry_in(3);
    end process;

    sum(0) <= p(0) xor cin ;
    sum(3 DOWNTO 1) <= p(3 downto 1) xor carry_in(2 downto 0);
end behavioral;
