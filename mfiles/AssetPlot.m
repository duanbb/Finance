%
% AssetPlot.m (効率的フロンティアと各資産の平均・標準偏差を同時に表示。
%              port_data.mの後に実行する。ただし、資産数は5の場合。)
%



SD_vec = sqrt(diag(Cov_mat));
hold on;
plot(SD_vec,Mean_vec,'kx');
plot(PortSD,PortMean,'ko');

v = axis; del = (v(1)+v(2))/2*0.02;

text(SD_vec(1)+del,Mean_vec(1),'資産1')
text(SD_vec(2)+del,Mean_vec(2),'資産2')
text(SD_vec(3)+del,Mean_vec(3),'資産3')
text(SD_vec(4)+del,Mean_vec(4),'資産4')
text(SD_vec(5)+del,Mean_vec(5),'資産5')

hold off;

%
% x軸、y軸のスケールを調整する際は，
% axix([x軸の最小値,x軸の最小値,x軸の最小値,x軸の最小値])
% を入力する。
% 例)
% >> axis([0.01,0.024,0.5e-3,2e-3])
%
