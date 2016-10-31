--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:14:50 10/29/2016
-- Design Name:   
-- Module Name:   D:/Desktop/procesador 3/procesador 2 final alejandra/procesador 2 aleja/procesador_aleja/psr_tb.vhd
-- Project Name:  procesador_aleja
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_psr IS
END tb_psr;
 
ARCHITECTURE behavior OF tb_psr IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT psr
    PORT(
         nzvc : IN  std_logic_vector(3 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         ncwp : IN  std_logic;
         carry : OUT  std_logic;
         cwp : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal nzvc : std_logic_vector(3 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal ncwp : std_logic := '0';

 	--Outputs
   signal carry : std_logic;
   signal cwp : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: psr PORT MAP (
          nzvc => nzvc,
          clk => clk,
          reset => reset,
          ncwp => ncwp,
          carry => carry,
          cwp => cwp
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      reset <= '1';
		nzvc <= "0001";
		ncwp <= '1';
      wait for 100 ns;	
		reset <= '0';
		nzvc <= "0011";
		ncwp <= '1';
      wait for 100 ns;	
		reset <= '0';
		nzvc <= "0000";
		ncwp <= '1';
      wait for 100 ns;
		reset <= '0';
		nzvc <= "0001";
		ncwp <= '0';
      wait;
   end process;

END;
