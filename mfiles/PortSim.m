%
% PortSim.m (与えられた資産価格時系列データからポートフォリオ重みを計算)
%

disp('  ');
disp('  平均分散最適資産分配に必要なパラメータを計算します。');
disp('  パラメータの計算には資産価格行列(ピリオド数×資産数)が必要です。');
input('  準備ができているならば、何かキーを押してください。');

disp('  ');
disp('  資産価格行列(ピリオド数×資産数)を入力して下さい。');
asset_mat=input('    資産価格行列= ');

Ret_mat=price2ret(asset_mat,[],'Periodic'); % リターン行列の計算
Cov_mat=cov(Ret_mat);                       % 共分散行列の計算
Mean_vec=mean(Ret_mat);                     % 各資産のリターン平均の計算
M_a = length(asset_mat(1,:));               % 資産数(資産価格行列の列数)

disp('  ');
disp('  空売りを許す場合は1を，空売りなしの場合は0を入力して下さい。');
short=input('    空売りあり: 1，空売りなし: 0;  ');

disp('  ');
disp('  効率的フロンティアを表示します。');
input('  準備ができているならば、何かキーを押してください。');

if short > 0,
  ConSet = portcons('AssetLims',-5,5,M_a,'PortValue',1,M_a); 
  portopt(Mean_vec,Cov_mat,200,[],ConSet);
else,
  portopt(Mean_vec,Cov_mat,200);
end

disp('  ');
disp('  採用したい効率フロンティア上のポートフォリオの');
disp('  平均の値を入力して下さい。');
target_r=input('     r=');

if short > 0,
  [PortSD,PortMean,PortW]=portopt(Mean_vec,Cov_mat,[],target_r,ConSet);
else,
  [PortSD,PortMean,PortW]=portopt(Mean_vec,Cov_mat,[],target_r);
end


disp('  ');
disp('  PortSD, PortMean, PortW にポートフォリオの標準偏差、平均、重みが収納されてます。');

