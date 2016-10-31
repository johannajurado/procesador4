----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:15:35 10/18/2016 
-- Design Name: 
-- Module Name:    psr_modifier - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity psrM is
    Port ( crs1 : in  STD_LOGIC;
           crs2 : in  STD_LOGIC;
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           alures : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end psrM;

architecture arqPsrM of psrM is

begin
	process(crs1, crs2, alures,op3)
		begin
			if(op3 = "010000" or op3 = "011000")then --addcc y addxcc
				nzvc(3) <= alures(31);	
				if(alures = X"00000000")then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (crs1 and crs2 and (not alures(31))) or ((not crs1) and (not crs2) and alures(31));
				nzvc(0) <= (crs1 and crs2) or ((not alures(31)) and (crs1 or crs2));
			else
				if(op3 = "010100" or op3 = "011100")then --subcc y subxcc
					nzvc(3) <= alures(31);	
					if(alures = X"00000000")then
						nzvc(2) <= '1';
					else
						nzvc(2) <= '0';
					end if;
					nzvc(1) <= ((crs1 and (not crs2) and (not alures(31))) or ((not crs1) and crs2 and alures(31)));
					nzvc(0) <= ((not crs1) and crs2) or ((alures(31)) and ((not crs1) or crs2));
				else
					if(op3 = "000000" or op3 = "000100" or op3 = "000001" or op3 = "000010" or op3 = "000011" or op3 = "000111" or op3 = "000101" or op3 = "000110" or op3 = "001000" or op3 = "001100" or op3 = "010001" or op3 = "010010" or op3 = "010011" or op3 = "010101" or op3 = "010110" or op3 = "010111" or op3 = "100101" or op3 = "100110" or op3 = "100111")then
						nzvc(3) <= alures(31);
						if(alures = X"00000000")then
							nzvc(2) <= '1';
						else
							nzvc(2) <= '0';
						end if;
						nzvc(1) <= '0';
						nzvc(0) <= '0';
					end if;
				end if;
			end if;
	end process;
end arqPsrM;

