%TestImpliedVolatility
Price=100; %ע���г��۸�
Strike=95; %ע��ִ�м۸�
Rate=0.10; %ע���޷�������
Time=1.0; %ע��ʱ�� ���꣩
CallPrice=15.0; %ע��������Ȩ���׼۸�
PutPrice=7.0; %ע��������Ȩ���׼۸�
%ע��û�в���
[Vc,Vp,Cfval,Pfval]=ImpliedVolatility(Price,Strike,Rate,Time,CallPrice,PutPrice)