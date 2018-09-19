library IEEE;
use IEEE.std_logic_1164.all;

entity fourbitsubtractor is port
(
a  , b: in std_logic_vector(3 downto 0 );
bin : in std_logic; 
sum : out std_logic_vector(3 downto 0);
bout : out std_logic
);

end fourbitsubtractor ; 

architecture behavioral of fourbitsubtractor is
  
signal    g    : std_logic_vector(3 downto 0 );
signal    p    : std_logic_vector(3 downto 0 );
signal    borrow_in : std_logic_vector(3 downto 0 );
--variable borrow0 : std_logic;
begin 
     
    g <= b and (not a) ;
    p <=b or (not a);
    
    process(g,p,borrow_in,bin)
    begin
    borrow_in(0) <= g(0) or(p(0) and bin);
        inst: for i in 1 to 3 loop 
          
              borrow_in(i) <= g(i) or (p(i) and borrow_in(i-1));
           
              end loop;
    bout <= borrow_in(3);
      sum(0) <= a(0) xor b(0) xor bin ;
    sum (3 DOWNTO 1) <= a(3 downto 1) xor b(3 downto 1) xor borrow_in(2 downto 0);
    end process;

  
end behavioral;