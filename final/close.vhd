library ieee;
use ieee.std_logic_1164.all;
entity close is
port(closecontrol,orderclose:in std_logic;  --closecontrol���û��رտ����źţ�BTN4����orderclose�ǵ���ʱ��ϲ����Ĺر��ź�
     clk1kHz:in std_logic;  --ʱ���źţ�����ʱ���ź�
     modecontrol:in std_logic;  --�����źţ����û���BTN7ʱ����
     resetall:buffer std_logic);  --�ر�����ģ�飬���������ģ��
end close;

architecture behave of close is
signal mask:std_logic:='0';  --��ʼ���������������ڳ�ʼ����ֵ
begin

process(clk1kHz)
begin
if clk1kHz'event and clk1kHz='1' then
	--��ʼ����ֵ
	if resetall = '0' and mask='0' then
		resetall<='1'; mask<='1';
	end if;
	
	if modecontrol='1' then
		resetall<='0';  --����״̬��resetall='0'
	else 
		if closecontrol ='1' or orderclose = '1' then
			resetall<='1';  --�ػ�״̬��resetall='1'
		end if;
	end if;
end if;
end process;

end behave;