% =========================================================================
% Matlab version: R2015b
% Character encoding: Shift-JIS
% =========================================================================
function [NSFunction] = DetermineZeroYieldCurve(CouponRate, Settle, QuestionNumber)
% DetermineZeroYieldCurve - Nelson-Siegel関数をフィットし、ゼロイールドカーブを引く
% INPUTS:  
%              CouponRate - （n*1 double vector）
%                  Settle - 決算日（DateNumber）
%          QuestionNumber - 設問の番号（int）
% Outputs:
%              NSFunction - Nelson-Siegel関数（CurveObj）と図

Price = repmat(100,[15 1]);%時価
MaturityInterval = [1 2 3 4 5 6 7 8 9 10 15 20 25 30 40]';%決算日からの年数
Maturity = datenum(MaturityInterval + year(Settle), month(Settle), day(Settle));%満期
Instruments = [repmat(Settle, [length(MaturityInterval) 1]) Maturity Price CouponRate/100];%利付債のデータ「精算日，満期，時価，クーポンレート」
NSFunction = IRFunctionCurve.fitNelsonSiegel('zero', Settle, Instruments);%Nelson-Siegel関数をフィットする
Parameters = NSFunction.Parameters;%パラメータの表示

% ゼロイールドカーブを引く
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