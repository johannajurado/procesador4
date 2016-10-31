--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:15:12 10/29/2016
-- Design Name:   
-- Module Name:   D:/Desktop/procesador 3/procesador 2 final alejandra/procesador 2 aleja/procesador_aleja/psrmodifier_tb.vhd
-- Project Name:  procesador_aleja
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PSR_Modifier
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
 
ENTITY tb_psrm1 IS
END tb_psrm1;
 
ARCHITECTURE behavior OF tb_psrm1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT psrM
    PORT(
         crs1 : IN  std_logic;
         crs2 : IN  std_logic;
         op3 : IN  std_logic_vector(5 downto 0);
         alures : IN  std_logic_vector(31 downto 0);
         nzvc : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal crs1 : std_logic := '0';
   signal crs2 : std_logic := '0';
   signal op3 : std_logic_vector(5 downto 0) := (others => '0');
   signal alures : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal nzvc : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: psrM PORT MAP (
          crs1 => crs1,
          crs2 => crs2,
          op3 => op3,
          alures => alures,
          nzvc => nzvc
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      crs1 <= '0';
		crs2 <= '0';
		op3 <= "000000";
		alures <= "11000000000000000000000000010100";
      wait for 100 ns;
		crs1 <= '1';
		crs2 <= '0';
		op3 <= "001000";
		alures <= "00000000000000000000000000010101";
      wait for 100 ns;
		crs1 <= '1';
		crs2 <= '1';
		op3 <= "010100";
		alures <= "10000000000000000000000000011100";
      wait for 100 ns;
		crs1 <= '0';
		crs2 <= '0';
		op3 <= "000000";
		alures <= "00000000000000000000000000011101";


      wait;
   end process;

END;
