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
addpath('Libs/'); 
syms x t y;

%Parametros del dominio
KsOptions.meshN = 50; %numero de nodos en la malla
KsOptions.dt = 0.05; %numero de nodos en la malla
KsOptions.Tfinal = 1; %tiempo final
KsOptions.Domain = [-30,30]; %Dominio Omega
KsOptions.FollowerDom = [-10,10]; %Dominio del seguidor

%%%%Parametros_del_control%%%%%%%%%%%
KsOptions.inicial_cond = sin(pi*x/30)*sin(pi*x/30); %condicion inicial
KsOptions.Objetive_func =  sin(pi*x/30)*sin(pi*x/30) + 0.05*t*(cos(pi*x/30) + 1);%exp(-x^2); %funcion objetivo
KsOptions.optitol = 10.0^(-6.0); %criterio de paro ||Grad_J|| < tol
KsOptions.l = 4.0; %parametro l
KsOptions.gamma =40.0; %parametro gamma
KsOptions.mu = 1.0; %parametro mu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Resolviendo Stackelberg
[Solucions] =  Ks_freefeem_robust_2(KsOptions);

XX = Solucions.Xusol; %malla de eje x                 
TT = Solucions.Tusol; %malla de eje t
                 
%plot u sol de punto silla en todo el domino
figure(1)
surf(XX,TT,Solucions.Yusol);
hold on
xlabel('x-axis');
ylabel('time-axis');

colormap hot 
shading interp

%freezeColors

%plot Obtejtivo
Objetivo_matlab = matlabFunction(KsOptions.Objetive_func,'Vars',[x t]);
surf(XX,TT,Objetivo_matlab(XX,TT));
colormap hot
shading interp
hold off
title('Sol vs Objective')



%plot pertubation en todo el dominio
figure(2)
surf(XX,TT,Solucions.Ypsisol);
xlabel('x-axis');
ylabel('time-axis');
shading interp
title('pertubation')
colormap hot 

%plot seguidor en todo el dominio
figure(3)
surf(XX,TT,Solucions.Yvfullsol);
xlabel('x-axis');
ylabel('time-axis');
shading interp
title('Follower')
colormap hot 

%plot Lider solo en el dominio de control
figure(4);
surf(XX,TT,Solucions.Yhfullsol);
xlabel('x-axis');
ylabel('time-axis');
shading interp
title('Lider')
colormap hot 

