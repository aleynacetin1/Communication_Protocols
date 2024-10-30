library ieee;
use ieee.std_logic_1164.all;

entity uart_tx_tb is 
end entity;

architecture bench of uart_tx_tb is

component uart_tx
port(clk, rst, trig: in std_logic;
data_to_send: in std_logic_vector(7 downto 0); 
tx,clk_out: out std_logic);
end component;

signal clk, rst, trig: std_logic;
signal data_to_send: std_logic_vector(7 downto 0); 
signal tx,clk_out: std_logic:='0';
constant clock_period: time := 10 ns; 
signal stop_the_clock: boolean;

begin

pm: uart_tx port map (
clk => clk,
rst => rst,
trig => trig,
data_to_send => data_to_send, 
tx=> tx,
clk_out => clk_out);

ps: process --stimulus  
begin 
	rst<='1'; trig <= '0'; rst<='0'; 
	wait for clock_period*2*5208; 
	trig <= '1';
	wait for clock_period*2*5208;
	data_to_send<="10010001"; 
	wait for clock_period*8*2*5208;
	stop_the_clock<=true; 
	wait;
end process;

pc: process --clock generation 
begin

	while not stop_the_clock loop 
	clk<='0';
	wait for clock_period / 2; 
	clk<='1';    
	wait for clock_period / 2;  
	end loop;
	wait;
end process;

end architecture;