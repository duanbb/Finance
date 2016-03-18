%ע��9.3.3
function [Va,AssetTheta]=KMVOptSearch(E,D,r,T,EquityTheta)
%KMVOptSearch
%code by ariszheng@gmail.com
EtoD=E/D;
x0=[1,1];%���س�ʼ��
VaThetaX=fsolve(@(x) KMVfun(EtoD,r,T,EquityTheta,x), x0);%ע������ fsolve ������ⷽ����
Va=VaThetaX(1)*E;%ע����ԭ��ֵ
AssetTheta=VaThetaX(2);%ע����˾�г���ֵ�Ĳ�����
% F=KMVfun(EtoD,r,T,EquityTheta,x)