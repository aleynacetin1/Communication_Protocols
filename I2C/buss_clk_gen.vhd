library ieee; 
use ieee.std_logic_1164.all;

entity buss_clk_gen is
port(clk_100MHz: in std_logic; 
scl, dcl: out std_logic);
end entity;


architecture logic_flow of buss_clk_gen is 

signal count: natural range 0 to 11; 
signal clk_4MHz: std_logic:='0';
signal scl_buss, dcl_buss: std_logic:='0'; 

begin

scl<=scl_buss; dcl<=dcl_buss;

clk4MHz: process(clk_100MHz)
begin
	if (rising_edge(clk_100MHz)) then 
	count<=count + 1;
		if(count=12) then
		 clk_4MHz<=not clk_4MHz;
		c ount<=0;
		end if;
	end if;
end process;

clk1MHz: process (clk_4MHz) 
variable count_1: integer range 0 to 3:=0; 
begin

	if(rising_edge(clk_4MHz)) then
		if(count_1=0) then
		 scl_buss<='0';
		elsif(count_1=1) then
		 dcl_buss<='1';
		elsif(count_1=2) then
		 scl_buss<='1';
		else
		 dcl_buss<='0';
		end if;
		if(count_1=3) then
		 count_1:=0;
		else
		 count_1:=count_1 + 1;
		end if;
	end if;
end process;

end architecture;