Price=20;%ע����Ĺ�Ʊ�۸�
Strike=20;%ע��ִ�м۸�
Rate=0.1;%ע���޷�������
Volatility=0.3;%ע���껯������
%%
subplot(2,1,1)
t=1:-0.05:0;
%t=0:0.05:1;%ע���˴�ָ������;ȡ������t=1:-0.05:0;��ͬ
Num=length(t);
PGNPrice=zeros(1,Num);
for i=1:Num;
    [Call, Put] = blsprice(Price, Strike, Rate, t(i), Volatility);%ע��ֻ�õ�Call��û�õ�Put
    PGNPrice(i)=1e4*(1.1)^(t(i)-1)+271.6027*Call;%ע����Ʋ�Ʒ��ֵ���޷���+�з��յ��ܺͣ��̶���1e4��������ղ�Ʒ����271�����ղ�Ʒ����Call��
    %ע��Ϊʲô�ò�ͬ��ti��һ����Ϊ�����ȡ��ʱ��ֹͣ����ʱ���ļ�ֵ�����룩�������Թ�Ʊ���ֲ������֣���̫��������
end
plot(t,PGNPrice,'-*')
legend('PGNPrice,Price=20')
%%
t=0.5;
subplot(2,1,2)
Price=10:1:30;%tʱ��Ʊ�����棨�������Ʋ�Ʒ��ע�ĵط�,�Ĺ�Ʊ���ǡ���
Num=length(Price);
PGNPrice=zeros(1,Num);
for i=1:Num;
    [Call, Put] = blsprice(Price(i), Strike, Rate, t, Volatility);
     PGNPrice(i)=1e4*(1.1)^(t-1)+271.6027*Call;
end
plot(Price,  PGNPrice,'-o')
legend('PGNPrice,Time=0.5')