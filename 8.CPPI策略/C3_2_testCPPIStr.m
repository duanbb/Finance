%%
%set value
PortValue=100; %Portfoilo Value %ע����Ʒ��ϳ�ʼ��ֵ��A0��
Riskmulti=2;%ע��CPPI ���Եķ��ճ�����M��
GuarantRatio=1.00;%ע����Ʒ�ı����ʣ�100%��ȫ��������lambda����ʼ���տ���ˮƽ��
TradeDayTimeLong=250;%ע����Ʒ���ޣ��Խ����ռ�����250��������
TradeDayOfYear=250;%ע��ģ�����һ�꽻��Ϊ 250 ��
adjustCycle=10;%ע����������Ϊÿ 10 �������յ���һ��
RisklessReturn=0.05;%ע���޷����ʲ��껯�����ʣ�r��
TradeFee=0.005;%ע�������ʲ��Ľ��׷��ã�%��
%%
%to generate random number
Mean=1.2^(1/TradeDayOfYear)-1;%ע�������ʲ�����300����Ԥ�������ʣ�0.2�����껯ת�ջ�����1+�գ�^250=1.2
Std=0.3/sqrt(TradeDayOfYear);%ע�������ʲ�����300����Ԥ�ڲ����ʣ���׼�0.3�����껯ת�ջ�
Price0=100;%ע�������ʲ��ĳ�ʼ�۸�
SData=RandnPrice(Price0,Mean,Std,TradeDayOfYear)%ע��ģ������ʲ�������300ָ�����������У������˶���������̬�ֲ������ƣ����ɱ仯��ļ۸�����У�
SData=[Price0;SData]%ע������ʼ�۸�������۸����У�%[X0,Xl,...,Xn]
%%
%to computer
[F,E,A,G,SumTradeFee,portFreez]=CPPIStr(PortValue,Riskmulti,GuarantRatio,...
    TradeDayTimeLong,TradeDayOfYear,adjustCycle,RisklessReturn,TradeFee,SData);
%%
%to plot
figure;
%ע����ͼ1��ģ���������շѿ�ļ۸�����
subplot(2,1,1)
plot(SData)
xlabel('t');
ylabel('price')
legend('Hs300-Simulation')
%ע����ͼ2��CPPI ���Ե��������
subplot(2,1,2)
plot(A,'-.')  
hold on
plot(E,'--')
plot(F,'-k')  
plot(G,'-x')
%ע���������
legend('PortValue','RiskAssect','GuarantLine','RisklessAssect')
xlabel('t');
ylabel('price')
SumTradeFee