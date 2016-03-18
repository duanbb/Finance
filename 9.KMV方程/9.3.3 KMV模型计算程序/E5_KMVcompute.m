%test KMV
%r: risk-free rate
r=0.0225; %ע���޷�������

%T: Time to expiration
T=1;%���� ����%ע��Ԥ������1��

%DP:Defaut point
%SD: short debt,  LD: long debt
SD=1e8;%���� %ע������ծ��������ծ��
LD=4e7;%���� %ע������ծ��
%����ΥԼ�� %ע����˾��ծ���г���ֵ
DP=SD+0.5*LD;%ע�����ݹ�˾�ĸ�ծ�������˾��ΥԼʵʩ�� ��default exercise poin t��Ϊ��ҵһ�����¶���ծ��ļ�ֵ����δ�峥����ծ�������ֵ��һ�룬������Ը�����Ҫ�趨��

%D:Debt maket value
D=DP;%ծ����г���ֵ�������޸�


%theta: volatility
%PriceTheta:  volatility of stock price
PriceTheta=0.2893;%(���룩
%EquityTheta: volatility of Theta value
EquityTheta=PriceTheta;%ע����˾�Ĺ�Ȩ��ֵ���꣩������
%AssetTheta: volatility of asset

%E:Equit maket value
E=141276427;%ע����˾�Ĺ�Ȩ��ֵ
%Va: Value of asset

%to compute the Va and AssetTheta
[Va,AssetTheta]=KMVOptSearch(E,D,r,T,EquityTheta)

%����ΥԼ����
DD=(Va-DP)/(Va*AssetTheta)
%����ΥԼ��
EDF=normcdf(-DD)