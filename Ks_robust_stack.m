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
KsOptions.meshN = 100; %\delta_x
KsOptions.dt = 0.05; %delta_t
KsOptions.Tfinal = 2; %final time
KsOptions.Domain = [-30,30]; %Domain Omega
KsOptions.LiderDom = [-2,1.0]; %Domain lider
KsOptions.FollowerDom = [1.0,2.0]; %Domain follower

%%%%Parametros_del_control%%%%%%%%%%%
KsOptions.inicial_cond = 0.001*exp(-x^2); %inicial condition 
KsOptions.Objetive_func =  0.0*x;%exp(-x^2); %Objetive function
KsOptions.optitol = 10.0^(-6.0); % ||Grad_J|| < tol
KsOptions.l = 2.0; %param l
KsOptions.gamma =40.0; %param gamma
KsOptions.mu = 1.0; %param mu
KsOptions.beta1 = 1.0; %param beta1
KsOptions.beta2 = 0.0000001; %param beta2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Resolviendo Stackelberg 
[Solucions] =  Ks_freefeem_robustStack(KsOptions);

XX = Solucions.Xusol; %malla de eje x                 
TT = Solucions.Tusol; %malla de eje t
                 
%plot u sol de punto silla en todo el domino
figure(1)
surf(XX,TT,Solucions.Yusol);
% hold on
% xlabel('x-axis');
% ylabel('time-axis');
% 
% colormap hot 
% shading interp
% 
% %freezeColors
% 
% %plot Obtejtivo
% Objetivo_matlab = matlabFunction(KsOptions.Objetive_func,'Vars',[x t]);
% surf(XX,TT,zeros(size(XX)) + Objetivo_matlab(XX,TT));
% colormap hot
% shading interp
% hold off
% title('Sol vs Objective')
% 
% 
% 
% %plot pertubation en todo el dominio
% figure(2)
% surf(XX,TT,Solucions.Ypsisol);
% xlabel('x-axis');
% ylabel('time-axis');
% shading interp
% title('pertubation')
% colormap hot 
% 
% %plot seguidor en todo el dominio
% figure(3)
% surf(XX,TT,Solucions.Yvfullsol);
% xlabel('x-axis');
% ylabel('time-axis');
% shading interp
% title('Follower')
% colormap hot 
% 
% %plot Lider solo en el dominio de control
% figure(4)
% surf(XX,TT,Solucions.Yhfullsol);
% xlabel('x-axis');
% ylabel('time-axis');
% shading interp
% title('Lider')
% colormap hot 

