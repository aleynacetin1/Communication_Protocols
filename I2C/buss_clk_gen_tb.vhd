library ieee; 
use ieee.std_logic_1164.all;

entity buss_clk_gen_tb is 
end;

architecture bench of buss_clk_gen_tb is

component buss_clk_gen
port(clk_100MHz: in std_logic; 
     scl, dcl: out std_logic); 
end component;

signal clk_100MHz: std_logic; 
signal scl, dcl: std_logic;

constant clock_period: time := 10 ns; 

signal stop_the_clock: boolean;

begin

pm: buss_clk_gen port map(
                          clk_100MHz => clk_100MHz,
                          scl       => scl,
                          dcl       => dcl );

p1: process --stimulus  
begin          
	wait for clock_period*10*100; 
	stop_the_clock<=true;
	wait;
end process;

p2: process --clock generation 
begin
	while not stop_the_clock loop 
	clk_100MHz<='0';
	wait for clock_period / 2; 
	clk_100MHz<='1';    
	wait for clock_period / 2;  
	end loop;
	wait;
end process;

end architecture;