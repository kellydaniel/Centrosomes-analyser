
function varargout = accueil(varargin)
% ACCUEIL MATLAB code for accueil.fig
%      ACCUEIL, by itself, creates a new ACCUEIL or raises the existing
%      singleton*.
%
%      H = ACCUEIL returns the handle to a new ACCUEIL or the handle to
%      the existing singleton*.
%
%      ACCUEIL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCUEIL.M with the given input arguments.
%
%      ACCUEIL('Property','Value',...) creates a new ACCUEIL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before accueil_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to accueil_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help accueil

% Last Modified by GUIDE v2.5 24-Apr-2017 17:12:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @accueil_OpeningFcn, ...
                   'gui_OutputFcn',  @accueil_OutputFcn, ...
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


% --- Executes just before accueil is made visible.
function accueil_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to accueil (see VARARGIN)

% Choose default command line output for accueil
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes accueil wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = accueil_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function Titre_Callback(hObject, eventdata, handles)
% hObject    handle to Titre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Titre as text
%        str2double(get(hObject,'String')) returns contents of Titre as a double


% --- Executes during object creation, after setting all properties.
function Titre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Titre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    close(handles.figure1);
    run('add_new_data');
else 
    close(handles.figure1);
    run('analyser');
    
end

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function uibuttongroup1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% --- Executes on button press in analyse_data.
function analyse_data_Callback(hObject, eventdata, handles)
% hObject    handle to analyse_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

