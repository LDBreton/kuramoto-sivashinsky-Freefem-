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
%%Para simular ks

%Parameters
meshN = 100; %\Delta_x
dt = 0.05; %\Delta_t
Tfinal = 100; %Final time of the simulation
Lmin =  -30; %L_min
Lmax = 30; %nL_max

%Incial condition, this also provides the boundary conditions
inicial_cond =  0.001*exp(-x^2);

[X,T,Y] =  Ks_freefeem_sim(inicial_cond,meshN,Lmin,Lmax,Tfinal,dt);


figure(2)
surf(X,T,Y);
shading interp

% % Animation
% [N,M]=size(X);
% for i = 10:N
% surf(X(1:i,:),T(1:i,:),Y(1:i,:));
% shading interp
% drawnow
% end
