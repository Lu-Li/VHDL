library ieee;
use ieee.std_logic_1164.all;
entity norder is
port(state:in std_logic_vector(2 downto 0);  --��ȡ��ǰ���״̬����ԴΪģʽģ��
	 timeset:out integer range 0 to 90;  --����ʱ�趨�źţ����������ʱ��ģ��
     reset:in std_logic);  --��λ���رգ��źţ���ԴΪ�ֶ�����ģ��͹ر�ģ��
end;

architecture behave of norder is
begin
process(state,reset)
begin
case state is
	when "011" => timeset<=3;
	when "101" => timeset<=20;
	when "001" => timeset<=90;
	when "010" => timeset<=90;
	when "100" => timeset<=90;
	when others=> timeset<=0;
end case;
if reset='1' then  --�Զ��趨ģ��ر�
  timeset<=0;
end if;
end process;

end behave;