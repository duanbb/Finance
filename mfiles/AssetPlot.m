%
% AssetPlot.m (�����I�t�����e�B�A�Ɗe���Y�̕��ρE�W���΍��𓯎��ɕ\���B
%              port_data.m�̌�Ɏ��s����B�������A���Y����5�̏ꍇ�B)
%



SD_vec = sqrt(diag(Cov_mat));
hold on;
plot(SD_vec,Mean_vec,'kx');
plot(PortSD,PortMean,'ko');

v = axis; del = (v(1)+v(2))/2*0.02;

text(SD_vec(1)+del,Mean_vec(1),'���Y1')
text(SD_vec(2)+del,Mean_vec(2),'���Y2')
text(SD_vec(3)+del,Mean_vec(3),'���Y3')
text(SD_vec(4)+del,Mean_vec(4),'���Y4')
text(SD_vec(5)+del,Mean_vec(5),'���Y5')

hold off;

%
% x���Ay���̃X�P�[���𒲐�����ۂ́C
% axix([x���̍ŏ��l,x���̍ŏ��l,x���̍ŏ��l,x���̍ŏ��l])
% ����͂���B
% ��)
% >> axis([0.01,0.024,0.5e-3,2e-3])
%
