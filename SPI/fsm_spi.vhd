library ieee;
use ieee.std_logic_1164.all;
entity fsm_spi  is
    port(clk, rst, tx_enable:  in std_logic;
         mosi, ss, sclk: out  std_logic );
end entity;

architecture logic_flow of  fsm_spi  is
    type state is (st_idle, st0_txmt, st1_txmt);
    signal present_state, next_state: state;

    constant control: std_logic_vector(3 downto 0) :="1110";
    constant data: std_logic_vector(7 downto 0) :="11010110";
  
    constant max_length: natural:=8;
    signal timer: natural range 0 to max_length;
    signal data_index: natural range 0 to max_length;

  signal spi_sclk: std_logic;
begin
    spi_sclk<=clk;
    sclk<=spi_sclk;

    process(spi_sclk, rst) 
    begin
        if(rst='1') then
            present_state<= st_idle;
            data_index <= 0;	
        elsif (spi_sclk'event and spi_sclk='0') then
            if(data_index=timer-1) then
                present_state<=next_state;
                data_index <=0;
            else
                data_index <= data_index +1;
            end if;      
        end if;
    end process;
  
    process(present_state, tx_enable, data_index) -- Circuit outputs and next state values
    begin
    
    
        case present_state is
            when st_idle =>
                ss<='1';
                mosi<='X';
                timer<=1;
                if(tx_enable ='1') then
                    next_state<= st0_txmt;
                else
                    next_state<= st_idle;
                end if;      
            when st0_txmt =>
                ss<='0';
                timer<=4;
                mosi<= control(3-data_index);
                next_state<= st1_txmt; 
              
            when st1_txmt =>
                ss<='0';
                timer<=8;
                mosi<= data(7-data_index);
                next_state<= st_idle; 
          
        end case;
    end process;

 end logic_flow;

  
