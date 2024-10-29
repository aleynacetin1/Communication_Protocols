library IEEE;
use IEEE.Std_logic_1164.all;

entity fsm_spi_tb is
end;

architecture bench of fsm_spi_tb is

  component fsm_spi
    port(clk, rst, tx_enable:  in std_logic;
         mosi, ss, sclk: out  std_logic );
  end component;

  signal clk, rst, tx_enable: std_logic;
  signal mosi, ss, sclk: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

   pm: fsm_spi port map ( clk       => clk,
                          rst       => rst,
                          tx_enable => tx_enable,
                          mosi      => mosi,
                          ss        => ss,
                          sclk      => sclk );

  process -- stimulus
  begin
     
    rst<='1';
    wait for clock_period;
    
    rst<='0';
    tx_enable<='1';
    wait for clock_period;
	
    wait for clock_period*12;
    
    tx_enable<='0';
    stop_the_clock<=true;
    wait;

  end process;

  process -- clock generation
  begin
    while not stop_the_clock loop
        clk <= '0';
        wait for clock_period / 2;
        clk <= '1';    
        wait for clock_period / 2;  
    end loop;
    wait;
   end process;

end;