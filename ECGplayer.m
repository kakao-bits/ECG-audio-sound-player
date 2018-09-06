function varargout = ECGplayer(varargin)
% ECGPLAYER MATLAB code for ECGplayer.fig
%      ECGPLAYER, by itself, creates a new ECGPLAYER or raises the existing
%      singleton*.
%
%      H = ECGPLAYER returns the handle to a new ECGPLAYER or the handle to
%      the existing singleton*.
%
%      ECGPLAYER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECGPLAYER.M with the given input arguments.
%
%      ECGPLAYER('Property','Value',...) creates a new ECGPLAYER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ECGplayer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ECGplayer_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ECGplayer

% Last Modified by GUIDE v2.5 04-Mar-2018 17:12:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECGplayer_OpeningFcn, ...
                   'gui_OutputFcn',  @ECGplayer_OutputFcn, ...
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


% --- Executes just before ECGplayer is made visible.
function ECGplayer_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECGplayer (see VARARGIN)

% Choose default command line output for ECGplayer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECGplayer wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECGplayer_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name;  
file_name = uigetfile({'*.wav'},'Load Wav File');
guidata(hObject,handles);


% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global file_name;
axes(handles.axes1);
syncPlayer(file_name);
[x,fs]=audioread(file_name);
plot(x);

% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close ECGplayer;
