addpath('Libs/'); syms x t y;
%%Para simular ks
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

%Parametros del dominio
meshN = 50; %\deta_x
dt = 0.05; %\delta_t
Tfinal = 1.0; %final time
Lmin =  -30; %L_min
Lmax = 30; %L_max
%%%%Parametros_del_control%%%%%%%%%%%
inicial_cond = sin(pi*x/30)*sin(pi*x/30); %%Inicial condition
Objetive_func =  sin(pi*x/30)*sin(pi*x/30) + 0.05*t*(cos(pi*x/30) + 1); %objective function
optitol = 10.0^(-6.0); % stop criteria
l = 40.0; 
gamma =40.0;
mu = 1.;
CRegions = [-10,10];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Obteniendo el punto silla
          [Xysol,Tysol,Yysol,...
          Xpsisol,Tpsisol,Ypsisol,...
          Xvsol,Tvsol,Yvsol,...
          Xvfullsol,Tvfullsol,Yvfullsol]...
                  =  Ks_freefeem_robust(inicial_cond,...
					 Objetive_func,...
					 meshN,...
					 Lmin,Lmax,...
					 Tfinal,dt,...
					 l,gamma,mu,optitol,CRegions);

                 
%plot y sol de punto silla en todo el domino
figure=surf(Xysol,Tysol,Yysol);
hold on
shading interp
title('solution ks en el punto silla')

%plot Obtejtivo
Objetivo_matlab = matlabFunction(Objetive_func,'Vars',[x t]);
surf(Xysol,Tysol,Objetivo_matlab(Xysol,Tysol));
shading interp
title('Objetive function')
hold off

% figure(1)
contour(Xysol,Tysol,Yysol,'ShowText','on')

% figure(2)
contour(Xysol,Tysol,Objetivo_matlab(Xysol,Tysol),'ShowText','on')

%plot pertubation en todo el dominio
figure1=surf(Xpsisol,Tpsisol,Ypsisol);
shading interp
title('pertubacion')

%plot control en todo el dominio
figure2=surf(Xvfullsol,Tvfullsol,Yvfullsol);
shading interp
title('control')
% 
% %plot control solo en el dominio de control
% figure2=surf(Xvsol,Tvsol,Yvsol);
% shading interp
% title('control')
% 
% 
% %tabla de punto silla
% % n | J(vsol,psisol) | J(vsol,psi_n) | J(v_n,psisol)
% % psi_n ----> psisol
% % v_n ----> vsol
% % pertuvation = exp(-x^2)/((n^2.0) + 2000.0)*Xcontrol;
% % n = 0 .... 200
% 
% %%%PARA MODIFICAR CAMBIAR:
% %linea 117 de libs/RobustSaddlepoint_verification.edp
% %pertuvation = exp(-x^2)/((i^2.0) + 2000.0);
% % 
% % [sadle_table] =  Ks_freefeem_saddle(inicial_cond,...
% % 					 Objetive_func,...
% % 					 meshN,...
% % 					 Lmin,Lmax,...
% % 					 Tfinal,dt,...
% % 					 l,gamma,mu,optitol,CRegions);
% %                  
% %                  
% % n=1;                 
% % h = plot(sadle_table(n:end,1),sadle_table(n:end,2),'-mx', ...
% %              sadle_table(n:end,1),sadle_table(n:end,3),'-r+', ...
% %              sadle_table(n:end,1),sadle_table(n:end,4),'-bs',...
% %             'markers',3);                 
