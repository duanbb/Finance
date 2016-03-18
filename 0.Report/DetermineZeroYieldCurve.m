% =========================================================================
% Matlab version: R2015b
% Character encoding: Shift-JIS
% =========================================================================
function [NSFunction] = DetermineZeroYieldCurve(CouponRate, Settle, QuestionNumber)
% DetermineZeroYieldCurve - Nelson-Siegel�v����ե��åȤ��������`��ɥ��`�֤�����
% INPUTS:  
%              CouponRate - ��n*1 double vector��
%                  Settle - �Q���գ�DateNumber��
%          QuestionNumber - �O���η��ţ�int��
% Outputs:
%              NSFunction - Nelson-Siegel�v����CurveObj���ȇ�

Price = repmat(100,[15 1]);%�r��
MaturityInterval = [1 2 3 4 5 6 7 8 9 10 15 20 25 30 40]';%�Q���դ��������
Maturity = datenum(MaturityInterval + year(Settle), month(Settle), day(Settle));%����
Instruments = [repmat(Settle, [length(MaturityInterval) 1]) Maturity Price CouponRate/100];%�������Υǩ`���������գ����ڣ��r�������`�ݥ��`�ȡ�
NSFunction = IRFunctionCurve.fitNelsonSiegel('zero', Settle, Instruments);%Nelson-Siegel�v����ե��åȤ���
Parameters = NSFunction.Parameters;%�ѥ��`���α�ʾ

% �����`��ɥ��`�֤�����
figure
scatter(MaturityInterval, CouponRate, 'black')
hold on
PlotedMaturity = datenum((1:40) + year(Settle), month(Settle), day(Settle));
SpotRate = NSFunction.getZeroRates(PlotedMaturity);
plot((1:40), SpotRate*100,'-r')
hold on
title({['Nelson-Siegel function of Question ' sprintf('%d', QuestionNumber) ];['(\beta_{0} = '  sprintf('%3.2f',Parameters(1)) ', ' ...
           '\beta_{1} = ' sprintf('%3.2f',Parameters(2)) ', ' ...
           '\beta_{2} = ' sprintf('%3.2f',Parameters(3)) ', ' ...
           '\lambda = ' sprintf('%3.2f',Parameters(4))     ')']})
xlabel(['Maturity (years after ' datestr(Settle) ')'])
ylabel('Rate (%)')
legend('Coupon rate','Zero yield curve','Location','southeast')
legend(gca,'boxoff')

end