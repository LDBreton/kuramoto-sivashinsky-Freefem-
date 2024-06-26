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
function [X,T,Y] =  Ks_freefeem_sim(inicial_cond,meshN,Lmin,Lmax,Tfinal,dt)
syms x t y;
%escribiendo el archivo de freefem
Ks_source = Wrtitefreem(inicial_cond,'Condiciones_sim.edp');

command = char(strcat('FreeFem++ -nw -v 0 Ks_freefem_solver/Ks_simulator.edp', {' '},...
                      '-meshN', {' '} , num2str(meshN,16), {' '}, ...
                      '-Lmin', {' '} ,num2str(Lmin,16),{' '},...
                      '-Lmax', {' '} ,num2str(Lmax,16),{' '},...
                      '-Tfinal', {' '} ,num2str(Tfinal,16),{' '},...
                      '-dt', {' '} ,num2str(dt,16),{' '}));

[status,cmdout] = system(command);
%Ksapprox = str2num(cmdout(10:end));
Ksapprox = cell2mat(textscan(cmdout,'%f %f %f'));

NT = length(0:dt:Tfinal);
NX = length(Lmin:((Lmax-Lmin)/meshN):Lmax);
X = reshape(Ksapprox(:,1),[NX ,NT])';
T = reshape(Ksapprox(:,2),[NX ,NT])';
Y = reshape(Ksapprox(:,3),[NX ,NT])';

%[X,T] = meshgrid(Lmin:((Lmax-Lmin)/meshN):Lmax,0:dt:Tfinal);
%Ks_sol = scatteredInterpolant(Ksapprox(:,1),Ksapprox(:,2),Ksapprox(:,3),'linear');
%Result = Ks_sol(X,T);
