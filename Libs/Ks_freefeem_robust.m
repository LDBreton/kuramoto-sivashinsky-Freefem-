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
function [Xysol,Tysol,Yysol,...
          Xpsisol,Tpsisol,Ypsisol,...
          Xvsol,Tvsol,Yvsol,...
          Xvfullsol,Tvfullsol,Yvfullsol]...
				  =  Ks_freefeem_robust(inicial_cond,...
					 Objetive_func,...
					 meshN,...
					 Lmin,Lmax,...
					 Tfinal,dt,...
					 l,gamma,mu,optitol,CRegions)
syms x t y;
%escribiendo el archivo de freefem
Wrtitefreem_robust(inicial_cond,Objetive_func);

command = char(strcat('FreeFem++ -nw -v 0 Ks_freefem_solver/Robust_Temman_nonlinear.edp', {' '},...
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


%%calculando el punto silla
system(command,'-echo');

%%Directorio donde se guardo toda la informacion
identifier = ['mu_',num2str(mu,16),'_l_',num2str(l,16),'_gamma_',num2str(gamma,16),'_Lmin_',num2str(CRegions(1),16),'_Lmax_',num2str(CRegions(2),16)];
dirsave = ['Ks_freefem_solver/savefile/Control_robust_GD_nonlinar/',identifier];

%%leyendo la solucion del estado primal con el punto silla
fileID = fopen([dirsave,'/Estados/ysol_matlab.txt']);
ysols = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%%leyendo la perturvacion
fileID = fopen([dirsave,'/pertubacion/psi_sol_matlab.txt']);
psisol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%%leyendo el controlfull
fileID = fopen([dirsave,'/control/vfull_sol_matlab.txt']);
vfullsol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%%leyendo el control
fileID = fopen([dirsave,'/control/v_sol_matlab.txt']);
vsol = cell2mat(textscan(fileID,'%f %f %f'));
fclose(fileID);

%%Creando las malla para ploteaar
NT = length(dt:dt:Tfinal);
NX = length(Lmin:((Lmax-Lmin)/meshN):Lmax);
%% [Lmin,Lmax] x [dt,Tfinal]
Xysol = reshape(ysols(:,1),[NX ,NT])';
Tysol = reshape(ysols(:,2),[NX ,NT])';
Yysol = reshape(ysols(:,3),[NX ,NT])';

Xpsisol = reshape(psisol(:,1),[NX ,NT])';
Tpsisol = reshape(psisol(:,2),[NX ,NT])';
Ypsisol = reshape(psisol(:,3),[NX ,NT])';

Xvfullsol = reshape(vfullsol(:,1),[NX ,NT])';
Tvfullsol = reshape(vfullsol(:,2),[NX ,NT])';
Yvfullsol = reshape(vfullsol(:,3),[NX ,NT])';


%% [Lmin,Lmax] x [dt,Tfinal]
NX = floor((1.0/((Lmax-Lmin)/meshN))*(CRegions(2)-CRegions(1)))+1;
Xvsol = reshape(vsol(:,1),[NX ,NT])';
Tvsol = reshape(vsol(:,2),[NX ,NT])';
Yvsol = reshape(vsol(:,3),[NX ,NT])';


%[X,T] = meshgrid(Lmin:((Lmax-Lmin)/meshN):Lmax,0:dt:Tfinal);
%Ks_sol = scatteredInterpolant(Ksapprox(:,1),Ksapprox(:,2),Ksapprox(:,3),'linear');
%Result = Ks_sol(X,T);
