library ieee;
use ieee.std_logic_1164.all;
entity div is 
port (input:in integer range 0 to 90000;  --����ʱ���룬���Ե���ʱģ��
      outen,outone:out integer range 0 to 10);  --������ʾ����ʱ���룩��ʮλ���λ������������ģ��
end div;

architecture behave of div is
begin

process(input)
variable seconds:integer range 0 to 90;  --ת��inputΪ��
begin
seconds:=input/1000;  --ת��inputΪ��
outen<=seconds/10;  --�������input��ʮλ
outone<=seconds mod 10;  --�������input�ĸ�λ
end process;

end behave;