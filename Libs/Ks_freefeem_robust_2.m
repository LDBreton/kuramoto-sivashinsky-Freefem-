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
function [Solucions] =  Ks_freefeem_robust_2(KsOptions)
syms x t y;
%escribiendo el archivo de freefem
Wrtitefreem_robust_2(KsOptions.inicial_cond,KsOptions.Objetive_func);

command = char(strcat('FreeFem++ -nw -v 0 ks_robust/Ks_Robust_Temman.edp', {' '},...
                      '-meshN', {' '} , num2str(KsOptions.meshN,16), {' '}, ...
                      '-Lmin', {' '} ,num2str(KsOptions.Domain(1),16),{' '},...
                      '-Lmax', {' '} ,num2str(KsOptions.Domain(2),16),{' '},...
                      '-Tfinal', {' '} ,num2str(KsOptions.Tfinal,16),{' '},...
                      '-optitol', {' '} ,num2str(KsOptions.optitol,16),{' '},...
                      '-LminControlF', {' '} ,num2str(KsOptions.FollowerDom(1),16),{' '},...
                      '-LmaxControlF', {' '} ,num2str(KsOptions.FollowerDom(2),16),{' '},...
                      '-l', {' '} ,num2str(KsOptions.l,16),{' '},...
                      '-gamma', {' '} ,num2str(KsOptions.gamma,16),{' '},...
                      '-mu', {' '} ,num2str(KsOptions.mu,16),{' '},...
                      '-dt', {' '} ,num2str(KsOptions.dt,16),{' '}));

system(command,'-echo');
identifier = ['mu_',num2str(KsOptions.mu,16),...
			  '_l_',num2str(KsOptions.l,16),...
			  '_gamma_',num2str(KsOptions.gamma,16),...
			  '_beta1_',num2str(0,16),...
			  '_beta2_',num2str(0,16)];
dirsave = ['ks_robust/savefile/Control_robust_GD_nonlinar/',identifier];

%leyendo la solucion del estado primal con el punto silla
fileID = fopen([dirsave,'/Estados/usol_matlab.txt']);
usols = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%leyendo la perturbacion
fileID = fopen([dirsave,'/pertubacion/psi_sol_matlab.txt']);
psisol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%leyendo el controlfull
fileID = fopen([dirsave,'/seguidor/vfull_sol_matlab.txt']);
vfullsol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%leyendo el controlfull
fileID = fopen([dirsave,'/lider/hfull_sol_matlab.txt']);
hfullsol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);


%Creando las malla para ploteaar
NT = length(KsOptions.dt:KsOptions.dt:KsOptions.Tfinal);
MeshLenght = KsOptions.Domain(2) - KsOptions.Domain(1);
NX = length(KsOptions.Domain(1):(MeshLenght/KsOptions.meshN):KsOptions.Domain(2));

Solucions.Xusol = reshape(usols(:,1),[NX ,NT])';
Solucions.Tusol = reshape(usols(:,2),[NX ,NT])';
Solucions.Yusol = reshape(usols(:,3),[NX ,NT])';

Solucions.Xpsisol = reshape(psisol(:,1),[NX ,NT])';
Solucions.Tpsisol = reshape(psisol(:,2),[NX ,NT])';
Solucions.Ypsisol = reshape(psisol(:,3),[NX ,NT])';

Solucions.Xvfullsol = reshape(vfullsol(:,1),[NX ,NT])';
Solucions.Tvfullsol = reshape(vfullsol(:,2),[NX ,NT])';
Solucions.Yvfullsol = reshape(vfullsol(:,3),[NX ,NT])';

Solucions.Xhfullsol = reshape(hfullsol(:,1),[NX ,NT])';
Solucions.Thfullsol = reshape(hfullsol(:,2),[NX ,NT])';
Solucions.Yhfullsol = reshape(hfullsol(:,3),[NX ,NT])';


