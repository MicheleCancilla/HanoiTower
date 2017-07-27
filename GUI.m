numPoints=100; %Number of points making up the circle
radius=1;      %Radius of the circle
speed = 2; %valore in secondi da aspettare tra una mossa e la successiva
colors = ['w' 'r' 'b' 'y' 'm' 'c' 'g' 'k']; %elenco dei colori possibili

err = 0;
while err == 0
    try
        err = 1;
        x = input('Enter the number of disks:');
        filename = ['hanoi-',num2str(x),'.mat'];
        load(filename);
    catch exception
        disp('Game not already played');
        err = 0;
    end
end

path = searchOptimalPath(Q, states, finalStates);

T = cell(size(path,2),3);
for i=1:size(path,2)
    T(i,:) = getStateByIndex(states, path(i));
end

valMax = x;

warning ('off','all');
fig = figure;
set(fig,'Color',[0 .5 0]);
set(fig,'units','normalized','outerposition',[0 0 1 1]);
fig;
pause(0.00001);
frame_h = get(handle(gcf),'JavaFrame');
set(frame_h,'Maximized',1);

pause(3);

for i = 1:size(T,1)
    if ~ishghandle(fig)
        break
    end
    clf %devo pulire la figura per cancellare i dischi residui
    
    s1 = subplot(2,3,[4 5 6]);
    xl = xlim(s1);
    xPos = xl(1) + diff(xl) / 2;
    yl = ylim(s1);
    yPos = yl(1) + diff(yl) / 2;
    t = text(xPos, yPos, sprintf('%s%i%s','Tower of Hanoi with ',valMax,' disks',' - ',size(T,1),' steps'),'Parent',s1);
    set(t,'fontsize',32);
    set(t,'Fontangle','italic');
    set(t,'Fontname','Timesnewroman');
    set(t, 'HorizontalAlignment', 'center');
    %button=uicontrol('Parent',fig,'Style','pushbutton','String','View Data','Units','normalized','Position',[0.0 0.5 0.4 0.2],'Visible','on');
    axis off
    hold on
    
    for k=1:3
        temp = T{i,k};
        if size(temp,2) > 0
            for j = 1:size(temp,2) %ciclo per individuare i dischi da disegnare
                v = str2double(temp(1,j));
                if temp(1,j) ~= '-' && ~isempty(temp(1,j)) && temp(1,j) ~= ' '
                    
                    %disegno un disco di dimensione pari a temp(1,j)
                    theta=linspace(0,2*pi,numPoints); %100 evenly spaced points between 0 and 2pi
                    rho=ones(1,numPoints)*radius*v; %raggio proporzionale al valore del disco
                    
                    %Convert polar coordinates to Cartesian for plotting
                    [X,Y] = pol2cart(theta,rho);
                    subplot(2,3,k);
                    fill(X,Y,colors(1,v));
                    txt = ['\downarrow disk ' temp(1,j)];
                    text(0,radius*v,txt);
                    xlim([valMax*-1 valMax])
                    ylim([valMax*-1 valMax])
                    axis square
                    hold on
                end
            end
        end
        %disegno il piolo
        subplot(2,3,k);
        rho=ones(1,numPoints)*0.15;
        theta=linspace(0,2*pi,numPoints);
        [X,Y] = pol2cart(theta,rho);
        fill(X,Y,[.6 .1 0]);
        xlim([valMax*-1 valMax])
        ylim([valMax*-1 valMax])
        axis square
        hold on
        set(gca,'visible','off');
    end
    pause(speed);
end

if ishghandle(fig)
    
    [s,fs] = audioread('Ta Da-Sound.wav');
    sound(s,fs);
end