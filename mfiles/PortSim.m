%
% PortSim.m (�^����ꂽ���Y���i���n��f�[�^����|�[�g�t�H���I�d�݂��v�Z)
%

disp('  ');
disp('  ���ϕ��U�œK���Y���z�ɕK�v�ȃp�����[�^���v�Z���܂��B');
disp('  �p�����[�^�̌v�Z�ɂ͎��Y���i�s��(�s���I�h���~���Y��)���K�v�ł��B');
input('  �������ł��Ă���Ȃ�΁A�����L�[�������Ă��������B');

disp('  ');
disp('  ���Y���i�s��(�s���I�h���~���Y��)����͂��ĉ������B');
asset_mat=input('    ���Y���i�s��= ');

Ret_mat=price2ret(asset_mat,[],'Periodic'); % ���^�[���s��̌v�Z
Cov_mat=cov(Ret_mat);                       % �����U�s��̌v�Z
Mean_vec=mean(Ret_mat);                     % �e���Y�̃��^�[�����ς̌v�Z
M_a = length(asset_mat(1,:));               % ���Y��(���Y���i�s��̗�)

disp('  ');
disp('  �󔄂�������ꍇ��1���C�󔄂�Ȃ��̏ꍇ��0����͂��ĉ������B');
short=input('    �󔄂肠��: 1�C�󔄂�Ȃ�: 0;  ');

disp('  ');
disp('  �����I�t�����e�B�A��\�����܂��B');
input('  �������ł��Ă���Ȃ�΁A�����L�[�������Ă��������B');

if short > 0,
  ConSet = portcons('AssetLims',-5,5,M_a,'PortValue',1,M_a); 
  portopt(Mean_vec,Cov_mat,200,[],ConSet);
else,
  portopt(Mean_vec,Cov_mat,200);
end

disp('  ');
disp('  �̗p�����������t�����e�B�A��̃|�[�g�t�H���I��');
disp('  ���ς̒l����͂��ĉ������B');
target_r=input('     r=');

if short > 0,
  [PortSD,PortMean,PortW]=portopt(Mean_vec,Cov_mat,[],target_r,ConSet);
else,
  [PortSD,PortMean,PortW]=portopt(Mean_vec,Cov_mat,[],target_r);
end


disp('  ');
disp('  PortSD, PortMean, PortW �Ƀ|�[�g�t�H���I�̕W���΍��A���ρA�d�݂����[����Ă܂��B');

