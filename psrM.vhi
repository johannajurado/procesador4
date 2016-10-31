
-- VHDL Instantiation Created from source file psrM.vhd -- 12:50:10 10/31/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT psrM
	PORT(
		crs1 : IN std_logic;
		crs2 : IN std_logic;
		op3 : IN std_logic_vector(5 downto 0);
		alures : IN std_logic_vector(31 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	Inst_psrM: psrM PORT MAP(
		crs1 => ,
		crs2 => ,
		op3 => ,
		alures => ,
		nzvc => 
	);


