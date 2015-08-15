library ieee;
use ieee.std_logic_1164.all;
entity fangdou is
port( clk100Hz:in std_logic;  --Ê±ÖÓÊäÈë
	  input:in std_logic;  --·À¶¶Æ÷ÊäÈë
	  output:out std_logic);  --·À¶¶Æ÷Êä³ö
end fangdou;

architecture behave of fangdou is
signal inputemp1,inputemp2:std_logic;
begin

process(clk100Hz)
begin
if clk100Hz'event and clk100Hz='0' then
  inputemp2<=inputemp1;
  inputemp1<=input;
end if;
end process;

  output<=clk100Hz and inputemp1 and (not inputemp2);
end behave;