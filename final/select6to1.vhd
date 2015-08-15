library ieee;
use ieee.std_logic_1164.all;
entity select6to1 is
port(no1,no2,no3,no4,no5,no6:in std_logic_vector(3 downto 0);  --�����ź�����
						count6in:in std_logic_vector(2 downto 0);  --ѡ������ź�,��0~5����λѭ���ӷ�������
						selectout:out std_logic_vector(3 downto 0);  --����ѡ����������
						cat:out std_logic_vector(5 downto 0));  --ѡ����������Ŀ����ź�
end select6to1;

architecture behave of select6to1 is
begin

process(count6in)
begin
case count6in is
	when "101"=>selectout<=no6;cat<="111110";  --cat0ѡͨ
	when "100"=>selectout<=no5;cat<="111101";  --cat1ѡͨ
	when "011"=>selectout<=no4;cat<="111011";  --cat2ѡͨ
	when "010"=>selectout<=no3;cat<="110111";  --cat3ѡͨ
	when "001"=>selectout<=no2;cat<="101111";  --cat4ѡͨ
	when "000"=>selectout<=no1;cat<="011111";  --cat5ѡͨ
	when others=>selectout<="1111";cat<="111111";  --��������ܾ�δѡͨ
end case;
end process;

end behave;