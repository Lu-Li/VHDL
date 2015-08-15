library ieee;
use ieee.std_logic_1164.all;
entity mode is 
port(clk1kHz:in std_logic;  --ʱ�����룬����ʱ��ģ��
	 modecontrol:in std_logic;  --�û�ģʽ���Ƽ����루BTN7��
	 timecontrol:in std_logic;  --�Զ�ģʽ�л��������루������ģʽ����3s���Զ�����峴ģʽ�������Ե���ʱģ��
	 reset:in std_logic;  --��λ���رգ��źţ����Թر�ģ��
	 state:out std_logic_vector(2 downto 0));  --�����ǰ��״̬�����������ģ�飬��ʱģ��
end mode;

architecture behave of mode is
type state_type is (C,H,J,B,T,Z);  --״̬�����ܹ�������״̬���ֱ�ΪC���ػ�����H��J��B��T��Z
signal present_state:state_type;  --��ǰ״̬
signal next_state:state_type;  --��һ��״̬
begin

nextstate_logic:process(present_state,modecontrol,timecontrol)  --״̬ת�ƽ���
begin
	case present_state is
		when C     => if modecontrol='1' then
						next_state<= H;
					  else
						next_state<= C;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
		when H     => if modecontrol='1' then
						next_state<= J;
					  else
						next_state<= H;
						if reset= '1' then
							next_state<=C;
	                    end if;
					  end if;
		when J	   => if modecontrol='1' then
							next_state<= B;
						else
							next_state<= J;
							if reset= '1' then
								next_state<=C;
							end if;
					  end if;
		when B     => if modecontrol='1' then
							next_state<= T;
					  else
						if timecontrol='1' then
							next_state<= J;
						else next_state<= B;
						end if; 
						if reset= '1' then
							next_state<=C;
						end if; 
					  end if;
		when T     => if modecontrol='1' then
						next_state<= Z;
					  else
						next_state<= T;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
		when Z     => if modecontrol='1' then
						next_state<= H;
					  else
						next_state<= Z;
						if reset= '1' then
							next_state<=C;
						end if;
					  end if;
	end case;
end process;

state_register:process(clk1kHz)  --ʱ�ӽ���
begin
	if clk1kHz'event and clk1kHz='1' then
		present_state<= next_state;
	end if;
end process;

output_logic:process(present_state)  --״̬���������
begin
  case present_state is
	when C      => state <="000";
	when H      => state <="001";
	when J      => state <="010";
	when B      => state <="011";
	when T      => state <="100";
	when Z      => state <="101";
	when others => state <="111";
  end case;
end process;

end behave;