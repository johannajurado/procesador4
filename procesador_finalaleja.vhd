----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:26:46 10/12/2016 
-- Design Name: 
-- Module Name:    procesador_finalaleja - arq_procesador 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity procesador_finalaleja is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           resultadoProcesador : out  STD_LOGIC_VECTOR (31 downto 0));
end procesador_finalaleja;

architecture arq_procesador of procesador_finalaleja is

COMPONENT sumador
	PORT(
		entrada_sum1 : IN std_logic_vector(31 downto 0);
		entrada_sum2 : IN std_logic_vector(31 downto 0);          
		salida_sumador : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT nPC
	PORT(
		clk : IN std_logic;
		reset : IN std_logic;
		actual : IN std_logic_vector(31 downto 0);          
		salida_nPC : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	
	
		COMPONENT memoriaInstrucciones
	PORT(
		direccion : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		instruccion : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT wm
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		ncwp : OUT std_logic;
		rs1w : OUT std_logic_vector(5 downto 0);
		rs2w : OUT std_logic_vector(5 downto 0);
		rdw : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	
	
		COMPONENT unidadControl
	PORT(
		op : IN STD_LOGIC_VECTOR(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);          
		salida_UC : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	
		COMPONENT registroArchivo_RF
	PORT(
		rs1 : IN std_logic_vector(5 downto 0);
		rs2 : IN std_logic_vector(5 downto 0);
		reset : IN std_logic;
		dataWrite : IN std_logic_vector(31 downto 0);
		rd : IN std_logic_vector(5 downto 0);          
		crs1 : OUT std_logic_vector(31 downto 0);
		crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT muxx
	PORT(
		i : IN std_logic;
		dato_seu : IN std_logic_vector(31 downto 0);
		crs2 : IN std_logic_vector(31 downto 0);          
		salida_mux : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
  
  
	COMPONENT seu
	PORT(
		inmediato13bits : IN std_logic_vector(12 downto 0);          
		salidaInmediato : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	


	COMPONENT psrM
	PORT(
		crs1 : IN std_logic;
		crs2 : IN std_logic;
		op3 : IN std_logic_vector(5 downto 0);
		alures : IN std_logic_vector(31 downto 0);          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;


COMPONENT psr
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		clk : IN std_logic;
		reset : IN std_logic;
		ncwp : IN std_logic;          
		carry : OUT std_logic;
		cwp : OUT std_logic
		);
	END COMPONENT;

		COMPONENT Alu
	PORT(
		entrada_suma1 : IN std_logic_vector(31 downto 0);
		entrada_sum2 : IN std_logic_vector(31 downto 0);
		alu_op : IN std_logic_vector(5 downto 0);
      Carry	: IN std_logic;	
		salida_ALU : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal sumadorToNPC,npcToPC,pcToIM,imToURS,aluResult,rfToalup1,rfTomux,seuTomux,muxToalu: STD_LOGIC_VECTOR (31 downto 0);--creo senales de 32
signal alup_op1,rs1wmtorf, rs2wmtorf, rdwmtorf: STD_LOGIC_VECTOR (5 downto 0);--creo senales de 6
signal wmtopsr,psrtowm,psrtoalu: STD_LOGIC := '0';--creo senal de 1
signal psrmtopsr: STD_LOGIC_VECTOR(3 downto 0);--creo senals de 4

begin

	Inst_sumador: sumador PORT MAP(
		entrada_sum1 =>x"00000001" ,
		entrada_sum2 =>npcToPC,
		salida_sumador =>sumadorToNPC 
	);



	Inst_nPC: nPC PORT MAP(
		clk =>clk ,
		reset =>reset ,
		actual =>sumadorToNPC ,
		salida_nPC =>npcToPC
	);
	
	

	Inst_PC: nPC PORT MAP(
		clk =>clk ,
		reset =>reset ,
		actual =>npcToPC,
		salida_nPC =>pcToIM
	);

	

	Inst_memoriaInstrucciones: memoriaInstrucciones PORT MAP( --la memoria se divide entre la unidad de control y RF
		direccion =>pcToIM ,
		instruccion =>imToURS  , --se divide en 32 bits entre unidad de control,register file y unidad de extension de signo
		reset =>reset 
	);
	

Inst_wm: wm PORT MAP(
		rs1 => imToURS(18 downto 14),
		rs2 => imToURS(4 downto 0),
		rd => imToURS(29 downto 25),
		op => imToURS (31 downto 30),
		op3 => imToURS(24 downto 19),
		cwp => psrtowm,
		ncwp => wmtopsr,
		rs1w => rs1wmtorf,
		rs2w => rs2wmtorf,
		rdw => rdwmtorf
	);




Inst_unidadControl: unidadControl PORT MAP(
		op =>imToURS(31 downto 30) , ---indica que tipo de formato estoy utilizando
		op3 =>imToURS(24 downto 19)  ,
		salida_UC =>alup_op1 
	);
	
	Inst_registroArchivo_RF: registroArchivo_RF PORT MAP(
		rs1 =>rs1wmtorf ,
		rs2 =>rs2wmtorf ,
		rd => rdwmtorf,
		dataWrite=>aluResult , ---- esta instruccion va de la ALU al dataWrite del register file
		reset => reset,
		crs1 =>rfToalup1 ,
		crs2 =>rfTomux 
		
	);
	
	Inst_psrM: psrM PORT MAP(
		crs1 => rfToalup1 (31),
		crs2 => rfTomux(31),
		op3 => alup_op1 ,
		alures => aluResult,
		nzvc => psrmtopsr
	);


	Inst_psr: psr PORT MAP(
	   nzvc => psrmtopsr,
		clk => clk,
		reset => reset,
		ncwp => wmtopsr,
		carry => psrtoalu,
		cwp => psrtowm
	);
	
	
	Inst_muxx: muxx PORT MAP(
		i =>imToURS(13) ,
		dato_seu =>seuTomux,
		crs2 =>rfTomux ,
		salida_mux =>muxToalu
	);

Inst_seu: seu PORT MAP(
		inmediato13bits =>imToURS(12 downto 0) ,
		salidaInmediato =>seuTomux 
	);
	


	
Inst_Alu: Alu PORT MAP(
		entrada_suma1 =>rfToalup1 ,
		entrada_sum2 =>muxToalu ,
		alu_op =>alup_op1 ,
		Carry => psrToalu,
		salida_ALU =>aluResult 
	);


resultadoProcesador<=aluResult;

end arq_procesador;

