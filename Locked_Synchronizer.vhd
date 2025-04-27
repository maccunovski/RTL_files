-----------------------------------------------------------------------------------------------
-- maccunovski, 28.10.2024
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------
-- LIBRARY
-----------------------------------------------------------------------------------------------
library IEEE;
  use IEEE.STD_LOGIC_1164.ALL;

-----------------------------------------------------------------------------------------------
-- ENTITY
-----------------------------------------------------------------------------------------------
entity Locked_Synchronizer is
  port (
    -- main clock input
    CLOCK_I                                   : in    std_logic                               ; 
    -- asynchronous locked signal input
    ASYNC_LOCKED_I                            : in    std_logic                               ;
    -- synchronous locked signal output       
    SYNC_LOCKED_O                             : out   std_logic                              );
end Locked_Synchronizer;

-----------------------------------------------------------------------------------------------
-- ARCHITECTURE
-----------------------------------------------------------------------------------------------
architecture rtl of Locked_Synchronizer is

  ---------------------------------------------------------------------------------------------
  -- CONSTANTS
  ---------------------------------------------------------------------------------------------
  -- N/A
  
  ---------------------------------------------------------------------------------------------
  -- COMPONENTS
  ---------------------------------------------------------------------------------------------
  -- N/A

  ---------------------------------------------------------------------------------------------
  -- STATES AND ARRAYS
  ---------------------------------------------------------------------------------------------
  -- N/A

  ---------------------------------------------------------------------------------------------
  -- SIGNALS
  ---------------------------------------------------------------------------------------------
  signal async_locked_w                       : std_logic                                     ;
  signal sync_locked_d0_r                     : std_logic                                     ;
  signal sync_locked_d1_r                     : std_logic                                     ;
  signal sync_locked_d2_r                     : std_logic                                     ;


-----------------------------------------------------------------------------------------------
-- MAIN BODY
-----------------------------------------------------------------------------------------------
begin

  -- input port assignments
  async_locked_w                              <= ASYNC_LOCKED_I                               ;
  
  -- output port assignments
  SYNC_LOCKED_O                               <= sync_locked_d2_r                             ;

  ---------------------------------------------------------------------------------------------
  -- SYNCHRONIZATION PROCESS
  ---------------------------------------------------------------------------------------------
  -- Locked signal from clocking wizard is used as active-low reset signal for internal modules
  -- Internal modules' reset signal is asserted asynchronously and deasserted synchronously by this process
  synchronizer_p : process(CLOCK_I, async_locked_w)
  begin
    if (async_locked_w = '0') then
      
      sync_locked_d0_r                        <= '0'                                          ;
      sync_locked_d1_r                        <= '0'                                          ;
      sync_locked_d2_r                        <= '0'                                          ;

    elsif rising_edge(CLOCK_I) then
      
      sync_locked_d0_r                        <= async_locked_w                               ;
      sync_locked_d1_r                        <= sync_locked_d0_r                             ;
      sync_locked_d2_r                        <= sync_locked_d1_r                             ;

    end if;
  end process;


end rtl;