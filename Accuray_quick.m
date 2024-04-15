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
addpath('Libs/'); syms x t y;
% Para ver la presicion del metodo


%Parametros
meshN = 300; %numero de nodos en la malla
dt = 0.001; %numero de nodos en la malla
Tfinal = 1; %numero de nodos en la malla
Lmin =  -30; %numero de nodos en la malla
Lmax = 30; %numero de nodos en la malla

%funcion para ajustar condiciones de frontera
PeriodicFunc = sin(2*pi*(x-Lmin)/(Lmax-Lmin))^2; 

%%SOLUCION EXACTA
u = (t+1)*sin^2(pi*x/30.0);

%escribiendo el archivo de freefem
Ks_source = Wrtitefreem(u,'Condiciones_sol.edp');

command = char(strcat('FreeFem++ -nw -v 0 Ks_freefem_solver/Ks_Accuracycheck_Quick.edp', {' '},...
                      '-meshN', {' '} , num2str(meshN,16), {' '}, ...
                      '-Lmin', {' '} ,num2str(Lmin,16),{' '},...
                      '-Lmax', {' '} ,num2str(Lmax,16),{' '},...
                      '-Tfinal', {' '} ,num2str(Tfinal,16),{' '},...
                      '-dt', {' '} ,num2str(dt,16),{' '}));
tic;
[status,cmdout] = system(command);
toc;
error = str2num(cmdout(10:end));

fprintf(' Linfty_Error_norm= %d \n L2_Error_norm= %d\n',error(1),error(2))
