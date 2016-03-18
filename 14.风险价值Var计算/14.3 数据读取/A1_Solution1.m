%% ����Ͷ����Ϸ��ռ�ֵ��VaR)-1
% ������ʹ�����ֲ�ͬ�ķ�������Ͷ����Ϸ��ռ�ֵ
% ���巽��Ϊ��
% 
% # ��ʷģ��
% # ����ģ��
% # ���ؿ���ģ�� 

%% Import data from Excel
% ��Excel�ж�ȡ����
% �ļ�CSI300.xlsx�������������ֱ�Ϊ����300ָ���ɷֹɼ۸����У�
% ����300ָ���ɷֹ�Ȩ�أ�������������300ָ���۸�
[num,txt]=xlsread('CSI300.xlsx','CSI300');
CSI300Dates=txt(4:end,1);%ʱ�� %ע����4�е����һ�У���һ�У�ʱ�䣩
CSI300Tickers=txt(2,2:end);%��Ʊ����
CSI300HistPrices=num;%�ɷֹ���ʷ�۸�
[num,txt]=xlsread('CSI300.xlsx','Portfolio Positions');
positionsPortfolio=num;%positionsPortfolio ��Ʊ����
[num,txt]=xlsread('CSI300.xlsx','CSI300-Index');
pricesIndex=num;%ָ���۸�
save CSI300Prices CSI300Dates CSI300Tickers CSI300HistPrices positionsPortfolio pricesIndex %ע���ļ��� ����1 ����2 ������
%% Convert price series to return series and visualize historical returns
% ������תΪ���������в�������ʷ��������
% ��������Ѵ��棨�ǵ�һ�����У�
clear variables
load('CSI300Prices.mat')

%% Visualize price series
% ���ӻ��۸�����
% ��׼���۸񣬳�ʼ�۸�Ϊ1.00
normPrices = ret2tick(tick2ret(CSI300HistPrices));%ע����һ���������Ϊ1��tick2ret������۸����ж�Ӧ�����������У�ret2tick�������ʡ��۸񣨳�ʼֵΪ1�����۸�������ʡ��۸�����Norm 1��׼�������á�

% ����ѡ����Ʊ�ı�׼���۸�'���A'��'Ϋ����'��'�Ϻ���Դ'
%ѡ����Ʊ %ע���������1���ڵ�λ��ȡֵ
mypick = strcmpi(CSI300Tickers, '���A') | strcmpi(CSI300Tickers, 'Ϋ����') ...
    | strcmpi(CSI300Tickers, '�Ϻ���Դ');
%ѡ����Ʊ�۸�����
mypickStockPrices = CSI300HistPrices(:, mypick);
%ѡ����Ʊ�ı�׼�۸�
mypickNormPrices = normPrices(:, mypick);
%ѡ����Ʊ������
mypickCSI300Tickers = CSI300Tickers(mypick);
%����ͼ��
plot(mypickNormPrices,'DisplayName','mypickNormPrices','YDataSource','mypickNormPrices');
figure(gcf)
legend(mypickCSI300Tickers)
normIndexPrice = ret2tick(tick2ret(pricesIndex));%ָ����׼�۸�
hold all
plot(normIndexPrice,'DisplayName','Index','YDataSource','normIndexPrice');
figure(gcf)
%% Simple data analysis, mean, std, correlation, beta
%������Ʊ�۸��������ֵ����׼��������beta
%�۸�ת������
mypickRet = tick2ret(mypickStockPrices, [], 'Continuous');
mean(mypickRet)%��ֵ
std(mypickRet)%��׼��
maxdrawdown(mypickStockPrices)  %���س�
corrcoef(mypickRet)% ����� %ע�����ϵ������Э���������㺯����cov��

% ��Beta����
IndexRet = tick2ret(pricesIndex);%ָ��������
SZ02 = tick2ret(mypickStockPrices(:,1));%ѡ�й�Ʊ�۸�תΪ������ %ע�����

% �Զ�����ͼƬ(cftool)
[fitresult, gof] = createFit(IndexRet, SZ02)

%% Calculate return from price series
%����۸����е�������
%�ɷֹ���ʷ������ 'Continuous'ָ����ʽ
returnsSecurity = tick2ret(CSI300HistPrices,[],'Continuous');%ע�����й�Ʊ��
%�ۼ�������
totalReturns = sum(returnsSecurity);%ע������Ĭ�ϰ��м���
numDays = size(CSI300HistPrices, 1);%ע����1�е�����

% ���ƹ�Ʊ�ȸ�ͼ����ά��  
%For more information edit the M-file "makeHeatmap.m"
makeHeatmap(totalReturns(end, :), CSI300Tickers, numDays, 'returns', 'matlab');

% [EOF]