%
% RiskAversion.m (UtilityEstimate.mを実行して求まった結果を、べき効用関数
%                 f(x) = x^gamma で近似し、相対的リスク回避係数を表示する。
%                 UtilityEstimate.mの後に実行。) 
% 

gtmp = [];

for ii=1:length(C)-2,
  gtmp(ii) = log(U(ii+1))/log(C(ii+1));
end

gamma = mean(gtmp);

Y = []; Z = [];
for ii=1:101,
  Y(ii) = 0.01*(ii-1);
  Z(ii) = (Y(ii))^gamma;
end

plot(Y,Z,'r--')

stat = sprintf('  あなたの(相対的)リスク回避係数は%2.4fです。',1-gamma);
disp('  ');
disp(stat);

