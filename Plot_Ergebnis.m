z = linspace(0,L,N)         ;
d = linspace(0,D/2,M)       ;
[X,Y]   =   meshgrid(z,d)   ; 


 
for i = numel(t_vec)-25:1:numel(t_vec)
%for i = numel(t_vec)-60:5:numel(t_vec)
uu = u(i,:);

figure(1)
 
surf(X,Y,reshape(uu(1:M*N),size(X)))
% figure(2)
% surf(X,Y,reshape(uu(M*N + 1 : 2*M*N),size(X)))
% figure(3)
% surf(X,Y,reshape(uu(2*M*N + 1 : 3*M*N),size(X)))
% figure(4)
% surf(X,Y,reshape(uu(3*M*N + 1 : 4*M*N),size(X)))
figure(5)
surf(X,Y,reshape(uu(4*M*N + 1 : 5*M*N),size(X)))
drawnow
end



% %% Skript zum Plotten der Ergebnisse
% % Hier werden die drei Subplots und das GIF erstellt
% 
% set(0, 'DefaultLineLineWidth', 2)               ;
% figure(1)                                ;
% z = linspace(0,L,N)                               ;      
% filename = 'figures/GIFs/PFR_GIF_voll_mit_LM_test.gif' ;
% 
% figure('units','normalized','outerposition',[0 0 1 1])  ;
% [X,Y]   =   meshgrid(z,z)                               ;  
% 
% for i = 1:50:numel(t_vec)
% 
%     
%     % Plot für die Konzentrationen
%     subplot(3,1,1)                  
%     surf(X,Y,reshape(u(1:M*N),size(X)))
%     axis([0 L 0 5000 ])
%     legend('Konzentration Propylenoxid','Konzentration Wasser/10','Konzentration Methanol','Konzentration Propylenglykol','Interpreter','latex','Location','bestoutside')
%     title('Verlauf der Konzentrationen im Reaktor','Interpreter','latex')                   ;
%     xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                       ;
%     ylabel('Konzentration der Komponenten in $mol/m^{3} $','Interpreter','latex')           ;
%     txt = ['Zeit = ',num2str(t_vec(i)),' Sekunden']                                         ;
%     text(0.05,4500,txt,'FontSize',20,'FontWeight','bold')                                   ;
%     hold off
%     grid on
%       
%     % Pseudocolorplot für die Temperatur
%     subplot(3,1,2)
%     s=pcolor(X,Y,ones(size(X)).*u(i,4*N+1:5*N))     ;
%     set(gca,'ytick',[])
%     caxis([310 360])                                ;
%     s.EdgeColor = 'none'                            ;
%     colormap(jet)                                   ;
%     colorbar                                        ;
%     legend(' Temperatur in K  \hspace{0.01 cm}','Interpreter','latex','Location','eastoutside')             ;
%     title('Verlauf der Temperatur im Reaktor','Interpreter','latex')                                        ;
%     xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                                       ;                                               
%     grid on 
%     
%     % Plot für die Temperatur
%     subplot(3,1,3)                  
%     plot(z,u(i,4*N+1:5*N),'r')            
%     axis([0 L 310 365 ])
%     legend('Temperatur \hspace{2.2 cm}','Interpreter','latex','Location','bestoutside')     ;
%     title('Verlauf der Temperatur im Reaktor','Interpreter','latex')                        ;
%     xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                       ;
%     ylabel('Temperatur in Kelvin','Interpreter','latex')                                    ;
%     grid on 
%     
% %     fig1=gcf;
% %     % Capture the plot as an image 
% %       frame = getframe(fig1)        ; 
% %       im = frame2im(frame)          ; 
% %       [imind,cm] = rgb2ind(im,256)  ; 
% %     
% %     % Write to the GIF File 
% %     if i == 1 
% %           imwrite(imind,cm,filename,'gif', 'Loopcount',inf)     ; 
% %       else 
% %           imwrite(imind,cm,filename,'gif','WriteMode','append') ; 
% %     end 
%     drawnow
% end
% 
% 
% %print(fig1,'Plot_Print.png','-dpng','-r600')
% %saveas(fig1,'Plot_SaveAs.png')
% 
% 
% % %% Testsektion:
% 
% % set(0, 'DefaultLineLineWidth', 2)               ;
% % fig2 = figure(2)                                ;
% % z = linspace(0,L,N)                             ;      
% % filename = 'figures/PFR_1.gif'                  ;
% % 
% % figure('units','normalized','outerposition',[0 0 1 1])  ;
% % [X,Y]   =   meshgrid(z,z)                               ;  
% % 
% % for i = 1:50:numel(t_vec)
% % %for i = numel(t_vec)-30:1:numel(t_vec)
% %     
% %     % Plot für die Konzentrationen
% %     subplot(2,1,1)                  
% %     plot(z,u(i,1 : N))                % Plot für die Konzentration von Propylenoxid
% %     hold on 
% %     plot(z,u(i,  N+1:2*N)/10,'g')     % Plot für die Konzentration von Wasser
% %     %plot(z,u(i,  N+1:2*N)/30,'g')       % Plot für die Konzentration von Wasser bei 3-fachem Feed
% %     plot(z,u(i,2*N+1:3*N))            % Plot für die Konzentration von Methanol
% %     plot(z,u(i,3*N+1:4*N))            % Plot für die Konzentration von Propylenglykol
% %     axis([0 L 0 5000 ])
% %     l = legend('Konzentration Propylenoxid','Konzentration Wasser/10','Konzentration Methanol','Konzentration Propylenglykol','Interpreter','latex','Location','bestoutside')
% %     %l = legend('Konzentration Propylenoxid','Konzentration Wasser/30','Konzentration Methanol','Konzentration Propylenglykol','Interpreter','latex','Location','bestoutside') % Legende bei 3-fachem Wasser-Feed
% %     t = title('Verlauf der Konzentrationen im Reaktor','Interpreter','latex')                   ;
% %     x = xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                       ;
% %     y = ylabel('Konzentration der Komponenten in $mol/m^{3} $','Interpreter','latex')           ;    
% %     l.FontSize = 20 ;
% %     t.FontSize = 40 ;
% %     x.FontSize = 35 ;
% %     y.FontSize = 35 ;
% %     ax = gca        ;
% %     a = ax.Color    ;
% %     ax.FontSize = 20;
% %     txt = ['Zeit = ',num2str(t_vec(i)),' Sekunden']                                         ;
% %     text(0.05,4500,txt,'FontSize',20,'FontWeight','bold')
% %     hold off
% %     grid on
% %       
% %   
% %     
% %     % Plot für die Temperatur
% %     subplot(2,1,2)                  
% %     plot(z,u(i,4*N+1:5*N),'r')            
% %     axis([0 L 310 365 ])
% %     l = legend('Temperatur \hspace{2.2 cm}','Interpreter','latex','Location','bestoutside')     ;
% %     t = title('Verlauf der Temperatur im Reaktor','Interpreter','latex')                        ;
% %     x = xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                       ;
% %     y = ylabel('Temperatur in Kelvin','Interpreter','latex')                                    ;
% %     l.FontSize = 20 ;
% %     t.FontSize = 40 ;
% %     x.FontSize = 35 ;
% %     y.FontSize = 35 ;
% %     ax = gca        ;
% %     a = ax.Color    ;
% %     ax.FontSize = 20;
% %     grid on 
% % 
% %     
% %     drawnow
% %     % Capture the plot as an image 
% %       frame = getframe(fig2)        ; 
% %       im = frame2im(frame)          ; 
% %       [imind,cm] = rgb2ind(im,256)  ; 
% %     
% %       
% %   
% %     
% %       
% %     % Write to the GIF File 
% %     if i == 1 
% %           imwrite(imind,cm,filename,'gif', 'Loopcount',inf)     ; 
% %       else 
% %           imwrite(imind,cm,filename,'gif','WriteMode','append') ; 
% %     end 
% % end
% % 
% % 
% %     % Pseudocolorplot für die Temperatur
% %     figure()
% %     s=pcolor(X,Y,ones(size(X)).*u(i,4*N+1:5*N))     ;
% %     set(gca,'ytick',[])   
% %     caxis([310 360])                                ;
% %     s.EdgeColor = 'none'                            ;
% %     colormap(jet)                                   ;
% %     colorbar                                        ;
% %     %l = legend(' Temperatur in Kelvin  \hspace{0.35 cm}','Interpreter','latex','Location','eastoutside')        ;
% %     t = title('Verlauf der Temperatur im Reaktor','Interpreter','latex')                                        ;
% %     x = xlabel('Abstand vom Reaktoreingang in $m$','Interpreter','latex')                                       ;                                               
% %     grid on
% %     set(gca,'XDir','Reverse')
% %     view(90,90)
% %     %l.FontSize = 20 ;
% %     t.FontSize = 40 ;
% %     x.FontSize = 35 ;
% %     ax = gca        ;
% %     a = ax.Color    ;
% %     ax.FontSize = 20;