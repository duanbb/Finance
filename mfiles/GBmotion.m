%
% GBmotion.m (幾何的ブラウン運動のシミュレーション)
%

disp('  原資産価格が幾何的ブラウン運動に従う場合のシミュレーションをします. ');
disp('  ');
disp('  ドリフト項 (mu), およびボラティリティ (sigma) を変えることによって,');
disp('  幾何的ブラウン運動のパスがどう変わるかを考察してください. ');
disp('  ');
input('  準備ができているならば, 何かキーを押してください. ');

disp('  ');
disp('  ドリフト項を入力して下さい. ');
mu=input('    ドリフト項 = ');
  if isempty(mu)>0, mu = 0.15; end;

disp('  ');
disp('  ボラティリティを入力して下さい. ');
sigma=input('    ボラティリティ = ');
  if isempty(sigma)>0, sigma = 0.35; end;

disp('  ');
disp('  原資産の初期価格を入力して下さい. ');
S0=input('    原資産の初期価格 = ');
  if isempty(S0)>0, S0 = 100; end;

disp('  ');
disp('  シミュレーション期間(=オプション満期)を入力して下さい. ');
T=input('    シミュレーション期間(年) = ');
  if isempty(T)>0, T = 0.5; end;

disp('  ');
disp('  分割数を入力して下さい. ');
N=input('    分割数 = ');
  if isempty(N)>0, N = 10000; end;

dt = T/N;

vecdB = randn([1,N]); vecdB = sqrt(dt)*vecdB; 
vecB = []; vecT = []; vecB(1) = vecdB(1); vecT(1) = dt;
for ii = 1:N-1,
   vecB(ii+1) = vecB(ii)+vecdB(ii+1);
   vecT(ii+1) = (ii+1)*dt;
end

nu = mu-sigma^2/2; 
vecS = nu*vecT+sigma*vecB; vecS = S0*exp(vecS);
vecS = [S0 vecS]; vecT = [0 vecT];

disp('  ');
disp('  原資産の価格変動を表示します. ');

figure(1)
plot(vecT,vecS);
xlabel('期間(年)')
ylabel('原資産価格')
