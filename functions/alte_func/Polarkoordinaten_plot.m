function Polarkoordinaten_plot(r_vec,T_mat,t_vec)
% Funktion plottet den T-Verlauf in Polarkoordinaten und gibt ein gif aus
% T_mat: Spalten enthalten den T-Verlauf zu einem Zeitpunkt
% t_vec: Enthält die Zeitpunkte der T-Verläufe in T_mat
% r_vec: Enthält den Ort zu T_mat

fg=figure;
set(fg,'color','w')
filename = 'T_verlauf.gif';

%% Sicherstellen, dass alles Spalten-vektoren sind
[zr,sr] = size(r_vec);
if zr<sr
    r_vec = r_vec';
    [zr,~] = size(r_vec);
end

% [zt,st] = size(t_vec);
% if zt<st
%     t_vec = t_vec';
% end

[zT,~] = size(T_mat);
if zT ~= zr
    T_mat = T_mat';
end


% Anhaengen eines Wertes fuer rho = 0 (=r)
r_vec = [0;r_vec];
T_mat = [T_mat(2,:);T_mat];

%% Iteration über die Zeitpunkte
% for n=1:1
for n=1:length(T_mat(1,:))
    
    % Umrechnen in Polarkoordinaten
    n_winkel=60;
    
    
    theta   = zeros(length(r_vec),n_winkel);
    rho     = zeros(length(r_vec),n_winkel);
    z       = zeros(length(r_vec),n_winkel);
    
    for i=1:length(r_vec)
        theta(i,:)  = linspace(0,2*pi,n_winkel);        
    end
    
    for i=1:n_winkel
        rho(:,i)    = r_vec;
        z(:,i)      = T_mat(:,n);
    end
    
    [X,Y,Z] = pol2cart(theta,rho,z);
    
    
    % Plotten

    hp=polar(X,Y);
    tex = findall(gcf,'type','text');
    delete(tex);
    
    titlestr = [ num2str(t_vec(n),'%1.2f'),'[s]'];
    title(titlestr,'FontSize', 32)
    
    hold on;
    contourf(X,Y,Z,256,'LineStyle','none');
    shading flat
    % Hide the POLAR function data and leave annotations
    set(hp,'Visible','off')
    % Turn off axes and set square aspect ratio
    axis off
    axis image
    colormap(jet)
    caxis([min(T_mat(:,end)) max(T_mat(:,1))]);
    cb=colorbar;
    xlabel(cb,'[K]')
    
    
    %saveas(fg, ['movie/T-Verlauf_',num2str(n,'%.3d')], 'png');
    drawnow
    frame = getframe(fg);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,512);
    if n == 1;
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append');
    end
    clf
    
end

end