##Pressure-film Open Source Scanning and Mapping
##Written by Patrick Grider, <patrickgrider@gmail.com>

##This work was supported in part by the U.S. Department of Energy,
##Office of Science, Office of Workforce Development for Teachers and Scientists
##(WDTS) under the Science Undergraduate Laboratory Internships (SULI) program.

close all
clc
clear
dir = pwd();
addpath(pwd);

## Make sure package Image is installed
image_installed = pkg("list", "image");
check = size(image_installed);
if (check != [1,1])
  disp("please download and install the latest Octave image package.")
  disp("https://octave.sourceforge.io/image/")
  disp("the package can be installed with the Octave command ""pkg install -forge image"" ")
  return
else
  pkg load image;
  clear
endif

## Make sure package io is installed
image_installed = pkg("list", "image");
check = size(image_installed);
if (check != [1,1])
  disp("please download and install the latest Octave image package.")
  disp("https://octave.sourceforge.io/image/")
  disp("the package can be installed with the Octave command ""pkg install -forge image"" ")
  return
else
  pkg load io;
  clear
endif

graphics_toolkit qt;

## POSSM logo
icon(:,:,1) = [112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  153  112  112  112  112  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  153  153  153  153  153  112  112  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  153  153  153  153  153  153  153  153  153  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  153  153  153  153  153  153  153  153  153  255  255  255  255  255  195    0    0  153  153  153  112  112  112  112  112  112;
112  112  112  112  112  153  153  153  255  255  255  255  255  255  255  255  255  255  255  255  255  255  195    0  153  153  153  112  112  112  112  112;
112  112  112  112  153  153  153  153  255  255  255  255  255  255  255  255  255  255    0  255  255  255    0    0  153  153  153  255  112  112  112  112;
112  112  112  112  153  153  153  153  153  195  195  255  255  255  255  255  255  255  255  255  255  255  255  195  153  153  255  255  255  112  112  112;
112  112  112  153  153  153  153  153  153  153  153  153  153  195  195  255  255  255  255  255  255  255  195  127  127  153  153  255  255  112  112  112;
112  112  112  153  153  153  153  153  153  255  255  255  153  153  153  153  255  255  255  255  255  195  195  195  195  195  195  195  127  153  112  112;
112  112  153  153  153  153  153  153  153  153  255  255  195  195  195  195  195  195  195  195  195  195  195  195  195  195  195  127  153  153  112  112;
112  112  153  153  153  153  153  255  153  153  153  195  195  195  195  195  255  255  255  255  195  195  195  195  195  127  127  153  153  153  112  112;
112  153  153  153  153  153  153  255  255  153  153  153  255  255  255  255  255  255  255  255  195  195  195  127  127  127  153  153  153  153  153  112;
112  153  153  153  153  153  153  153  255  255  255  255  255  255  255  255  255  255  255  255  255  255  195  195  195  127  153  153  153  153  153  112;
112  153  153  153  153  153  153  153  153  153  153  195  195  195  255  255  255  255  195  195  255  255  255  195  195  127  153  153  153  153  153  112;
112  153  153  153  153  153  153  153  153  153  195  195  195  255  255  255  255  195  195  195  195  255  255  255  195  127  153  153  153  153  153  112;
112  153  153  153  153  153  153  255  255  195  195  195  255  255  255  255  255  195  195  195  195  195  255  255  255  127  153  153  153  153  153  112;
112  153  153  153  153  153  153  255  255  255  195  195  255  255  255  255  255  195  195  195  195  195  195  255  255  153  153  153  153  153  153  112;
112  153  153  153  153  153  153  153  153  255  255  195  255  255  255  255  255  255  195  127  195  195  195  255  255  153  153  153  153  153  153  112;
112  153  153  153  153  153  153  153  153  255  255  127  255  255  255  255  255  255  127  195  195  195  127  255  255  153  153  153  153  153  153  112;
112  112  153  153  153  153  153  153  153  153  255  127  255  255  255  255  255  195  195  195  195  127  127  255  255  153  153  153  153  153  112  112;
112  112  153  153  153  153  153  153  153  153  153  127  255  255  255  255  255  255  195  127  127  127  153  255  255  153  153  153  153  153  112  112;
112  112  112  153  153  153  153  153  153  153  153  127  127  255  255  255  255  127  127  127  153  153  153  255  255  153  153  153  153  153  112  112;
112  112  112  153  153  153  153  153  153  153  153  153  153  127  127  127  127  127  153  153  153  153  153  255  255  153  153  153  153  112  112  112;
112  112  112  112  153  153  153  153  153  153  153  153  153  153  255  255  255  153  153  153  153  153  255  255  255  153  153  153  112  112  112  112;
112  112  112  112  153  153  153  153  153  153  153  153  153  153  255  255  255  153  153  153  153  153  255  255  255  153  153  153  112  112  112  112;
112  112  112  112  112  153  153  153  153  153  153  153  153  153  255  255  255  255  153  153  153  255  255  255  153  153  153  112  112  112  112  112;
112  112  112  112  112  112  153  153  153  153  153  153  153  153  255  255  255  255  255  255  255  255  255  153  153  153  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  255  255  255  255  255  255  255  153  153  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  255  255  255  255  255  153  153  112  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  112  112  112  112  153  153  153  153  153  153  153  153  112  112  112  112  112  112  112  112  112  112  112  112;
112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112  112];

icon(:,:,2) = [146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  217  146  146  146  146  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  217  217  217  217  217  146  146  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  217  217  217  217  217  217  217  217  217  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  217  217  217  217  217  217  217  217  217  255  255  255  255  255  195    0    0  217  217  217  146  146  146  146  146  146;
146  146  146  146  146  217  217  217  174  174  255  255  255  255  255  255  255  255  255  255  255  255  195    0  217  217  217  146  146  146  146  146;
146  146  146  146  217  217  217  217  255  255  255  255  255  255  255  255  255  255    0  255  255  255    0    0  217  217  217  174  146  146  146  146;
146  146  146  146  217  217  217  217  217  195  195  255  255  255  255  255  255  255  255  255  255  255  255  195  217  217  149  174  174  146  146  146;
146  146  146  217  217  217  217  217  217  217  217  217  217  195  195  255  255  255  255  255  255  255  195  127  127  217  217  149  174  146  146  146;
146  146  146  217  217  217  217  217  217  149  174  174  217  217  217  217  255  255  255  255  255  195  195  195  195  195  195  195  127  217  146  146;
146  146  217  217  217  217  217  217  217  217  149  174  195  195  195  195  195  195  195  195  195  195  195  195  195  195  195  127  217  217  146  146;
146  146  217  217  217  217  217  174  217  217  217  195  195  195  195  195  255  255  255  255  195  195  195  195  195  127  127  217  217  217  146  146;
146  217  217  217  217  217  217  149  174  217  217  217  174  174  174  174  174  174  174  174  195  195  195  127  127  127  217  217  217  217  217  146;
146  217  217  217  217  217  217  217  149  174  174  174  149  149  149  174  149  174  174  174  174  174  195  195  195  127  217  217  217  217  217  146;
146  217  217  217  217  217  217  217  217  217  217  195  195  195  255  255  255  255  195  195  149  174  174  195  195  127  217  217  217  217  217  146;
146  217  217  217  217  217  217  217  217  217  195  195  195  255  255  174  255  195  195  195  195  149  174  174  195  127  217  217  217  217  217  146;
146  217  217  217  217  217  217  174  174  195  195  195  255  255  149  174  174  195  195  195  195  195  149  174  174  127  217  217  217  217  217  146;
146  217  217  217  217  217  217  149  149  174  195  195  255  255  255  149  174  195  195  195  195  195  195  174  174  217  217  217  217  217  217  146;
146  217  217  217  217  217  217  217  217  149  174  195  255  255  255  255  149  174  195  127  195  195  195  174  174  217  217  217  217  217  217  146;
146  217  217  217  217  217  217  217  217  149  174  127  255  255  255  255  255  174  127  195  195  195  127  174  174  217  217  217  217  217  217  146;
146  146  217  217  217  217  217  217  217  217  174  127  255  255  255  255  255  195  195  195  195  127  127  174  174  217  217  217  217  217  146  146;
146  146  217  217  217  217  217  217  217  217  217  127  255  255  255  255  255  255  195  127  127  127  217  174  174  217  217  217  217  217  146  146;
146  146  146  217  217  217  217  217  217  217  217  127  127  255  255  255  255  127  127  127  217  217  217  174  174  217  217  217  217  217  146  146;
146  146  146  217  217  217  217  217  217  217  217  217  217  127  127  127  127  127  217  217  217  217  217  174  174  217  217  217  217  146  146  146;
146  146  146  146  217  217  217  217  217  217  217  217  217  217  174  174  174  217  217  217  217  217  174  174  174  217  217  217  146  146  146  146;
146  146  146  146  217  217  217  217  217  217  217  217  217  217  174  174  174  217  217  217  217  217  174  174  174  217  217  217  146  146  146  146;
146  146  146  146  146  217  217  217  217  217  217  217  217  217  149  174  174  174  217  217  217  174  174  174  217  217  217  146  146  146  146  146;
146  146  146  146  146  146  217  217  217  217  217  217  217  217  149  174  174  174  174  174  174  174  174  217  217  217  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  149  174  174  174  174  174  149  217  217  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  149  149  149  149  149  217  217  146  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  146  146  146  146  217  217  217  217  217  217  217  217  146  146  146  146  146  146  146  146  146  146  146  146;
146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146  146];

icon(:,:,3) = [190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  234  190  190  190  190  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  234  234  234  234  234  190  190  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  234  234  234  234  234  234  234  234  234  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  234  234  234  234  234  234  234  234  234  255  255  255  255  255  195    0    0  234  234  234  190  190  190  190  190  190;
190  190  190  190  190  234  234  234  201  201  255  255  255  255  255  255  255  255  255  255  255  255  195    0  234  234  234  190  190  190  190  190;
190  190  190  190  234  234  234  234  255  255  255  255  255  255  255  255  255  255    0  255  255  255    0    0  234  234  234  201  190  190  190  190;
190  190  190  190  234  234  234  234  234  195  195  255  255  255  255  255  255  255  255  255  255  255  255  195  234  234  149  201  201  190  190  190;
190  190  190  234  234  234  234  234  234  234  234  234  234  195  195  255  255  255  255  255  255  255  195  127  127  234  234  149  201  190  190  190;
190  190  190  234  234  234  234  234  234  149  201  201  234  234  234  234  255  255  255  255  255  195  195  195  195  195  195  195  127  234  190  190;
190  190  234  234  234  234  234  234  234  234  149  201  195  195  195  195  195  195  195  195  195  195  195  195  195  195  195  127  234  234  190  190;
190  190  234  234  234  234  234  201  234  234  234  195  195  195  195  195  255  255  255  255  195  195  195  195  195  127  127  234  234  234  190  190;
190  234  234  234  234  234  234  149  201  234  234  234  201  201  201  201  201  201  201  201  195  195  195  127  127  127  234  234  234  234  234  190;
190  234  234  234  234  234  234  234  149  201  201  201  149  149  149  201  149  201  201  201  201  201  195  195  195  127  234  234  234  234  234  190;
190  234  234  234  234  234  234  234  234  234  234  195  195  195  255  255  255  255  195  195  149  201  201  195  195  127  234  234  234  234  234  190;
190  234  234  234  234  234  234  234  234  234  195  195  195  255  255  201  255  195  195  195  195  149  201  201  195  127  234  234  234  234  234  190;
190  234  234  234  234  234  234  201  201  195  195  195  255  255  149  201  201  195  195  195  195  195  149  201  201  127  234  234  234  234  234  190;
190  234  234  234  234  234  234  149  149  201  195  195  255  255  255  149  201  195  195  195  195  195  195  201  201  234  234  234  234  234  234  190;
190  234  234  234  234  234  234  234  234  149  201  195  255  255  255  255  149  201  195  127  195  195  195  201  201  234  234  234  234  234  234  190;
190  234  234  234  234  234  234  234  234  149  201  127  255  255  255  255  255  201  127  195  195  195  127  201  201  234  234  234  234  234  234  190;
190  190  234  234  234  234  234  234  234  234  201  127  255  255  255  255  255  195  195  195  195  127  127  201  201  234  234  234  234  234  190  190;
190  190  234  234  234  234  234  234  234  234  234  127  255  255  255  255  255  255  195  127  127  127  234  201  201  234  234  234  234  234  190  190;
190  190  190  234  234  234  234  234  234  234  234  127  127  255  255  255  255  127  127  127  234  234  234  201  201  234  234  234  234  234  190  190;
190  190  190  234  234  234  234  234  234  234  234  234  234  127  127  127  127  127  234  234  234  234  234  201  201  234  234  234  234  190  190  190;
190  190  190  190  234  234  234  234  234  234  234  234  234  234  201  201  201  234  234  234  234  234  201  201  201  234  234  234  190  190  190  190;
190  190  190  190  234  234  234  234  234  234  234  234  234  234  201  201  201  234  234  234  234  234  201  201  201  234  234  234  190  190  190  190;
190  190  190  190  190  234  234  234  234  234  234  234  234  234  149  201  201  201  234  234  234  201  201  201  234  234  234  190  190  190  190  190;
190  190  190  190  190  190  234  234  234  234  234  234  234  234  149  201  201  201  201  201  201  201  201  234  234  234  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  149  201  201  201  201  201  149  234  234  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  149  149  149  149  149  234  234  190  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  190  190  190  190  234  234  234  234  234  234  234  234  190  190  190  190  190  190  190  190  190  190  190  190;
190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190  190];


icon = uint8(icon);
icon = imresize(icon, 2,"box");
[iconx,iconmap] = rgb2ind(icon);
box = msgbox ("Welcome to Pressure-film Open Source Scanning and Mapping!", "POSSM", "custom", iconx, iconmap);
waitfor(box,"beingdeleted", "on");

##get the size of the screen, use screen size to determine window size
sze = get(0,"screensize");

##make main figure to display images. position is declared in pixels;
##[bottom left x position, bottom left y position, width, height]
displayspace = figure("name","Pressure-film Open Source Scanning and Mapping",
"NumberTitle","off",
"tag", "displayspace",
"position",[(0.25*sze(3))+1, 59, (sze(3)*0.75)-1, sze(4)-139]);

##make figure to contain the entirity of the user interface
controlFig = figure("name", "POSSM Controls",
"NumberTitle" , "off",
"tag", "controlFig",
"position", [1,59,(sze(3)*.25)-1,sze(4)-139]);

##make the panel to contain all the ui objects
toolPanel = uipanel("parent", controlFig,
"tag", "toolPanel",
"position", [0, 0, 1, 0.85]);

##radiobutton group to determine how many subplots to generate
group = uibuttongroup("parent",controlFig,
"position", [0, 0.85, 0.75, 0.15],
"title", "image output number");

radio1 = uicontrol("parent", group,
"style", "radiobutton",
"tag", "1",
"string", "one plot",
"value", 0,
"units", "normalized",
"callback", @plot_number,
"position", [0.1,0.6,0.5,0.3]);

radio2 = uicontrol("parent", group,
"style", "radiobutton",
"tag", "2",
"string", "two subplots",
"units", "normalized",
"callback", @plot_number,
"position", [0.6,0.6,0.5,0.3]);

radio3 = uicontrol("parent", group,
"style", "radiobutton",
"tag", "3",
"string", "three subplots",
"units", "normalized",
"callback", @plot_number,
"position", [0.1,0.1,0.5,0.3]);

radio4 = uicontrol("parent", group,
"style", "radiobutton",
"tag", "4",
"string", "four subplots",
"units", "normalized",
"callback", @plot_number,
"position", [0.6,0.1,0.5,0.3]);

helpPane = uipanel("parent", controlFig,
"title", " ",
"tag", "helpPane",
"position", [0.75, 0.85, 0.25, 0.15]);

helpButton = uicontrol("parent", helpPane,
"tag", "helpButton",
"string", "help",
"units", "normalized",
"callback", @helpme,
"position", [0.1,0.35,0.8,0.3]);

cmap = colormap(viridis(256));


setappdata (displayspace, "displayspace", displayspace,
"controlFig", controlFig,
"toolPanel", toolPanel,
"cmap", cmap);

##function called by radiobuttons. governs the generation of subplots and the
##generation of all GUI controls that depend on the number of subplots.
function plot_number(calledBy, data);
  if(get(calledBy,"value") == 1)
  displayspace = findobj("tag","displayspace");
  controlFig = findobj("tag","controlFig");
  tag = get(calledBy, "tag");
  toolPanel = getappdata(displayspace,"toolPanel");
  children = get(toolPanel, "children");
  allSubplots = get(displayspace, "children");
  cmap = getappdata(displayspace,"cmap");
  #  base = getappdata(displayspace,"base");

  plottype = struct("type", "image",
  "batchColorbar", 0,
  "batchWhitespace", 0);

  settings = struct("batchColormap",cmap,
  "batchFilmtype", 85,
  "batchUnits", "psi",
  "batchPressure",[28 85],
  "imageExport", 0,
  "tableExport", 0,
  "batchprocess",0,
  "batchNumPlot", 0,
  "sampleRate", 1,
  "decolorized", 0,
  "grayscale", 0,
  "cinvert", 0,
  "batchSkip", 1);

  switch tag;                                                                   #tag refers to number of subplots to be generated.
## This section could be trimmed down significantly by
## merging all the generations and using just one 
## for loop

##if there is only one subplot:
  case "1"
    delete(children);
    delete(allSubplots);
    numplot = 1;
    subcontrol_1 = uipanel("parent", toolPanel,
    "title", "panel 1",
    "position", [0, 0.6, 1, 0.4]);

    subplot_1 = subplot(1,1,1,"parent",displayspace);

    menu_1 = uicontrol(subcontrol_1,
    "tag", "menu_1",
    "style", "listbox",
    "string", {"colorized pressuremap",
    "histogram",
    "color histogram",
    "3D surface plot"},
    "callback", @process,
    "units", "normalized",
    "position", [0.05,0.1,0.5,0.3]);

    cbar_1 = uicontrol(subcontrol_1,
    "tag", "cbar_1",
    "string", "apply colorbar",
    "units", "normalized",
    "callback", @process,
    "position", [0.6,0.25,0.3,0.15]);

    base = struct("batchImage", 0,
    "batchTable", 0,
    "batchSettings", settings,
    "batchSubPlot_1", plottype,
    "batchSubPlot_2", 0,
    "batchSubPlot_3", 0,
    "batchSubPlot_4", 0);

    setappdata(displayspace,
    "base", base,
    "subcontrol_1", subcontrol_1,
    "subplot_1", subplot_1,
    "menu_1", menu_1,
    "cbar_1", cbar_1,
    "numplot", 1);

##If there are 2 subplots:
  case "2"
    delete(children)
    delete(allSubplots)
    subplot_2 = subplot(1,2,2,"parent",displayspace);
    axis square
    subplot_1 = subplot(1,2,1,"parent",displayspace);
    axis square
    numplot = 2;
    base = struct("batchImage", 0,
    "batchTable", 0,
    "batchSettings", settings,
    "batchSubPlot_1", plottype,
    "batchSubPlot_2", plottype,
    "batchSubPlot_3", 0,
    "batchSubPlot_4", 0);

    setappdata(displayspace,
    "base", base,
    "subplot_1", subplot_1,
    "subplot_2", subplot_2,
    "numplot", 2);

    for ii = 1:numplot                                                          #do this once for every subplot
      eval(["subcontrol_", num2str(ii)," = uipanel(""parent"", toolPanel,\
      ""title"", [""panel "", num2str(ii)],                              \
      ""position"", [0, 1-(0.2*ii), 1, 0.2]);"]);

      eval(["setappdata(displayspace, [""subcontrol_"", num2str(ii)],\
      ",      ["subcontrol_", num2str(ii)],", ""numplot"", 2);"]);

      a = getappdata(displayspace, ["subcontrol_", num2str(ii)]);
      setappdata(displayspace, ["subcontrol_", num2str(ii)], a);
      if ii > 1
        eval(["menu_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""menu_"", num2str(ii)],          \
        ""style"", ""listbox"",                     \
        ""string"", {""colorized pressuremap"",     \
        ""histogram"",                              \
        ""color  histogram"",                       \
        ""3D surface plot""},                       \
        ""callback"", @process,                     \
        ""units"", ""normalized"",                  \
        ""position"", [0.05,0.2,0.5,0.6]);"]);

        eval(["cbar_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""cbar_"", num2str(ii)],          \
        ""string"", ""apply colorbar"",             \
        ""units"", ""normalized"",                  \
        ""callback"", @process,                     \
        ""position"", [0.6,0.5,0.3,0.3]);"]);

        eval(["setappdata(displayspace, [""menu_"", num2str(ii)], \
        ",["menu_", num2str(ii)], ", \
        [""cbar_"", num2str(ii)], ", ["cbar_", num2str(ii)], ");"]),

      endif
    endfor

##If there are 3 subplots:
  case "3"
    delete(children)
    delete(allSubplots)
    subplot_2 = subplot(2,2,2,"parent",displayspace);
    subplot_3 = subplot(2,2,3,"parent",displayspace);
    subplot_1 = subplot(2,2,1,"parent",displayspace);
    numplot = 3;
    base = struct("batchImage", 0,
    "batchTable", 0,
    "batchSettings", settings,
    "batchSubPlot_1", plottype,
    "batchSubPlot_2", plottype,
    "batchSubPlot_3", plottype,
    "batchSubPlot_4", 0);

    setappdata(displayspace, "subplot_1", subplot_1,
    "base", base,
    "subplot_2", subplot_2,
    "subplot_3", subplot_3,
    "numplot", 3);

    for ii = 1:numplot
      eval(["subcontrol_", num2str(ii)," = uipanel(""parent"", toolPanel,\
      ""title"", [""panel "", num2str(ii)],                              \
      ""position"", [0, 1-(0.2*ii), 1, 0.2]);"]);

      eval(["setappdata(displayspace, [""subcontrol_"", num2str(ii)],\
      ",["subcontrol_", num2str(ii)],", ""numplot"", 3);"])

      a = getappdata(displayspace, ["subcontrol_", num2str(ii)]);
      setappdata(displayspace, ["subcontrol_", num2str(ii)], a);
      if ii > 1
        eval(["menu_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""menu_"", num2str(ii)],          \
        ""style"", ""listbox"",                     \
        ""string"", {""colorized pressuremap"",     \
        ""histogram"",                              \
        ""color  histogram"",                       \
        ""3D surface plot""},                       \
        ""callback"", @process,                     \
        ""units"", ""normalized"",                  \
        ""position"", [0.05,0.2,0.5,0.6]);"]);

        eval(["cbar_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""cbar_"", num2str(ii)],          \
        ""string"", ""apply colorbar"",             \
        ""units"", ""normalized"",                  \
        ""callback"", @process,                     \
        ""position"", [0.6,0.5,0.3,0.3]);"]);

        eval(["setappdata(displayspace, [""menu_"", num2str(ii)], \
        ",["menu_", num2str(ii)], ", \
        [""cbar_"", num2str(ii)], ", ["cbar_", num2str(ii)], ");"]);

      endif
    endfor
##if there are 4 subplots:
  case "4"
    delete(children)
    delete(allSubplots)
    subplot_2 = subplot(2,2,2,"parent",displayspace);
    subplot_3 = subplot(2,2,3,"parent",displayspace);
    subplot_4 = subplot(2,2,4,"parent",displayspace);
    subplot_1 = subplot(2,2,1,"parent",displayspace);
    numplot = 4;
    base = struct("batchImage", 0,
    "batchTable", 0,
    "batchSettings", settings,
    "batchSubPlot_1", plottype,
    "batchSubPlot_2", plottype,
    "batchSubPlot_3", plottype,
    "batchSubPlot_4", plottype);

    setappdata(displayspace, "subplot_1", subplot_1,
    "base", base,
    "subplot_2", subplot_2,
    "subplot_3", subplot_3,
    "subplot_4", subplot_4,
    "numplot", 4)

    for ii = 1:numplot
      eval(["subcontrol_", num2str(ii)," = uipanel(""parent"", toolPanel, \
      ""title"", [""panel "", num2str(ii)], \
      ""position"", [0, 1-(0.2*ii), 1, 0.2]);"]);

      eval(["setappdata(displayspace, [""subcontrol_"", num2str(ii)],\
      ",["subcontrol_", num2str(ii)],", ""numplot"", 4);"])

      a = getappdata(displayspace, ["subcontrol_", num2str(ii)]);
      if ii > 1
        eval(["menu_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""menu_"", num2str(ii)],          \
        ""style"", ""listbox"",                     \
        ""string"", {""colorized pressuremap"",     \
        ""histogram"",                              \
        ""color histogram"",                        \
        ""3D surface plot""},                       \
        ""callback"", @process,                     \
        ""units"", ""normalized"",                  \
        ""position"", [0.05,0.2,0.5,0.6]);"]);

        eval(["cbar_", num2str(ii)," = uicontrol(a, \
        ""tag"", [""cbar_"", num2str(ii)],          \
        ""string"", ""apply colorbar"",             \
        ""units"", ""normalized"",                  \
        ""callback"", @process,                     \
        ""position"", [0.6,0.5,0.3,0.3]);"]);

        eval(["setappdata(displayspace, [""menu_"", num2str(ii)], \
        ",["menu_", num2str(ii)], ", \
        [""cbar_"", num2str(ii)], ", ["cbar_", num2str(ii)], ");"]);
      endif
    endfor
endswitch
base.batchSettings.batchNumPlot = numplot;                                      #set all batch operations to work with number of subplots = numplot
if numplot < 4
  for i = (numplot+1):4
    C = ["batchSubPlot_",num2str(i)];
    base.(C) = 0;
  endfor
endif

#populate the fifth ui subpanel, which is present regardless of number of subplots
subcontrol_5 = uipanel("parent", toolPanel, "position", [0, 0, 1, 0.2]);

colormaptitle = uicontrol(subcontrol_5, "style", "text",
"string", "Color Map",
"units", "normalized",
"position", [0.1 0.85 0.4 0.15]);

colormapmenu = uicontrol(subcontrol_5, "tag", "map",
"value", 2,
"style", "listbox",
"callback", @process,
"string", {"load custom .ggr",
"viridis",
"cubehelix",
"hsv",
"rainbow",
"hot",
"cool",
"spring",
"summer",
"autumn",
"winter",
"gray",
"bone",
"copper",
"pink",
"ocean",
"colorcube",
"flag",
"lines",
"prism",
"white"},
"units", "normalized",
"position", [0.1,0.25,0.4,0.6]);

invert = uicontrol(subcontrol_5, "tag", "inv",
"style", "checkbox",
"string", "invert colormap",
"callback", @process,
"units", "normalized",
"position", [0.1,0.05,0.4,0.15]);

exportImage = uicontrol(subcontrol_5, "tag", "expimg",
"style", "checkbox",
"string", "export image",
"callback", @process,
"units", "normalized",
"value", 0,
"position", [0.6,0.8,0.4,0.15]);

exportTable = uicontrol(subcontrol_5, "tag", "exptab",
"style", "checkbox",
"string", "export table",
"callback", @process,
"units", "normalized",
"value", 0,
"position", [0.6,0.6,0.4,0.15]);

batchProcess = uicontrol(subcontrol_5, "tag", "batch",
"style", "checkbox",
"string", "process batch",
"callback", @process,
"units","normalized",
"value", 0,
"position", [0.6,0.4,0.4,0.15]);

run = uicontrol(subcontrol_5, "tag", "run",
"string", "run export process",
"units", "normalized",
"callback", @process,
"position", [0.6,0.05,0.35,0.3]);

setappdata(displayspace,
"exportImage", exportImage,
"exportTable", exportTable,
"batchProcess", batchProcess);

##this if/else could be slimmed down by creating the uicontrols and then using
##the if/else statement to set(uicontrol, "differentParameter", different value)
if tag == "1"                                                                   #if there is only one subplot, the UI changes somewhat.
  loadimage = uicontrol("parent", subcontrol_1 ,
  "callback", @process,
  "tag", "load",
  "string", "load image",
  "value", 0,
  "units", "normalized", "position", [0.05,(16/20),0.25,(0.33/2)]);

  downsample = uicontrol("parent", subcontrol_1,
  "tag", "down",
  "string", "downsample",
  "units", "normalized",
  "callback", @process,
  "position", [0.05,(11/20),0.25,(0.33/2)]);

  filmType = uicontrol("parent", subcontrol_1,
  "tag", "film",
  "style", "popupmenu",
  "string", {"Ultra Low",
  "Extreme Low",
  "Ultra Extreme Low",
  "Custom entry"},
  "callback", @process,
  "value", 1,
  "units", "normalized",
  "position", [0.7,11/20,0.25,0.15]);

  pressureType = uicontrol("parent", subcontrol_1,
  "tag", "units",
  "style", "popupmenu",
  "string", {"psi","kPa"},
  "callback", @process,
  "value", 1,
  "units", "normalized",
  "position", [0.7,16/20,0.25,0.15]);

  grayscale = uicontrol("parent", subcontrol_1,
  "tag", "grayscale",
  "string","decolorize",
  "callback", @process,
  "units", "normalized",
  "position", [0.375, (16/20), 0.25, (0.33/2)]);

  decolorize = uicontrol("parent", subcontrol_1,
  "tag", "decolorize",
  "string","decolorize",
  "callback", @process,
  "units", "normalized",
  "position", [0.375, (11/20), 0.25, (0.33/2)]);

else
  loadimage = uicontrol("parent", subcontrol_1 ,
  "callback", @process,
  "tag", "load",
  "string", "load image",
  "value", 0,
  "units", "normalized",
  "position", [0.05,0.6,0.25,0.33]);

  downsample = uicontrol("parent", subcontrol_1,
  "tag", "down",
  "string", "downsample",
  "units", "normalized",
  "callback", @process,
  "position", [0.05,0.1,0.25,0.33]);

  filmType = uicontrol("parent", subcontrol_1,
  "tag", "film",
  "style", "popupmenu",
  "string", {"Ultra Low",
  "Extreme Low",
  "Ultra Extreme Low",
  "Custom entry"},
  "callback", @process,
  "value", 1,
  "units", "normalized",
  "position", [0.7,0.1,0.25,0.3]);

  pressureType = uicontrol("parent", subcontrol_1,
  "tag", "units",
  "style", "popupmenu",
  "string", {"psi","kPa"},
  "callback", @process,
  "value", 1,
  "units", "normalized",
  "position", [0.7,0.6,0.25,0.3]);

  grayscale = uicontrol("parent", subcontrol_1,
  "tag", "grayscale",
  "string","grayscale",
  "callback",@process,
  "units", "normalized",
  "position", [0.375, 0.6, 0.25, 0.33]);

  decolorize = uicontrol("parent", subcontrol_1,
  "tag", "decolorize",
  "string","decolorize",
  "callback",@process,
  "units", "normalized",
  "position", [0.375, 0.1, 0.25, 0.33]);

endif
setappdata(displayspace,
"base",base,
"subcontrol_5", subcontrol_5,
"colormapmenu", colormapmenu,
"invert", invert,
"loadimage", loadimage,
"downsample", downsample,
"filmType", filmType,
"genUnits", "psi",
"film", [28 85],
"mult", 1,
"pressure", [28 85],
"texport", 0,
"iexport", 0,
"bexport" ,0);

numplot =  getappdata(displayspace, "numplot");
endif
endfunction

function process(calledBy, data);                                               #function that processes the image. most UI controlls call this function.
displayspace = findobj("tag","displayspace");
controlFig = findobj("tag","controlFig");
tag = get(calledBy, "tag");
toolPanel = getappdata(displayspace,"toolPanel");
children = get(toolPanel, "children");
allSubplots = get(displayspace, "children");
base = getappdata(displayspace, "base");
subplot_1 = getappdata(displayspace, "subplot_1");


switch tag;                                                                     #tag is the name of the UIcontrol called.
case "load"
  subplot(subplot_1);
  [fname, fpath, fltidx] = uigetfile();
  ffpath = strcat(fpath, fname);
  img = imread(ffpath);
  base.batchImage = img;
  setappdata(displayspace,"fname",fname, "fpath",fpath, "image", img, "base", base);
  imshow(img);
  base.batchSubPlot_1.type = "image";

## defines the name of the film used, and together with the "units" parameter
## determines the minimum and maximum pressure values
case "film"
  f = get(calledBy, "value")
  switch f
    case 1,
      film = [28 85.0];
      setappdata(displayspace, "film", film);
      base.batchSettings.batchFilmtype = film;
    case 2,
      film = [7.25 29.0];
      setappdata(displayspace, "film", film);
      base.batchSettings.batchFilmtype = film;
    case 3,
      film = [0.87 7.25];
      setappdata(displayspace, "film", film);
      base.batchSettings.batchFilmtype = film;
    case 4
      cstr = inputdlg ({"Input pressure max (film saturation pressure)","Input pressure min (default 0)"}, "Experimentally gathered film values in psi", [1,1], {0,0});
      film = [str2double(cstr(2)) str2double(cstr(1))];
      setappdata(displayspace, "film", film);
      base.batchSettings.batchFilmtype = film;
  endswitch

  film = getappdata(displayspace, "film");
  mult = getappdata(displayspace, "mult");

  pressure = film*mult;
  base.batchSettings.batchPressure = pressure;
  setappdata(displayspace,"base",base,"pressure",pressure);

## Determines the output units and, alongside the film type, the min and max pressure.
case "units"
  p = get(calledBy, "value");
  if p == 1
    mult = 1;
    setappdata(displayspace, "mult", mult, "genUnits", "psi");
    base.batchSettings.batchUnits = "psi";
  elseif p == 2
    mult = 6.89;
    setappdata(displayspace, "mult", mult, "genUnits", "kPa");
    base.batchSettings.batchUnits = "kPa";
  endif

  film = getappdata(displayspace, "film");
  base.batchSettings.batchFilmtype = film;
  mult = getappdata(displayspace, "mult");
  pressure = film*mult;
  base.batchSettings.batchPressure = pressure;
  setappdata(displayspace, "pressure", pressure, "base", base);

##Downsample the image. vital for large images.
case "down"
  subplot(subplot_1);
  v = inputdlg("what rate would you like to downsample your image by? \n Entering 1 will save every pixel of your image, \n entering 2 will save every 2nd pixel, \n entering 3 will save every 3rd, etc.");
  v = cell2mat(v)
  v = str2num(v)
  img = getappdata(displayspace, "image");
  for i = 1:size(img,3)
    imgdown(:,:,i) = img(1:v:end,1:v:end,i);
  endfor
  base.batchImage = imgdown;
  base.batchSettings.sampleRate = v;
  setappdata(displayspace, "image", imgdown, "base", base);
  imshow(imgdown);

case "grayscale"
  subplot(subplot_1);
  img = getappdata(displayspace, "image");
  imgNew = rgb2gray(img);
  base.batchImage = imgNew;
  base.batchSettings.grayscale = 1;
  imshow(imgNew);
  setappdata(displayspace, "image",imgNew, "base", base);

case "decolorize"
  subplot(subplot_1);
  img = getappdata(displayspace, "image");
  img = rgb2gray(img);
  [counts, x] = imhist(img);
  [w,iw] = max(counts(2:end));
  oMax = x(iw)
  oMin = min(min(img))
  imgNew = ((img-oMin)*(double(255)/double(oMax-oMin)));
  base.batchImage = imgNew;
  base.batchSettings.decolorized = 1;
  imshow(imgNew);
  setappdata(displayspace, "image",imgNew, "base", base);

case "map"
  m = get(calledBy, "value")
  if m == 1
    [fname, fpath, fltidx] = uigetfile("*.ggr")
    ffpath = strcat(fpath, fname);
    fid = fopen(ffpath);
    txt = fgetl(fid);
    if txt != "GIMP Gradient"
      disp("Not a GIMP gradient file");
      return;
    endif

    data = dlmread(fid, " ", 2, 0);
    segs = rows(data);
    segs = segs+1;
    rgbLGrad = data(:, 4:6);
    rgbRGrad = data(:, 8:10);
    rgbList = zeros(segs,3);
    rgbList(1:end-1, :) = rgbLGrad(:, :);
    rgbList(end,:) = rgbRGrad(end, :);
    locGrad = (data(:,3)-data(:,1))*100;
    cmap = colorgradient(rgbList,locGrad,256);
    setappdata(displayspace,"cmap", cmap);
    colormap(cmap);
  else
    list = {"load custom .ggr",
    "viridis",
    "cubehelix",
    "hsv",
    "rainbow",
    "hot",
    "cool",
    "spring",
    "summer",
    "autumn",
    "winter",
    "gray",
    "bone",
    "copper",
    "pink",
    "ocean",
    "colorcube",
    "flag",
    "lines",
    "prism",
    "white"}
    cmap = colormap(list{m});
    base.batchSettings.batchColormap = cmap;
    setappdata(displayspace,"cmap", cmap), "base", base;
    colormap(cmap);
    refresh(displayspace)

  endif
case "inv"
  cmap = getappdata(displayspace,"cmap");
  cmap = flipud(cmap);
  base.batchSettings.batchColormap = cmap;
  base.batchSettings.cinvert = 1;
  colormap(cmap);
  setappdata(displayspace,"cmap", cmap, "base", base);
  refresh(displayspace)


endswitch

tag = get(calledBy, "tag");
displayspace = getappdata(displayspace, "displayspace");
tagName = strtrunc(tag,4);
if length(tag) == 6
tagNum =  str2num(tag(6));                                                       #tagNum gives which subplot is calling the function
setappdata (displayspace,"tagNum", tagNum);
endif
img = getappdata(displayspace, "image");

numplot = getappdata(displayspace, "numplot");

switch tagName;
case "menu";
  menuNum = get(calledBy, "value");
  numplot = getappdata(displayspace, "numplot");
  subplotB = getappdata(displayspace, ["subplot_",num2str(tagNum)]);
  delete(subplotB);
  if numplot == 1
    subplotB = subplot(1,1,1,"parent",displayspace);
  elseif numplot == 2
    subplotB = subplot(1,2,tagNum,"parent",displayspace);
  elseif numplot > 2
    subplotB = subplot(2,2,tagNum,"parent",displayspace);
  endif
  setappdata(displayspace,["subplot_",num2str(tagNum)],subplotB)

  img = getappdata(displayspace, "image");
  pressure = getappdata(displayspace, "pressure");
  range = [0,linspace(pressure(1),pressure(2),255)];
  imvalues = range((imcomplement(img))+1);
  setappdata(displayspace,"imvalues",imvalues);
  setappdata(displayspace,"menuNum",menuNum);

  switch menuNum


  case 1 ;
    imvalues = getappdata(displayspace,"imvalues");
    whitespace = double(((sum(sum(imvalues == 0)))/(size(imvalues,1)*size(imvalues,2)))*100);
    setappdata(displayspace,"whitespace",whitespace);
    C = ["batchSubPlot_",num2str(tagNum)];
    I = imagesc(imvalues);
    base.(C).type = "pressuremap";
    axis nolabel
    axis tick off
    axis image

    subcontrol = getappdata(displayspace, ["subcontrol_",num2str(tagNum)]);
    if tagNum == 1
      whitespacebox = uicontrol(subcontrol,"style","checkbox","tag", num2str(tagNum),"string","% white space","units","normalized","position", [0.6,0.05,0.3,0.2],"callback",@whitespace);
    else
      whitespacebox = uicontrol(subcontrol,"style","checkbox","tag", num2str(tagNum),"string","% white space","units","normalized","position", [0.6,0.1,0.3,0.4],"callback",@whitespace);
    endif
    setappdata(displayspace,["whitespacebox_",num2str(tagNum)],whitespacebox,["I_",num2str(tagNum)],I, "base", base);


  case 2;
    if isappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      whitespacebox = getappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      rmappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      delete(whitespacebox);
    endif
    subplotB = getappdata(displayspace,["subplot_",num2str(tagNum)]);
    subplot(subplotB);
    units = getappdata(displayspace,"genUnits");
    img = imcomplement(img);
    [counts, histx] = imhist(img);

    histx = [0,linspace(pressure(1),pressure(2),255)]';
    skip = inputdlg("How many bins in the ""white"" range would you \
    like to skip for the histogram? \n 5 recommended.");

    skip = cell2mat(skip);
    skip = str2num(skip);
    base.batchSettings.batchSkip = skip;
    xTrunc = histx(skip:end,1);
    countsTrunc = counts(skip:end,1);
    table = vertcat( {"NaN", getappdata(displayspace,"fname"); getappdata(displayspace,"genUnits"), "instances"}, num2cell(horzcat(histx,counts)));
    base.batchTable = table;
    C = ["batchSubPlot_",num2str(tagNum)];
    base.(C).type = "histogram";
    eval(["I_",num2str(tagNum)," = bar(xTrunc,countsTrunc,""histc"",\
    ""linestyle"",""none"",""facecolor"",[0 0 0]);"]);
    set(subplotB,"xlabel",units,"ylabel","instances","xlim", [0, pressure(2) + 1]);
    setappdata(displayspace,"base",base);
  case 3;
    if isappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      whitespacebox = getappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      rmappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      delete(whitespacebox);
    endif
    tic

    img = imcomplement(img);
    units = getappdata(displayspace,"genUnits");
    cmap = getappdata(displayspace, "cmap");

    subplotA = getappdata(displayspace, ["subplot_",num2str(tagNum)]);
    subplot(subplotA);
    set(subplotA, "xlim", [0, pressure(2) + 1]);

    [counts, histx] = imhist(img);
    histx = [0,linspace(pressure(1),pressure(2),255)]'
    skip = inputdlg("How many bins in the ""white"" range would you like to skip for the histogram? \n 5 recommended.");

    skip = cell2mat(skip);
    skip = str2num(skip);
    base.batchSettings.batchSkip = skip;

    countsTrunc = counts;
    countsTrunc(1:skip) = 0;
    I = bar(histx,countsTrunc,'hist');
    set(I,"cdata",histx,"linestyle","none");
    set(subplotA,"xlabel",units,"ylabel","instances","xlim", [0, pressure(2) + 1]);
    table = vertcat( {"NaN", getappdata(displayspace,"fname");getappdata(displayspace,"genUnits"), "instances"}, num2cell(horzcat(histx,counts)));
    base.batchTable = table;
    C = ["batchSubPlot_",num2str(tagNum)];
    base.(C).type = "colorHistogram";
    setappdata(displayspace, ["I_", num2str(tagNum)],  I, "base", base);
    setappdata(displayspace, "table",table);
    subcontrol = getappdata(displayspace, ["subcontrol_", num2str(tagNum)]);


    disp(["time taken: " num2str(toc) " seconds"]);
  case 4
    if isappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      whitespacebox = getappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      rmappdata(displayspace,["whitespacebox_",num2str(tagNum)]);
      delete(whitespacebox);
    endif
    subplotB = getappdata(displayspace,["subplot_",num2str(tagNum)]);
    subplot(subplotB);
    C = ["batchSubPlot_",num2str(tagNum)];
    base.(C).type = "surfaceMap";
    eval(["surfmap_",num2str(tagNum)," = surf(columns(imvalues):-1:1,\
    1:rows(imvalues),imvalues,""linestyle"",""none"");"]);

    eval(["setappdata(displayspace, ""base"", base, \
    [""surfmap_"", num2str(tagNum)], ", ["surfmap_", num2str(tagNum)],");"]);
    axis image
endswitch



case "cbar"
tagNum = getappdata(displayspace,"tagNum");
menuNum = getappdata(displayspace,"menuNum");
C = ["batchSubPlot_",num2str(tagNum)];
switch isappdata(displayspace, ["clrbar_",num2str(tagNum)])
  case false
    eval(["subplot_",num2str(tagNum)," = getappdata(displayspace, [""subplot_"", num2str(tagNum)]);"]);
    if (menuNum == 2|menuNum ==3)
      eval(["clrbar_",num2str(tagNum)," = colorbar(subplot_",num2str(tagNum),",""southoutside"");"]);
      base.(C).batchColorbar = 1;
    else
      eval(["clrbar_",num2str(tagNum)," = colorbar(subplot_",num2str(tagNum),",""title"", getappdata(displayspace, ""genUnits""));"]);
      base.(C).batchColorbar = 1;
    endif
    eval(["setappdata(displayspace, [""clrbar_"", num2str(tagNum)], ", ["clrbar_", num2str(tagNum)],");"]);
  case true
    cbarHandle = getappdata(displayspace,["clrbar_",num2str(tagNum)])
     eval(["clrbar_",num2str(tagNum)," = getappdata(displayspace, [""clrbar_"",num2str(tagNum)]);"])
    rmappdata(displayspace,["clrbar_",num2str(tagNum)]);
    if ishandle(cbarHandle) == true
      delete(cbarHandle);
     endif
    base.(C).batchColorbar = 0;
endswitch
setappdata(displayspace, "base", base);

endswitch
switch tag
case "expimg"
  base.batchSettings.batchImageExport = get(calledBy, "value");
  setappdata(displayspace, "exportImage", calledBy, "base", base);
case "exptab"
  base.batchSettings.batchTableExport = get(calledBy, "value");
  setappdata(displayspace, "exportTable", calledBy, "base", base);
case "batch"
  base.batchSettings.batchprocess = get(calledBy, "value");
  setappdata(displayspace, "batchProcess", calledBy, "base",base);
case "run"
  exportImage = getappdata(displayspace, "exportImage");
  expimg = get(getappdata(displayspace, "exportImage"), "value");
  exptab = get(getappdata(displayspace, "exportTable"), "value");
  expbat = get(getappdata(displayspace, "batchProcess"), "value");
  table = getappdata(displayspace, "table");
  fname = getappdata(displayspace, "fname");
  fpath = getappdata(displayspace, "fpath");
  base = getappdata(displayspace, "base");
  [dir, name, ext] = fileparts ([fpath,fname]);
  units = getappdata(displayspace, "genUnits");


  if expbat == 1
    inLoc = ["none selected"];
    outLoc = ["none selected"];
    ready = 0;
    extensions = {".bmp";
    ".gif";
    ".jpg";
    ".jpeg";
    ".pbm";
    ".pcx";
    ".pgm";
    ".png";
    ".pnm";
    ".ppm";
    ".ras";
    ".tif";
    ".tiff";
    ".xwd"};

    while (ready == 0)
      dialogue = ["Batch processing \n\
      ------------------------------------\n\
      Input folder location: \n\
      ",inLoc,"\n\
      \n\
      Output folder location:\n\
      ",outLoc,"\n\
      \n\
      WARNING: batch process will apply same process done to original image\n\
      to ALL FILES in input folder, then apply export options as selected to \n\
      the Output folder. please ensure everything is correct. filename extensions \n\
      inside input folder should be ALL LOWERCASE"];

      if (strcmp(inLoc , ["none selected"]) | strcmp(outLoc , ["none selected"]))
        ready == 0;
      else
        ready == 1;
        break
      endif

      btn = questdlg (dialogue, "Batch Processing", "Input Folder", "Output Folder", "CANCEL", "CANCEL");

      if strcmp(btn , "Input Folder")
        inLoc = uigetdir (pwd,"Select input folder");

      elseif strcmp(btn, ["Output Folder"])
        outLoc = uigetdir (pwd,"Select output folder");
        setappdata(displayspace, "outLoc", outLoc);

      else
        return

      endif


    endwhile
    btn = questdlg (dialogue, "Batch Processing", "RUN PROCESS", "CANCEL", "CANCEL");

    sze = get(0,"screensize");
    sze = [(0.5*(sze(3)-(sze(3)*0.95))) ,(0.5*(sze(4)-(sze(4)*0.95))) ,sze(3)*0.95 ,sze(4)*0.95];

    list = fullfile(inLoc,readdir(inLoc));
    A = cell(length(list),length(extensions));
    for i = 1:length(extensions)
      A(:,i) = strfind(lower(list),extensions{i});
    endfor
    indx = find(~cellfun(@isempty,A));
    indx = rem(indx,length(list));
    indx(indx == 0) = length(list);
    files = cell(length(indx),1);
    files(1:end) = list(indx(1:end));
    h = waitbar (0, 'processing...');
    timeElapsed = zeros(length(files));
    outside = tic();
    for ii = 1:length(files)
      inside = tic();
      [dir,name,ext] = fileparts(files{ii});
      waitbar (ii/(length(files)), h, [num2str(ii),"/",num2str(length(files)),"\n Processing: ",name,ext,]);
      tempFigure = figure("filename", name,
      "visible", "off",
      "NumberTitle","off",
      "tag", "tempFigure",
      "position",[sze(1)+(0.25*sze(3)), sze(2), sze(3)*0.75, sze(4)]);

      cmap = base.batchSettings.batchColormap;
      colormap(cmap);
      img = imread(files{ii});

      if base.batchSettings.decolorized == 1
        if isrgb(img)
          img = rgb2gray(img);
          [graycounts, x] = imhist(img);
          [w,iw] = max(graycounts);
          oMax = x(iw);
          oMin = min(min(img));
          img = ((img-oMin)*(double(255)/double(oMax-oMin)));
        endif
      endif

      if base.batchSettings.grayscale == 1
        if isrgb(img)
          img = rgb2gray(img);
        endif
      endif

      if base.batchSettings.batchTableExport == 1
        [counts,histx] = imhist(img);
        histx = [0,linspace(base.batchSettings.batchPressure(1),base.batchSettings.batchPressure(2),255)]';
        table = vertcat( {"NaN", name; base.batchSettings.batchUnits, "instances"}, num2cell(horzcat(histx,counts)));
      endif

      v = base.batchSettings.sampleRate;
      if v != 1

        if exist("imgdown","var")
          clear("imgdown");
        endif

        for i = 1:size(img,3)
          imgdown(:,:,i) = img(1:v:end,1:v:end,i);
        endfor
        img = imgdown;
      endif

      range = [0,linspace(base.batchSettings.batchPressure(1),base.batchSettings.batchPressure(2),255)];
      imvalues = range((imcomplement(img))+1);
      numPlot = base.batchSettings.batchNumPlot;
      if numPlot == 1
        A = 1;
        B = 1;
      elseif numPlot == 2
        A = 1;
        B = 2;
      else
        A = 2;
        B = 2;
      endif

      for iii = 1:numPlot
        subplot(A, B, iii);
        C = ["batchSubPlot_",num2str(iii)];
        switch base.(C).type;
          case "image"
            disp(["output ",num2str(ii),
            ", subplot",num2str(iii),", type: image"]);

            imshow(img);
          case "pressuremap"
            disp(["output ",num2str(ii),
            ", subplot",num2str(iii),", type: pressuremap"]);

            imagesc(imvalues);
            axis image

            if base.(C).batchColorbar == 1;
              colorbar("title",base.batchSettings.batchUnits);
            endif
            if base.(C).batchWhitespace == 1;
              whitespace = double(((sum(sum(imvalues == 0)))/...
              (size(imvalues,1)*size(imvalues,2)))*100);

              whitetext = text(0.5,1.1,[sprintf("%.1f", whitespace),"% white space"],
              "horizontalalignment","center",
              "units","normalized",
              "color",[0,0,0]);

            endif
          case "histogram"
            disp(["output ",num2str(ii),
            " subplot",num2str(iii),", type: histogram"])
            subplotA = subplot(A, B, iii);
            img = imcomplement(img);
            [counts, histx] = imhist(img);
            histx = [0,linspace(base.batchSettings.batchPressure(1),base.batchSettings.batchPressure(2),255)]';
            skip = base.batchSettings.batchSkip;
            xTrunc = histx(skip:end,1);
            countsTrunc = counts(skip:end,1);

            bar1 = bar(xTrunc,countsTrunc,"histc",
            "linestyle","none",
            "facecolor",[0 0 0]);

            if  base.(C).batchColorbar == 1;
              colorbar("southoutside");
            endif
            set(bar1,"xlabel",base.batchSettings.batchUnits,
            "ylabel","instances");
            set(subplotA,"xlabel",base.batchSettings.batchUnits,"ylabel","instances","xlim", [0, base.batchSettings.batchPressure(2) + 1]);

            case"colorHistogram"
            disp(["output ",num2str(ii),
            " subplot",num2str(iii),", type: color histogram"]);
            subplotA = subplot(A, B, iii);
            img = imcomplement(img);
            units = base.batchSettings.batchUnits;
            [counts, histx] = imhist(img);
            histx = [0,linspace(base.batchSettings.batchPressure(1),base.batchSettings.batchPressure(2),255)]'
            skip = base.batchSettings.batchSkip;
            countsTrunc = counts;
            countsTrunc(1:skip) = 0;
            I = bar(histx,countsTrunc,'hist');
            set(I,"cdata",histx,"linestyle","none");
            if  base.(C).batchColorbar == 1;
              colorbar("title",base.batchSettings.batchUnits,"southoutside");
            endif
            case"surfaceMap"
            disp(["output ",num2str(ii),
            " subplot",num2str(iii),", type: surfacemap"]);

            col = columns(imvalues):-1:1;
            row = 1:rows(imvalues);

            surf(col,row,imvalues, "linestyle","none");

            axis image
            if  base.(C).batchColorbar == 1;
              colorbar("southoutside");
            endif
            set(subplotA,"xlabel",base.batchSettings.batchUnits,"ylabel","instances","xlim", [0, base.batchSettings.batchPressure(2) + 1]);
        endswitch
      endfor
      if base.batchSettings.batchImageExport == 1
        cd(outLoc);
        disp(["printing: ",[name,"_processed_",base.batchSettings.batchUnits,".png"]]);
        print(tempFigure,[name,"_processed_",base.batchSettings.batchUnits,".png"]);
      endif
      if base.batchSettings.batchTableExport == 1
        cd (outLoc)
        disp(["printing: \
        ",[name,"_",base.batchSettings.batchUnits,".csv"]]);

        cell2csv([name,"_",base.batchSettings.batchUnits,".csv"],
        table);

      endif
      delete(tempFigure);
      disp("tempFigure deleted")
      timeElapsed(ii) = toc(inside);
    endfor
    doubleCheckTiming = toc(outside);
    delete(h)
    [minval, minID] = min(timeElapsed);
    [~,minName,minExt] = fileparts(files{minID});
    [maxval, maxID] = max(timeElapsed);
    [~,maxName,maxExt] = fileparts(files{maxID});
    statsBox = msgbox(["Number of files processed: ",num2str(length(files)),"\n\
\n\
Total time elapsed (inside for): ",sprintf("%.1f",sum(timeElapsed))," seconds \n\
\n\
Total time elapsed (outside for): ",sprintf("%.1f",doubleCheckTiming)," seconds \n\
\n\
average time per file: ",sprintf("%.1f",mean(timeElapsed))," seconds \n\
\n\
shortest time and file: ", sprintf("%.1f",minval)," seconds; ", minName, minExt,"\n\
\n\
longest time and file: ", sprintf("%.1f",maxval)," seconds; ", maxName, maxExt,]);

  endif

  if expimg == 1
    genUnits = getappdata(displayspace,"genUnits");
    displayspace = getappdata(displayspace, "displayspace");
    print(displayspace, [name,"_processed_",genUnits,".png"]);
  endif

  if exptab == 1
    cell2csv ([name,"_",units,".csv"], table);
  endif
endswitch

endfunction
function whitespace(calledBy, data)
displayspace = findobj("tag","displayspace")
controlFig = findobj("tag","controlFig")
base = getappdata(displayspace,"base");
tag = (get(calledBy, "tag"))
C = ["batchSubPlot_",num2str(tag)]
subplotA = getappdata(displayspace,["subplot_",tag])
subplot(subplotA)
whitespace = getappdata(displayspace, "whitespace")
v = get(calledBy, "value")
disp(["base.",(C),".batchWhitespace = ",num2str(v)]);
base.(C).batchWhitespace = v;
setappdata(displayspace,"base",base);
switch v
  case 1
    whitetext = text(0.5,1.1,[sprintf("%.1f", whitespace),"% white space"],"horizontalalignment","center","units","normalized","color",[0,0,0])
    setappdata(displayspace,"whitetext",whitetext)
  case 0
    if isappdata(displayspace, "whitetext") == 1
      whitetext = getappdata(displayspace, "whitetext")
      rmappdata(displayspace, "whitetext")
      delete(whitetext)
    endif
endswitch
endfunction

function helpme(calledBy, data)
  sze = get(0,"screensize")

  helpBox = figure("position", [(0.2*sze(3))+1, 89, (sze(3)*0.6)-1, sze(4)*.8],
    "toolbar","none",
  "name", "HELP",
  "NumberTitle", "off")

  panel = uipanel("parent", helpBox,
  "title", "Help Topics",
  "units", "normalized",
  "position", [0 0 0.25 1])

  list = uicontrol("parent", panel,
  "style", "listbox",
  "units", "normalized",
  "position", [0 0 1 1],
  "string", {"",
  "General Help",
  "FAQ",
  "Loading images",
  "Downsampling",
  "Grayscale and Decolorize",
  "Units and Film Type",
  "Pressure Maps",
  "Color and non-color histograms",
  "3D Surface maps",
  "Exporting images and tables",
  "Batch exporting"},
  "callback", @listclicked)

  helptext1 = uicontrol("parent", helpBox,
  "style", "text",
  "string", " ",
  "units", "normalized",
  "position",[0.25 0.5 0.75 0.5],
  "tag","helptext1",
  "horizontalalignment","left")

  helptext2 = uicontrol("parent", helpBox,
  "style", "text",
  "string", " ",
  "units", "normalized",
  "position",[0.25 0 0.75 0],
  "tag","helptext2",
  "horizontalalignment","left")
endfunction

  function listclicked(calledBy, data)
  helptext1 = findobj("tag","helptext1")
  helptext2 = findobj("tag","helptext2")
  val = get(calledBy, "value")
  switch val
    case 1
set(helptext1, "string", " ")
set(helptext2, "string", " ")
    case 2
      set(helptext1,"position", [0.25 0 0.75 1],
      "string","\
General information \n\
------------------------- \n\
Welcome to POSSM! This program takes data from black and  \n\
white images and turns them into various kinds of graphs and tables. The basic \n\
workflow is as follows: \n\
1) decide how many figures you would like to export as your final product.\n\
   select the correspoding radio buttone under ""image output number"".\n\
2) under panel one, click ""load image"" and browse to the imige you wish to \n\
   analyze. \n\
3) downsample the image if it is very large. click ""grayscale"" if your image  \n\
   is already a black and white image. click ""decolorize"" if it is in color. \n\
4) select the units you would like to export data in, and the filmtype that your\n\
   image was taken with. \n\
5) your first image (unless you selected ""one plot"") will always be the image \n\
   the data is being taken from. for the remaing images, select what sort of \n\
   graph you would like, and if you would like to display it with a colorbar. \n\
6) change your color map, if you intend to.\n\
7) select your export types and whether you want a batch process done, and then\n\
   click ""run export process"".\n\
   \n\
This software was written by Patrick Grider <patrickgrider@gmail.com>")
set(helptext2,"position", [0.25 0.5 0.75 0], "string", " ")
    case 3
set(helptext1, "string", "")
set(helptext2, "string", " ")
    case 4
set(helptext1, "string", "\
Loading images\n\
-----------------\n\
The images you load into possum can have the file extensions:\n\
.bmp\n\
.gif\n\
.jpg\n\
.jpeg\n\
.pbm\n\
.pcx\n\
.pgm\n\
.png\n\
.pnm\n\
.ppm\n\
.ras\n\
.tif\n\
.tiff\n\
.xwd\n\
\n\
if your image has a different filetype, convert it to one of the above types \n\
with an image editing program.")
set(helptext2, "string", " ")
    case 5
    set(helptext1,"position", [0.25 0.5 0.75 0.5],
    "string",
"Downsampling \n\
------------------------- \n\
Downsampling data in POSSM works through interpreting an image as a matrix and   \n\
then manipulating that matrix. If you set the downsampling rate at two, the   \n\
resulting image will keep one pixel, then skip one pixel, then keep one pixel, \n\
etc. If you set the rate to 3, it will be keep one, skip two instead.")

 set(helptext2, "position",[0.25 0 0.75 0.5],
 "fontname","courier",
  "horizontalalignment","left",
  "string",
"Original Image:\n\
 1   2   3   4   5 \n\
 6   7   8   9   10 \n\
 11  12  13  14  15 \n\
 16  17  18  19  20 \n\
 21  22  23  24  25 \n\
 \n\
Downsampling rate: 2 \n\
(1)  2  (3)  4  (5)\n\
 6   7   8   9   10             1   3   5\n\
(11) 12 (13) 14 (15)    ------->11  13  15\n\
 16  17  18  19  20             21  23  25\n\
(21) 22 (23) 24 (25)\n\
\n\
Downsampling rate: 3\n\
(1)  2   3  (4)  5 \n\
 6   7   8   9   10 \n\
 11  12  13  14  15     ------->1   4 \n\
(16) 17  18 (19) 20             16  19\n\
 21  22  23  24  25 ");
    case 6
set(helptext1, "position", [0.25 0 0.75 1],
 "string",
"GRAYSCALE: click ""grayscale"" if you have uploaded a black and white image to POSSM.\n\
\n\
DECOLORIZE: click ""decolorize if you have uploaded a color image to POSSM.\n\
-------------------------------------------------------------------------------\n\
POSSM can only analyze black and white images, and your pressure-film images\n\
are likely in color. POSSM is designed to analyze 2 dimensional grayscale matrices of \n\
values from 0 to 255, each matrix value representing one image pixel. Standard \n\
color images are typically saved as RGB matrices, 3 dimentional matrices of \n\
values 0 to 255. They can also be thought of as three matrices stacked on top of \n\
one another, each the size of the image; one matrix representing Red values, \n\
another representing Green, and the last representing Blue, e.g. \n\
img(:,:,1) = red\n\
img(:,:,2) = blue\n\
img(:,:,3) = green\n\
\n\
There are two ways to handle color images with POSSM, both with their own pros\n\
and cons.\n\
\n\
1) Edit your pressure-film images in an image editing software, such as Krita, \n\
   then load your new black and white image into POSSM and click ""grayscale"".\n\
   The grayscale button is necescary because sometimes image editing software \n\
   will not export as a 2D grayscale matrix, but instead as a 3D RGB matrix \n\
   with each value set equal to one another (e.g. img(:,:,1) = img(:,:,2) = img(:,:,3)).\n\
   The grayscale button flattens a 3D matrix into a 2D one.\n\
   \n\
   The general protocol for processing color images for POSSM is: \n\
     a) Desaturate image (make grayscale) \n\
     b) Adjust image levels. Your 100% saturation points should be value 0 black \n\
        and your most used white (the background color of the film) should be \n\
        value 255 white.\n\
   This method leads to the most consistent images with the least amount of \n\
   background noise, but it takes a considerable amount of time, and requires \n\
   an additional program.\n\
\n\
2) Load a color image into POSSM, and click ""decolorize"". POSSM will attempt \n\
   to process the image for you, choosing the color value with the highest histogram \n\
   count to set as 255 value white, and the darkest value to be 0 value black. \n\
   This is significantly less precise than editing the image yourself, and can\n\
   result in high background noise. However, it is extremely quick and easy,\n\
   and can be useful for batch processing large image sets.")
set(helptext2,"position", [0.25 0 0.75 0], "string", " ")
case 7
set(helptext1, "string", "\
Units and film type\n\
--------------------\n\
POSSM currently can export results exclusively in kPa and psi. If you need to \n\
change this by adding another unit type, you will have to add it to the uicontrols \n\
named filmType near lines 593 and 644, and add it to the case ""units"" statement\n\
near line 745. POSSM uses psi as its base value, and multiplies by 6.89 to get kPa.\n\
\n\
The currently coded film types are Fujifilm Prescale Ultra Super Low (abbreviated as Ultra Low)\n\
Extreme Low, and Ultra Extreme Low, and custom. If you need to add another specific film type, you \n\
will have to add it to the uicontrols named filmType near lines 581 and 632, \n\
and to the case ""film"" statement near line 715.\n\
\n\
Custom film type asks for a maximum registration pressure and a minimum \n\
registration pressure. these must be entered in psi.")
set(helptext2, "string", " ")
case 8
set(helptext1, "string", "\
2D Pressure maps\n\
------------------\n\
The 2D pressure map is just a colormap applied to your uploaded image, with your\n\
image adjusted for film type and unit type. If you find that, after adding a \n\
different type of graphic, that your color bar is now incorrect (white space at \n\
the top, or only showing part of the desired gradient), try clicking the Apply \n\
Colorbar button to delete it, and then click it again to re-generate the color bar.\n\
\n\
The percent whitespace tick box, when ticked, will display what percentage of your \n\
image is at zero pressure. if you would like to target a different pressure \n\
value, you will have to change the boolean value inside the sum(imvalues == 0) \n\
operation in the if base.(C).batchWhitespace == 1 statement near line 1221 and \n\
in the case 1 statement near line 906. For instance, if you wanted to display\n\
the percentage of values equal to or greater than 50 kPa, you would change it to\n\
sum(imvalues >= 50). Adding this proces to the UI is an implementation goal.")
set(helptext2, "string", " ")
case 9
set(helptext1, "string", " ")
set(helptext2, "string", " ")
case 10
set(helptext1, "string", " ")
set(helptext2, "string", " ")
case 11
set(helptext1, "string", " ")
set(helptext2, "string", " ")
case 12
set(helptext1, "string", " ")
set(helptext2, "string", " ")
endswitch
  endfunction

