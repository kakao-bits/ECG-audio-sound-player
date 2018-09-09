function varargout = ECGrecorder(varargin)
% ECGRECORDER M-file for ECGrecorder.fig
%      ECGRECORDER, by itself, creates a new ECGRECORDER or raises the existing
%      singleton*.
%
%      H = ECGRECORDER returns the handle to a new ECGRECORDER or the handle to
%      the existing singleton*.
%
%      ECGRECORDER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECGRECORDER.M with the given input arguments.
%
%      ECGRECORDER('Property','Value',...) creates a new ECGRECORDER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AudioDisplay_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECGrecorder_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECGrecorder

% Last Modified by GUIDE v2.5 04-Mar-2018 15:35:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECGrecorder_OpeningFcn, ...
                   'gui_OutputFcn',  @ECGrecorder_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ECGrecorder is made visible.
function ECGrecorder_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECGrecorder (see VARARGIN)

% Choose default command line output for ECGrecorder
handles.output = hObject;
handles.r = hObject;
% backgroundImage = importdata('bg3.jpg');
% axes(handles.axes2);
% image(backgroundImage)
% Update handles structure
guidata(hObject, handles);
global flag;
global FClose;
flag = 1;
% UIWAIT makes ECGrecorder wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECGrecorder_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
global FClose;
global FSave;
Fs=44100;
handles.r = audiorecorder(Fs,16,1);
handles.Mr = audiorecorder(Fs,16,1);
flag = 1;
FClose = 1;
FSave = 1;
StopExe = 0;
buffSize = 100000;
buffer1(1:buffSize,1) = 0;
while(1)
    while(~flag);
        pause(0.1);
        if(~FClose)
            pause(0.01)
            close ECGrecorder;
            StopExe = 1;
            break;
        elseif(~FSave)
                stop(handles.Mr);
                stop(handles.r);
                recorded=getaudiodata(handles.Mr);
                % record = audiorecorder(recordtime.*Fs,Fs);
                [filename, pathname] = uiputfile('*.wav');
                cd (pathname);
                audiowrite(filename,recorded,Fs);
                FSave=1;
                plot(recorded);
        else
            break;
        end
    end
    if(flag)
        record(handles.Mr);
        recordblocking(handles.r,0.1);
        buff = getaudiodata(handles.r,'int16');
        [n m] = size(buff);
        %     buff = buff(1:n-mod(n,64));
%         a(:,1) = 1:3;
%         [n m] = size(a);
%         b(:,1) = buffSize:-1:1
%         b(1 : n,1 ) = a(1 : n,1)
%         b(n + 1 : buffSize,1) = b(1 : buffSize - n,1)
        buffer1(1:n,1) = buff(1:n,1);
        buffer1(n + 1  : buffSize,1) = buffer1(1 : (buffSize) - n,1);
        axes(handles.axes1)
        plot(buffer1);
        guidata(hObject,handles);
        if(~FClose)
            pause(.1);
            close ECGrecorder;      
            break;
        end
        if(~FSave)
            stop(handles.Mr);
            stop(handles.r);
            recorded=getaudiodata(handles.Mr);
            % record = audiorecorder(recordtime.*Fs,Fs);
            [filename, pathname] = uiputfile('*.wav');
            cd (pathname);
            audiowrite(filename,recorded,Fs);
            FSave=1;
            plot(recorded);
        end
    end
    if(StopExe) % in Closing
        break;
    end
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag;
flag = 0;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global FClose;
FClose = 0;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FSave;
FSave = 0;
