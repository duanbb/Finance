%
% BScall.m (コールオプション価格変動の計算)
%

disp('  ');
disp('  原資産価格変動に対するコールオプション価格の変動を計算します。');
disp('  GBmotion.m を実行した後に、実行してください。');
input('  準備ができているならば、何かキーを押してください。');

disp('  ');
disp('  行使価格を入力して下さい。');
K=input('    行使価格 = ');
if isempty(K)>0, K = S0; end;

disp('  ');
disp('  無リスク利子率を入力して下さい。');
r=input('    無リスク利子率 = ');
  if isempty(r)>0, r = 0.05; end;

vecC = [];
vectau = T*ones(size(vecT)); vectau = vectau-vecT;
for nn = 1:N+1,
  vecC(nn) = blsprice(vecS(nn),K,r,vectau(nn),sigma,0);
end

disp('  ');
disp('  ヨーロピアンコールオプション価格を表示します。');
disp('  実線は、オプション価格と保有期間との関係を表し、');
disp('  点線は、本質価値max(S-K,0)を表します。');

figure(2)
hold off;
ival = vecS-K*ones(size(vecS));
for ii = 1:length(ival),
  ival(ii) = max(ival(ii),0);
end

plot(vecT,vecC,'b-',vecT,ival,'r:');
xlabel('期間(年)')
ylabel('ヨーロピアンコールオプション価格(実線)と本質価値max[S-K,0](点線)')

