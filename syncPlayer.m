function syncPlayer(file_name)
%some example music
% file_name='Mitral Regurgitation- normal speed.wav';
[y,Fs]=audioread(file_name);  
%set up audio player
player = audioplayer(y, Fs);
[samples,channels]=size(y);
%calculate timeline
t=linspace(0,1/Fs*(samples-1),samples);
%initialize full plot, update will only move the visible area using xlim
h=plot(t,y);
%set up callback to update every <TimerPeriod> s
player.TimerFcn=@mytimerFcn;
player.TimerPeriod=0.01;
player.playblocking()
end

function mytimerFcn(source,data)
%an area of length <area> s will be visible
area=1;
position=(source.CurrentSample-1)/source.SampleRate;
%move visible area, current position is in the center
set(gca,'XLim',[position-area/2,position+area/2]);
%used a waitbar for testing, might be commented in
%waitbar(source.CurrentSample/source.TotalSamples);
end