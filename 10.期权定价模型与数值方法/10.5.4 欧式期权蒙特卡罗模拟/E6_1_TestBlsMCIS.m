%ע
S0=50;%��Ʊ��ǰ�۸�
K=52;%ִ�м�
r=0.1;%�޷�������
T=5/12;%��Ȩ�ĵ�����
sigma=0.4;%��Ʊ�����ı�׼��
NRepl=1000;%ģ�����
%ŷʽ������Ȩ�ļ۸�
%ŷʽ������Ȩ�ļ۸�ģ����Ȩ�۸�ķ������95%����Ȩ��������
[Price,VarPrice,Cl] = BlsMCIS(S0,K,r,T,sigma,NRepl)

%ŷʽ��Ȩ�Ľ�����ʽ��BSModel��
[call,put]= blsprice(S0,K,r,T,sigma)

NRepl=10000;
[Price1,VarPrice1,CI1]=BlsMCIS(S0,K,r,T,sigma,NRepl)