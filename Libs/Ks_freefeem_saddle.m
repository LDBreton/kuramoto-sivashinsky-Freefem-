% Authors: Louis Breton <louis.breton@ciencias.unam.mx>,
% Authors: Cristhian Montoya <cdmontoy@mat.uc.cl>,
%
% This program is free software: you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hopeC that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see
% <https://www.gnu.org/licenses/>.
%
%
function [sadle_table] =  Ks_freefeem_saddle(inicial_cond,...
					 Objetive_func,...
					 meshN,...
					 Lmin,Lmax,...
					 Tfinal,dt,...
					 l,gamma,mu,optitol,CRegions)
syms x t y;
%escribiendo el archivo de freefem
Wrtitefreem_robust(inicial_cond,Objetive_func);

command = char(strcat('FreeFem++ -nw -v 0 Ks_freefem_solver/RobustSaddlepoint_verification.edp', {' '},...
                      '-meshN', {' '} , num2str(meshN,16), {' '}, ...
                      '-Lmin', {' '} ,num2str(Lmin,16),{' '},...
                      '-Lmax', {' '} ,num2str(Lmax,16),{' '},...
                      '-Tfinal', {' '} ,num2str(Tfinal,16),{' '},...
                      '-optitol', {' '} ,num2str(optitol,16),{' '},...
                      '-LminControl', {' '} ,num2str(CRegions(1),16),{' '},...
                      '-LmaxControl', {' '} ,num2str(CRegions(2),16),{' '},...
                      '-l', {' '} ,num2str(l,16),{' '},...
                      '-gamma', {' '} ,num2str(gamma,16),{' '},...
                      '-mu', {' '} ,num2str(mu,16),{' '},...
                      '-dt', {' '} ,num2str(dt,16),{' '}));

system(command,'-echo');
identifier = ['mu_',num2str(mu,16),'_l_',num2str(l,16),'_gamma_',num2str(gamma,16)];
dirsave = ['Ks_freefem_solver/savefile/Control_robust_GD_nonlinar/',identifier];

fileID = fopen([dirsave,'/Saddle_point_table.txt']);
sadle_table = cell2mat(textscan(fileID,'%f %f %f %f'));
fclose(fileID);

