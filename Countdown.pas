unit Countdown;
//{$mode objfpc}{$H+}
{*
Copyright (C) 2010-2016  Henk Jegers
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

for questions email to info@archeryclock.com

this software uses SDPO serial, SDL, LNET and MMSystem

Contributions: Yann Morere (Linux)
               Henk Jegers (initial version/Windows.)
*}

interface

uses
  {$IFDEF Windows}

  MMSystem, windows,
  {$ENDIF}
  {$IFDEF Unix}
  UTF8Process, {$IFDEF Darwin}macsound,{$ELSE}sdl, sdl_mixer,{$ENDIF} unix, BaseUnix, Regexpr, Process, mouse, CRT,
  {$ENDIF}
  LCLIntf, LCLType, Synaser, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, ComCtrls, Spin, dateutils, DBCtrls,
  StrUtils, Menus, Grids, IniPropStorage, maskedit, ColorBox, ExtDlgs, ActnList,
  SdpoSerial, lNetComponents, FileUtil, LazFileUtils, SynEdit, lNet, blcksock, synsock,
  {$IFDEF Windows}
  Winsock,
  {$ENDIF}
  synautil, types;

{$DEFINE UseCThreads}
{$IFDEF UNIX}{$IFDEF UseCThreads}
//cthreads,
{$ENDIF}{$ENDIF}


type

  { TCountdownform }

  TCountdownform = class(TForm)
    abcd25m1p: TCheckBox;
    ABCDperEND: TCheckBox;
    ABColListBoxtime: TColorListBox;
    ABGroupBox: TGroupBox;
    abouticon: TImage;
    Addimagebutton: TButton;
    am24: TRadioGroup;
    am24_2: TRadioGroup;
    Archerlabel25m1p: TLabel;
    arduinoselect1: TCheckBox;
    arduinoselect2: TCheckBox;
    arrowkeyImage1: TImage;
    arrowkeyImage2: TImage;
    arrowkeyImage3: TImage;
    arrowkeyImage4: TImage;
    AudioActionstate2: TGroupBox;
    AudioActionstate3: TGroupBox;
    AudioActionstate4: TGroupBox;
    AudioActionstate5: TGroupBox;
    AudioActionstate6: TGroupBox;
    Audioboxstate2: TGroupBox;
    Audioboxstate3: TGroupBox;
    Audioboxstate4: TGroupBox;
    Audioboxstate5: TGroupBox;
    Audioboxstate6: TGroupBox;
    AudioVolumestate1: TGroupBox;
    AudioVolumestate2: TGroupBox;
    AudioVolumestate3: TGroupBox;
    AudioVolumestate4: TGroupBox;
    AudioVolumestate5: TGroupBox;
    AudioVolumestate6: TGroupBox;
    BCDtoROG2: TCheckBox;
    BCDtoROG2label: TLabel;
    Bevel1: TBevel;
    Blinkphase2CheckBox: TCheckBox;
    blnkcombox: TComboBox;
    blnklabel: TLabel;
    button1: TLabel;
    button2: TLabel;
    button3: TLabel;
    button4: TLabel;
    button5: TLabel;
    blinkredgroupbox: TGroupBox;
    Blinkphase1CheckBox: TCheckBox;
    Beepswitcharcher: TCheckBox;
    atstartuplabel: TLabel;
    AudioIPedit: TEdit;
    Actualtimecheckbox: TCheckBox;
    interfaceEdit: TEdit;
    interfacelabel: TLabel;
    enableaccesspointbutton: TButton;
    closesystemPanel: TPanel;
    AccesspointGroupBox: TGroupBox;
    CountrycodeEdit: TEdit;
    countrycodelabel: TLabel;
    disableaccesspointbutton1: TButton;
    enableaccesspointpanel: TPanel;
    disableaccesspointpanel: TPanel;
    PWEdit: TEdit;
    renewserialbutton: TButton;
    comboxK8055but1: TComboBox;
    comboxK8055but2: TComboBox;
    comboxK8055but3: TComboBox;
    comboxK8055but4: TComboBox;
    comboxK8055but5: TComboBox;
    comboxpn32: TComboBox;
    comboxpn33: TComboBox;
    comboxpn35: TComboBox;
    comboxpn36: TComboBox;
    comboxpn37: TComboBox;
    comboxpn38: TComboBox;
    comboxpn40: TComboBox;
    comboxunknown: TComboBox;
    controltab: TTabSheet;
    downarrowkeycombo: TComboBox;
    genericpointer: TImage;
    HWP32: TLabel;
    HWP33: TLabel;
    HWP35: TLabel;
    HWP36: TLabel;
    HWP37: TLabel;
    HWP38: TLabel;
    HWP40: TLabel;
    HWPunknown: TLabel;
    controlScrollBox: TScrollBox;
    K8055but1: TLabel;
    K8055but2: TLabel;
    K8055but3: TLabel;
    K8055but4: TLabel;
    K8055but5: TLabel;
    kensingtonpointer: TImage;
    keyboardinputbox: TGroupBox;
    keyboardpref1: TButton;
    keyboardpref2: TButton;
    keyboardpref3: TButton;
    SSIDEdit: TEdit;
    SSIDlabel: TLabel;
    APstatuslabel: TLabel;
    SSIDPWlabel: TLabel;
    stopinbetweenturnsfitacheckbox: TCheckBox;
    showendnrlabel: TLabel;
    laserpointerbox: TGroupBox;
    leftarrowkeycombo: TComboBox;
    line1: TShape;
    line2: TShape;
    line3: TShape;
    line4: TShape;
    line5: TShape;
    line6: TShape;
    logitechpointer: TImage;
    logppt: TImage;
    minsec: TRadioGroup;
    newminsecbox: TGroupBox;
    nextonlybutton: TButton;
    nonzerosec: TRadioButton;
    normalppt: TImage;
    pgdncombox: TComboBox;
    pgdnlabel: TLabel;
    pgupcombox: TComboBox;
    pguplabel: TLabel;
    playcombox: TComboBox;
    playlabel: TLabel;
    repeatsequencelabel: TLabel;
    repeatsequence: TSpinEdit;
    rightarrowkeycombo: TComboBox;
    RPIinputbox: TGroupBox;
    serialinputbox: TGroupBox;
    sheetdatetime1label: TLabel;
    sheetdatetime3label: TLabel;
    sheetdatetime4label: TLabel;
    sheetdatetime2label: TLabel;
    reconnectbutton: TButton;
    Controlaudiocheckbox: TCheckBox;
    finalteamturns: TSpinEdit;
    finalteamturnsSO: TSpinEdit;
    finalturns: TSpinEdit;
    finalturnsSO: TSpinEdit;
    iconstate1: TImage;
    fitatimingbox: TGroupBox;
    greentime: TSpinEdit;
    greentimeso: TSpinEdit;
    fitafinseqbox: TGroupBox;
    audiovolumebox: TGroupBox;
    Audioboxstate1: TGroupBox;
    AudioActionstate1: TGroupBox;
    iconstate2: TImage;
    iconstate3: TImage;
    iconstate4: TImage;
    iconstate5: TImage;
    iconstate6: TImage;
    controlicon: TImage;
    TCPmusiccntrl: TLTCPComponent;
    pauseimagestate1: TImage;
    pauseimagestate2: TImage;
    pauseimagestate3: TImage;
    pauseimagestate4: TImage;
    pauseimagestate5: TImage;
    pauseimagestate6: TImage;
    Pausestate2: TRadioButton;
    Pausestate3: TRadioButton;
    Pausestate4: TRadioButton;
    Pausestate5: TRadioButton;
    Pausestate6: TRadioButton;
    playimagestate2: TImage;
    playimagestate3: TImage;
    playimagestate4: TImage;
    playimagestate5: TImage;
    playimagestate6: TImage;
    Playstate2: TRadioButton;
    Playstate3: TRadioButton;
    Playstate4: TRadioButton;
    Playstate5: TRadioButton;
    Playstate6: TRadioButton;
    stopimagestate1: TImage;
    playimagestate1: TImage;
    indfindefbutton: TButton;
    AudioIPlabel: TLabel;
    mxteamfindefbutton: TButton;
    Playstate1: TRadioButton;
    Pausestate1: TRadioButton;
    stopimagestate2: TImage;
    stopimagestate3: TImage;
    stopimagestate4: TImage;
    stopimagestate5: TImage;
    stopimagestate6: TImage;
    Stopstate1: TRadioButton;
    orangetime: TSpinEdit;
    orangetimeso: TSpinEdit;
    Audioportnumber: TSpinEdit;
    audioportlabel: TLabel;
    Stopstate2: TRadioButton;
    Stopstate3: TRadioButton;
    Stopstate4: TRadioButton;
    Stopstate5: TRadioButton;
    Stopstate6: TRadioButton;
    musicvolumetimer: TTimer;
    timedown: TImage;
    serialfreqdelay: TTimer;
    closesystem: TTimer;
    uparrowkeycombo: TComboBox;
    VLCradiobutton: TRadioButton;
    reamfindefbutton: TButton;
    redtime: TSpinEdit;
    redtimeso: TSpinEdit;
    secgrnlabel4: TLabel;
    secgrnlabel5: TLabel;
    secorlabel4: TLabel;
    secorlabel5: TLabel;
    secredlabel4: TLabel;
    secredlabel5: TLabel;
    sectotlabel4: TLabel;
    sectotlabel5: TLabel;
    so: TGroupBox;
    timeperend: TRadioButton;
    timeperturn: TRadioButton;
    timingfitabox: TGroupBox;
    nrof1ppractisearrows: TSpinEdit;
    nrof1pshooters: TSpinEdit;
    practiselabel25m1p1: TLabel;
    sequence25m1pbox: TGroupBox;
    leftsideclientbutton: TButton;
    rightsideclientbutton: TButton;
    rotate25m1p: TCheckBox;
    rotate25m1p_p: TCheckBox;
    Start1_1p: TGroupBox;
    startupscenariobox: TGroupBox;
    preborder: TImage;
    preborder1: TImage;
    prelayoutradio2: TRadioButton;
    pretimelayoutbox: TGroupBox;
    L_EndBG: TImage;
    prelayoutradio1: TRadioButton;
    R_EndBG: TImage;
    rightgrncircle: TShape;
    leftredcircle: TShape;
    rightredcircle: TShape;
    leftyelcircle: TShape;
    leftgrncircle: TShape;
    rightyelcircle: TShape;
    Shape1: TShape;
    showendnrcheckbox: TCheckBox;
    coloricon: TImage;
    emergencyicon: TImage;
    Hardwareicon: TImage;
    iconpanel: TPanel;
    IconScrollBox: TScrollBox;
    languageicon: TImage;
    layouticon: TImage;
    networkicon: TImage;
    precounticon: TImage;
    scenarioicon: TImage;
    soundicon: TImage;
    timecheckbox: TCheckBox;
    greenfinalendso: TSpinEdit;
    groupfinendSO: TGroupBox;
    Datetimelabel: TLabel;
    orangebeepfitacheckbox: TCheckBox;
    fitafinicon: TImage;
    followicon: TImage;
    manualicon: TImage;
    icon25m1p: TImage;
    fitaicon: TImage;
    orangebeep25m1pcheckbox: TCheckBox;
    orangefinalendso: TSpinEdit;
    redfinalendso: TSpinEdit;
    secgrnlabel6: TLabel;
    secorlabel6: TLabel;
    secredlabel6: TLabel;
    sectotlabel6: TLabel;
    actualtime: TTimer;
    changeendturntimer: TTimer;
    totalfinalendso: TLabel;
    ShutdownremoteButton: TButton;
    RemshutdownCheckBox: TCheckBox;
    Choosebannerbutton: TButton;
    CDColListBoxtime: TColorListBox;
    CDGroupBox: TGroupBox;
    cdmenu2: TLabel;
    closeimage1: TImage;
    colorscheme1: TRadioButton;
    colorscheme2: TRadioButton;
    colorscheme3: TRadioButton;
    colorscheme4: TRadioButton;
    colorscheme5: TRadioButton;
    colorscheme6: TRadioButton;
    colorscheme7: TRadioButton;
    colorscheme8: TRadioButton;
    colorscheme9: TRadioButton;
    danger2: TImage;
    dbltime: TRadioButton;
    dblturn: TRadioButton;
    fliplabel: TLabel;
    bannerscrollbox: TScrollBox;
    specificbannerpath: TLabel;
    specificbannerRadioButton: TRadioButton;
    disapsec2: TLabel;
    dot1: TLabel;
    dot2: TLabel;
    dot3: TLabel;
    doubleseq: TLabel;
    doubletime: TLabel;
    doubleturnpanel: TPanel;
    doubleturns: TCheckBox;
    doubleturnslabel: TLabel;
    EmergencyalternativeRadioButton: TRadioButton;
    EmergencybhaviorGroupBox: TGroupBox;
    EmergencydefaultRadioButton: TRadioButton;
    EmergencysoundGroupBox: TGroupBox;
    EmergencytxtEdit: TEdit;
    EmergencytxtGroupBox: TGroupBox;
    exthwbox: TGroupBox;
    F10Bevel: TBevel;
    F10Button: TButton;
    F10description: TLabel;
    F10Group: TGroupBox;
    F10sequence: TLabel;
    F10shootredtime: TLabel;
    F10shoottime: TLabel;
    F10Shoottimelabel: TLabel;
    F10SOredtime: TLabel;
    F10SOtime: TLabel;
    F10SOtimelabel: TLabel;
    F10waitlabel1: TLabel;
    F10waitlabel2: TLabel;
    F11Bevel: TBevel;
    F11Button: TButton;
    F11description: TLabel;
    F11Group: TGroupBox;
    F11sequence: TLabel;
    F11shootredtime: TLabel;
    F11shoottime: TLabel;
    F11Shoottimelabel: TLabel;
    F11SOredtime: TLabel;
    F11SOtime: TLabel;
    F11SOtimelabel: TLabel;
    F11waitlabel1: TLabel;
    F11waitlabel2: TLabel;
    F12Bevel: TBevel;
    F12Button: TButton;
    F12description: TLabel;
    F12Group: TGroupBox;
    F12sequence: TLabel;
    F12shootredtime: TLabel;
    F12shoottime: TLabel;
    F12Shoottimelabel: TLabel;
    F12SOredtime: TLabel;
    F12SOtime: TLabel;
    F12SOtimelabel: TLabel;
    F12waitlabel1: TLabel;
    F12waitlabel2: TLabel;
    F1Bevel: TBevel;
    F1Button: TButton;
    F1description: TLabel;
    F1Group: TGroupBox;
    F1sequence: TLabel;
    F1shootredtime: TLabel;
    F1shoottime: TLabel;
    F1Shoottimelabel: TLabel;
    F1SOredtime: TLabel;
    F1SOtime: TLabel;
    F1SOtimelabel: TLabel;
    F1waitlabel1: TLabel;
    F1waitlabel2: TLabel;
    F2Bevel: TBevel;
    F2Button: TButton;
    F2description: TLabel;
    F2Group: TGroupBox;
    F2sequence: TLabel;
    F2shootredtime: TLabel;
    F2shoottime: TLabel;
    F2Shoottimelabel: TLabel;
    F2SOredtime: TLabel;
    F2SOtime: TLabel;
    F2SOtimelabel: TLabel;
    F2waitlabel1: TLabel;
    F2waitlabel2: TLabel;
    F3Bevel: TBevel;
    F3Button: TButton;
    F3description: TLabel;
    F3Group: TGroupBox;
    F3sequence: TLabel;
    F3shootredtime: TLabel;
    F3shoottime: TLabel;
    F3Shoottimelabel: TLabel;
    F3SOredtime: TLabel;
    F3SOtime: TLabel;
    F3SOtimelabel: TLabel;
    F3waitlabel1: TLabel;
    F3waitlabel2: TLabel;
    F4Bevel: TBevel;
    F4Button: TButton;
    F4description: TLabel;
    F4Group: TGroupBox;
    F4sequence: TLabel;
    F4shootredtime: TLabel;
    F4shoottime: TLabel;
    F4Shoottimelabel: TLabel;
    F4SOredtime: TLabel;
    F4SOtime: TLabel;
    F4SOtimelabel: TLabel;
    F4waitlabel1: TLabel;
    F4waitlabel2: TLabel;
    F5Bevel: TBevel;
    F5Button: TButton;
    F5description: TLabel;
    F5Group: TGroupBox;
    F5sequence: TLabel;
    F5shootredtime: TLabel;
    F5shoottime: TLabel;
    F5Shoottimelabel: TLabel;
    F5SOredtime: TLabel;
    F5SOtime: TLabel;
    F5SOtimelabel: TLabel;
    F5waitlabel1: TLabel;
    F5waitlabel2: TLabel;
    F6Bevel: TBevel;
    F6Button: TButton;
    F6description: TLabel;
    F6Group: TGroupBox;
    F6sequence: TLabel;
    F6shootredtime: TLabel;
    F6shoottime: TLabel;
    F6Shoottimelabel: TLabel;
    F6SOredtime: TLabel;
    F6SOtime: TLabel;
    F6SOtimelabel: TLabel;
    F6waitlabel1: TLabel;
    F6waitlabel2: TLabel;
    F7Bevel: TBevel;
    F7Button: TButton;
    F7description: TLabel;
    F7Group: TGroupBox;
    F7sequence: TLabel;
    F7shootredtime: TLabel;
    F7shoottime: TLabel;
    F7Shoottimelabel: TLabel;
    F7SOredtime: TLabel;
    F7SOtime: TLabel;
    F7SOtimelabel: TLabel;
    F7waitlabel1: TLabel;
    F7waitlabel2: TLabel;
    F8Bevel: TBevel;
    F8Button: TButton;
    F8description: TLabel;
    F8Group: TGroupBox;
    F8sequence: TLabel;
    F8shootredtime: TLabel;
    F8shoottime: TLabel;
    F8Shoottimelabel: TLabel;
    F8SOredtime: TLabel;
    F8SOtime: TLabel;
    F8SOtimelabel: TLabel;
    F8waitlabel1: TLabel;
    F8waitlabel2: TLabel;
    F9Bevel: TBevel;
    F9Button: TButton;
    F9description: TLabel;
    F9Group: TGroupBox;
    F9sequence: TLabel;
    F9shootredtime: TLabel;
    F9shoottime: TLabel;
    F9Shoottimelabel: TLabel;
    F9SOredtime: TLabel;
    F9SOtime: TLabel;
    F9SOtimelabel: TLabel;
    F9waitlabel1: TLabel;
    F9waitlabel2: TLabel;
    finalstiming: TGroupBox;
    finarrow: TRadioButton;
    fintarget: TRadioButton;
    FITA: TRadioButton;
    FITAFIN: TRadioButton;
    FITAFINlabel: TLabel;
    FITAScrollBox: TScrollBox;
    fitasequence: TGroupBox;
    flipsecondslabel: TLabel;
    follow: TRadioButton;
    followexplanation: TLabel;
    FollowScrollBox: TScrollBox;
    fromHOST: TEdit;
    fromhostrefresh: TLabel;
    fullscreencheckbox: TCheckBox;
    GetHOSTsignallabel: TLabel;
    GetHOSTsignallabel1: TLabel;
    greenbox: TGroupBox;
    greenfinal: TSpinEdit;
    greenfinalend: TSpinEdit;
    greenmenu: TImage;
    greentime1p: TSpinEdit;
    BGGroupBox: TGroupBox;
    GrnColABLabel: TLabel;
    GrnColBGPanel: TPanel;
    GrnColCDLabel: TLabel;
    GrnColGroupBox: TGroupBox;
    GrnColListBoxbg: TColorListBox;
    GrnColListBoxtime: TColorListBox;
    GrnColtimeLabel: TLabel;
    Bannerbox: TGroupBox;
    groupfinarrow: TGroupBox;
    groupfinend: TGroupBox;
    groupsign: TLabel;
    hideicons: TCheckBox;
    HOSTNAME: TEdit;
    HWbutton1: TComboBox;
    HWbutton2: TComboBox;
    HWbutton3: TComboBox;
    HWbutton4: TComboBox;
    HWbutton5: TComboBox;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    imagesListBox: TListBox;
    inputbox: TGroupBox;
    IP1: TSpinEdit;
    IP2: TSpinEdit;
    IP3: TSpinEdit;
    IP4: TSpinEdit;
    K8055select: TCheckBox;
    KeepbuzzingCheckBox: TCheckBox;
    LANinput: TRadioButton;
    Lanremoteselect: TCheckBox;
    LANselect: TCheckBox;
    largeimagecheckbox: TCheckBox;
    leftnumber: TSpinEdit;
    leftrightbox: TGroupBox;
    leftscreen: TRadioButton;
    Manual: TRadioButton;
    manualcolorpanel: TPanel;
    menudisap2: TLabel;
    minnrbeeps: TSpinEdit;
    minsoundlabel: TLabel;
    multicastlabel: TLabel;
    nrgreenbuzz: TSpinEdit;
    nrorangebuzz: TSpinEdit;
    nrredbuzz: TSpinEdit;
    number: TPanel;
    onefive: TRadioButton;
    onefour: TRadioButton;
    oneone: TRadioButton;
    onepijl: TRadioButton;
    onesix: TRadioButton;
    onethree: TRadioButton;
    onetwo: TRadioButton;
    orangebox: TGroupBox;
    orangefinal: TSpinEdit;
    orangefinalend: TSpinEdit;
    orangemenu: TImage;
    orangetime1p: TSpinEdit;
    OrColABLabel: TLabel;
    OrColBGPanel: TPanel;
    OrColCDLabel: TLabel;
    OrColGroupBox: TGroupBox;
    OrColListBoxbg: TColorListBox;
    OrColListBoxtime: TColorListBox;
    OrColtimeLabel: TLabel;
    PABCDperEND: TCheckBox;
    Pause_emergency_RadioButton: TRadioButton;
    PCnameLabel: TLabel;
    portnumber1: TSpinEdit;
    portnumberrec: TSpinEdit;
    practiselabel: TLabel;
    practiseturns: TSpinEdit;
    PrepColABLabel: TLabel;
    PrepColBGPanel: TPanel;
    PrepColCDLabel: TLabel;
    PrepColGroupBox: TGroupBox;
    PrepColListBoxbg: TColorListBox;
    PrepColListBoxtime: TColorListBox;
    PrepColtimeLabel: TLabel;
    pwlabel: TLabel;
    pwstring: TEdit;
    defaultbannerRadioButton: TRadioButton;
    Rarchertxt: TLabel;
    LENDtxt: TLabel;
    Larchertxt: TLabel;
    LTRNtxt: TLabel;
    Receivenetworkpanel: TGroupBox;
    redbox: TGroupBox;
    RedColABLabel: TLabel;
    RedColBGPanel: TPanel;
    RedColCDLabel: TLabel;
    RedColGroupBox: TGroupBox;
    RedColListBoxbg: TColorListBox;
    RedColListBoxtime: TColorListBox;
    RedColtimeLabel: TLabel;
    redfinal: TSpinEdit;
    redfinalend: TSpinEdit;
    redmenu: TImage;
    redtime1p: TSpinEdit;
    Removeimagebutton: TButton;
    retrColABLabel: TLabel;
    retrColBGPanel: TPanel;
    retrColCDLabel: TLabel;
    retrColGroupBox: TGroupBox;
    retrColListBoxbg: TColorListBox;
    retrColListBoxtime: TColorListBox;
    retrColtimeLabel: TLabel;
    retrLabel: TLabel;
    rightnumber: TSpinEdit;
    rightscreen: TRadioButton;
    RTRNtxt: TLabel;
    RENDtxt: TLabel;
    RABCDtxt: TLabel;
    Lnexttxt: TLabel;
    LABCDtxt: TLabel;
    Rnexttxt: TLabel;
    background1: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Lnextturnbg: TImage;
    FitaFinScrollBox: TScrollBox;
    onearrowScrollBox: TScrollBox;
    manualScrollBox: TScrollBox;
    BGScrollBox: TScrollBox;
    savevarF10button: TButton;
    savevarF11button: TButton;
    savevarF12button: TButton;
    savevarF1button: TButton;
    savevarF2button: TButton;
    savevarF3button: TButton;
    savevarF4button: TButton;
    savevarF5button: TButton;
    savevarF6button: TButton;
    savevarF7button: TButton;
    savevarF8button: TButton;
    savevarF9button: TButton;
    ScenarioScrollBox: TScrollBox;
    SCRcolScrollBox: TScrollBox;
    networkScrollBox: TScrollBox;
    emergencyScrollBox: TScrollBox;
    HWScrollBox: TScrollBox;
    selectsoundlabel: TLabel;
    serialpanel1: TPanel;
    serialpanel2: TPanel;
    serialport1: TComboBox;
    serialport2: TComboBox;
    serverportlabel1: TLabel;
    soundScrollBox: TScrollBox;
    secgrnlabel1: TLabel;
    secgrnlabel2: TLabel;
    secgrnlabel3: TLabel;
    secorlabel1: TLabel;
    secorlabel2: TLabel;
    secorlabel3: TLabel;
    secredlabel1: TLabel;
    secredlabel2: TLabel;
    secredlabel3: TLabel;
    sectotlabel1: TLabel;
    sectotlabel2: TLabel;
    sectotlabel3: TLabel;
    serialinput: TRadioButton;
    Show: TGroupBox;
    showhints: TCheckBox;
    showtarget: TCheckBox;
    slidetime: TSpinEdit;
    soundselect: TComboBox;
    soundsignallabel1: TLabel;
    soundsignallabel2: TLabel;
    soundsignallabel3: TLabel;
    speaker: TCheckBox;
    Stop_current_RadioButton: TRadioButton;
    Stop_next_RadioButton: TRadioButton;
    targetID: TLabel;
    testsound: TButton;
    teststring: TLabel;
    teststringendnr: TLabel;
    teststringendnr1: TLabel;
    teststringendnr2: TLabel;
    teststringendnr3: TLabel;
    teststringleft: TLabel;
    teststringright: TLabel;
    threetwo: TRadioButton;
    backgroundtimer: TTimer;
    blinkingred: TTimer;
    timeseqpanel: TGroupBox;
    timeup: TImage;
    Fbutonscreenbox: TCheckBox;
    F2panel: TPanel;
    F11panel: TPanel;
    F12panel: TPanel;
    F3panel: TPanel;
    F4panel: TPanel;
    F5panel: TPanel;
    F6panel: TPanel;
    F7panel: TPanel;
    F8panel: TPanel;
    F9panel: TPanel;
    F10panel: TPanel;
    MagText: TLabel;
    magnification: TSpinEdit;
    F1panel: TPanel;
    Startuplabel: TLabel;
    shutdownicon: TImage;
    IPtxt: TMemo;
    serial2: TSdpoSerial;
    K8055settings: TTabSheet;
    tabEmergency: TTabSheet;
    Rnextturnbg: TImage;
    timing1p: TGroupBox;
    TLgroup: TGroupBox;
    TLleft: TRadioButton;
    TLright: TRadioButton;
    topbot: TRadioButton;
    totalfinal: TLabel;
    totalfinalend: TLabel;
    totaltime: TLabel;
    totaltime1p: TLabel;
    totaltimeso: TLabel;
    touchicon: TImage;
    Touchscreentab: TTabSheet;
    tdown: TImage;
    endup: TImage;
    tup: TImage;
    enddown: TImage;
    screencolor: TTabSheet;
    TCPaccess1: TLTCPComponent;
    BOTshooterlet: TLabel;
    rcvmcasttimer: TTimer;
    TabNetwork: TTabSheet;
    TabGPIO: TTabSheet;
    TOPshootertxt: TLabel;
    serialtimestamp: TTimer;
    followtimer: TTimer;
    LUDP1: TLUDPComponent;
    emergencytext: TLabel;
    networktimestamp: TTimer;
    Shooter5: TLabel;
    Shooter6: TLabel;
    TOPshooterlet: TLabel;
    BOTshootertxt: TLabel;
    Turns_per_end: TLabel;
    Turns_per_end_SO: TLabel;
    twothree: TRadioButton;
    twotwo: TRadioButton;
    IniPropStorage1: TIniPropStorage;
    danger: TImage;
    buzzicon2: TImage;
    buzzicon3: TImage;
    precountalways: TCheckBox;
    connect_switch_delay: TTimer;
    connect_delay: TTimer;
    Aboutmemo: TMemo;
    serial: TSdpoSerial;
    abouttab: TTabSheet;
    buzzicon1: TImage;
    source: TStream;
    Shooter1: TLabel;
    Shooter2: TLabel;
    Shooter3: TLabel;
    Shooter4: TLabel;
    serienr: TLabel;
    FirstTimer: TTimer;
    shooternr: TLabel;
    digit1_1: TLabel;
    digit2_1: TLabel;
    digit3_1: TLabel;
    dots_1: TLabel;
    buzzerTimer: TTimer;
    seriedown: TPanel;
    serieup: TPanel;
    show_commercial: TTimer;
    hardwaretab: TTabSheet;
    manualgreen: TImage;
    manualorange: TImage;
    manualred: TImage;
    turndown: TPanel;
    turnup: TPanel;
    resizeicon: TImage;
    clockicon: TImage;
    closeicon: TImage;
    nexticon: TImage;
    playpauzeicon: TImage;
    stopicon: TImage;
    startupdelay: TTimer;
    Practise: TLabel;
    endtimout: TTimer;
    serielabel: TLabel;
    turnlabel: TLabel;
    USBconnect: TLabel;
    inputtimer: TTimer;
    inputtimernext: TTimer;
    usb: TImage;
    shooteronearrownr: TLabel;
    shooteronearrow: TLabel;
    SOicon: TImage;
    archeryclock: TLabel;  //Label shown when archers get arrows. (over digits)
    copyright: TLabel;
    USBserialbox: TGroupBox;
    usetraffic: TCheckBox;
    var2F10sequence: TLabel;
    var2F11sequence: TLabel;
    var2F12sequence: TLabel;
    var2F1sequence: TLabel;
    var2F2sequence: TLabel;
    var2F3sequence: TLabel;
    var2F4sequence: TLabel;
    var2F5sequence: TLabel;
    var2F6sequence: TLabel;
    var2F7sequence: TLabel;
    var2F8sequence: TLabel;
    var2F9sequence: TLabel;
    varF10Bevel: TBevel;
    varF10Button: TButton;
    varF10description: TLabel;
    varF10Group: TGroupBox;
    varF10sequence: TLabel;
    varF10shootredtime: TLabel;
    varF10shoottime: TLabel;
    varF10Shoottimelabel: TLabel;
    varF10SOredtime: TLabel;
    varF10SOtime: TLabel;
    varF10SOtimelabel: TLabel;
    varF10waitlabel1: TLabel;
    varF10waitlabel2: TLabel;
    varF11Bevel: TBevel;
    varF11Button: TButton;
    varF11description: TLabel;
    varF11Group: TGroupBox;
    varF11sequence: TLabel;
    varF11shootredtime: TLabel;
    varF11shoottime: TLabel;
    varF11Shoottimelabel: TLabel;
    varF11SOredtime: TLabel;
    varF11SOtime: TLabel;
    varF11SOtimelabel: TLabel;
    varF11waitlabel1: TLabel;
    varF11waitlabel2: TLabel;
    varF12Bevel: TBevel;
    varF12Button: TButton;
    varF12description: TLabel;
    varF12Group: TGroupBox;
    varF12sequence: TLabel;
    varF12shootredtime: TLabel;
    varF12shoottime: TLabel;
    varF12Shoottimelabel: TLabel;
    varF12SOredtime: TLabel;
    varF12SOtime: TLabel;
    varF12SOtimelabel: TLabel;
    varF12waitlabel1: TLabel;
    varF12waitlabel2: TLabel;
    varF1Bevel: TBevel;
    varF1Button: TButton;
    varF1description: TLabel;
    varF1Group: TGroupBox;
    varF1sequence: TLabel;
    varF1shootredtime: TLabel;
    varF1shoottime: TLabel;
    varF1Shoottimelabel: TLabel;
    varF1SOredtime: TLabel;
    varF1SOtime: TLabel;
    varF1SOtimelabel: TLabel;
    varF1waitlabel1: TLabel;
    varF1waitlabel2: TLabel;
    varF2Bevel: TBevel;
    varF2Button: TButton;
    varF2description: TLabel;
    varF2Group: TGroupBox;
    varF2sequence: TLabel;
    varF2shootredtime: TLabel;
    varF2shoottime: TLabel;
    varF2Shoottimelabel: TLabel;
    varF2SOredtime: TLabel;
    varF2SOtime: TLabel;
    varF2SOtimelabel: TLabel;
    varF2waitlabel1: TLabel;
    varF2waitlabel2: TLabel;
    varF3Bevel: TBevel;
    varF3Button: TButton;
    varF3description: TLabel;
    varF3Group: TGroupBox;
    varF3sequence: TLabel;
    varF3shootredtime: TLabel;
    varF3shoottime: TLabel;
    varF3Shoottimelabel: TLabel;
    varF3SOredtime: TLabel;
    varF3SOtime: TLabel;
    varF3SOtimelabel: TLabel;
    varF3waitlabel1: TLabel;
    varF3waitlabel2: TLabel;
    varF4Bevel: TBevel;
    varF4Button: TButton;
    varF4description: TLabel;
    varF4Group: TGroupBox;
    varF4sequence: TLabel;
    varF4shootredtime: TLabel;
    varF4shoottime: TLabel;
    varF4Shoottimelabel: TLabel;
    varF4SOredtime: TLabel;
    varF4SOtime: TLabel;
    varF4SOtimelabel: TLabel;
    varF4waitlabel1: TLabel;
    varF4waitlabel2: TLabel;
    varF5Bevel: TBevel;
    varF5Button: TButton;
    varF5description: TLabel;
    varF5Group: TGroupBox;
    varF5sequence: TLabel;
    varF5shootredtime: TLabel;
    varF5shoottime: TLabel;
    varF5Shoottimelabel: TLabel;
    varF5SOredtime: TLabel;
    varF5SOtime: TLabel;
    varF5SOtimelabel: TLabel;
    varF5waitlabel1: TLabel;
    varF5waitlabel2: TLabel;
    varF6Bevel: TBevel;
    varF6Button: TButton;
    varF6description: TLabel;
    varF6Group: TGroupBox;
    varF6sequence: TLabel;
    varF6shootredtime: TLabel;
    varF6shoottime: TLabel;
    varF6Shoottimelabel: TLabel;
    varF6SOredtime: TLabel;
    varF6SOtime: TLabel;
    varF6SOtimelabel: TLabel;
    varF6waitlabel1: TLabel;
    varF6waitlabel2: TLabel;
    varF7Bevel: TBevel;
    varF7Button: TButton;
    varF7description: TLabel;
    varF7Group: TGroupBox;
    varF7sequence: TLabel;
    varF7shootredtime: TLabel;
    varF7shoottime: TLabel;
    varF7Shoottimelabel: TLabel;
    varF7SOredtime: TLabel;
    varF7SOtime: TLabel;
    varF7SOtimelabel: TLabel;
    varF7waitlabel1: TLabel;
    varF7waitlabel2: TLabel;
    varF8Bevel: TBevel;
    varF8Button: TButton;
    varF8description: TLabel;
    varF8Group: TGroupBox;
    varF8sequence: TLabel;
    varF8shootredtime: TLabel;
    varF8shoottime: TLabel;
    varF8Shoottimelabel: TLabel;
    varF8SOredtime: TLabel;
    varF8SOtime: TLabel;
    varF8SOtimelabel: TLabel;
    varF8waitlabel1: TLabel;
    varF8waitlabel2: TLabel;
    varF9Bevel: TBevel;
    varF9Button: TButton;
    varF9description: TLabel;
    varF9Group: TGroupBox;
    varF9sequence: TLabel;
    varF9shootredtime: TLabel;
    varF9shoottime: TLabel;
    varF9Shoottimelabel: TLabel;
    varF9SOredtime: TLabel;
    varF9SOtime: TLabel;
    varF9SOtimelabel: TLabel;
    varF9waitlabel1: TLabel;
    varF9waitlabel2: TLabel;
    viewleft: TRadioButton;
    viewright: TRadioButton;
    MP3_2VLCradiobutton: TRadioButton;
    volumestate1: TSpinEdit;
    volumestate2: TSpinEdit;
    volumestate3: TSpinEdit;
    volumestate4: TSpinEdit;
    volumestate5: TSpinEdit;
    volumestate6: TSpinEdit;
    websitename: TLabel;
    savesettings: TGroupBox;
    save: TButton;
    arrowlabel: TLabel;
    settings: TImage;
    closeimage2: TImage;
    seconds: TRadioButton;
    minutes: TRadioButton;
    greenleft: TImage;
    greyright: TImage;
    greyleft: TImage;
    greenright: TImage;
    finalchoose: TPanel;
    menuremovedelay: TTimer;
    bannerpicture: TImage;
    dots_2: TLabel;
    digit2_2: TLabel;
    digit3_2: TLabel;
    digit1_2: TLabel;
    leftrightzoom: TTimer;
    secondTimer: TTimer;
    leftstart: TLabel;
    rightstart: TLabel;
    lefttarget: TLabel;
    righttarget: TLabel;
    TLredlefton: TImage;
    TLredrighton: TImage;
    TLgrnlefton: TImage;
    TLgrnrighton: TImage;
    TLorangelefton: TImage;
    TLorangerighton: TImage;
    TLredleftoff: TImage;
    TLorangeleftoff: TImage;
    TLgrnleftoff: TImage;
    TLredrightoff: TImage;
    TLorangerightoff: TImage;
    TLgrnrightoff: TImage;
    beforestartbg: TImage;
    beforestarttxt2: TLabel;
    dots_3: TLabel;
    digit2_3: TLabel;
    digit3_3: TLabel;
    digit1_3: TLabel;
    countdowntostart: TLabel;
    SettingsTabs: TPageControl;
    tablang: TTabSheet;
    Lang: TComboBox;
    selectlanguagelabel: TLabel;
    tabscr: TTabSheet;
    tabsound: TTabSheet;
    tabscen: TTabSheet;
    startupscenario: TComboBox;
    selectscenariolabel: TLabel;
    tabprecnt: TTabSheet;
    starttocd: TButton;
    tostart: TSpinEdit;
    precountminutelabel: TLabel;
    precountcaptionlabel: TLabel;
    beforestarttxt1: TLabel;
    menudisap1: TLabel;
    disapsec1: TLabel;
    cdmenu: TLabel;
    preptime: TImage;
    nexthelp: TLabel;
    chooselabel: TLabel;
    varSOtimelabel:TLabel;
    switchmomoff: TTimer;
    wifichannel: TSpinEdit;
    wifichannellabel: TLabel;
    wifiHWlabel: TLabel;
    WIFIHWListBox: TListBox;
    zerosec: TRadioButton;
    procedure abcd25m1pChange(Sender: TObject);
    procedure ABCDperENDChange(Sender: TObject);
    procedure ABColListBoxtimeClick(Sender: TObject);
    procedure abouticonClick(Sender: TObject);
    procedure actualtimeTimer(Sender: TObject);
    procedure AddimagebuttonClick(Sender: TObject);
    procedure arduinoselect2Change(Sender: TObject);
    procedure AudioActionstate4Click(Sender: TObject);

    procedure backgroundtimerTimer(Sender: TObject);
    procedure BeepswitcharcherChange(Sender: TObject);
    procedure blinkingredTimer(Sender: TObject);
    procedure Blinkphase1CheckBoxChange(Sender: TObject);
    procedure Blinkphase2CheckBoxChange(Sender: TObject);
    procedure closesystemTimer(Sender: TObject);
    procedure disableaccesspointbutton1Click(Sender: TObject);
    procedure enableaccesspointbuttonClick(Sender: TObject);
    procedure renewserialbuttonClick(Sender: TObject);
    procedure controliconClick(Sender: TObject);
    procedure finalteamturnsSOChange(Sender: TObject);
    procedure finalturnsSOChange(Sender: TObject);
    procedure HWbutton1Change(Sender: TObject);
    procedure HWbutton2Change(Sender: TObject);
    procedure HWbutton3Change(Sender: TObject);
    procedure HWbutton4Change(Sender: TObject);
    procedure HWbutton5Change(Sender: TObject);
    procedure keyboardpref1Click(Sender: TObject);
    procedure keyboardpref2Click(Sender: TObject);
    procedure keyboardpref3Click(Sender: TObject);
    procedure musicvolumetimerTimer(Sender: TObject);
    procedure nextonlybuttonClick(Sender: TObject);
    procedure nrgreenbuzzChange(Sender: TObject);
    procedure nrorangebuzzChange(Sender: TObject);
    procedure nrredbuzzChange(Sender: TObject);
    procedure orangebeep25m1pcheckboxChange(Sender: TObject);
    procedure orangebeepfitacheckboxChange(Sender: TObject);
    procedure pauseimagestate1Click(Sender: TObject);
    procedure pauseimagestate2Click(Sender: TObject);
    procedure pauseimagestate3Click(Sender: TObject);
    procedure pauseimagestate4Click(Sender: TObject);
    procedure pauseimagestate5Click(Sender: TObject);
    procedure pauseimagestate6Click(Sender: TObject);
    procedure playimagestate1Click(Sender: TObject);
    procedure playimagestate2Click(Sender: TObject);
    procedure playimagestate3Click(Sender: TObject);
    procedure playimagestate4Click(Sender: TObject);
    procedure playimagestate5Click(Sender: TObject);
    procedure playimagestate6Click(Sender: TObject);
    procedure reconnectbuttonClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure buzzicon1Click(Sender: TObject);
    procedure buzzicon2Click(Sender: TObject);
    procedure buzzicon3Click(Sender: TObject);
    procedure CDColListBoxtimeClick(Sender: TObject);
    procedure changeendturntimerTimer(Sender: TObject);
    procedure ChoosebannerbuttonClick(Sender: TObject);
    procedure chooselabelClick(Sender: TObject);
    procedure coloriconClick(Sender: TObject);
    procedure colorscheme1Change(Sender: TObject);
    procedure colorscheme2Change(Sender: TObject);
    procedure colorscheme3Change(Sender: TObject);
    procedure colorscheme4Change(Sender: TObject);
    procedure colorscheme5Change(Sender: TObject);
    procedure colorscheme6Change(Sender: TObject);
    procedure colorscheme7Change(Sender: TObject);
    procedure colorscheme8Change(Sender: TObject);
    procedure colorscheme9Change(Sender: TObject);
    procedure ControlaudiocheckboxChange(Sender: TObject);
    procedure dangerClick(Sender: TObject);
    procedure defaultbannerRadioButtonChange(Sender: TObject);
    procedure emergencyiconClick(Sender: TObject);
    procedure EmergencytxtEditChange(Sender: TObject);
    procedure F10panelClick(Sender: TObject);
    procedure F11panelClick(Sender: TObject);
    procedure F12panelClick(Sender: TObject);
    procedure F1panelClick(Sender: TObject);
    procedure F2panelClick(Sender: TObject);
    procedure F3panelClick(Sender: TObject);
    procedure F4panelClick(Sender: TObject);
    procedure F5panelClick(Sender: TObject);
    procedure F6panelClick(Sender: TObject);
    procedure F7panelClick(Sender: TObject);
    procedure F8panelClick(Sender: TObject);
    procedure F9panelClick(Sender: TObject);
    procedure FbutonscreenboxChange(Sender: TObject);
    procedure finalteamturnsChange(Sender: TObject);
    procedure fitafiniconClick(Sender: TObject);
    procedure fitaiconClick(Sender: TObject);
    procedure followChange(Sender: TObject);
    procedure followiconClick(Sender: TObject);
    procedure followtimerTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure fromHOSTChange(Sender: TObject);
    procedure fullscreencheckboxChange(Sender: TObject);
    procedure greenfinalendsoChange(Sender: TObject);
    procedure GrnColListBoxbgClick(Sender: TObject);
    procedure GrnColListBoxtimeClick(Sender: TObject);
    procedure HardwareiconClick(Sender: TObject);
    procedure icon25m1pClick(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure Image8Click(Sender: TObject);
    procedure indfindefbuttonClick(Sender: TObject);
    procedure languageiconClick(Sender: TObject);
    procedure LANinputChange(Sender: TObject);
    procedure LanremoteselectChange(Sender: TObject);
    procedure LANselectChange(Sender: TObject);
    procedure largeimagecheckboxChange(Sender: TObject);
    procedure layouticonClick(Sender: TObject);
    procedure leftscreenChange(Sender: TObject);
    procedure leftsideclientbuttonClick(Sender: TObject);
    procedure logpptClick(Sender: TObject);
    procedure magnificationChange(Sender: TObject);
    procedure manualiconClick(Sender: TObject);
    procedure mxteamfindefbuttonClick(Sender: TObject);
    procedure networkiconClick(Sender: TObject);
    procedure networktimestampTimer(Sender: TObject);
    procedure nexthelpClick(Sender: TObject);
    procedure nonzerosecChange(Sender: TObject);
    procedure normalpptClick(Sender: TObject);
    procedure nrof1ppractisearrowsChange(Sender: TObject);
    procedure onefiveClick(Sender: TObject);
    procedure onesixClick(Sender: TObject);
    procedure orangefinalendsoChange(Sender: TObject);
    procedure OrColBGPanelClick(Sender: TObject);
    procedure OrColListBoxbgClick(Sender: TObject);
    procedure OrColListBoxtimeClick(Sender: TObject);
    procedure portnumber1Change(Sender: TObject);
    procedure portnumberfollowChange(Sender: TObject);
    procedure portnumberrecChange(Sender: TObject);
    procedure preborder1Click(Sender: TObject);
    procedure preborderClick(Sender: TObject);
    procedure precounticonClick(Sender: TObject);
    procedure prelayoutradio1Change(Sender: TObject);
    procedure prelayoutradio2Change(Sender: TObject);
    procedure PrepColListBoxbgClick(Sender: TObject);

    procedure rcvmcasttimerTimer(Sender: TObject);
    procedure reamfindefbuttonClick(Sender: TObject);
    procedure RedColCDLabelClick(Sender: TObject);
    procedure RedColListBoxbgClick(Sender: TObject);
    procedure RedColListBoxtimeClick(Sender: TObject);
    procedure redfinalendsoChange(Sender: TObject);
    procedure RemoveimagebuttonClick(Sender: TObject);
    procedure repeatsequenceChange(Sender: TObject);
    procedure retrColListBoxbgClick(Sender: TObject);
    procedure retrColListBoxtimeClick(Sender: TObject);
    procedure rightsideclientbuttonClick(Sender: TObject);
    procedure RnextturnbgClick(Sender: TObject);
    procedure rotate25m1pChange(Sender: TObject);
    procedure scenarioiconClick(Sender: TObject);
    procedure screencolorHide(Sender: TObject);
    procedure screencolorShow(Sender: TObject);
    procedure serial2RxData(Sender: TObject);
    procedure serialfreqdelayTimer(Sender: TObject);
    procedure serialport2Change(Sender: TObject);
    procedure serialtimestampTimer(Sender: TObject);
    procedure Shooter5Click(Sender: TObject);
    procedure Shooter6Click(Sender: TObject);
    procedure showendnrcheckboxChange(Sender: TObject);
    procedure showendnrlabelClick(Sender: TObject);
    procedure shutdowniconClick(Sender: TObject);
    procedure ShutdownremoteButtonClick(Sender: TObject);
    procedure slidetimeChange(Sender: TObject);
    procedure soundiconClick(Sender: TObject);
    procedure specificbannerRadioButtonChange(Sender: TObject);
    procedure StartuplabelClick(Sender: TObject);
    procedure stopimagestate1Click(Sender: TObject);
    procedure stopimagestate2Click(Sender: TObject);
    procedure stopimagestate3Click(Sender: TObject);
    procedure stopimagestate4Click(Sender: TObject);
    procedure stopimagestate5Click(Sender: TObject);
    procedure stopimagestate6Click(Sender: TObject);

    procedure TCP1Receive(aSocket: TLSocket);
    procedure TCPaccess1Receive(aSocket: TLSocket);
    procedure TCPfollowAccept(aSocket: TLSocket);
    procedure TCPfollowReceive(aSocket: TLSocket);
    procedure threetwoClick(Sender: TObject);
    procedure timecheckboxChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure topbotClick(Sender: TObject);
    procedure touchiconClick(Sender: TObject);
    procedure twothreeClick(Sender: TObject);
    procedure manualgreenClick(Sender: TObject);
    procedure manualorangeClick(Sender: TObject);
    procedure manualredClick(Sender: TObject);
    procedure rightscreenChange(Sender: TObject);
    procedure showtargetChange(Sender: TObject);
    procedure followClick(Sender: TObject);
    procedure ManualClick(Sender: TObject);
    procedure serialRxData(Sender: TObject);
    procedure arduinoselect1Change(Sender: TObject);
    procedure connect_delayTimer(Sender: TObject);
    procedure connect_switch_delayTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);

    procedure K8055selectChange(Sender: TObject);
    procedure FirstTimerTimer(Sender: TObject);

    procedure playpausebuttonClick(Sender: TObject);
    procedure orangetimeChange(Sender: TObject);
    procedure initialize;//to initialize the system at startup
    procedure resizewindowreferencing;
    procedure resizewindowsingleclock;
    procedure resizewindowpreclock;
    procedure resizewindowfinalturndetails;
    procedure resizewindowlabelsiconsmenu;
    procedure resizewindowTL;
    procedure restorestate;
    procedure writeaccessdata;
    procedure resizewindow;
    procedure resizewindowfinals;
    procedure resizewindownonfinals;
    procedure midbartop;
    procedure resizewindowall;
    procedure serialport1Change(Sender: TObject);
    procedure getPCname;
    procedure connectports;
    procedure show_commercialTimer(Sender: TObject);
    procedure TLgrnleftoffClick(Sender: TObject);
    procedure TLgrnleftonClick(Sender: TObject);
    procedure TLgrnrightoffClick(Sender: TObject);
    procedure TLgrnrightonClick(Sender: TObject);
    procedure TLorangeleftoffClick(Sender: TObject);
    procedure TLorangeleftonClick(Sender: TObject);
    procedure TLorangerightoffClick(Sender: TObject);
    procedure TLorangerightonClick(Sender: TObject);
    procedure TLredleftoffClick(Sender: TObject);
    procedure TLredleftonClick(Sender: TObject);
    procedure TLredrightoffClick(Sender: TObject);
    procedure TLredrightonClick(Sender: TObject);
    procedure UDP1Receive(aSocket: TLSocket);
    procedure UDPfollowReceive(aSocket: TLSocket);
    procedure viewleftClick(Sender: TObject);
    procedure viewrightClick(Sender: TObject);
    procedure views;
    procedure viewchangestateactive; //between state 2-3-4
    procedure viewchangestateinact; // between state 5-6-1
    procedure setleftclockdigits;   //Make correct digits vissible dependingon seconds settings etc.
    procedure setrightclockdigits; //Make correct digits vissible dependingon seconds settings etc.
    procedure setfinalsdigitposition; //left right settings of digits depending on sec/min/etc notation
    procedure setnonfinalsdigitposition; //left right settings of digits depending on sec/min/etc notation
    procedure viewchangestateexchange; //between active to inactive
    procedure viewstateone;     //State one is depending on yes or no commercialview
    Procedure timevssheet;  //in sheet mode show layout with actual date/time or slides
    procedure changecolorscheme; //to change the color scheme of the screen
    procedure viewchangmenuitems;
    procedure viewactivate; // view Items that need to be activated / deactivated depending on circumstances
    procedure viewicons;   //update icons visible  or not visible
    procedure viewarchsystemchange;
    procedure viewfinupdate; // view items update for final specific
    procedure viewturnchange; //view changes due to different turn or end
    procedure windowsize;
    procedure preclose;
    procedure shutdownsys;
    procedure startshortcut;
    procedure next;
    procedure stop;
    procedure stopemergency;
    procedure hide;
    procedure hide2;
    procedure playpauze;
    procedure soff;
    procedure upserie;
    procedure downserie;
    procedure upturn;
    procedure downturn;
    procedure nextscenario;
    procedure prevscenario;
    procedure leftarea;
    procedure rightarea;
    Procedure switchbox;
    Procedure TLswitch;
    Procedure setlanguage;
    Procedure choosebanner;
    Procedure changescenario;
    Procedure menuscreensize;
    procedure connect;
    Procedure Setsettings;
    Procedure Setsystemsettings;
    Procedure storeF;
    procedure initsystemtype; //after selecting system type (Fita, 25m1p, etc) subsettings will be set according to this system type
    procedure initaccesspointmenu;
    Procedure showF1;
    Procedure showF2;
    Procedure showF3;
    Procedure showF4;
    Procedure showF5;
    Procedure showF6;
    Procedure showF7;
    Procedure showF8;
    Procedure showF9;
    Procedure showF10;
    Procedure showF11;
    Procedure showF12;
    Procedure getsetting;
    Procedure getscenario;
    Procedure oneonesystem;
    Procedure onetwosystem;
    Procedure onethreesystem;
    procedure onefoursystem;
    Procedure twotwosystem;
    Procedure onefivesystem;
    Procedure onesixsystem;
    Procedure twothreesystem;
    Procedure threetwosystem;
    Procedure topbotsystem;
    Procedure showseq;
    Procedure showtime;
    Procedure checknextsecond;
    Procedure selectleftarcher;
    Procedure selectrightarcher;
    Procedure selectnonearcher;
    procedure finalyzeturn;
    procedure nextfinal;
    procedure Changestartarcher;
    procedure starttostart;
    procedure removemenu;
    procedure updatemenu;
    procedure soundsignal;
    Procedure setvarsettings;
    Procedure actualtimerstatus;
    Procedure setgreen;
    Procedure setorange;
    Procedure setred;
    Procedure onebeep;
    Procedure twobeeps;
    Procedure threebeeps;
    Procedure switchfollow;
    Procedure Followlansettings;
    Procedure Shutdownremotesystem;
    Procedure broadswitch;
    Procedure refreshserial;
    Procedure sentstatusstring;
    Procedure Checkredblink;
    Procedure MinSecselection;
    Procedure resetendnr;
    Procedure setmusicstatus;
    Procedure perfsercommand(var Ard: string);
    procedure FormActivate(Sender: TObject);
    procedure timingsettingsClick(Sender: TObject);
    procedure serienrClick(Sender: TObject);
    procedure greentimeChange(Sender: TObject);
    procedure oneoneClick(Sender: TObject);
    procedure onetwoClick(Sender: TObject);
    procedure onethreeClick(Sender: TObject);
    procedure onefourClick(Sender: TObject);
    procedure twotwoClick(Sender: TObject);
    procedure decreaseseriebuttonClick(Sender: TObject);
    procedure increaseseriebuttonClick(Sender: TObject);
    procedure decreaseshooterbuttonClick(Sender: TObject);
    procedure increaseshooterbuttonClick(Sender: TObject);
    procedure minutesClick(Sender: TObject);
    procedure secondsClick(Sender: TObject);
    procedure startnextbuttonClick(Sender: TObject);
    procedure buzzerTimerTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;  Shift: TShiftState);
    procedure stopbuttonClick(Sender: TObject);
    procedure startupdelayTimer(Sender: TObject);
    procedure closeiconClick(Sender: TObject);
    procedure endtimoutTimer(Sender: TObject);
    procedure dots_1Click(Sender: TObject);
    procedure digit2_1Click(Sender: TObject);
    procedure digit1_1Click(Sender: TObject);
    procedure USBconnectClick(Sender: TObject);
    procedure inputtimerTimer(Sender: TObject);
    procedure inputtimernextTimer(Sender: TObject);
    procedure usbClick(Sender: TObject);
    procedure Shooter2Click(Sender: TObject);
    procedure Shooter4Click(Sender: TObject);
    procedure Shooter3Click(Sender: TObject);
    procedure Shooter1Click(Sender: TObject);
    procedure greentimesoChange(Sender: TObject);
    procedure orangetimesoChange(Sender: TObject);
    procedure greentime1pChange(Sender: TObject);
    procedure orangetime1pChange(Sender: TObject);
    procedure nrof1pshootersChange(Sender: TObject);
    procedure SOiconClick(Sender: TObject);
    procedure shooteronearrownrClick(Sender: TObject);
    procedure shooteronearrowClick(Sender: TObject);
    procedure doubleturnsClick(Sender: TObject);
    procedure resizeiconClick(Sender: TObject);
    procedure websitenameClick(Sender: TObject);
    procedure archeryclockClick(Sender: TObject);
    procedure minsecClick(Sender: TObject);
    procedure saveClick(Sender: TObject);
    procedure LangChange(Sender: TObject);
    procedure settingsClick(Sender: TObject);
    procedure closeimage2Click(Sender: TObject);
    procedure hideiconsClick(Sender: TObject);
    procedure F1ButtonClick(Sender: TObject);
    procedure F2ButtonClick(Sender: TObject);
    procedure F3ButtonClick(Sender: TObject);
    procedure F4ButtonClick(Sender: TObject);
    procedure F5ButtonClick(Sender: TObject);
    procedure F6ButtonClick(Sender: TObject);
    procedure F7ButtonClick(Sender: TObject);
    procedure F8ButtonClick(Sender: TObject);
    procedure F9ButtonClick(Sender: TObject);
    procedure F10ButtonClick(Sender: TObject);
    procedure F11ButtonClick(Sender: TObject);
    procedure F12ButtonClick(Sender: TObject);
    procedure practiseturnsChange(Sender: TObject);
    procedure startupscenarioChange(Sender: TObject);

    procedure FITAClick(Sender: TObject);
    procedure FITAFINClick(Sender: TObject);
    procedure onepijlClick(Sender: TObject);
    procedure closeimage1Click(Sender: TObject);
    procedure redtimeChange(Sender: TObject);
    procedure redtimesoChange(Sender: TObject);
    procedure redtime1pChange(Sender: TObject);
    procedure finnameClick(Sender: TObject);
    procedure finarrowClick(Sender: TObject);
    procedure fintargetClick(Sender: TObject);
    procedure numberClick(Sender: TObject);
    procedure dblturnClick(Sender: TObject);
    procedure dbltimeClick(Sender: TObject);
    procedure menuremovedelayTimer(Sender: TObject);

    procedure greyleftClick(Sender: TObject);
    procedure greyrightClick(Sender: TObject);
    procedure finalchooseClick(Sender: TObject);
    procedure leftrightzoomTimer(Sender: TObject);
    procedure secondTimerTimer(Sender: TObject);
    procedure timeperendClick(Sender: TObject);
    procedure timeperturnClick(Sender: TObject);
    procedure greenfinalChange(Sender: TObject);
    procedure orangefinalChange(Sender: TObject);
    procedure greenfinalendChange(Sender: TObject);
    procedure orangefinalendChange(Sender: TObject);
    procedure digit3_2Click(Sender: TObject);
    procedure digit2_2Click(Sender: TObject);
    procedure dots_2Click(Sender: TObject);
    procedure digit1_2Click(Sender: TObject);
    procedure digit3_1Click(Sender: TObject);
    procedure rightstartClick(Sender: TObject);
    procedure leftstartClick(Sender: TObject);
    procedure finalturnsChange(Sender: TObject);
    procedure leftnumberChange(Sender: TObject);
    procedure rightnumberChange(Sender: TObject);
    procedure BCDtoROG2Click(Sender: TObject);
    procedure savevarF8buttonClick(Sender: TObject);
    procedure savevarF1buttonClick(Sender: TObject);
    procedure savevarF2buttonClick(Sender: TObject);
    procedure savevarF3buttonClick(Sender: TObject);
    procedure savevarF4buttonClick(Sender: TObject);
    procedure savevarF5buttonClick(Sender: TObject);
    procedure savevarF6buttonClick(Sender: TObject);
    procedure savevarF7buttonClick(Sender: TObject);
    procedure savevarF9buttonClick(Sender: TObject);
    procedure savevarF10buttonClick(Sender: TObject);
    procedure savevarF11buttonClick(Sender: TObject);
    procedure savevarF12buttonClick(Sender: TObject);
    procedure varF1ButtonClick(Sender: TObject);
    procedure varF2ButtonClick(Sender: TObject);
    procedure varF3ButtonClick(Sender: TObject);
    procedure varF4ButtonClick(Sender: TObject);
    procedure varF5ButtonClick(Sender: TObject);
    procedure varF6ButtonClick(Sender: TObject);
    procedure varF7ButtonClick(Sender: TObject);
    procedure varF8ButtonClick(Sender: TObject);
    procedure varF9ButtonClick(Sender: TObject);
    procedure varF10ButtonClick(Sender: TObject);
    procedure varF11ButtonClick(Sender: TObject);
    procedure varF12ButtonClick(Sender: TObject);
    procedure redfinalChange(Sender: TObject);
    procedure redfinalendChange(Sender: TObject);
    procedure abcd25m1pClick(Sender: TObject);
    procedure TLleftClick(Sender: TObject);
    procedure TLrightClick(Sender: TObject);
    procedure usetrafficClick(Sender: TObject);
    procedure soundselectChange(Sender: TObject);
    procedure testsoundClick(Sender: TObject);
    procedure starttocdClick(Sender: TObject);
    procedure countdowntostartClick(Sender: TObject);
    procedure tostartChange(Sender: TObject);
    procedure speakerClick(Sender: TObject);
    procedure showhintsClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
const

//  PIN_6: PChar = '6';
  PIN_13: PChar = '13';
  PIN_19: PChar = '19';
  PIN_26: PChar = '26';
  PIN_12: PChar = '12';
  PIN_16: PChar = '16';
  PIN_20: PChar = '20';
  PIN_21: PChar = '21';


  PIN_2: PChar = '2';
  PIN_3: PChar = '3';
  PIN_4: PChar = '4';
  PIN_17: PChar = '17';
  PIN_27: PChar = '27';
  PIN_22: PChar = '22';
  PIN_10: PChar = '10';
  PIN_9: PChar = '9';
  PIN_11: PChar = '11';
  PIN_5: PChar = '5';
//  PIN_7: PChar = '7';
//  PIN_8: PChar = '8';
//  PIN_25: PChar = '25';
//  PIN_24: PChar = '24';
//  PIN_23: PChar = '23';
//  PIN_18: PChar = '18';

  PIN_ON: PChar = '1';
  PIN_OFF: PChar = '0';
  OUT_DIRECTION: PChar = 'out';
  IN_DIRECTION: PChar = 'in';

var
  gReturnCode: longint; {stores the result of the IO operation}

  DisableOtherFunctionCall:boolean;
  Countdownform: TCountdownform;
  Filespath:string;  //location of files
  labelnr:integer;  //depending on the number a different text is shown during wat time
  aspectratio:real; //aspect ratio. Depending on TL on screen or not
  nrofSOarrows:integer;  //aantal naschiet / shootoffpijlen
  Shooters:integer;      //shooters per end
  showABCD:boolean; //To indicate or ABCD is visible or top bottom
  oldshooters:integer;  // detect shooters change
  oldsound:string;  //detect soundstart.
  Fitasystem:integer;  //0=1pijl 1is 3pijl 2 is fitafinals
  Shootoff:double; //actief in geval een shootoff plaatsvind
  mag:real; //depending on OS a different size for all items is needed.
  Turnsperserie:integer;    //number of turns per serie
  Archersperturn:integer;    //number of archers per turn per target
  oldArchersperturn:integer;    //to detect an archersperturn change
  archerspertarget:integer;   //number of archers per target
  serienumber:integer;      //current end
  shooternumber:double; //current shooter;
  turnnumber:integer;            //current turn
  shootercolor:tcolor;   //color of the letter for shooters in this turn
  nonshootercolor:tcolor;  //color of the letter for shooters not in this turn
  waitcolor:tcolor; //digit color during waitng time
  redcolor:tcolor; //digit color during red
  orangecolor:tcolor; //digit color during orange
  greencolor:tcolor; //digit color during green
  bgwaitcolor:tcolor; //background color during waitng time
  bgredcolor:tcolor; //background color during red
  bgorangecolor:tcolor; //background color during orange
  bggreencolor:tcolor; //background color during green
  bgprecolor:tcolor; //background color during time to start match.

  countdowntimer:integer; //actual value to count down in seconds
  countdowntimer2:integer; //actual value to count down in seconds for second timer in case of finalrounds
  countdowntimertmp:integer; //tmp value for switching between coundowntimer2 and countdowntimer
  temptime:integer; //time for debugging
  state, prevstate, prevfolstate, realstate:integer; //possible states are 1 waitstateredstate 2 greenstate 3 orangestate and 4 redstate  and 5 countdown to start match. 6 is tabEmergency
  oldstate:integer; //to detect a state change
  alarmstate:integer; //0 is allarmtate is off. 1 is allarmstate is on
  buzzeron:integer; //buzzer aan of uit;
  senton:integer; //serial sent (TE)  aan of uit;
  leftsent:integer; //serial sent 1 =left side, 0 = right side
  ABCDsent:integer; //serial sent 1 = no ABCD, 0=ABCD
  scenario:string;  //Scenario (F1 to F12). used in a loop to get scenarios during initialyse
  buzzeronold:integer; //old value to check if serial update is needed
  mode:integer; //mode to read/write/set scenario
  lamp_green_on_off:integer; //green lamp off or on;
  lamp_orange_on_off:integer; //orange lamp off or on;
  lamp_red_on_off:integer; //red lamp off or on;
  LampA_on_off:integer; //A lamp off or on;
  LampB_on_off:integer; //B lamp off or on;
  LampC_on_off:integer; //C lamp off or on;
  LampD_on_off:integer; //D lamp off or on;
  LampE_on_off:integer; //E lamp off or on;
  LampF_on_off:integer; //F lamp off or on;
  Not_LampA_on_off:integer; //A lamp off but used;
  Not_LampB_on_off:integer; //B lamp off but used;
  Not_LampC_on_off:integer; //C lamp off but used;
  Not_LampD_on_off:integer; //D lamp off but used;
  Not_LampE_on_off:integer; //E lamp off but used;
  Not_LampF_on_off:integer; //F lamp off but used;
  rememberK8055i,rememberK8055E,rememberK8055F:longint;

  lamp_green_left_on_off:integer; //groenelamp aan of uit in finale;
  lamp_orange_left_on_off:integer; //oranje lamp aan of uit in finale;
  lamp_red_left_on_off:integer; //rode lamp aan of uit in finale;
  lamp_green_right_on_off:integer; //groenelamp aan of uit in finale;
  lamp_orange_right_on_off:integer; //oranje lamp aan of uit in finale;
  lamp_red_right_on_off:integer; //rode lamp aan of uit in finale;
  leftalign:integer; //  to remember the left position of the form when changing to small form
  topalign:integer;   // to remember the top position of the form when changing to small form
  Practiseturn:integer;   // to remember if practiceturn is active or normal turn
  nrofbeeps:integer; //number of times for buzzer
  nrofmanualbeeps:integer; //number of beeps in manual mode
  nrofturns:integer; //if there are more than 1 turn before getting the arrow (for example during long distances 2 times 3 arrows.
  serialsequence:integer; //serial sequence for serial output (TL left, TL right, ABCD etc
  times:integer; //   if nr of turns is 2 with double times: 2 else 1
  turnsss:integer; //   if nr of turns is 2 with double turns: 2 else 1
  nextsec:integer; // is 1 if next second can start.
  systemtime:TDateTime; //time according to the PC
  referencetime:TDateTime; //systemtime during next push
  referencesize:integer; //for resizing. depending on aspect ratio choose height or with as reference.
  iconsize:integer; // for resizing, icons depending on referencesize but with a maximum size;
  leftmarge:integer;  //left marge is bigger than 0 in case of widescreens
  topmarge:integer;   //top marge is bigger than 0 in case of smallscreens
  bannerAR:extended; // Aspect ratio is depending on the immage (width/height)
  bannerscaling:integer; // is depending on the size of the picture. reference is height of 100
  CardAddr:longint;      //adress  of k8055 card
  oldoutpstate:longint; //Remember previous output stat to know if a latch is needed
  dutchlang:string;     //yes means initial version has dutch language
  frenchlang:string;    //yes means initial version has french language
  englang:string;       //yes means initial version has English language
  WavFilename:PChar;   //Filename of the wav file used as sound.
  wavbuffer:string;
  settingsfile : TextFile;   //to read/wite settings file
  scenariotextfile : TextFile;    //to read scenariofles
  accessfile:Textfile; //File for accesspoint settings to remember.
  storefile : TextFile;           //to store scenariofiles
  langTxtFile : TextFile;    //to read/write language textfile
  buffer : string;   //to read/write items from files
  buffer2 : string;  //to read/write items from files
  langbuffer : string;  //to read items from language files
  precnthintfirst : string; //to read the hint of the counter during time before shoot from initialisation file
  Mintext : string;       //to read the hint of minutes from initialisation file
  Sectext : string;       //to read the hint of seconds from initialisation file
  Minabr : string;        //to read the hint of minutes abreviation from initialisation file
  Menudisap : string;     //to read the hint of mune disapears from initialisation file
  Paustxt : string;         //hint text pause
  resumetxt : string;       //hint text resume
  NXTstart : string;        //hint text start timer
  NXTnext : string;         //hint text next archer
  NXTstop : string;         //hint text last archer
  ActAtxt : string;         //hint text actuate archer A
  ActBtxt : string;         //hint text actuate archer B
  ActCtxt : string;         //hint text actuate archer C
  ActDtxt : string;         //hint text actuate archer D
  ActEtxt : string;         //hint text actuate archer E
  ActFtxt : string;         //hint text actuate archer F
  Mainhint1 : string;       //main hint text 1
  Mainhint2 : string;       //main hint text 2
  Mainhint3 : string;       //main hint text 3
  Mainhint4 : string;       //main hint text 4
  selectright : string;     //selectrightsidehint
  selectleft : string;      //select leftsidehint
  prevarch: string;         //select previousarcherhint
  nextarch: string;         //select nextarcherhint
  Connectingstring:string;  //language text for connecting
  Connectedstring:string;  //language text for connected
  Cardnotfoundstring:string;  //language text for Card not found
  Cardstring:string;  //language text for Card
  waitstate:integer; //remember in follow state if digits indicated waitstate (state1)
  leftreceivedvalue:string; //remember in follow mode the left value
  rightreceivedvalue:string; //remember in follow mode the right value
  trafficreceiveddata:string; //remember in follow mode the traficlight value
  fitamode:integer;         //fita mode (1=A, 2=A-B, 3=A-B-C, 4=A-B-C-D, 5=AB-CD)
  Fstore:string; //location for defaultsetting
  fitaseq:string; //sequence A, A-B, A-B-C, etc
  fitaseq2:string; //sequence of second end. A, B-A, C-A-B, etc
  duration:string; //Duration of 1 turn,
  archerysystem:string; // Can be 'FITA',  'fitafin', '25m1P' , 'manual' or 'follow'
  followsystem:string; //  0 = fita in top bottom mode, 1='fita',2 ='fitafin,3='25m1p',4='manual'
  followleft, followright:boolean; // to indicate in follow finals if left or right archer is active
  oldfollowsystem: string; //to detect a followsystemchange.
  oldturnnumber: integer; // to detect a turnnumber change
  oldserienumber, oldfolturnnumber, oldfolArchersperturn, oldfolTurnsperserie, oldPractiseturn: integer; // to detect a turnnumber change in followmode
  oldABCDperEND, oldrotate25m1p, oldrotate25m1p_p, oldfollowleft, oldfollowright:boolean;
  fitafinarcher:string; //Which archers turn in finals . Can be 'left', 'right' or 'none'
  fitafinstartarcher:string; //Which archers start the serie in finals . Can be 'left', 'right' or 'none'
  leftscale:integer; //(scaling of left figure
  rightscale:integer; //(scaling of right figure
  menuremovesec:integer; //secons before menu disapears
  arduinowrite1:longint; //remember the last serial data to arduino for trafic lights and ABCD light. new information is only sent if it is different
  arduinowrite2:longint; //remember the last serial data to arduino for left side digits. new information is only sent if it is different
  arduinowrite3:longint; //remember the last serial data to arduino for right side digits. new information is only sent if it is different
  arduinowrite4:longint; //remember the last serial data to arduino for abcd details. new information is only sent if it is different
  arduinowrite5:longint; //remember the last serial data to arduino for end nr  new information is only sent if it is different
  arduinowrite6:longint;
  arduinowrite7:longint;
  lanwrite1, lanwrite2, lanwrite3, lanwrite4, lanwrite5, lanwrite6, lanwrite7: Longint;  //remember the lan  data to  etc
  SENTLAN1, SENTLAN2, SENTLAN3, SENTLAN4, SENTLAN4b, SENTLAN5, SENTLAN6:longint; //serialdata to sent via LAN
  SENTBROAD0, SENTBROAD1, SENTBROAD2, SENTBROAD3, SENTBROAD4, SENTBROAD5, SENTBROAD6, SENTBROAD7, SENTBROAD8, SENTBROAD9, SENTBROAD10, SENTBROAD11, SENTBROAD12:Char; //the broadcast (multicast)signal
  justconnected:boolean; //when the arduino is just connected, a serial update is needed to arduino (even if previous sent signal is not different
  lanref1, lanref2, lanref3, lanref4, lanref5, lanref6, lanref7, serref1, serref2, serref3, serref4, serref5, serref6, serref7 : boolean; //to indicate if the individual serial strings need to be refreshed.
  refreshtiming, refreshtimelan:integer;   //counter for refreshing serial signal and lan signal
  arduinoactive_at_init: boolean;
  manualfollowmenuremove:boolean; //to indicate tha timer is running to remove menu in follow or manual mode
  initializationstate:boolean;
  NETWORK1, TCPnetwork, TCPmusicnetwork: TLConnection; //network1 (first port  )
  isserver:boolean; //to indicate if this one is server
  foltime1, foltime2, foltrafic, folsecdetails, folsecdetailssec, folendnr, folstate:string;  // 16 bits values for follow mode
  orgPABCDperEND, orgfolabcdsec, orgfol25m1pse, orgfol25m1pse_p, orgfolminsec:boolean; // to remember when switching to follow mode and back if originally minutes or seconds used. 25m1p turns get rotated. fita abcd stays the same per turn. (checkboxes will be checked depending on server system
  orgrepeatsequence:integer;  // to remember when switching to follow mode and back if originally repeated sequence changed
  oldfolstate, oldfolsecdetails, oldfolsecdetailssec, oldfolendnr, oldfolendnr2:string; //To detect changes in folsecdetails or folstate or folendnr
  lanint, serint:integer; // to indicate which lan or serial string needs to be sent
  sndsock:TUDPBlockSocket;
  rcvsock:TUDPBlockSocket;
  skitem:integer;
  ptop:real; //Topside of ABCDEF;
  primarytext, secondarytext:string;
  prevkey:string; //To detect previous key for laser pointer ( esc + F5)
  linuxHW:string; //to indicate during compiling if program is suitable for RPI
  LOWRES:boolean; //to indicate id high resolution or low resolution is needed. (Because of performance RPI
  olds, olds13, olds14, olds15, olds3, olds4, olds5, olds6, olds7, olds8, olds9, olds10, olds11, olds12:string;
  debugcounter:integer;
  fastcountdownrepeat:integer; //To detect fast countdown due to internet time adjustment
  repeatnetworkstring1, repeatnetworkstring2, repeatnetworkstring3:string;
  repeatnetworkcount, sentscencount:integer;
  FBroad: array [0..12] of string;
  orgS:string; //remember received broadcast string
  imagecount:integer; //index number for background image
  screenwidth,screenheight:integer; //width (size) of the screen excluding menu
  menuwidth:integer; // fix Size of menubar (width)
  Shutdwnremote:boolean; //True if remote systems need to shut down
  shutdownsystem:boolean;//True if full system needs to shutdown.
  nrofshutdwnsignals:integer; //numer of times a shutdownsignal should be given
  redlighton:boolean; //to indicate if red light is on during blinking in state 1 or 2. If blinking checkboxes are not checked redlighton is true. (red light needs to be on when state is 1 or 2)
  musicaction, musicmute, newmusicaction, newmusicmute: string; //status of ongoing music
  musicvolume, newmusicvolume: integer;
  monthname: array[1..12] of string;
  dayname: array[1..7] of string;
  endtimebuzzer: boolean; // to indicate in finalrounds if sound is needed because alternating time is up
  {$IFDEF Unix}{$IFNDEF Darwin}
  //SDL Stuff
  audio_rate: integer;
  audio_format: Uint16;
  audio_channels: integer;
  audio_buffers : integer;
  wave: PMix_Chunk;
  channel : integer;
  {$ENDIF}{$ENDIF}


implementation

{$IFDEF Darwin}uses mactidy, macserial;{$ENDIF}

{$R *.lfm}
{$IFDEF Windows}       //at this moment only supported for Windows
function OpenDevice(CardAddress: Longint): Longint; stdcall; external 'K8055D.dll';
procedure CloseDevice; stdcall; external 'K8055D.dll';
function ReadAnalogChannel(Channel: Longint):Longint; stdcall; external 'K8055D.dll';
procedure ReadAllAnalog(var Data1, Data2: Longint); stdcall; external 'K8055D.dll';
procedure OutputAnalogChannel(Channel: Longint; Data: Longint); stdcall; external 'K8055D.dll';
procedure OutputAllAnalog(Data1: Longint; Data2: Longint); stdcall; external 'K8055D.dll';
procedure ClearAnalogChannel(Channel: Longint); stdcall; external 'K8055D.dll';
procedure ClearAllAnalog; stdcall; external 'K8055D.dll';
procedure SetAnalogChannel(Channel: Longint); stdcall; external 'K8055D.dll';
procedure SetAllAnalog; stdcall; external 'K8055D.dll';
procedure WriteAllDigital(Data: Longint);stdcall;  external 'K8055D.dll';
procedure ClearDigitalChannel(Channel: Longint); stdcall; external 'K8055D.dll';
procedure ClearAllDigital; stdcall; external 'K8055D.dll';
procedure SetDigitalChannel(Channel: Longint); stdcall; external 'K8055D.dll';
procedure SetAllDigital; stdcall; external 'K8055D.dll';
function ReadDigitalChannel(Channel: Longint): Boolean; stdcall; external 'K8055D.dll';
function ReadAllDigital: Longint; stdcall; external 'K8055D.dll';
function ReadCounter(CounterNr: Longint): Longint; stdcall; external 'K8055D.dll';
procedure ResetCounter(CounterNr: Longint); stdcall; external 'K8055D.dll';
procedure SetCounterDebounceTime(CounterNr, DebounceTime:Longint); stdcall; external 'K8055D.dll';

{$ENDIF}

{$IFDEF Unix}

{$ENDIF}

Procedure TCountdownform.startshortcut;

begin
  case skitem of
  0: next;
  1: stop;
  2: stopemergency;
  3: playpauze;
  4: if state=6 then downserie else downturn;
  5: if state=6 then upserie else upturn;
  6: upserie;
  7: downserie;
  8: starttostart;
  9: leftarea;
  10: rightarea;
  11: nextscenario;
  12: prevscenario;
  13: shutdownsys;
  14: begin
        nrofSOarrows:=1;
        soff;
      end;
  15: begin
        nrofSOarrows:=2;
        soff;
      end;
  16: begin
        nrofSOarrows:=3;
        soff;
      end;
  17: begin
        scenario:='F1';
        Setsettings;
      end;
  18: begin
        scenario:='F2';
        Setsettings;
      end;
  19: begin
        scenario:='F3';
        Setsettings;
      end;
  20: begin
        scenario:='F4';
        Setsettings;
      end;
  21: begin
        scenario:='F5';
        Setsettings;
      end;
  22: begin
        scenario:='F6';
        Setsettings;
      end;
  23: begin
        scenario:='F7';
        Setsettings;
      end;
  24: begin
        scenario:='F8';
        Setsettings;
      end;
  25: begin
        scenario:='F9';
        Setsettings;
      end;
  26: begin
        scenario:='F10';
        Setsettings;
      end;
  27: begin
        scenario:='F11';
        Setsettings;
      end;
  28: begin
        scenario:='F12';
        Setsettings;
      end;
  29: begin
        nrofSOarrows:=1;
        soff;
      end;
  30: begin
        nrofSOarrows:=2;
        soff;
      end;
  31: begin
        nrofSOarrows:=3;
        soff;
      end;
  32: begin
        nrofSOarrows:=4;
        soff;
      end;
  33: begin
        nrofSOarrows:=5;
        soff;
      end;
  34: begin
        nrofSOarrows:=6;
        soff;
      end;
  35: begin
        nrofSOarrows:=1;
        state:=2;
        soff;
      end;
  36: begin
        nrofSOarrows:=2;
        state:=2;
        soff;
      end;
  37: begin
        nrofSOarrows:=3;
        state:=2;
        soff;
      end;
  38: begin
        nrofSOarrows:=4;
        state:=2;
        soff;
      end;
  39: begin
        nrofSOarrows:=5;
        state:=2;
        soff;
      end;
  40: begin
        nrofSOarrows:=6;
        state:=2;
        soff;
      end;
  41: begin

      end;

  end;

end;

Function getcurrenttime :TDateTime;
var now1,now2,now3,now4:TdateTime;
begin
  repeat

    now1:=Now;
    now2:=Now;
    now3:=Now;
    now4:=Now;

  until ((now1=now2) and (now1=now3) and (now1=now4) and (now1<>0)) ;

  Result:=now1;

end;

Function bitstoABCD (BIT1,BIT2,BIT3:string):string;
var tot:integer;

begin
  tot:=0;

  if BIT3='1'then tot:=tot+1;
  if BIT2='1'then tot:=tot+2;
  if BIT1='1'then tot:=tot+4;


  case tot of

  1: bitstoABCD:='A';
  2: bitstoABCD:='B';
  3: bitstoABCD:='C';
  4: bitstoABCD:='D';
  5: bitstoABCD:='E';
  6: bitstoABCD:='F';

  else bitstoABCD:='';

  end;

end;

procedure TCountdownform.TLswitch;

//This procedure takes care for the trafic lights on the screen. depending on:
//-if the trafic lights are enabled
//-if the trafic lights are selected for right or left side of the screen
//-if one (normal) or two (final rounds) trafic lights are needed
begin
  if (usetraffic.checked=true)or (archerysystem='manual') or ((archerysystem='follow') and (followsystem='4'))then
  begin   //Show trafic lights on screen
    if  ((archerysystem<>'fitafin') or ((archerysystem='fitafin')and (finarrow.Checked=false))) then

    begin                        //others than final rounds where only one trafic light is used
      if TLleft.checked=true then
      begin               //Trafic lights on left side of the screen
        if (rightredcircle.Visible=true)and not((archerysystem='fitafin')and (finarrow.Checked=true)) then
        Begin
          rightredcircle.Visible:=false;
          rightyelcircle.Visible:=false;
          rightgrncircle.Visible:=false;
        end;
        if (leftredcircle.Visible=false) and LOWRES then
        Begin
          leftredcircle.Visible:=true;
          leftyelcircle.Visible:=true;
          leftgrncircle.Visible:=true;
        end;


        if TLredrightoff.Visible=true then TLredrightoff.Visible:=false;           //Left side, so right side invisible
        if TLorangerightoff.Visible=true then TLorangerightoff.Visible:=false;     //Left side, so right side invisible
        if TLgrnrightoff.Visible=true then TLgrnrightoff.Visible:=false;           //Left side, so right side invisible
        if TLredrighton.Visible=true then TLredrighton.Visible:=false;             //Left side, so right side invisible
        if TLorangerighton.Visible=true then TLorangerighton.Visible:=false;       //Left side, so right side invisible
        if TLgrnrighton.Visible=true then TLgrnrighton.Visible:=false;             //Left side, so right side invisible
        if (archerysystem<>'fitafin') or ((archerysystem='fitafin')and (viewleft.Checked=true) ) then
        begin


          if lamp_red_left_on_off=1 then
          begin                               //red state
            if LOWRES then leftredcircle.Brush.Color:=clRed else
            begin
              if TLredleftoff.Visible=true then TLredleftoff.Visible:=false;      //--> 'red light off' invisible
              if TLredlefton.Visible=false then TLredlefton.Visible:=true;        //--> 'red light visible
            end;
          end
          else
          begin                               // not a red state
            if LOWRES then leftredcircle.Brush.Color:=clBlack else
            begin
              if TLredleftoff.Visible=false then TLredleftoff.Visible:=true;       //--> 'red light off' visible
              if TLredlefton.Visible=true then TLredlefton.Visible:=false;         //--> 'red light invisible
            end;
          end;
          if lamp_orange_left_on_off=1 then
          begin                               //orange state
            if LOWRES then leftyelcircle.Brush.Color:=clYellow else
            begin
              if TLorangeleftoff.Visible=true then TLorangeleftoff.Visible:=false;   //--> 'orange light off' invisible
              if TLorangelefton.Visible=false then TLorangelefton.Visible:=true;     //--> 'orange light visible
            end;
          end
          else
          begin                               //not orange state
            if LOWRES then leftyelcircle.Brush.Color:=clBlack else
            begin
              if TLorangeleftoff.Visible=false then TLorangeleftoff.Visible:=true;    //--> 'orange light off' visible
              if TLorangelefton.Visible=true then TLorangelefton.Visible:=false;      //--> 'orange light invisible
            end;
          end;
          if lamp_green_left_on_off=1 then
          begin                               //green state
            if LOWRES then leftgrncircle.Brush.Color:=clLime else
            begin
              if TLgrnleftoff.Visible=true then TLgrnleftoff.Visible:=false;      //--> 'green light off' invisible
              if TLgrnlefton.Visible=false then TLgrnlefton.Visible:=true;        //--> 'green light visible
            end;
          end
          else
          begin                               //not green state
            if LOWRES then leftgrncircle.Brush.Color:=clBlack else
            begin
              if TLgrnleftoff.Visible=false then TLgrnleftoff.Visible:=true;       //--> 'green light off' visible
              if TLgrnlefton.Visible=true then TLgrnlefton.Visible:=false;         //--> 'green light invisible
            end;
          end;
        end
        else    //fita final mode, but right screen is selected so right side traficlight collors are leading to show on screen.
        begin

          if lamp_red_right_on_off=1 then
           begin                               //red state
             if LOWRES then leftredcircle.Brush.Color:=clRed else
             begin
               if TLredleftoff.Visible=true then TLredleftoff.Visible:=false;      //--> 'red light off' invisible
               if TLredlefton.Visible=false then TLredlefton.Visible:=true;        //--> 'red light visible
             end;
           end
           else
           begin                               // not a red state
             if LOWRES then leftredcircle.Brush.Color:=clBlack else
             begin
               if TLredleftoff.Visible=false then TLredleftoff.Visible:=true;       //--> 'red light off' visible
               if TLredlefton.Visible=true then TLredlefton.Visible:=false;       //--> 'red light invisible
             end;
           end;
           if lamp_orange_right_on_off=1 then
           begin                               //orange state
             if LOWRES then leftyelcircle.Brush.Color:=clYellow else
             begin
               if TLorangeleftoff.Visible=true then TLorangeleftoff.Visible:=false;   //--> 'orange light off' invisible
               if TLorangelefton.Visible=false then TLorangelefton.Visible:=true;     //--> 'orange light visible
             end;
           end
           else
           begin                               //not orange state
             if LOWRES then leftyelcircle.Brush.Color:=clBlack else
             begin
               if TLorangeleftoff.Visible=false then TLorangeleftoff.Visible:=true;    //--> 'orange light off' visible
               if TLorangelefton.Visible=true then TLorangelefton.Visible:=false;    //--> 'orange light invisible
             end;
           end;
           if lamp_green_right_on_off=1 then
           begin                               //green state
             if LOWRES then leftgrncircle.Brush.Color:=clLime else
             begin
               if TLgrnleftoff.Visible=true then TLgrnleftoff.Visible:=false;      //--> 'green light off' invisible
               if TLgrnlefton.Visible=false then TLgrnlefton.Visible:=true;        //--> 'green light visible
             end;
           end
           else
           begin                               //not green state
             if LOWRES then leftgrncircle.Brush.Color:=clBlack else
             begin
               if TLgrnleftoff.Visible=false then TLgrnleftoff.Visible:=true;       //--> 'green light off' visible
               if TLgrnlefton.Visible= true then TLgrnlefton.Visible:=false;       //--> 'green light invisible
             end;
           end;


        end;
      end
      else
      begin   //Trafic lights on right side of the screen
        if (rightredcircle.Visible=false) and LOWRES then
        Begin
          rightredcircle.Visible:=true;
          rightyelcircle.Visible:=true;
          rightgrncircle.Visible:=true;
        end;
        if (leftredcircle.Visible=true) and not((archerysystem='fitafin')and (finarrow.Checked=true)) then
        Begin
          leftredcircle.Visible:=false;
          leftyelcircle.Visible:=false;
          leftgrncircle.Visible:=false;
        end;
        if TLredleftoff.Visible=true then TLredleftoff.Visible:=false;        //right side, so left side invisible
        if TLorangeleftoff.Visible=true then TLorangeleftoff.Visible:=false;     //right side, so left side invisible
        if TLgrnleftoff.Visible=true then TLgrnleftoff.Visible:=false;        //right side, so left side invisible
        if TLredlefton.Visible=true then TLredlefton.Visible:=false;         //right side, so left side invisible
        if TLorangelefton.Visible=true then TLorangelefton.Visible:=false;      //right side, so left side invisible
        if TLgrnlefton.Visible=true then TLgrnlefton.Visible:=false;         //right side, so left side invisible
        if (archerysystem<>'fitafin') or ((archerysystem='fitafin')and (viewright.Checked=true) ) then
        begin
          if lamp_red_right_on_off=1 then
          begin                               //red state
            if LOWRES then rightredcircle.Brush.Color:=clRed else
            begin
              if TLredrightoff.Visible=true then TLredrightoff.Visible:=false;     //--> 'red light off' invisible
              if TLredrighton.Visible=false then TLredrighton.Visible:=true;       //--> red light visible
            end;
          end
          else
          begin                               // not a red state
            if LOWRES then rightredcircle.Brush.Color:=clBlack else
            begin
              if TLredrightoff.Visible=false then TLredrightoff.Visible:=true;      //--> 'red light off' visible
              if TLredrighton.Visible=true then TLredrighton.Visible:=false;      //--> red light invisible
            end;
          end;
          if lamp_orange_right_on_off=1 then
          begin                               //orange state
            if LOWRES then rightyelcircle.Brush.Color:=clYellow else
            begin
              if TLorangerightoff.Visible=true then TLorangerightoff.Visible:=false;  //--> 'orange light off' invisible
              if TLorangerighton.Visible=false then TLorangerighton.Visible:=true;    //--> orange light visible
            end;
          end
          else
          begin                               //not orange state
            if LOWRES then rightyelcircle.Brush.Color:=clBlack else
            begin
              if TLorangerightoff.Visible=false then TLorangerightoff.Visible:=true;   //--> 'orange light off' visible
              if TLorangerighton.Visible=true then TLorangerighton.Visible:=false;   //--> orange light invisible
            end;
          end;
          if lamp_green_right_on_off=1 then
          begin                               //green state
            if LOWRES then rightgrncircle.Brush.Color:=clLime else
            begin
              if TLgrnrightoff.Visible=true then TLgrnrightoff.Visible:=false;     //--> 'green light off' invisible
              if TLgrnrighton.Visible=false then TLgrnrighton.Visible:=true;       //--> green light visible
            end;
          end
          else
          begin                               //not green state
            if LOWRES then rightgrncircle.Brush.Color:=clBlack else
            begin
              if TLgrnrightoff.Visible=false then TLgrnrightoff.Visible:=true;      //--> 'green light off' visible
              if TLgrnrighton.Visible=true then TLgrnrighton.Visible:=false;      //--> green light invisible
            end;
          end;
        end
        else    //fita final mode, but left screen is selected so left side traficlight colors are leading to show on screen.
        begin

          if lamp_red_left_on_off=1 then
          begin                               //red state
            if LOWRES then rightredcircle.Brush.Color:=clRed else
            begin
              if TLredrightoff.Visible=true then TLredrightoff.Visible:=false;     //--> 'red light off' invisible
              if TLredrighton.Visible=false then TLredrighton.Visible:=true;       //--> red light visible
            end;
          end
          else
          begin                               // not a red state
            if LOWRES then rightredcircle.Brush.Color:=clBlack else
            begin
              if TLredrightoff.Visible=false then TLredrightoff.Visible:=true;      //--> 'red light off' visible
              if TLredrighton.Visible=true then TLredrighton.Visible:=false;      //--> red light invisible
            end;
          end;
          if lamp_orange_left_on_off=1 then
          begin                               //orange state
            if LOWRES then rightyelcircle.Brush.Color:=clYellow else
            begin
              if TLorangerightoff.Visible=true then TLorangerightoff.Visible:=false;  //--> 'orange light off' invisible
              if TLorangerighton.Visible=false then TLorangerighton.Visible:=true;    //--> orange light visible
            end;
          end
          else
          begin                               //not orange state
            if LOWRES then rightyelcircle.Brush.Color:=clBlack else
            begin
              if TLorangerightoff.Visible=false then TLorangerightoff.Visible:=true;   //--> 'orange light off' visible
              if TLorangerighton.Visible=true then TLorangerighton.Visible:=false;   //--> orange light invisible
            end;
          end;
          if lamp_green_left_on_off=1 then
          begin                               //green state
            if LOWRES then rightgrncircle.Brush.Color:=clLime else
            begin
              if TLgrnrightoff.Visible=true then TLgrnrightoff.Visible:=false;     //--> 'green light off' invisible
              if TLgrnrighton.Visible=false then TLgrnrighton.Visible:=true;       //--> green light visible
            end;
          end
          else
          begin                               //not green state
            if LOWRES then rightgrncircle.Brush.Color:=clBlack else
            begin
              if TLgrnrightoff.Visible=false then TLgrnrightoff.Visible:=true;      //--> 'green light off' visible
              if TLgrnrighton.Visible=true then TLgrnrighton.Visible:=false;      //--> green light invisible
            end;
          end;
        end;
      end
    end
    else
    begin                                   //final round
      if (leftredcircle.Visible=false) and LOWRES then
      Begin
        leftredcircle.Visible:=true;
        leftyelcircle.Visible:=true;
        leftgrncircle.Visible:=true;
      end;

      if (rightredcircle.Visible=false) and LOWRES then
      Begin
        rightredcircle.Visible:=true;
        rightyelcircle.Visible:=true;
        rightgrncircle.Visible:=true;
      end;


      if lamp_red_left_on_off=1 then
      begin                                 //left side red state
        if LOWRES then leftredcircle.Brush.Color:=clRed else
        begin
          if TLredleftoff.Visible=true then TLredleftoff.Visible:=false;        //--> 'red left light off' invisible
          if TLredlefton.Visible=false then TLredlefton.Visible:=true;          //--> red left light visible
        end;
      end
      else
      begin                                 //left side not red state
        if LOWRES then leftredcircle.Brush.Color:=clBlack else
        begin
          if TLredleftoff.Visible=false then TLredleftoff.Visible:=true;         //--> 'red left light off' visible
          if TLredlefton.Visible=true then TLredlefton.Visible:=false;         //--> red left light invisible
        end;
      end;

      if lamp_orange_left_on_off=1 then
      begin                                 //left side orange state
        if LOWRES then leftyelcircle.Brush.Color:=clYellow else
        begin
          if TLorangeleftoff.Visible=true then TLorangeleftoff.Visible:=false;     //--> 'orange left light off' invisible
          if TLorangelefton.Visible=false then TLorangelefton.Visible:=true;       //--> orange left light visible
        end;
      end
      else
      begin                                 //left side not orange state
        if LOWRES then leftyelcircle.Brush.Color:=clBlack else
        begin
          if TLorangeleftoff.Visible=false then TLorangeleftoff.Visible:=true;      //--> 'orange left light off' visible
          if TLorangelefton.Visible=true then TLorangelefton.Visible:=false;      //--> orange left light invisible
        end;
      end;

      if lamp_green_left_on_off=1 then
      begin                                 //left side green state
        if LOWRES then leftgrncircle.Brush.Color:=clLime else
        begin
          if TLgrnleftoff.Visible=true then TLgrnleftoff.Visible:=false;        //--> 'green left light off' invisible
          if TLgrnlefton.Visible=false then TLgrnlefton.Visible:=true;          //--> green left light visible
        end;
      end
      else
      begin                                 //left side not green state
        if LOWRES then leftgrncircle.Brush.Color:=clBlack else
        begin
          if TLgrnleftoff.Visible=false then TLgrnleftoff.Visible:=true;         //--> 'green left light off' visible
          if TLgrnlefton.Visible=true then TLgrnlefton.Visible:=false;         //--> green left light invisible
        end;
      end;

      if lamp_red_right_on_off=1 then
      begin                                 //right side red state
        if LOWRES then rightredcircle.Brush.Color:=clRed else
        begin
          if TLredrightoff.Visible=true then TLredrightoff.Visible:=false;       //--> 'red right light off' invisible
          if TLredrighton.Visible=false then TLredrighton.Visible:=true;         //--> red right light visible
        end;
      end
      else
      begin                                 //right side not red state
        if LOWRES then rightredcircle.Brush.Color:=clBlack else
        begin
          if TLredrightoff.Visible=false then TLredrightoff.Visible:=true;        //--> 'red right light off' visible
          if TLredrighton.Visible=true then TLredrighton.Visible:=false;        //--> red right light invisible
        end;
      end;

      if lamp_orange_right_on_off=1 then
      begin                                 //right side orange state
        if LOWRES then rightyelcircle.Brush.Color:=clYellow else
        begin
          if TLorangerightoff.Visible=true then TLorangerightoff.Visible:=false;    //--> 'orange right light off' invisible
          if TLorangerighton.Visible=false then TLorangerighton.Visible:=true;      //--> orange right light visible
        end;
      end
      else
      begin                                 //right side not orange state
        if LOWRES then rightyelcircle.Brush.Color:=clBlack else
        begin
          if TLorangerightoff.Visible=false then TLorangerightoff.Visible:=true;     //--> 'orange right light off' visible
          if TLorangerighton.Visible=true then TLorangerighton.Visible:=false;     //--> orange right light invisible
        end;
      end;

      if lamp_green_right_on_off=1 then
      begin                                 //right side green state
        if LOWRES then rightgrncircle.Brush.Color:=clLime else
        begin
          if TLgrnrightoff.Visible=true then TLgrnrightoff.Visible:=false;       //--> 'green right light off' invisible
          if TLgrnrighton.Visible=false then TLgrnrighton.Visible:=true;         //--> green right light visible
        end;
      end
      else
      begin                                 //right side not green state
        if LOWRES then rightgrncircle.Brush.Color:=clBlack else
        begin
          if TLgrnrightoff.Visible=false then TLgrnrightoff.Visible:=true;        //--> 'green right light off' visible
          if TLgrnrighton.Visible=true then TLgrnrighton.Visible:=false;        //--> green right light invisible
        end;
      end
    end;
  end
  else
  begin                                     //do not show trafic lights on screen
    if TLredrightoff.Visible=true then TLredrightoff.Visible:=false;           //trafic light invisible
    if TLorangerightoff.Visible=true then TLorangerightoff.Visible:=false;        //trafic light invisible
    if TLgrnrightoff.Visible=true then TLgrnrightoff.Visible:=false;           //trafic light invisible
    if TLredrighton.Visible=true then TLredrighton.Visible:=false;            //trafic light invisible
    if TLorangerighton.Visible=true then TLorangerighton.Visible:=false;         //trafic light invisible
    if TLgrnrighton.Visible=true then TLgrnrighton.Visible:=false;            //trafic light invisible
    if TLredleftoff.Visible=true then TLredleftoff.Visible:=false;            //trafic light invisible
    if TLorangeleftoff.Visible=true then TLorangeleftoff.Visible:=false;         //trafic light invisible
    if TLgrnleftoff.Visible=true then TLgrnleftoff.Visible:=false;            //trafic light invisible
    if TLredlefton.Visible=true then TLredlefton.Visible:=false;             //trafic light invisible
    if TLorangelefton.Visible=true then TLorangelefton.Visible:=false;          //trafic light invisible
    if TLgrnlefton.Visible=true then TLgrnlefton.Visible:=false;             //trafic light invisible

    if leftredcircle.Visible=true then
    Begin
      leftredcircle.Visible:=false;
      leftyelcircle.Visible:=false;
      leftgrncircle.Visible:=false;
    end;
    if rightredcircle.Visible=true then
    Begin
      rightredcircle.Visible:=false;
      rightyelcircle.Visible:=false;
      rightgrncircle.Visible:=false;
    end;


  end
end;


procedure TCountdownform.viewchangestateactive; //between state 2-3-4
begin
    if state = 2 then   //state =2 means red time
    begin
      if prevstate<>2 then
      begin
        if digit1_1.Font.Color<>redcolor then
        begin
          digit1_1.Font.Color:=redcolor;          // during red state the font of the timers are redcolor
          dots_1.Font.Color:=redcolor;
          digit2_1.Font.Color:=redcolor;
          digit3_1.Font.Color:=redcolor;
        end;
      end;
      if (archerysystem='fitafin') then
      begin
        if digit1_2.Font.Color<>redcolor then
        begin
          digit1_2.Font.Color:=redcolor;
          dots_2.Font.Color:=redcolor;
          digit2_2.Font.Color:=redcolor;
          digit3_2.Font.Color:=redcolor;

        end;
      end;
      if (Countdownform.Color<>bgredcolor) and ((archerysystem<>'fitafin')or((archerysystem='fitafin')and ((finarrow.Checked)or (viewleft.Checked and(fitafinarcher ='left'))or(viewright.Checked and(fitafinarcher ='right'))))) then Countdownform.Color:=bgredcolor;
      if redlighton=true then lamp_red_left_on_off:=1 else lamp_red_left_on_off:=0;                //During red state, the trafic lights (HW) are red
      lamp_orange_left_on_off:=0;
      lamp_green_left_on_off:=0;
      if redlighton=true then lamp_red_right_on_off:=1 else lamp_red_right_on_off:=0;
      lamp_orange_right_on_off:=0;
      lamp_green_right_on_off:=0;
      If (archerysystem<>'manual') and not((archerysystem='follow') and (followsystem='4'))then
      begin
        if prevstate=1 then
        begin
          archeryclock.visible:=false;  //hide label because time is ticking
          show_commercial.Enabled:=false;
        end;
      end;
    end;
    if state = 3 then     //state =3 means green state
    begin
      if  (archerysystem<>'fitafin')  then
      begin
        if prevstate<>3 then
        begin
          if  digit1_1.Font.Color<>greencolor then
          begin
            digit1_1.Font.Color:=greencolor;       // during green state the font of the timers are greencolor
            dots_1.Font.Color:=greencolor;
            digit2_1.Font.Color:=greencolor;
            digit3_1.Font.Color:=greencolor;
          end;
          if Countdownform.Color <> bggreencolor then  Countdownform.Color:=bggreencolor;
          lamp_red_left_on_off:=0;
          lamp_red_right_on_off:=0;
          lamp_orange_left_on_off:=0;
          lamp_orange_right_on_off:=0;
          lamp_green_left_on_off:=1;          //During green state, the trafic lights (HW) are green
          lamp_green_right_on_off:=1;
        end;
      end
      else
      begin
        if fitafinarcher='left'then
        begin                                //during green state finals, left archer shooting means left archer green light
          if digit1_1.Font.Color<>greencolor then
          begin
            digit1_1.Font.Color:=greencolor;
            dots_1.Font.Color:=greencolor;
            digit2_1.Font.Color:=greencolor;
            digit3_1.Font.Color:=greencolor;
          end;
          if viewright.Checked=true then
          begin
            if Countdownform.Color<>bgredcolor then Countdownform.Color:=bgredcolor;
          end
          else if Countdownform.Color<>bggreencolor then Countdownform.Color:=bggreencolor;
          if digit1_2.Font.Color<>redcolor then
          begin
            digit1_2.Font.Color:=redcolor;
            dots_2.Font.Color:=redcolor;
            digit2_2.Font.Color:=redcolor;
            digit3_2.Font.Color:=redcolor;
          end;
          lamp_red_left_on_off:=0;
          lamp_orange_left_on_off:=0;
          lamp_green_left_on_off:=1;         //during green state finals, left archer shooting means left archer green light (HW)
          lamp_red_right_on_off:=1;          //during green state finals, left archer shooting means right archer still red light
          lamp_orange_right_on_off:=0;
          lamp_green_right_on_off:=0;
        end
        else        //right archer
        begin
          if digit1_1.Font.Color<>redcolor then
          begin
            digit1_1.Font.Color:=redcolor;       //during green state finals, right archer shooting means right archer green light
            dots_1.Font.Color:=redcolor;
            digit2_1.Font.Color:=redcolor;
            digit3_1.Font.Color:=redcolor;
          end;
          if viewleft.Checked=true then
          begin
            if Countdownform.Color<>bgredcolor then Countdownform.Color:=bgredcolor;
          end
          else Countdownform.Color:=bggreencolor;
          if digit1_2.Font.Color<>greencolor then
          begin
            digit1_2.Font.Color:=greencolor;
            dots_2.Font.Color:=greencolor;
            digit2_2.Font.Color:=greencolor;
            digit3_2.Font.Color:=greencolor;
          end;
          lamp_red_left_on_off:=1;             //during green state finals, right archer shooting means left archer still red light
          lamp_orange_left_on_off:=0;
          lamp_green_left_on_off:=0;
          lamp_red_right_on_off:=0;
          lamp_orange_right_on_off:=0;
          lamp_green_right_on_off:=1;           //during green state finals, right archer shooting means right archer green light (HW)
        end;
      end;
    end;
    if state = 4 then            //state =4 means orange state
    begin
      if  archerysystem<>'fitafin'then
      begin
        if prevstate<>4 then
        begin
          if digit1_1.Font.Color<>orangecolor then
          begin
            digit1_1.Font.Color:=orangecolor;
            dots_1.Font.Color:=orangecolor;
            digit2_1.Font.Color:=orangecolor;
            digit3_1.Font.Color:=orangecolor;
          end;
          if Countdownform.Color<>bgorangecolor then Countdownform.Color:=bgorangecolor;
          lamp_red_left_on_off:=0;
          lamp_red_right_on_off:=0;
          lamp_orange_left_on_off:=1;             //During orange state, the trafic lights (HW) are orange
          lamp_orange_right_on_off:=1;
          lamp_green_left_on_off:=0;
          lamp_green_right_on_off:=0;
        end;
      end
      else
      begin
        if fitafinarcher='left'then
        begin
          if digit1_1.Font.Color<>orangecolor then
          begin
            digit1_1.Font.Color:=orangecolor;          //during orange state finals, left archer shooting means left archer orange light
            dots_1.Font.Color:=orangecolor;
            digit2_1.Font.Color:=orangecolor;
            digit3_1.Font.Color:=orangecolor;
          end;
          if viewright.Checked=true then
          begin
            if Countdownform.Color<>bgredcolor then Countdownform.Color:=bgredcolor;
          end
           else if Countdownform.Color<>bgorangecolor then Countdownform.Color:=bgorangecolor;
          if digit1_2.Font.Color<>redcolor then
          begin
            digit1_2.Font.Color:=redcolor;
            dots_2.Font.Color:=redcolor;
            digit2_2.Font.Color:=redcolor;
            digit3_2.Font.Color:=redcolor;
          end;
          lamp_red_left_on_off:=0;
          lamp_orange_left_on_off:=1;                //during orange state finals, left archer shooting means left archer orange light (HW)
          lamp_green_left_on_off:=0;
          lamp_red_right_on_off:=1;                  //during orange state finals, left archer shooting means right archer still red light
          lamp_orange_right_on_off:=0;
          lamp_green_right_on_off:=0;
        end
        else                //right archer
        begin
          if digit1_1.Font.Color<>redcolor then
          begin
            digit1_1.Font.Color:=redcolor;              //during orange state finals, right archer shooting means right archer orange light
            dots_1.Font.Color:=redcolor;
            digit2_1.Font.Color:=redcolor;
            digit3_1.Font.Color:=redcolor;
          end;
          if digit1_2.Font.Color<>orangecolor then
          begin
            digit1_2.Font.Color:=orangecolor;
            dots_2.Font.Color:=orangecolor;
            digit2_2.Font.Color:=orangecolor;
            digit3_2.Font.Color:=orangecolor;
          end;
          if viewleft.Checked=true then
          begin
            if Countdownform.Color<>bgredcolor then Countdownform.Color:=bgredcolor;
          end
          else if Countdownform.Color<>bgorangecolor then Countdownform.Color:=bgorangecolor;
          lamp_red_left_on_off:=1;                 //during orange state finals, right archer shooting means left archer still red light
          lamp_orange_left_on_off:=0;
          lamp_green_left_on_off:=0;
          lamp_red_right_on_off:=0;
          lamp_orange_right_on_off:=1;             //during orange state finals, right archer shooting means right archer orange light (HW)
          lamp_green_right_on_off:=0;
        end;
      end;
    end;
    If (state=3) or (state=4) then
    begin
      if (archerysystem<>'fitafin') then
      begin
        if (prevstate<>3) and (prevstate<>4) then
        begin
          if (((turnnumber =turnsperserie) and (serienumber mod turnsss =0)) or (Shootoff=1)) then
          begin
            nexticon.Hint:=NXTstop;
            nexthelp.Caption:= Mainhint4;
          end
          else
          begin
            nexticon.Hint:= NXTnext;
            nexthelp.Caption:= Mainhint3;
          end;
        end;
      end
      else
      begin
        if ((((serienumber>=finalturns.value) and (timeperturn.checked=true))or((serienumber>=finalteamturns.Value) and (timeperturn.checked=false)) )and(((fitafinarcher='right') and (fitafinstartarcher = 'left')  )or ((fitafinarcher='left') and (fitafinstartarcher = 'right'))))then
        begin
          nexticon.Hint:=NXTstop;
          nexthelp.Caption:= Mainhint4;
        end
        else
        begin
          nexticon.Hint:= NXTnext;
          nexthelp.Caption:= Mainhint3;
        end;
      end;
    end;
    If (state=2) or (state=3) or (state=4)then
    begin
      archeryclock.visible:=false;
      show_commercial.Enabled:=false;
     // viewstateone;
    end;
    if (showhints.checked=true) and (state = 1) and (archerysystem='fitafin') and (fitafinarcher='none') then chooselabel.Visible:=true else chooselabel.Visible:=false;                              //show help text for choose button  depending on menu setting and state
    if (archerysystem='fitafin')and (fitafinarcher='none') and  (state = 1) then
    begin
      nexticon.visible:=false;              // if the choise is not made if left or right archer starts, it is not possible to press next. so icon is invisible
      SOicon.Visible:=false;
    end
    else
    begin
      if ((hideicons.checked = false) and (archerysystem<>'manual') and (archerysystem<>'follow')) then
      begin
        nexticon.visible:=true;
        if state=1 then SOicon.Visible:=true;
      end;
    end;
    if (showhints.checked=true) and(((state <> 2) and (archerysystem<>'fitafin')and (archerysystem<>'manual') and (archerysystem<>'follow'))or((archerysystem='fitafin')and(fitafinarcher<>'none'))) then nexthelp.Visible:=true else nexthelp.Visible:=false;   //show help text for next button  depending on menu setting and state
    If state=2 then nexticon.Hint:='';
    if (state = 2) and ((archerysystem<>'fita') or (redtime.Value<>-1)) then
    begin     //during red state   the next button is invisible because timer is already started and it is not possible tha all archers are ready because they couldn't shoot yet
      nexticon.visible:=false;
      nexthelp.Visible:=false;
    end;
  prevstate:=state;
end;
procedure TCountdownform.setleftclockdigits;  //Make correct digits vissible dependingon seconds settings etc.
begin
  //debugcounter:=debugcounter+1;
  //copyright.Caption:=inttostr(debugcounter)+'-'+archerysystem+'-'+fitafinarcher+'-'+inttostr(state)+'-'+CurrToStr(realstate);
  if (((archerysystem='fitafin') and (fitafinarcher<>'none'))or ((archerysystem='follow') and (followsystem='2')and((followright or followleft))))and (archeryclock.Visible=true) then archeryclock.Visible:=false;
  if (archerysystem<>'fitafin')or ((archerysystem='fitafin')and((viewleft.Checked=true)or (finarrow.Checked=true))) then
  begin
    if (((((archerysystem='fitafin')and(fitafinarcher='right'))or  ((archerysystem='follow')and(followsystem='2')and(((followright)and(leftscreen.Checked))or((followleft)and(rightscreen.Checked)) ))     )and((state=1)or(not((archerysystem='follow')and(followsystem='2'))and(state=2))or((archerysystem='follow')and(followsystem='2')and(realstate=2)) ))or(((digit1_1.caption='0')and(minsec.ItemIndex=0)and (nonzerosec.Checked=true))or(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and ((((state=1)and(((archerysystem='fitafin')and(fitafinarcher='none'))or((archerysystem='follow')and(followsystem='2') and not(followright or followleft))or((archerysystem<>'fitafin')and not((archerysystem='follow')and(followsystem='2')))))or((state=6)and(Pause_emergency_RadioButton.Checked=false)))or(background1.Visible=true)) and (nrofbeeps=0)))) or (state=5) then digit1_1.Visible:=false else
    Begin
      if (archerysystem<>'fitafin') then  digit1_1.Visible:=true  else if (viewright.Checked=true)then  digit1_1.Visible:=false else digit1_1.Visible:=true;
    end;
    if (((((archerysystem='fitafin')and(fitafinarcher='right'))or  ((archerysystem='follow')and(followsystem='2')and(((followright)and(leftscreen.Checked))or((followleft)and(rightscreen.Checked)) )) )  and((state=1)or(not((archerysystem='follow')and(followsystem='2'))and(state=2))or((archerysystem='follow')and(followsystem='2')and(realstate=2))))or(((digit1_1.caption='0')and(digit2_1.Caption='0')and(minsec.ItemIndex=0)and (nonzerosec.Checked=true))or(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and ((((state=1)and(((archerysystem='fitafin')and(fitafinarcher='none'))or((archerysystem='follow')and(followsystem='2') and not(followright or followleft))or((archerysystem<>'fitafin')and not((archerysystem='follow')and(followsystem='2')))))or((state=6)and(Pause_emergency_RadioButton.Checked=false)))or(background1.Visible=true)) and (nrofbeeps=0)))) or (state=5) then digit2_1.Visible:=false else
    Begin
      if (archerysystem<>'fitafin') then  digit2_1.Visible:=true  else if (viewright.Checked=true)then  digit2_1.Visible:=false else digit2_1.Visible:=true;
    end;
    if  (not((((archerysystem='fitafin')and(fitafinarcher='right'))or  ((archerysystem='follow')and(followsystem='2')and(((followright)and(leftscreen.Checked))or((followleft)and(rightscreen.Checked)) ))          )and((state=1)or(not((archerysystem='follow')and(followsystem='2'))and(state=2))or((archerysystem='follow')and(followsystem='2')and(realstate=2))))and(not(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and (((state=1)and(((archerysystem='fitafin')and(fitafinarcher='none'))or((archerysystem='follow')and(followsystem='2') and not(followright or followleft))or((archerysystem<>'fitafin')and not((archerysystem='follow')and(followsystem='2')))))or(background1.Visible=true)) and (nrofbeeps=0))and not((archerysystem='follow') and (followsystem='4')))) and (not(state=5)) then digit3_1.visible:=true else digit3_1.visible:=false;
    if (((((archerysystem<>'fitafin')or((archerysystem='fitafin')and((fitafinarcher='left')or((fitafinarcher='right')and(state<>1)and(state<>2))or(fitafinarcher='none'))))and not(((archerysystem='follow')and(followsystem='2')and(((followright)and(leftscreen.Checked))or((followleft)and(rightscreen.Checked)) )and((realstate=2)or(state=1))))   )and((seconds.Checked=false) and (archerysystem <> 'manual') and  not((archerysystem='follow')and(followsystem='4'))and not(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and ((((state=1)and(((archerysystem='fitafin')and(fitafinarcher='none'))or((archerysystem='follow')and(followsystem='2') and not(followright or followleft))or((archerysystem<>'fitafin')and not((archerysystem='follow')and(followsystem='2'))))))or(background1.Visible=true)) and (nrofbeeps=0))))) and (not(state=5)) then dots_1.visible:=true else dots_1.visible:=false;
    if (seconds.Checked=true) then if (archerysystem<>'fitafin') then setnonfinalsdigitposition else setfinalsdigitposition;
  end;

end;
procedure TCountdownform.setrightclockdigits;  //Make correct digits vissible dependingon seconds settings etc.
begin
  if (archerysystem='fitafin')and((viewright.Checked=true)or (finarrow.Checked=true)) then
  begin
      if ((archerysystem='fitafin')and(fitafinarcher='left')and((state=1)or(state=2)))or(((digit1_2.caption='0')and(minsec.ItemIndex=0)and (nonzerosec.Checked=true))or(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and (((state=1)and(fitafinarcher='none'))or(background1.Visible=true)) and (nrofbeeps=0))) then digit1_2.Visible:=false else
      Begin
        if (archerysystem='fitafin') then  if (viewleft.Checked=true)then  digit1_2.Visible:=false else digit1_2.Visible:=true;
      end;
      if ((archerysystem='fitafin')and(fitafinarcher='left')and((state=1)or(state=2)))or(((digit1_2.caption='0')and(digit2_2.Caption='0')and(minsec.ItemIndex=0)and (nonzerosec.Checked=true))or(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and (((state=1)and(fitafinarcher='none'))or(background1.Visible=true)) and (nrofbeeps=0))) then digit2_2.Visible:=false else
      Begin
        if (viewleft.Checked=true)then  digit2_2.Visible:=false else digit2_2.Visible:=true;
      end;
      if ((archerysystem='fitafin')and(fitafinarcher='left')and((state=1)or(state=2)))or(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and (((state=1)and(fitafinarcher='none'))or(background1.Visible=true)) and (nrofbeeps=0)) then digit3_2.Visible:=false else  digit3_2.Visible:=true;
      if (((((archerysystem='fitafin')and((fitafinarcher='right')or((fitafinarcher='left')and(state<>1)and(state<>2))or((fitafinarcher='none'))))))and((seconds.Checked=false) and (archerysystem <> 'manual') and  not((archerysystem='follow')and(followsystem='4'))and not(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and ((((state=1)and(fitafinarcher='none')))or(background1.Visible=true)) and (nrofbeeps=0)))) then dots_2.visible:=true else dots_2.visible:=false;
      if (seconds.Checked=true) then setfinalsdigitposition;
  end;

end;
procedure TCountdownform.setfinalsdigitposition; //left right settings of digits depending on sec/min/etc notation
begin
  if finarrow.Checked=true then
  begin
      if seconds.Checked=true then
      begin
        if (zerosec.Checked=true)or(digit1_1.Visible=true) then
        begin
          digit1_1.Left:= (trunc ((referencesize*0.046)-(referencesize*leftscale*0.00016))+leftmarge);
          digit2_1.Left:= (trunc ((referencesize*0.294)-(referencesize*leftscale*0.00144))+leftmarge);
          digit3_1.Left:= (trunc ((referencesize*0.542)-(referencesize*leftscale*0.00272))+leftmarge);
        end
        else
        begin
          if (digit1_1.Visible=false) and digit2_1.Visible=true then
          begin
            digit2_1.Left:= (trunc ((referencesize*0.170)-(referencesize*leftscale*0.00080))+leftmarge);
            digit3_1.Left:= (trunc ((referencesize*0.418)-(referencesize*leftscale*0.00208))+leftmarge);
          end
          else digit3_1.Left:= (trunc ((referencesize*0.294)-(referencesize*leftscale*0.00144))+leftmarge);

        end;
        if (zerosec.Checked=true)or(digit1_2.Visible=true) then
        begin
          digit1_2.Left:= (trunc ((referencesize*0.236)+(referencesize*rightscale*0.00380))+leftmarge);
          digit2_2.Left:= (trunc ((referencesize*0.484)+(referencesize*rightscale*0.00260))+leftmarge);
          digit3_2.Left:= (trunc ((referencesize*0.732)+(referencesize*rightscale*0.00140))+leftmarge);
        end
        else
        begin
          if (digit1_2.Visible=false) and digit2_2.Visible=true then
          begin
            digit2_2.Left:= (trunc ((referencesize*0.360)+(referencesize*rightscale*0.00320))+leftmarge);
            digit3_2.Left:= (trunc ((referencesize*0.608)+(referencesize*rightscale*0.00200))+leftmarge);
          end
          else digit3_2.Left:= (trunc ((referencesize*0.484)+(referencesize*rightscale*0.00260))+leftmarge);

        end;
        dots_1.Visible:=false;
        dots_2.Visible:=false;
      end
      else
      begin
        digit1_1.Left:= (trunc ((referencesize*0.0008)-(referencesize*leftscale*0.000008))+leftmarge);
        dots_1.Left:= (trunc ((referencesize*0.232)-(referencesize*leftscale*0.00115))+leftmarge);
        digit2_1.Left:= (trunc ((referencesize*0.304)-(referencesize*leftscale*0.00152))+leftmarge);
        digit3_1.Left:= (trunc ((referencesize*0.544)-(referencesize*leftscale*0.00272))+leftmarge);

        digit1_2.Left:= (trunc ((referencesize*0.1888)+(referencesize*rightscale*0.00412))+leftmarge);
        dots_2.Left:= (trunc ((referencesize*0.42)+(referencesize*rightscale*0.00295))+leftmarge);
        digit2_2.Left:= (trunc ((referencesize*0.492)+(referencesize*rightscale*0.00260))+leftmarge);
        digit3_2.Left:= (trunc ((referencesize*0.732)+(referencesize*rightscale*0.00140))+leftmarge);
      end;
  end
  else setnonfinalsdigitposition;

end;
procedure TCountdownform.setnonfinalsdigitposition; //left right settings of digits depending on sec/min/etc notation
begin
      if seconds.Checked=true then     //horizontal position is different if minute notation is used because of extra dots_1.
      begin
        begin
          if (archerysystem<>'fitafin')or((archerysystem='fitafin') and (viewleft.Checked=true)) then
          begin
            if (zerosec.Checked=true)or(digit1_1.Visible=true) then
            begin
              digit1_1.Left:= (trunc (referencesize*0.02)+leftmarge);
              digit2_1.Left:= (trunc (referencesize*0.33)+leftmarge);
              digit3_1.Left:= (trunc (referencesize*0.64)+leftmarge);
            end
            else
            begin
              if (digit1_1.Visible=false) and digit2_1.Visible=true then
              begin
                digit2_1.Left:= (trunc (referencesize*0.18)+leftmarge);
                digit3_1.Left:= (trunc (referencesize*0.49)+leftmarge);

              end
              else digit3_1.Left:= (trunc (referencesize*0.33)+leftmarge);
            end;

          end;

          if ((archerysystem='fitafin') and (viewright.Checked=true)) then
          begin
            if (zerosec.Checked=true)or(digit1_2.Visible=true) then
            begin
              digit1_2.Left:= (trunc (referencesize*0.02)+leftmarge);
              digit2_2.Left:= (trunc (referencesize*0.33)+leftmarge);
              digit3_2.Left:= (trunc (referencesize*0.64)+leftmarge);
            end
            else
            begin
              if (digit1_2.Visible=false) and digit2_2.Visible=true then
              begin
                digit2_2.Left:= (trunc (referencesize*0.18)+leftmarge);
                digit3_2.Left:= (trunc (referencesize*0.49)+leftmarge);

              end
              else digit3_2.Left:= (trunc (referencesize*0.33)+leftmarge);

            end;
          end;
          dots_1.Visible:=false;
          dots_2.Visible:=false;
        end;
      end
      else
      begin
        if (archerysystem<>'fitafin')or((archerysystem='fitafin') and (viewleft.Checked=true)) then
        begin
          digit1_1.Left:= (trunc (referencesize*0.001)+leftmarge);
          dots_1.Left:= (trunc (referencesize*0.29)+leftmarge);
          digit2_1.Left:= (trunc (referencesize*0.38)+leftmarge);
          digit3_1.Left:= (trunc (referencesize*0.68)+leftmarge);
        end;
        if ((archerysystem='fitafin') and (viewright.Checked=true)) then
        begin
          digit1_2.Left:= (trunc (referencesize*0.001)+leftmarge);
          dots_2.Left:= (trunc (referencesize*0.29)+leftmarge);
          digit2_2.Left:= (trunc (referencesize*0.38)+leftmarge);
          digit3_2.Left:= (trunc (referencesize*0.68)+leftmarge);
        end;
      end;
end;

procedure TCountdownform.viewchangestateinact; // between state 5-6-1
begin

    if state = 5 then       //state 5 means the timer before start of match is running to show the audience how long it takes before the match starts
    begin
      if prelayoutradio1.Checked=true then
      begin
        beforestartbg.visible:=true;        //enable blue screen
        beforestarttxt2.visible:=true;
        beforestarttxt1.visible:=true;
      end
      else
      begin
        beforestartbg.visible:=false;
        beforestarttxt2.visible:=false;
        beforestarttxt1.visible:=false;
      end;
      digit1_3.visible:=true;            // show timer digits for timer before match start
      digit2_3.visible:=true;
      digit3_3.visible:=true;
      dots_3.visible:=true;             // This timer is always shown in minutes (not seconds

      digit1_1.visible:=false;
      digit2_1.visible:=false;
      digit3_1.visible:=false;
      dots_1.visible:=false;
      lamp_red_left_on_off:=1;           //trafic lights stay red because it is not aloud to shoot
      lamp_red_right_on_off:=1;
      lamp_orange_left_on_off:=0;
      lamp_orange_right_on_off:=0;
      lamp_green_left_on_off:=0;
      lamp_green_right_on_off:=0;
      archeryclock.visible:=false;
      //viewstateone;
      show_commercial.Enabled:=false;
      Countdownform.Color:=bgprecolor ;
    end
    else    //not state 5
    begin
      beforestartbg.visible:=false;        // disable blue screen
      beforestarttxt2.visible:=false;
      beforestarttxt1.visible:=false;
      digit1_3.visible:=false;
      digit2_3.visible:=false;
      digit3_3.visible:=false;
      dots_3.visible:=false;
      if ((archerysystem <> 'manual')and(archerysystem <> 'fitafin')and  not((archerysystem='follow')and(followsystem='4'))) then   // and  ((archerysystem<>'follow'))
      begin
        setleftclockdigits;
      end;
    end;

end;

procedure TCountdownform.viewarchsystemchange;     // for change of archery (sub) system
begin
    if ((archerysystem='fita') and (Shootoff=0) and (not(((state=1)or((state=6)and(Pause_emergency_RadioButton.Checked=false))) and (((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)) and (nrofbeeps=0))))or(((archerysystem='follow') and (Shootoff=0) and (not(((state=1)or((state=6))) and (((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)) and (nrofbeeps=0))))and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))) then
    begin             // depending on how many shooters per target (A-B-C-D) depends how many are visible on screen,
      if (Shooters>=2) and showABCD then Shooter1.Visible:=true else Shooter1.Visible:=false;    //if only 1 shooter, it is not needed to show "A"
      if (Shooters>=2) and showABCD then Shooter2.Visible:=true else Shooter2.Visible:=false;
      if (Shooters>=3) and showABCD then Shooter3.Visible:=true else Shooter3.Visible:=false;
      if (Shooters>=4) and showABCD then Shooter4.Visible:=true else Shooter4.Visible:=false;
      if (Shooters>=5) and showABCD then Shooter5.Visible:=true else Shooter5.Visible:=false;
      if (Shooters>=6) and showABCD then Shooter6.Visible:=true else Shooter6.Visible:=false;
      if (((shooter1.Caption='A') and (shooter1.Font.Color=shootercolor))or((shooter2.Caption='A') and (shooter2.Font.Color=shootercolor))) and (not showABCD) then
      begin
        TOPshooterlet.Visible:=false;
        TOPshootertxt.Visible:=false;
        BOTshooterlet.Visible:=true;
        BOTshootertxt.Visible:=true;
        RABCDtxt.Caption:=BOTshooterlet.Caption;
        LABCDtxt.Caption:=BOTshooterlet.Caption;
      end;
      if (((shooter1.Caption='B') and (shooter1.Font.Color=shootercolor))or((shooter2.Caption='B') and (shooter2.Font.Color=shootercolor))) and (not showABCD) then
      begin
        TOPshooterlet.Visible:=true;
        TOPshootertxt.Visible:=true;
        BOTshooterlet.Visible:=false;
        BOTshootertxt.Visible:=false;
        RABCDtxt.Caption:=TOPshooterlet.Caption;
        LABCDtxt.Caption:=TOPshooterlet.Caption;
      end;
    end
    else     //not fita, so ABCD invisible
    begin
      Shooter1.Visible:=false;
      Shooter2.Visible:=false;
      Shooter3.Visible:=false;
      Shooter4.Visible:=false;
      Shooter5.Visible:=false;
      Shooter6.Visible:=false;
      TOPshooterlet.Visible:=false;
      TOPshootertxt.Visible:=false;
      BOTshooterlet.Visible:=false;
      BOTshootertxt.Visible:=false;
    end;
    if ((archerysystem='25m1p') and (Shootoff=0)and (not(((state=1)or((state=6)and(Pause_emergency_RadioButton.Checked=false))) and (((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)) and (nrofbeeps=0) and ((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))))) or (((archerysystem='follow')and (Shootoff=0)and (not(((state=1)or((state=6))) and (nrofbeeps=0) and ((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)))))and(followsystem='3')) then
    begin
      shooteronearrownr.Visible:=true;
      shooteronearrow.Visible:=true;
    end
    else    //not 25m1p
    begin
      shooteronearrownr.Visible:=false;
      shooteronearrow.Visible:=false;
    end;
    if archerysystem<>'fitafin'then // set correct help labels
    begin
      tdown.hint:=prevarch;
      tup.hint:=nextarch;
    end
    else
    begin
      tdown.hint:=selectleft;
      tup.hint:=selectright;
    end;
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: the shooting system changed: lay out its panel
end;
procedure TCountdownform.changecolorscheme;

begin
  if colorscheme1.Checked=true then
  begin
    shootercolor:=clLime;
    nonshootercolor:=clGray;
    waitcolor:=clGray;
    redcolor:=clRed;
    orangecolor:=clYellow;
    greencolor:=clLime;
    bgwaitcolor:=clBlack;
    bgredcolor:=clBlack;
    bgorangecolor:=clBlack;
    bggreencolor:=clBlack;
    bgprecolor:=clBlack;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clred;
    sheetdatetime1label.Font.Color:=clYellow;
    sheetdatetime3label.Font.Color:=clLime;
    sheetdatetime4label.Font.Color:=clLime;
  end;
  if colorscheme2.Checked=true then
  begin
    shootercolor:=clGreen;
    nonshootercolor:=clGray;
    waitcolor:=clGray;
    redcolor:=clMaroon;
    orangecolor:=clOlive;
    greencolor:=clGreen;
    bgwaitcolor:=clWhite;
    bgredcolor:=clWhite;
    bgorangecolor:=clWhite;
    bggreencolor:=clWhite;
    bgprecolor:=clWhite;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clMaroon;
    sheetdatetime1label.Font.Color:=clOlive;
    sheetdatetime3label.Font.Color:=clGreen;
    sheetdatetime4label.Font.Color:=clGreen;
  end;
  if colorscheme3.Checked=true then
  begin
    shootercolor:=clLime;
    nonshootercolor:=clGray;
    waitcolor:=clWhite;
    redcolor:=clWhite;
    orangecolor:=clWhite;
    greencolor:=clWhite;
    bgwaitcolor:=clBlack;
    bgredcolor:=clBlack;
    bgorangecolor:=clBlack;
    bggreencolor:=clBlack;
    bgprecolor:=clBlack;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clred;
    sheetdatetime1label.Font.Color:=clYellow;
    sheetdatetime3label.Font.Color:=clLime;
    sheetdatetime4label.Font.Color:=clLime;
  end;
  if colorscheme4.Checked=true then
  begin
    shootercolor:=clLime;
    nonshootercolor:=clBlack;
    waitcolor:=clBlack;
    redcolor:=clBlack;
    orangecolor:=clBlack;
    greencolor:=clBlack;
    bgwaitcolor:=clWhite;
    bgredcolor:=clWhite;
    bgorangecolor:=clWhite;
    bggreencolor:=clWhite;
    bgprecolor:=clWhite;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clMaroon;
    sheetdatetime1label.Font.Color:=clOlive;
    sheetdatetime3label.Font.Color:=clGreen;
    sheetdatetime4label.Font.Color:=clGreen;
  end;
  if colorscheme5.Checked=true then
  begin
    shootercolor:=clLime;
    nonshootercolor:=clGray;
    waitcolor:=clGray;
    redcolor:=clRed;
    orangecolor:=clYellow;
    greencolor:=clLime;
    bgwaitcolor:=clBlack;
    bgredcolor:=clMaroon;
    bgorangecolor:=clOlive;
    bggreencolor:=clGreen;
    bgprecolor:=clNavy;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clred;
    sheetdatetime1label.Font.Color:=clYellow;
    sheetdatetime3label.Font.Color:=clLime;
    sheetdatetime4label.Font.Color:=clLime;
  end;
  if colorscheme6.Checked=true then
  begin
    shootercolor:=clGreen;
    nonshootercolor:=clGray;
    waitcolor:=clGray;
    redcolor:=clMaroon;
    orangecolor:=clOlive;
    greencolor:=clGreen;
    bgwaitcolor:=clWhite;
    bgredcolor:=clRed;
    bgorangecolor:=clYellow;
    bggreencolor:=clLime;
    bgprecolor:=clAqua;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clMaroon;
    sheetdatetime1label.Font.Color:=clOlive;
    sheetdatetime3label.Font.Color:=clGreen;
    sheetdatetime4label.Font.Color:=clGreen;
  end;
  if colorscheme7.Checked=true then
  begin
    shootercolor:=clLime;
    nonshootercolor:=clGray;
    waitcolor:=clWhite;
    redcolor:=clWhite;
    orangecolor:=clWhite;
    greencolor:=clWhite;
    bgwaitcolor:=clBlack;
    bgredcolor:=clMaroon;
    bgorangecolor:=clOlive;
    bggreencolor:=clGreen;
    bgprecolor:=clNavy;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clred;
    sheetdatetime1label.Font.Color:=clYellow;
    sheetdatetime3label.Font.Color:=clLime;
    sheetdatetime4label.Font.Color:=clLime;
  end;
  if colorscheme8.Checked=true then
  begin
    shootercolor:=clGreen;
    nonshootercolor:=clBlack;
    waitcolor:=clBlack;
    redcolor:=clBlack;
    orangecolor:=clBlack;
    greencolor:=clBlack;
    bgwaitcolor:=clWhite;
    bgredcolor:=clRed;
    bgorangecolor:=clYellow;
    bggreencolor:=clLime;
    bgprecolor:=clAqua;
    manualcolorpanel.Visible:=false;
    sheetdatetime2label.Font.Color:=clMaroon;
    sheetdatetime1label.Font.Color:=clOlive;
    sheetdatetime3label.Font.Color:=clGreen;
    sheetdatetime4label.Font.Color:=clGreen;
  end;
  if colorscheme9.Checked=true then
  begin
    shootercolor:=ABColListBoxtime.Selected;
    nonshootercolor:=CDColListBoxtime.Selected;
    waitcolor:=retrColListBoxtime.Selected;
    redcolor:=redColListBoxtime.Selected;
    orangecolor:=OrColListBoxtime.Selected;
    greencolor:=GrnColListBoxtime.Selected;
    bgwaitcolor:=retrColListBoxbg.Selected;
    bgredcolor:=RedColListBoxbg.Selected;
    bgorangecolor:=OrColListBoxbg.Selected;
    bggreencolor:=GrnColListBoxbg.Selected;
    bgprecolor:=PrepColListBoxbg.Selected;
    if SettingsTabs.ActivePage=screencolor then manualcolorpanel.Visible:=true;
    if bgwaitcolor=clRed then archeryclock.Font.Color:=clBlack else archeryclock.Font.Color:=clRed;
  end;
  if (state = 1) or (state = 6) then
  begin
    Countdownform.Color:=bgwaitcolor;
    digit1_1.Font.Color :=waitcolor;
    digit2_1.Font.Color :=waitcolor;
    digit3_1.Font.Color :=waitcolor;
    dots_1.Font.Color   :=waitcolor;
    digit1_2.Font.Color :=waitcolor;
    digit2_2.Font.Color :=waitcolor;
    digit3_2.Font.Color :=waitcolor;
    dots_2.Font.Color   :=waitcolor;
  end;
  if state = 2 then
  begin
    Countdownform.Color:=bgredcolor;
    digit1_1.Font.Color :=redcolor;
    digit2_1.Font.Color :=redcolor;
    digit3_1.Font.Color :=redcolor;
    dots_1.Font.Color   :=redcolor;
    digit1_2.Font.Color :=redcolor;
    digit2_2.Font.Color :=redcolor;
    digit3_2.Font.Color :=redcolor;
    dots_2.Font.Color   :=redcolor;
  end;
  if state = 3 then
  begin
    Countdownform.Color:=bggreencolor;
    digit1_1.Font.Color :=greencolor;
    digit2_1.Font.Color :=greencolor;
    digit3_1.Font.Color :=greencolor;
    dots_1.Font.Color   :=greencolor;
    digit1_2.Font.Color :=greencolor;
    digit2_2.Font.Color :=greencolor;
    digit3_2.Font.Color :=greencolor;
    dots_2.Font.Color   :=greencolor;
  end;
  if state = 4 then
  begin
    Countdownform.Color:=bgorangecolor;
    digit1_1.Font.Color :=orangecolor;
    digit2_1.Font.Color :=orangecolor;
    digit3_1.Font.Color :=orangecolor;
    dots_1.Font.Color   :=orangecolor;
    digit1_2.Font.Color :=orangecolor;
    digit2_2.Font.Color :=orangecolor;
    digit3_2.Font.Color :=orangecolor;
    dots_2.Font.Color   :=orangecolor;
  end;
  if state = 5 then
  begin
    Countdownform.Color:=bgprecolor ;
  end;
  shooteronearrownr.Font.Color:=shootercolor;
  TOPshooterlet.Font.Color:=shootercolor;
  BOTshooterlet.Font.Color:=shootercolor;
  leftstart.Font.Color:=shootercolor;
  rightstart.Font.Color:=shootercolor;
  archeryclock.Color:=bgwaitcolor;
  emergencytext.Color:=bgwaitcolor;
  viewturnchange;
end;

procedure TCountdownform.timevssheet;
begin
  if (imagecount=-1) and (Actualtimecheckbox.Checked=true) then
  begin
    background1.Visible:=false;
    sheetdatetime1label.Visible:=true;
    sheetdatetime2label.Visible:=true;
    sheetdatetime3label.Visible:=true;
    sheetdatetime4label.Visible:=true;
    if (archerysystem='fitafin')or ((archerysystem='follow') and (followsystem='2')) then
    begin
      archeryclock.top:=(trunc (referencesize*0.19)+topmarge);    //(trunc (referencesize*0.02)+topmarge);
      bannerpicture.Visible:=false;
    end
    else
    begin
      archeryclock.top:=(trunc (referencesize*0.21)+topmarge);
      bannerpicture.Visible:=true;
    end;
    sheetdatetime1label.top:=(trunc (referencesize*0.25)+topmarge);
    sheetdatetime2label.top:=(trunc (referencesize*0.03)+topmarge);
    sheetdatetime3label.top:=(trunc (referencesize*0.38)+topmarge);
    sheetdatetime4label.top:=(trunc (referencesize*0.49)+topmarge);
  end
  else
  begin
    background1.Visible:=true;
    sheetdatetime1label.Visible:=false;
    sheetdatetime2label.Visible:=false;
    sheetdatetime3label.Visible:=false;
    sheetdatetime4label.Visible:=false;
    bannerpicture.Visible:=false;
    if (archerysystem='fitafin')or ((archerysystem='follow') and (followsystem='2')) then
    begin
      archeryclock.top:=0
    end
    else
    begin
      archeryclock.top:=Countdownform.height-iconsize-(trunc (referencesize*0.065));
    end;
  end;
end;

procedure TCountdownform.viewstateone; //State one is depending on yes or no commercialview
begin
  if ((((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)) and (((((state=1)and(((archerysystem<>'fitafin')and not((archerysystem='follow')and(followsystem='2')))or((archerysystem='fitafin')and(fitafinarcher='none'))or((archerysystem='follow')and(followsystem='2')and not(followright or followleft))   ))or((state=6)and(Pause_emergency_RadioButton.Checked=false))) and (nrofbeeps=0))or((archerysystem='follow') and (followsystem='4'))))  then
  begin
    Shooter1.Visible:=false;
    Shooter2.Visible:=false;
    Shooter3.Visible:=false;
    Shooter4.Visible:=false;
    Shooter5.Visible:=false;
    Shooter6.Visible:=false;
    TOPshooterlet.Visible:=false;
    BOTshooterlet.Visible:=false;
    TOPshootertxt.Visible:=false;
    BOTshootertxt.Visible:=false;
    digit1_1.Visible:=false;
    digit2_1.Visible:=false;
    digit3_1.Visible:=false;
    digit1_2.Visible:=false;
    digit2_2.Visible:=false;
    digit3_2.Visible:=false;
    arrowlabel.Visible:=false;
    serielabel.Visible:=false;
    turnlabel.Visible:=false;
    Practise.Visible:=false;
    serienr.Visible:=false;
    shooternr.Visible:=false;
    dots_1.Visible:=false;
    dots_2.Visible:=false;
    shooteronearrownr.Visible:=false;
    shooteronearrow.Visible:=false;
    if TLleft.Checked=true then
    begin
      Rnextturnbg.visible:=false;
      if ((archerysystem='fita')and (Shooters<>1)) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))and (Shooters<>1))then Lnexttxt.visible:=true else Lnexttxt.visible:=false;              //or(followsystem='2')
      if (archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))  then  Larchertxt.visible:=true else Larchertxt.visible:=false;
      Rnexttxt.visible:=false;
      Rarchertxt.visible:=false;
      if ((archerysystem<>'manual')and ((archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))or((archerysystem='fita')) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))) then            //or(followsystem='2')
      begin
        if (showendnrcheckbox.Checked=true) then
        begin
          LENDtxt.Visible:=true;
          LTRNtxt.Visible:=true;
          L_EndBG.Visible:=true;
        end
        else
        begin
          LENDtxt.Visible:=false;
          LTRNtxt.Visible:=false;
          L_EndBG.Visible:=false;
        end;
        if ((archerysystem='25m1p')or((archerysystem='fita')and (Shooters<>1)) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))and (Shooters<>1)))then
        begin
          LABCDtxt.Visible:=true;
          Lnextturnbg.visible:=true;
        end
        else
        begin
          LABCDtxt.Visible:=false;
          Lnextturnbg.visible:=false;
        end;
      end
      else
      begin
        LABCDtxt.Visible:=false;
        LENDtxt.Visible:=false;
        L_EndBG.Visible:=false;
        LTRNtxt.Visible:=false;
        Lnextturnbg.visible:=false;
      end;
      RABCDtxt.Visible:=false;
      RENDtxt.Visible:=false;
      R_EndBG.Visible:=false;
      RTRNtxt.Visible:=false;
    end
    else
    begin
      Lnextturnbg.visible:=false;
      Lnexttxt.visible:=false;
      Larchertxt.visible:=false;
      if ((archerysystem='fita')and (Shooters<>1)) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))and (Shooters<>1))then Rnexttxt.visible:=true else Rnexttxt.visible:=false;    //or(followsystem='2')
      if (archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))  then  Rarchertxt.visible:=true else Rarchertxt.visible:=false;
      if (archerysystem<>'manual') and ((archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))or((archerysystem='fita')) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7')))) then       //or(followsystem='2')
      begin
        if (showendnrcheckbox.Checked=true) then
        begin
          RENDtxt.Visible:=true;
          R_EndBG.Visible:=true;
          RTRNtxt.Visible:=true;
        end
        else
        begin
          RENDtxt.Visible:=false;
          R_EndBG.Visible:=false;
          RTRNtxt.Visible:=false;
        end;
        if ((archerysystem='25m1p')or((archerysystem='fita')and (Shooters<>1)) or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))and (Shooters<>1)))then
        begin
          RABCDtxt.Visible:=true;
          Rnextturnbg.visible:=true;
        end
        else
        begin
          RABCDtxt.Visible:=false;
          Rnextturnbg.visible:=false;
        end;
      end
      else
      begin
        RABCDtxt.Visible:=false;
        RENDtxt.Visible:=false;
        R_EndBG.Visible:=false;
        RTRNtxt.Visible:=false;
        Rnextturnbg.visible:=false;
      end;
      LABCDtxt.Visible:=false;
      LENDtxt.Visible:=false;
      L_EndBG.Visible:=false;
      LTRNtxt.Visible:=false;

    end;
    timevssheet;
    if archeryclock.Visible=false then archeryclock.Visible:=true;
    archeryclock.Transparent:=true;
    if (archerysystem='fitafin')or ((archerysystem='follow') and (followsystem='2')) then
    begin
      greenleft.top:=Countdownform.Height-iconsize-greenleft.Height;
      greyleft.top:=Countdownform.Height-iconsize-greyleft.Height;
      greenright.top:=Countdownform.Height-iconsize-greenright.Height;
      greyright.top:=Countdownform.Height-iconsize-greyright.Height;
      serienr.Top:=Countdownform.Height-iconsize; //-serienr.Height;
      finalchoose.top:=Countdownform.Height-iconsize-iconsize-(finalchoose.Height); //-(serienr.Height div 2);
      leftstart.top:=Countdownform.Height-iconsize-leftstart.Height;
      rightstart.top:=Countdownform.Height-iconsize-rightstart.Height;
    end;
    backgroundtimer.Enabled:=true;
  end
  else
  begin
    if ((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) and (state=2) then viewarchsystemchange;
    Lnextturnbg.visible:=false;
    Rnextturnbg.visible:=false;
    Lnexttxt.visible:=false;
    Rnexttxt.visible:=false;
    Larchertxt.Visible:=false;
    Rarchertxt.Visible:=false;
    LABCDtxt.Visible:=false;
    RABCDtxt.Visible:=false;
    LENDtxt.Visible:=false;
    L_EndBG.Visible:=false;
    RENDtxt.Visible:=false;
    R_EndBG.Visible:=false;
    LTRNtxt.Visible:=false;
    RTRNtxt.Visible:=false;
    if (archerysystem='fitafin')or ((archerysystem='follow') and (followsystem='2')) then archeryclock.top:=(trunc (referencesize*0.02)+topmarge) else archeryclock.top:=(trunc (referencesize*0.19)+topmarge);
    if (archerysystem='fitafin')or ((archerysystem='follow') and (followsystem='2')) then
    begin
      greenleft.top:=(trunc (referencesize*0.45)+topmarge);
      greyleft.top:=(trunc (referencesize*0.45)+topmarge);
      greenright.top:=(trunc (referencesize*0.45)+topmarge);
      greyright.top:=(trunc (referencesize*0.45)+topmarge);
      serienr.Top:=(trunc (referencesize*0.4)+topmarge);
      finalchoose.top:=(trunc (referencesize*0.58)+topmarge);
     leftstart.top:=(trunc (referencesize*0.58)+topmarge);
     rightstart.top:=(trunc (referencesize*0.58)+topmarge);
    end;

    background1.Visible:=false;
    sheetdatetime1label.Visible:=false;
    sheetdatetime2label.Visible:=false;
    sheetdatetime3label.Visible:=false;
    sheetdatetime4label.Visible:=false;

    bannerpicture.Visible:=true;
    if (not(archerysystem<>'fitafin'))and(not((archerysystem='fitafin') and (fitafinarcher<>'none')))and (not((archerysystem='follow') and (followsystem='2')and((followright or followleft)))) then   archeryclock.visible:=true;
    archeryclock.Transparent:=false;
    backgroundtimer.Enabled:=false;
  end;
  midbartop;
  actualtimerstatus;
end;

procedure TCountdownform.viewchangestateexchange; //between active to inactive
begin
  if (archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))  then
  begin
    if state <> 5 then
    begin
      setleftclockdigits;
    end;
  end;
  if (archerysystem='fita') or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7')or(followsystem='2')))then
  begin
    if state <> 5 then
    begin
      setleftclockdigits;
    end;
  end;

  if (archerysystem='fitafin') then
  begin

    if finarrow.Checked=true then
    begin
      setleftclockdigits;
      setrightclockdigits;
    end;

    if viewleft.Checked=true then
    begin
      setleftclockdigits;
      digit1_2.Visible:=false;
      digit2_2.Visible:=false;
      digit3_2.Visible:=false;
      dots_2.visible:=false;
    end;
    if viewright.Checked=true then
    begin
      digit1_1.Visible:=false;
      digit2_1.Visible:=false;
      digit3_1.Visible:=false;
      dots_1.visible:=false;
      setrightclockdigits;
      dots_1.visible:=false;
    end;
    if showtarget.checked=true then        //depending on checkbox the target numbers are shown on the screen
    begin
      lefttarget.Visible:=true;
      lefttarget.Caption:=CurrToStr(leftnumber.Value);
      righttarget.Visible:=true;
      righttarget.Caption:=CurrToStr(rightnumber.Value);
    end
    else
    begin
      lefttarget.Visible:=false;
      righttarget.Visible:=false;
    end;
  end
  else               //not Fita finals
  begin
    digit1_2.Visible:=false;      //only one timer used, so second one invisible
    digit2_2.Visible:=false;
    digit3_2.Visible:=false;
    dots_2.visible:=false;
    lefttarget.Visible:=false;
    righttarget.Visible:=false;
  end;
  if (state = 1) or (state = 6) then    //state is 1 means waiting state
  begin
    if  (archerysystem<>'fitafin') and (archerysystem<>'manual') then
    begin
      if (archerysystem<>'follow') and (state<>6)  then
      begin
        countdowntostart.Visible:=true;       //Only during waiting state the countdowntostart text (next to icon is vissible. In other situations it is not possible to start the countdown to start timer
        preptime.Visible:=true;               //Only during waiting state the countdowntostart icon is vissible. In other situations it is not possible to start the countdown to start timer
        starttocd.Enabled:=true;               //Only during waiting state the start countdowntostart button in the munu is vissible. In other situations it is not possible to start the countdown to start timer
      end
      else
      begin
        countdowntostart.Visible:=false;
        preptime.Visible:=false;
        starttocd.Enabled:=false;
      end;
      digit1_1.Font.Color:=waitcolor;      // during waiting state the font of the timers are waitingcolor
      dots_1.Font.Color:=waitcolor;
      digit2_1.Font.Color:=waitcolor;
      digit3_1.Font.Color:=waitcolor;

      digit1_2.Font.Color:=waitcolor;
      dots_2.Font.Color:=waitcolor;
      digit2_2.Font.Color:=waitcolor;
      digit3_2.Font.Color:=waitcolor;
      Countdownform.Color:=bgwaitcolor;

      if redlighton=true then lamp_red_left_on_off:=1 else lamp_red_left_on_off:=0;               //During waiting state, the trafic lights (HW) are red
      if redlighton=true then lamp_red_right_on_off:=1 else lamp_red_right_on_off:=0;
      lamp_orange_left_on_off:=0;
      lamp_orange_right_on_off:=0;
      lamp_green_left_on_off:=0;
      lamp_green_right_on_off:=0;
    end
    else         //fita finals
    begin
      countdowntostart.Visible:=false;
      preptime.Visible:=false;
      starttocd.Enabled:=false;
      if redlighton=true then lamp_red_left_on_off:=1 else lamp_red_left_on_off:=0;                  //During waiting state, the trafic lights (HW) are red
      lamp_orange_left_on_off:=0;
      lamp_green_left_on_off:=0;
      if redlighton=true then lamp_red_right_on_off:=1 else lamp_red_right_on_off:=0;
      lamp_orange_right_on_off:=0;
      lamp_green_right_on_off:=0;
      if fitafinarcher='none' then               //if not defined yet which archer starts. left and right timer Font are red
      begin
        if finarrow.Checked=true then
        begin
          digit1_1.Font.Color:=redcolor;
          dots_1.Font.Color:=redcolor;
          digit2_1.Font.Color:=redcolor;
          digit3_1.Font.Color:=redcolor;

          digit1_2.Font.Color:=redcolor;
          dots_2.Font.Color:=redcolor;
          digit2_2.Font.Color:=redcolor;
          digit3_2.Font.Color:=redcolor;
          Countdownform.Color:=bgwaitcolor;
        end
        else
        begin
          digit1_1.Font.Color:=waitcolor;
          dots_1.Font.Color:=waitcolor;
          digit2_1.Font.Color:=waitcolor;
          digit3_1.Font.Color:=waitcolor;

          digit1_2.Font.Color:=waitcolor;
          dots_2.Font.Color:=waitcolor;
          digit2_2.Font.Color:=waitcolor;
          digit3_2.Font.Color:=waitcolor;
          Countdownform.Color:=bgwaitcolor;
        end;
      end;
      if fitafinarcher='left' then              //if left archer starts, right archer get red font color, Left archer get wait color
      begin
        digit1_1.Font.Color:=waitcolor;
        dots_1.Font.Color:=waitcolor;
        digit2_1.Font.Color:=waitcolor;
        digit3_1.Font.Color:=waitcolor;
        if finarrow.Checked=true then
        begin
          digit1_2.Font.Color:=redcolor;
          dots_2.Font.Color:=redcolor;
          digit2_2.Font.Color:=redcolor;
          digit3_2.Font.Color:=redcolor;
          Countdownform.Color:=bgredcolor;
        end
        else
        begin
          digit1_2.Font.Color:=waitcolor;
          dots_2.Font.Color:=waitcolor;
          digit2_2.Font.Color:=waitcolor;
          digit3_2.Font.Color:=waitcolor;
          Countdownform.Color:=bgredcolor;
        end;
      end;
      if fitafinarcher='right' then             //if right archer starts, left archer get red font color, right archer get wait color
      begin
        if finarrow.Checked=true then
        begin
          digit1_1.Font.Color:=redcolor;
          dots_1.Font.Color:=redcolor;
          digit2_1.Font.Color:=redcolor;
          digit3_1.Font.Color:=redcolor;
          Countdownform.Color:=bgredcolor;
        end
        else
        begin
          digit1_1.Font.Color:=waitcolor;
          dots_1.Font.Color:=waitcolor;
          digit2_1.Font.Color:=waitcolor;
          digit3_1.Font.Color:=waitcolor;
          Countdownform.Color:=bgredcolor;
        end;
        digit1_2.Font.Color:=waitcolor;
        dots_2.Font.Color:=waitcolor;
        digit2_2.Font.Color:=waitcolor;
        digit3_2.Font.Color:=waitcolor;
      end;
    end;
    If state <> 6 then
    begin
      if show_commercial.Enabled=false then
      begin
        labelnr:=15;
        archeryclock.caption:='www.archeryclock.com';
      end;
      if (not((archerysystem='fitafin') and (fitafinarcher<>'none')))and (not((archerysystem='follow') and (followsystem='2')and(not(followright or followleft)))) then   archeryclock.visible:=true;  //show label because timing is in between ends
      archeryclock.Color:=bgwaitcolor;
      show_commercial.Enabled:=true; //start timer to change text in label
    end;
  end
  else   //state is not 1  (not wait state)
  begin
    countdowntostart.Visible:=false;        //Only during waiting state the countdowntostart text (next to icon is vissible. In other situations it is not possible to start the countdown to start timer
    preptime.Visible:=false;                //Only during waiting state the countdowntostart icon is vissible. In other situations it is not possible to start the countdown to start timer
    starttocd.Enabled:=false;               //Only during waiting state the start countdowntostart button in the munu is vissible. In other situations it is not possible to start the countdown to start timer
    if archeryclock.visible=true then
    begin
      archeryclock.visible:=false;
      show_commercial.Enabled:=false;
    end;

  end;

  //set the correct hint on next button depending on state
  if (state=1) or (state=5) then
  begin
    nexticon.Hint:= NXTstart;
    nexthelp.Caption:= Mainhint1;
  end;

end;


procedure TCountdownform.viewchangmenuitems;
begin
  if (archerysystem='fitafin') and (Shootoff=0) then
  begin
    if (state=1) then  finalchoose.Visible:=true else finalchoose.Visible:=false;
  end
  else
  begin
    finalchoose.Visible:=false;
  end;

  countdowntostart.Caption:=(CurrToStr(tostart.value)+ ' '+Minabr);   //show the correct number of minutes next to countdownbefore start icon. Number is in the settings menu

end;
procedure TCountdownform.viewicons;     //make icons and labels visible/invisible
begin
  if archerysystem<>'follow' then
  begin
    //state is 1 means waiting state. so no reason to show pause icon, nothing to pause
    if ((state=1) or (state=6) or  (archerysystem='manual')) then playpauzeicon.visible:=false else
    begin           //depending on the "hide icons" checkbox, the pause button needs to visible if not in wait state
      if hideicons.checked=false then playpauzeicon.visible:=true else playpauzeicon.visible:=false;
    end;
  end;
  if archerysystem='follow'then
  begin
    SOicon.visible:=false;

  end;
  if (archerysystem='manual') or ((archerysystem='follow') and (followsystem='4'))then
  begin
    serienr.visible:=false;
    SOicon.visible:=false;
    digit1_1.Visible:=false;
    digit2_1.Visible:=false;
    digit3_1.Visible:=false;
    dots_1.Visible:=false;
    serielabel.visible:=false;
    arrowlabel.Visible:=false;

    turnlabel.visible:=false;
    shooternr.Visible:=false;
  end
  else
  begin
    serienr.visible:=true;
    if archerysystem<>'fitafin' then if Practiseturn=1 then practise.Visible:=true else practise.Visible:=false;
  end;
  if (archerysystem='25m1p') or ((archerysystem='follow') and (followsystem='3'))  then
  begin
    serienr.visible:=true;
    if Practiseturn=1 then practise.Visible:=true else practise.Visible:=false;
    serielabel.Visible:=false;                                         //25m1p is per arrow, not per end. --> serie label invisible
    if hideicons.checked=false then  arrowlabel.Visible:=true else arrowlabel.Visible:=false;       //arrow lable visible ( depending on "hide icons" checkbox)
    turnlabel.visible:=false;
    if  ((rotate25m1p.Checked=false) or (rotate25m1p_p.Checked=false)) then shooternr.Visible:=true else shooternr.Visible:=false;
    if (FirstTimer.enabled=true) or (state<>1) or (archerysystem='follow') then SOicon.visible:=false else SOicon.visible:=true ;  //Shoot off (SO) can only be started during wait state, not when the timer is running. If SO can not be selected, the icon should be invisible
  end;
  if (archerysystem='fita') or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7')or(followsystem='2')))then
  begin
    arrowlabel.Visible:=false;      //fita is per end, not per arrow. Arrow label is invisible
    if hideicons.checked=false then
    begin
      if not((archerysystem='follow') and (followsystem='2'))then
      begin
        serielabel.Visible:=true;
        turnlabel.visible:=true;
        shooternr.Visible:=true;

      end;
    end;
    if (FirstTimer.enabled=true)  or (state<>1) or (archerysystem='follow')   then SOicon.visible:=false else SOicon.visible:=true ;  //Shoot off (SO) can only be started during wait state, not when the timer is running. If SO can not be selected, the icon should be invisible
  end;
  if (archerysystem='fitafin') or ((archerysystem='follow') and (followsystem='2')) then
  begin
    if ((FirstTimer.enabled=true)or(SecondTimer.enabled=true))  or (state<>1) or (archerysystem='follow')   then SOicon.visible:=false else SOicon.visible:=true ;  //Shoot off (SO) can only be started during wait state, not when the timer is running. If SO can not be selected, the icon should be invisible
    serienr.visible:=true;
    arrowlabel.Visible:=false;
    serielabel.Visible:=false;
    turnlabel.visible:=false;
    shooternr.Visible:=false;
  end;
  if CardAddr=0 then   //only if k8055 is used, the option to choose BCD lights is visible because K8055 has only 8 outputs. So it is not possible to stear 6 trafic lights and 4 ABSD signs. And ABCD is not used during final rounds
  begin
    BCDtoROG2.Visible:=true;
    BCDtoROG2label.Visible:=true;
  end
  else
  begin
    BCDtoROG2.Visible:=false;
    BCDtoROG2label.Visible:=false;
  end;


end;

procedure TCountdownform.viewactivate;   // view Items that need to be activated / deactivated depending on circumstances
begin
  if ((FirstTimer.enabled=true) or (secondTimer.enabled=true) or (manualfollowmenuremove=true) ) and ((timeseqpanel.visible=true)or(savesettings.visible=true))then
  begin                                      //if menu's  visible, start delay timer to remove menu's after timeout.
    menuremovedelay.enabled:=true;           //menuremovetimer takes care that the menu is removed after a the time specified
  end;
  if ((FirstTimer.enabled=false) and (secondTimer.enabled=false) and (manualfollowmenuremove=false) ) then
  begin                                      //when timers stop running (for example when pause is selected) there is ne need anymore to remove the menus.
    menuremovedelay.enabled:=false;          //--> menuremove timer is stopped
  end;

  if archerysystem<>'follow' then
  begin
    if state<>5 then
    begin
      if seconds.Checked=true then               //time shown in seconds is selected. (not in minutes)
      begin
        digit3_1.caption:=CurrToStr(countdowntimer mod 10);                 //rightside digit is showing what is left after deviding by 10 --> asume timer is 123, than right digit is 3
        digit2_1.caption:=CurrToStr((countdowntimer mod 100)div 10);        //middle digit is showing what is left after dividing by 100, this is divided by 10. --> asume timer is 123 than middle digit is 2
        digit1_1.caption:=CurrToStr((countdowntimer mod 1000)div 100);      //leftside digit is showing what is left after dividing by 1000, this is divided by 100. --asume timer is 123 than left digit is 1
        digit3_2.caption:=CurrToStr(countdowntimer2 mod 10);                //rightside digit is showing what is left after deviding by 10 --> asume timer is 123, than right digit is 3
        digit2_2.caption:=CurrToStr((countdowntimer2 mod 100)div 10);       //middle digit is showing what is left after dividing by 100, this is divided by 10. --> asume timer is 123 than middle digit is 2
        digit1_2.caption:=CurrToStr((countdowntimer2 mod 1000)div 100);     //leftside digit is showing what is left after dividing by 1000, this is divided by 100. --asume timer is 123 than left digit is 1
      end
      else
      begin                                      //time shown in minutes is selected. (not in seconds)
        digit3_1.caption:=CurrToStr(countdowntimer mod 10);                //rightside digit is showing what is left after deviding by 10 --> asume timer is 123, which means 2:03 minutes. than right digit is 3
        digit2_1.caption:=CurrToStr((countdowntimer mod 60)div 10);        //middle digit is showing what is left after dividing by 60, this is divided by 10. --> asume timer is 123, which means 2:03 minutes. than middle digit is 0
        digit1_1.caption:=CurrToStr((countdowntimer mod 600) div 60);      //leftside digit is showing what is left after dividing by 600, this is divided by 60. --> asume timer is 123, which means 2:03 minutes. than left digit is 2

        digit3_2.caption:=CurrToStr(countdowntimer2 mod 10);               //rightside digit is showing what is left after deviding by 10 --> asume timer is 123, which means 2:03 minutes. than right digit is 3
        digit2_2.caption:=CurrToStr((countdowntimer2 mod 60)div 10);       //middle digit is showing what is left after dividing by 60, this is divided by 10. --> asume timer is 123, which means 2:03 minutes. than middle digit is 0
        digit1_2.caption:=CurrToStr((countdowntimer2 mod 600) div 60);     //leftside digit is showing what is left after dividing by 600, this is divided by 60. --> asume timer is 123, which means 2:03 minutes. than left digit is 2
      end;
      setleftclockdigits;
      setrightclockdigits;
    end
    else
    begin
      //following digits are used before start of the match (countdown to start of match) This is always in minutes
      digit3_3.caption:=CurrToStr(countdowntimer mod 10);                  //rightside digit is showing what is left after deviding by 10 --> asume timer is 123, which means 2:03 minutes. than right digit is 3
      digit2_3.caption:=CurrToStr((countdowntimer mod 60)div 10);          //middle digit is showing what is left after dividing by 60, this is divided by 10. --> asume timer is 123, which means 2:03 minutes. than middle digit is 0
      digit1_3.caption:=CurrToStr((countdowntimer ) div 60);        //leftside digit is showing what is left after dividing by 600, this is divided by 60. --> asume timer is 123, which means 2:03 minutes. than left digit is 2
      if ((countdowntimer =597) or (countdowntimer =599) or (countdowntimer =598)) then  resizewindowpreclock;
    end;
  end;
  switchbox;
end;

procedure TCountdownform.viewfinupdate;
begin

  if (archerysystem='fitafin')  then  //and (Shootoff=0)
  begin

    leftstart.Visible:=true;
    rightstart.Visible:=true;

    if fitafinarcher = 'none' then   //not selected which archer is (starting) shooting
    begin
      //arrows are grey if selection left or right is not done. Choose button is red
      greenleft.Visible:=false;
      greenright.Visible:=false;
      greyleft.Visible:=true;
      greyright.Visible:=true;

      //finalchoose.Visible:=true;
      finalchoose.Color:=cllime;
      righttarget.Font.Color:=nonshootercolor;
      lefttarget.Font.Color:=nonshootercolor;
    end;
    if fitafinarcher = 'left' then   //left archer selected as (starting) shooting
    begin
      //left arrow is green, right arrow is grey. if left side is selected. Choose button is grey
      greenleft.Visible:=true;
      greenright.Visible:=false;
      greyleft.Visible:=false;
      greyright.Visible:=true;
      //finalchoose.Visible:=true;
      finalchoose.Color:=clgray;
      righttarget.Font.Color:=nonshootercolor;
      lefttarget.Font.Color:=shootercolor;

    end;
    if fitafinarcher = 'right' then       //right archer selected as (starting) shooting
    begin
      //right arrow is green, left arrow is grey. if right side is selected. Choose button is grey
      greenleft.Visible:=false;
      greenright.Visible:=true;
      greyleft.Visible:=true;
      greyright.Visible:=false;
      //finalchoose.Visible:=true;
      finalchoose.Color:=clgray;
      righttarget.Font.Color:=shootercolor;
      lefttarget.Font.Color:=nonshootercolor;

    end;
    if fitafinstartarcher='right' then
    begin
      //update text and color of primary and secundary
      rightstart.font.Color:=shootercolor;
      rightstart.Caption:=primarytext;
      leftstart.font.Color:=nonshootercolor;
      leftstart.caption:=secondarytext;
    end;
    if fitafinstartarcher='left' then
    begin
      //update text and color of primary and secundary
      rightstart.font.Color:=nonshootercolor;
      rightstart.Caption:=secondarytext;
      leftstart.font.Color:=shootercolor;
      leftstart.caption:=primarytext;
    end;

    if fitafinstartarcher='none' then         //not selected which archer is (starting) shooting
    begin
      //update text and color of primary and secundary
      rightstart.font.Color:=nonshootercolor;
      rightstart.Caption:='--';
      leftstart.font.Color:=nonshootercolor;
      leftstart.caption:='--';
    end;
  end
  else    //not fita finals
  begin //arrows etc, specially for final rounds are invisible during nonFinal rounds
    if not((archerysystem='follow') and (followsystem='2')) then
    begin
    leftstart.Visible:=false;
    rightstart.Visible:=false;
    greenleft.Visible:=false;
    greenright.Visible:=false;
    greyleft.Visible:=false;
    greyright.Visible:=false;
    finalchoose.Visible:=false;

    end;

  end;

end;
procedure TCountdownform.viewturnchange;
begin
  serienr.Caption:=CurrToStr(serienumber);                                    //show correct end number in the label
  if (not ((state=1)and(((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)))) or ((largeimagecheckbox.Checked=false)and(Actualtimecheckbox.Checked=false)) then
  begin
    if Practiseturn=1 then practise.Visible:=true else practise.Visible:=false; //show indication if it is a practise end or not
  end;

  shooternr.Caption:=CurrToStr(turnnumber);                                   //show turn number in label
  if (((rotate25m1p.Checked=false) and (Practiseturn=0))or((rotate25m1p_p.Checked=false)and (Practiseturn=1))) then
  begin
    shooteronearrownr.Caption:=CurrToStr(((turnnumber+((serienumber-1) mod nrof1pshooters.Value)-1)mod nrof1pshooters.Value)+1);
    LABCDtxt.Caption:=shooteronearrownr.Caption;
    RABCDtxt.Caption:=shooteronearrownr.Caption;
  end
  else
  begin
    shooteronearrownr.Caption:=CurrToStr(turnnumber);
    LABCDtxt.Caption:=shooteronearrownr.Caption;
    RABCDtxt.Caption:=shooteronearrownr.Caption;

  end;


  //set the correct colors for shooters (ABCD) depending on the turn number
  if Practiseturn=1 then RENDtxt.Caption:=practise.Caption+serienr.Caption else RENDtxt.Caption:=serienr.Caption ;
  LENDtxt.Caption:=RENDtxt.Caption;
  LTRNtxt.caption:='('+shooternr.Caption+')';
  RTRNtxt.caption:='('+shooternr.Caption+')';

  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter1.Font.Color:=shootercolor else shooter1.Font.Color:=nonshootercolor;
  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter2.Font.Color:=shootercolor else shooter2.Font.Color:=nonshootercolor;
  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 3)  then shooter3.Font.Color:=shootercolor else shooter3.Font.Color:=nonshootercolor;
  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 4)  then shooter4.Font.Color:=shootercolor else shooter4.Font.Color:=nonshootercolor;
  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 5)  then shooter5.Font.Color:=shootercolor else shooter5.Font.Color:=nonshootercolor;
  if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 6)  then shooter6.Font.Color:=shootercolor else shooter6.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter1.Font.Color:=shootercolor else shooter1.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter2.Font.Color:=shootercolor else shooter2.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter3.Font.Color:=shootercolor else shooter3.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter4.Font.Color:=shootercolor else shooter4.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 3)  then shooter5.Font.Color:=shootercolor else shooter5.Font.Color:=nonshootercolor;
  if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 3)  then shooter6.Font.Color:=shootercolor else shooter6.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter1.Font.Color:=shootercolor else shooter1.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter2.Font.Color:=shootercolor else shooter2.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter3.Font.Color:=shootercolor else shooter3.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter4.Font.Color:=shootercolor else shooter4.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter5.Font.Color:=shootercolor else shooter5.Font.Color:=nonshootercolor;
  if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter6.Font.Color:=shootercolor else shooter6.Font.Color:=nonshootercolor;

  //set A, B, C or D on the correct shooters. depending on archers per target etc.
  if (archerysystem='follow')  then
  if((followsystem='2')) then
  begin
    if followleft then
    begin
      greenleft.visible:=true;
      greyleft.visible:=false;
    end
    else
    begin
      greenleft.visible:=false;
      greyleft.visible:=true;
    end;
    if followright then
    begin
      greenright.visible:=true;
      greyright.visible:=false;
    end
    else
    begin
      greenright.visible:=false;
      greyright.visible:=true;
    end;
  end
  else
  begin
    greyleft.visible:=false;
    greyright.visible:=false;
    greenleft.visible:=false;
    greenright.visible:=false;
  end;
  if (archerysystem='fita') or ((archerysystem='follow') and ((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7')))then
  begin
    if showABCD then
    begin
      TOPshooterlet.Visible:=false;
      TOPshootertxt.Visible:=false;
      BOTshooterlet.Visible:=false;
      BOTshootertxt.Visible:=false;
    end;
    if  (Archersperturn=3) and (Turnsperserie=2) then
    begin
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true)  then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
        shooter5.Caption:='E';
        shooter6.Caption:='F';
      end;
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='D';
        shooter2.Caption:='E';
        shooter3.Caption:='F';
        shooter4.Caption:='A';
        shooter5.Caption:='B';
        shooter6.Caption:='C';
      end;
    end;
    if  (Archersperturn=2) and (Turnsperserie=2) then
    begin
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true)  then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
      end;
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='D';
        shooter3.Caption:='A';
        shooter4.Caption:='B';
      end;
    end;
    if  (Archersperturn=2) and (Turnsperserie=3) then
    begin
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true)  then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
        shooter5.Caption:='E';
        shooter6.Caption:='F';
      end;
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 2) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='E';
        shooter2.Caption:='F';
        shooter3.Caption:='A';
        shooter4.Caption:='B';
        shooter5.Caption:='C';
        shooter6.Caption:='D';
      end;
      if  (((((((serienumber+nrofturns-1)div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value)  mod Turnsperserie) = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='D';
        shooter3.Caption:='E';
        shooter4.Caption:='F';
        shooter5.Caption:='A';
        shooter6.Caption:='B';
      end;
    end;
    if  (Archersperturn=1) and (Turnsperserie=5) then
    begin
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true) then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
        shooter5.Caption:='E';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 2)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='E';
        shooter2.Caption:='A';
        shooter3.Caption:='B';
        shooter4.Caption:='C';
        shooter5.Caption:='D';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 3)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='D';
        shooter2.Caption:='E';
        shooter3.Caption:='A';
        shooter4.Caption:='B';
        shooter5.Caption:='C';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 4)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='D';
        shooter3.Caption:='E';
        shooter4.Caption:='A';
        shooter5.Caption:='B';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='B';
        shooter2.Caption:='C';
        shooter3.Caption:='D';
        shooter4.Caption:='E';
        shooter5.Caption:='A';
      end;
    end;
    if  (Archersperturn=1) and (Turnsperserie=6) then
    begin
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true) then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
        shooter5.Caption:='E';
        shooter6.Caption:='F';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 2)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='F';
        shooter2.Caption:='A';
        shooter3.Caption:='B';
        shooter4.Caption:='C';
        shooter5.Caption:='D';
        shooter6.Caption:='E';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 3)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='E';
        shooter2.Caption:='F';
        shooter3.Caption:='A';
        shooter4.Caption:='B';
        shooter5.Caption:='C';
        shooter6.Caption:='D';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 4)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='D';
        shooter2.Caption:='E';
        shooter3.Caption:='F';
        shooter4.Caption:='A';
        shooter5.Caption:='B';
        shooter6.Caption:='C';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 5) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='D';
        shooter3.Caption:='E';
        shooter4.Caption:='F';
        shooter5.Caption:='A';
        shooter6.Caption:='B';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='B';
        shooter2.Caption:='C';
        shooter3.Caption:='D';
        shooter4.Caption:='E';
        shooter5.Caption:='F';
        shooter6.Caption:='A';
      end;
    end;
    if  (Archersperturn=1) and (Turnsperserie=4) then
    begin
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true) then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
        shooter4.Caption:='D';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 2) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='D';
        shooter2.Caption:='A';
        shooter3.Caption:='B';
        shooter4.Caption:='C';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 3)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='D';
        shooter3.Caption:='A';
        shooter4.Caption:='B';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 0)  and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='B';
        shooter2.Caption:='C';
        shooter3.Caption:='D';
        shooter4.Caption:='A';
      end;
    end;
    if  (Archersperturn=1) and (Turnsperserie=3) then
    begin
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true) then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
        shooter3.Caption:='C';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 2) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='C';
        shooter2.Caption:='A';
        shooter3.Caption:='B';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='B';
        shooter2.Caption:='C';
        shooter3.Caption:='A';
      end;
    end;
    if  (Archersperturn=1) and (Turnsperserie=2) then
    begin
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 1) or ((Practiseturn=1)and (PABCDperEND.Checked=false)))or (ABCDperEND.Checked=true) then
      begin
        shooter1.Caption:='A';
        shooter2.Caption:='B';
      end;
      if  ((((((serienumber+nrofturns-1) div nrofturns)+repeatsequence.Value-1)div repeatsequence.Value) mod Turnsperserie = 0) and ((Practiseturn=0)or((Practiseturn=1)and (PABCDperEND.Checked=true)))) and (ABCDperEND.Checked=false) then
      begin
        shooter1.Caption:='B';
        shooter2.Caption:='A';
      end;
      if (((shooter1.Caption='A') and (shooter1.Font.Color=shootercolor))or((shooter2.Caption='A') and (shooter2.Font.Color=shootercolor))) and (not showABCD) then
      begin
        TOPshooterlet.Visible:=false;
        TOPshootertxt.Visible:=false;
        BOTshooterlet.Visible:=true;
        BOTshootertxt.Visible:=true;
        RABCDtxt.Caption:=BOTshooterlet.Caption;
        LABCDtxt.Caption:=BOTshooterlet.Caption;
      end;
      if (((shooter1.Caption='B') and (shooter1.Font.Color=shootercolor))or((shooter2.Caption='B') and (shooter2.Font.Color=shootercolor))) and (not showABCD) then
      begin
        TOPshooterlet.Visible:=true;
        TOPshootertxt.Visible:=true;
        BOTshooterlet.Visible:=false;
        BOTshootertxt.Visible:=false;
        RABCDtxt.Caption:=TOPshooterlet.Caption;
        LABCDtxt.Caption:=TOPshooterlet.Caption;
      end;
    end;
       if  ((showABCD) and( (Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))) then
      begin
        //RABCDtxt.Caption:=inttostr(Archersperturn)+inttostr(turnnumber)+inttostr(Turnsperserie+1);
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 1)  then RABCDtxt.Caption:=shooter1.caption;
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 2)  then RABCDtxt.Caption:=shooter2.caption;
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 3)  then RABCDtxt.Caption:=shooter3.caption;
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 4)  then RABCDtxt.Caption:=shooter4.caption;
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 5)  then RABCDtxt.Caption:=shooter5.caption;
        if  (Archersperturn=1) then if (turnnumber mod (Turnsperserie+1) = 6)  then RABCDtxt.Caption:=shooter6.caption;
        if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 1)  then RABCDtxt.Caption:=shooter1.caption+shooter2.caption;
        //if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter2.Font.Color:=shootercolor else shooter2.Font.Color:=nonshootercolor;
        if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 2)  then RABCDtxt.Caption:=shooter3.caption+shooter4.caption;
        //if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter4.Font.Color:=shootercolor else shooter4.Font.Color:=nonshootercolor;
        if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 3)  then RABCDtxt.Caption:=shooter5.caption+shooter6.caption;
        //if  (Archersperturn=2) then if (turnnumber mod (Turnsperserie+1) = 3)  then shooter6.Font.Color:=shootercolor else shooter6.Font.Color:=nonshootercolor;
        if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then RABCDtxt.Caption:=shooter1.caption+shooter2.caption+shooter3.caption;
        //if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter2.Font.Color:=shootercolor else shooter2.Font.Color:=nonshootercolor;
        //if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 1)  then shooter3.Font.Color:=shootercolor else shooter3.Font.Color:=nonshootercolor;
        if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then RABCDtxt.Caption:=shooter4.caption+shooter5.caption+shooter6.caption;
        //if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter5.Font.Color:=shootercolor else shooter5.Font.Color:=nonshootercolor;
        //if  (Archersperturn=3) then if (turnnumber mod (Turnsperserie+1) = 2)  then shooter6.Font.Color:=shootercolor else shooter6.Font.Color:=nonshootercolor;
        LABCDtxt.Caption:=RABCDtxt.Caption;
      end;
   end
  else
  begin
    if (archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7')) then
    begin
      shooter6.Caption := bitstoABCD(folsecdetailssec[7], folsecdetailssec[8],folsecdetailssec[9]);
      shooter5.Caption := bitstoABCD(folsecdetailssec[10], folsecdetailssec[11],folsecdetailssec[12]);
      shooter4.Caption := bitstoABCD(folsecdetails[1], folsecdetails[2],folsecdetails[3]);
      shooter3.Caption := bitstoABCD(folsecdetails[4], folsecdetails[5],folsecdetails[6]);
      shooter2.Caption := bitstoABCD(folsecdetails[7], folsecdetails[8],folsecdetails[9]);
      shooter1.Caption := bitstoABCD(folsecdetails[10], folsecdetails[11],folsecdetails[12]);
    end;
  end;
  if Length(RABCDtxt.Caption)=1 then
  Begin
    if usetraffic.Checked=true then
    begin
      RABCDtxt.top:=(trunc (referencesize*0.48)+topmarge);
      LABCDtxt.top:=(trunc (referencesize*0.48)+topmarge);
    end
    else
    begin
      RABCDtxt.top:=countdownform.Height-trunc(referencesize*0.22);
      LABCDtxt.top:=countdownform.Height-trunc(referencesize*0.22);
    end;
    RABCDtxt.Font.height:=trunc ((referencesize*0.25)*mag);
    LABCDtxt.Font.height:=trunc ((referencesize*0.25)*mag);
  end;
  if Length(RABCDtxt.Caption)=2 then
  Begin
    if usetraffic.Checked=true then
    begin
      RABCDtxt.top:=(trunc (referencesize*0.49)+topmarge);
      LABCDtxt.top:=(trunc (referencesize*0.49)+topmarge);
    end
    else
    begin
      RABCDtxt.top:=countdownform.Height-trunc(referencesize*0.21);
      LABCDtxt.top:=countdownform.Height-trunc(referencesize*0.21);
    end;
    RABCDtxt.Font.height:=trunc ((referencesize*0.22)*mag);
    LABCDtxt.Font.height:=trunc ((referencesize*0.22)*mag);
  end;
  if Length(RABCDtxt.Caption)>2 then
  begin
    if usetraffic.Checked=true then
    begin
      RABCDtxt.top:=(trunc (referencesize*0.52)+topmarge);
      LABCDtxt.top:=(trunc (referencesize*0.52)+topmarge);
    end
    else
    begin
      RABCDtxt.top:=countdownform.Height-trunc(referencesize*0.18);
      LABCDtxt.top:=countdownform.Height-trunc(referencesize*0.18);
    end;
    RABCDtxt.Font.height:=trunc ((referencesize*0.15)*mag);
    LABCDtxt.Font.height:=trunc ((referencesize*0.15)*mag);
  end;
  RENDtxt.top:=(trunc (referencesize*0.26)+topmarge);
  RENDtxt.Font.height:=trunc ((referencesize*0.16)*mag);
  LENDtxt.top:=(trunc (referencesize*0.26)+topmarge);
  LENDtxt.Font.height:=trunc ((referencesize*0.16)*mag);
  RTRNtxt.top:=(trunc (referencesize*0.39)+topmarge);
  RTRNtxt.Font.height:=trunc ((referencesize*0.05)*mag*mag);
  LTRNtxt.top:=(trunc (referencesize*0.39)+topmarge);
  LTRNtxt.Font.height:=trunc ((referencesize*0.05)*mag*mag);

  //set correct help text to shooters
  If shooter1.caption='A'then shooter1.Hint:=ActAtxt;
  If shooter1.caption='B'then shooter1.Hint:=ActBtxt;
  If shooter1.caption='C'then shooter1.Hint:=ActCtxt;
  If shooter1.caption='D'then shooter1.Hint:=ActDtxt;
  If shooter1.caption='E'then shooter1.Hint:=ActEtxt;
  If shooter1.caption='F'then shooter1.Hint:=ActFtxt;
  If shooter2.caption='A'then shooter2.Hint:=ActAtxt;
  If shooter2.caption='B'then shooter2.Hint:=ActBtxt;
  If shooter2.caption='C'then shooter2.Hint:=ActCtxt;
  If shooter2.caption='D'then shooter2.Hint:=ActDtxt;
  If shooter2.caption='E'then shooter2.Hint:=ActEtxt;
  If shooter2.caption='F'then shooter2.Hint:=ActFtxt;
  If shooter3.caption='A'then shooter3.Hint:=ActAtxt;
  If shooter3.caption='B'then shooter3.Hint:=ActBtxt;
  If shooter3.caption='C'then shooter3.Hint:=ActCtxt;
  If shooter3.caption='D'then shooter3.Hint:=ActDtxt;
  If shooter3.caption='E'then shooter3.Hint:=ActEtxt;
  If shooter3.caption='F'then shooter3.Hint:=ActFtxt;
  If shooter4.caption='A'then shooter4.Hint:=ActAtxt;
  If shooter4.caption='B'then shooter4.Hint:=ActBtxt;
  If shooter4.caption='C'then shooter4.Hint:=ActCtxt;
  If shooter4.caption='D'then shooter4.Hint:=ActDtxt;
  If shooter4.caption='E'then shooter4.Hint:=ActEtxt;
  If shooter4.caption='F'then shooter4.Hint:=ActFtxt;
  If shooter5.caption='A'then shooter5.Hint:=ActAtxt;
  If shooter5.caption='B'then shooter5.Hint:=ActBtxt;
  If shooter5.caption='C'then shooter5.Hint:=ActCtxt;
  If shooter5.caption='D'then shooter5.Hint:=ActDtxt;
  If shooter5.caption='E'then shooter5.Hint:=ActEtxt;
  If shooter5.caption='F'then shooter5.Hint:=ActFtxt;
  If shooter6.caption='A'then shooter6.Hint:=ActAtxt;
  If shooter6.caption='B'then shooter6.Hint:=ActBtxt;
  If shooter6.caption='C'then shooter6.Hint:=ActCtxt;
  If shooter6.caption='D'then shooter6.Hint:=ActDtxt;
  If shooter6.caption='E'then shooter6.Hint:=ActEtxt;
  If shooter6.caption='F'then shooter6.Hint:=ActFtxt;
  //show helptext on ABCD depending on color (because the color of the font indicates if the archer is active)
  If ((shooter1.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter1.ShowHint:=true else shooter1.ShowHint:=false;
  If ((shooter2.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter2.ShowHint:=true else shooter2.ShowHint:=false;
  If ((shooter3.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter3.ShowHint:=true else shooter3.ShowHint:=false;
  If ((shooter4.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter4.ShowHint:=true else shooter4.ShowHint:=false;
  If ((shooter5.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter5.ShowHint:=true else shooter5.ShowHint:=false;
  If ((shooter6.Font.Color=nonshootercolor) and (showhints.checked=true)and (archerysystem<>'follow')) then shooter6.ShowHint:=true else shooter6.ShowHint:=false;

  //switch on or off the correct ABCD lights  (HW)
  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='A') and (turnnumber=1)) or ((Shooter2.Caption='A') and (turnnumber=2)and(Archersperturn=1)) or ((Shooter3.Caption='A') and (turnnumber=3)and(Archersperturn=1)) or ((Shooter3.Caption='A') and (turnnumber=2)and(Archersperturn=2)) or ((Shooter4.Caption='A') and (turnnumber=4)and(Archersperturn=1)) or ((Shooter4.Caption='A') and (turnnumber=2)and(Archersperturn=3)) or ((Shooter5.Caption='A') and (turnnumber=5)and(Archersperturn=1)) or ((Shooter5.Caption='A') and (turnnumber=3)and(Archersperturn=2)) or ((Shooter6.Caption='A') and (turnnumber=6)and(Archersperturn=1)) ))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='1')and (abcd25m1p.checked=true)) then
  begin
    LampA_on_off:=1;
    Not_LampA_on_off:=0;
  end
  else
  begin
    LampA_on_off:=0;
    if (Turnsperserie>1) then Not_LampA_on_off:=1 else Not_LampA_on_off:=0 ;
  end;
  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='B') and (turnnumber=1 )and (Archersperturn=1)) or ((Shooter2.Caption='B') and (turnnumber=2)and(Archersperturn=1)) or ((Shooter2.Caption='B') and (turnnumber=1)and(Archersperturn=2)) or ((Shooter2.Caption='B') and (turnnumber=1)and(Archersperturn=3)) or ((Shooter3.Caption='B') and (turnnumber=3)and(Archersperturn=1)) or ((Shooter4.Caption='B') and (turnnumber=4 )and( Archersperturn=1)) or ((Shooter4.Caption='B') and (turnnumber=2 )and( Archersperturn=2)) or ((Shooter5.Caption='B') and (turnnumber=5)and(Archersperturn=1)) or ((Shooter5.Caption='B') and (turnnumber=2)and(Archersperturn=3)) or ((Shooter6.Caption='B') and (turnnumber=6)and(Archersperturn=1)) or ((Shooter6.Caption='B') and (turnnumber=3)and(Archersperturn=2))))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='2')and (abcd25m1p.checked=true)) then
  begin
    LampB_on_off:=1;
    Not_LampB_on_off:=0;
  end
  else
  begin
    LampB_on_off:=0;
    if (Turnsperserie>1) then Not_LampB_on_off:=1 else Not_LampB_on_off:=0;
  end;
  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='C') and (turnnumber=1) and (Archersperturn=1)) or ((Shooter1.Caption='C') and (turnnumber=1) and (Archersperturn=2)) or  ((Shooter2.Caption='C') and (turnnumber=2) and(Archersperturn=1)) or ((Shooter3.Caption='C') and (turnnumber=3 )and(Archersperturn=1)) or ((Shooter3.Caption='C') and (turnnumber=2 )and(Archersperturn=2)) or ((Shooter3.Caption='C') and (turnnumber=1 )and(Archersperturn=3))  or ((Shooter4.Caption='C') and (turnnumber=4) and (Archersperturn=1))or ((Shooter5.Caption='C') and (turnnumber=5) and(Archersperturn=1)) or ((Shooter5.Caption='C') and (turnnumber=3) and(Archersperturn=2)) or ((Shooter6.Caption='C') and (turnnumber=6)and(Archersperturn=1)) or ((Shooter6.Caption='C') and (turnnumber=2)and(Archersperturn=3)) ))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='3')and (abcd25m1p.checked=true))  then
  begin
    LampC_on_off:=1;
    Not_LampC_on_off:=0;

  end
  else
  begin
    LampC_on_off:=0;
    if (Turnsperserie * Archersperturn >2) then Not_LampC_on_off:=1 else Not_LampC_on_off:=0;

  end;
  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='D') and (turnnumber=1)and(Archersperturn=1)) or ((Shooter1.Caption='D') and (turnnumber=1)and(Archersperturn=3)) or ((Shooter2.Caption='D') and (turnnumber=2) and(Archersperturn=1)) or ((Shooter2.Caption='D') and (turnnumber=1) and(Archersperturn=2)) or ((Shooter3.Caption='D') and  (turnnumber=3 )and(Archersperturn=1)) or ((Shooter4.Caption='D') and (turnnumber=4) and (Archersperturn=1)) or ((Shooter4.Caption='D') and (turnnumber=2) and (Archersperturn=2)) or ((Shooter4.Caption='D') and (turnnumber=2) and (Archersperturn=3)) or ((Shooter5.Caption='D') and (turnnumber=5) and(Archersperturn=1)) or ((Shooter6.Caption='D') and (turnnumber=6)and(Archersperturn=1)) or ((Shooter6.Caption='D') and (turnnumber=3)and(Archersperturn=2))))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='4')and (abcd25m1p.checked=true)) then
  begin
    LampD_on_off:=1;
    Not_LampD_on_off:=0;

  end
  else
  begin
    LampD_on_off:=0;
    if (Turnsperserie * Archersperturn>3) then Not_LampD_on_off:=1 else Not_LampD_on_off:=0;
  end;

  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='E') and (turnnumber=1)and(Archersperturn=1)) or ((Shooter1.Caption='E') and (turnnumber=1)and(Archersperturn=2)) or ((Shooter2.Caption='E') and (turnnumber=2)and(Archersperturn=1)) or ((Shooter2.Caption='E') and (turnnumber=1)and(Archersperturn=3)) or ((Shooter3.Caption='E') and (turnnumber=3) and (Archersperturn=1)) or ((Shooter3.Caption='E') and (turnnumber=2) and (Archersperturn=2)) or ((Shooter4.Caption='E') and (turnnumber=4) and (Archersperturn=1)) or ((Shooter5.Caption='E') and (turnnumber=5) and(Archersperturn=1)) or ((Shooter5.Caption='E') and (turnnumber=3) and(Archersperturn=2)) or ((Shooter5.Caption='E') and (turnnumber=2) and(Archersperturn=3))  or ((Shooter6.Caption='E') and (turnnumber=6)and(Archersperturn=1)) ))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='5')and (abcd25m1p.checked=true))  then
  begin
    LampE_on_off:=1;
    Not_LampE_on_off:=0;

  end
  else
  begin
    LampE_on_off:=0;
    if (Turnsperserie * Archersperturn >4) then Not_LampE_on_off:=1 else Not_LampE_on_off:=0;

  end;
  if  (((Shootoff=0)and(archerysystem='fita')or((archerysystem='follow')and((followsystem='0')or(followsystem='1')or(followsystem='6')or(followsystem='7'))))and ((Turnsperserie >1) and
  ((Shooter1.Caption='F') and (turnnumber=1)and( Archersperturn=1)) or ((Shooter2.Caption='F') and (turnnumber=2)and( Archersperturn=1)) or ((Shooter2.Caption='F') and (turnnumber=1)and( Archersperturn=2)) or ((Shooter3.Caption='F') and (turnnumber=3) and (Archersperturn=1)) or ((Shooter3.Caption='F') and (turnnumber=1) and (Archersperturn=3)) or ((Shooter4.Caption='F') and (turnnumber=4)and(Archersperturn=1)) or ((Shooter4.Caption='F') and (turnnumber=2)and(Archersperturn=2)) or ((Shooter5.Caption='F') and (turnnumber=5)and(Archersperturn=1)) or ((Shooter6.Caption='F') and (turnnumber=6)and(Archersperturn=1)) or ((Shooter6.Caption='F') and (turnnumber=3)and(Archersperturn=2)) or ((Shooter6.Caption='F') and (turnnumber=2)and(Archersperturn=3))))
  or ((((Shootoff=0)and(archerysystem='25m1p'))or((archerysystem='follow')and(followsystem='3')))and (shooteronearrownr.caption='6')and (abcd25m1p.checked=true)) then
  begin
    LampF_on_off:=1;
    Not_LampF_on_off:=0;

  end
  else
  begin
    LampF_on_off:=0;
    if (Turnsperserie * Archersperturn>5) then Not_LampF_on_off:=1 else Not_LampF_on_off:=0;
  end;
end;

procedure TCountdownform.views;
//when something changes like time, state, archer, etc. a change is visible on the sreen.
//after all these changes, this procedure takes care that the correct info is visible on the screen

begin
  viewactivate;
  viewchangmenuitems;
  viewchangestateactive;
  viewchangestateinact;
  viewchangestateexchange;
  viewicons;
  //viewarchsystemchange;
  viewfinupdate;
  viewturnchange;
  switchbox;   //switch the external hardware (lamps, digits etc)
  TLswitch;  //to switch the TraficLights on the sceen (If applicable)

end;


Procedure TCountdownform.switchbox;
var i,j,k,l,l2,m,n,atype,stype,extshooter1,extshooter2,extshooter3,extshooter4,extshooter5,extshooter6,leftend,midend,rightend,bit15,bit16,zerotwelve1,zerotwelve2,zerotwelve3,shtrs:longint;
var fileDesc, nonnonzero: integer;
var ichar1, ichar2, ichar3, ichar4:longint;

  (*
  this procedure is used to switch the external hardware. Two possibilities (at this moment) the K8055 and related interface boards from Velleman. or USB/serial
  K8055 has only the possibility to switch 8 output channnels (and 2 annalog channels can be used as digital channel)

  USB serial is commonly used with arduino, but can also be used with other serial or USB interface boards.
  Protocol: 16 bits strings where the first 2 bits of the string is the address (destination)
  -if 1st bit is '1' means "traffic light data". The information of the other bits is about traffic lights (red orange green), ABCD lights and buzzer
    -if 2nd bit is '0' means bit 3 is buzzer, 4 to 6 is green orange and red light on right side (right side archer). Bit 7 to 9 is green orange and red light on left side. Bit 10 to 15 is ABCDEF light.
    -if 2nd bit is '1'   meant to use sequence of ABCD. 4 positions are sent where 3 bits per archer tel if it is A, B, C, D, blank, +, or -
       -if 3rd and 4th bit is '00' then Details about ABCD positions in sequence (bit 5,6 and 7 pos1. bit 8,9 and 10 pos2. bit 11,12 and 13 pos3. bit 14, 15 and 16 pos 4.
       -if 3rd and 4th bit is '01' then: Details about EF positions in sequence (bit 5,6 and 7 pos5. bit 8,9 and 10 pos6.
       -if 3rd and 4th bit is '10' then: end nr. 5-8 left bit, 9-12 mid bit, 13-16 right bit. 1111 is P (practice)
       -if 3rd and 4th bit is '11' then: state details. Bit 5,6,7,8 for state.  bit 9 and up archerytype (Fita, fitafinals, etc)
  -if 1st bit is '0' means "Digits data". The information of the other bits is about the digits of the countdown (nr of seconds)
    -if 2nd + 3rd bit is '00' means digits on leftside (left side archer) are in the string in bit 4 to 16
    -if 2nd + 3rd bit is '10' means digits on rightside (right side archer) are in the string in bit 4 to 16
    -if 2nd + 3rd bit is '*1' means digits for both sides are in the string in bit 4 to 16 (no alternating round)
    -bit 4 to 16:
      -bit 4 indicates minute or seconds notation (Two dots are needed between left and middle digits
      -bit 5 to 8 is left digit (minutes or 100 seconds)
      -bit 9 to 12 is middle digit (10 seconds)
      -bit 13 to 16 is right digits (1 seconds)

Digits with value zero ("0") are sent as 12 ('1010') to prevent that when all 3 digits are zero, which means 12 bits zero in a row, are not recognized anymore.
  *)
begin

{$IFDEF Windows}     //K8055 is only for windows at the moment
  if (archerysystem='fitafin')then
  begin
    if finarrow.Checked=true then
    begin
      if  (BCDtoROG2.checked=true) then
      begin
        i:=buzzeron*1+
        lamp_red_left_on_off*2+
        lamp_orange_left_on_off*4+
        lamp_green_left_on_off*8+
        lamp_red_right_on_off*32+
        lamp_orange_right_on_off*64+
        lamp_green_right_on_off*128;

      end
      else
      begin
        i:=buzzeron*1+
        1*2+
        0*4+
        0*8+
        0*32+
        0*64+
        0*128;

      end;
    end;
    if viewleft.Checked=true then
    begin
      i:=buzzeron*1+
      lamp_red_left_on_off *2+
      lamp_orange_left_on_off *4+
      lamp_green_left_on_off *8+
      LampA_on_off*16+
      LampB_on_off*32+
      LampC_on_off*64+
      LampD_on_off*128;

    end;
    if viewright.Checked=true then
    begin
      i:=buzzeron*1+
      lamp_red_right_on_off *2+
      lamp_orange_right_on_off *4+
      lamp_green_right_on_off *8+
      LampA_on_off*16+
      LampB_on_off*32+
      LampC_on_off*64+
      LampD_on_off*128;

    end;
    if not DisableOtherFunctionCall then WriteAllDigital(i);
    OutputAnalogChannel(1,0);
    OutputAnalogChannel(2,0);

  end
  else
  begin


    i:=buzzeron*1+
    (lamp_red_left_on_off and lamp_red_right_on_off)*2+
    (lamp_orange_left_on_off or lamp_orange_right_on_off)*4+
    (lamp_green_left_on_off or lamp_green_right_on_off)*8+
    LampA_on_off*16+
    LampB_on_off*32+
    LampC_on_off*64+
    LampD_on_off*128;
    if (not DisableOtherFunctionCall) and (rememberK8055i<>i)  then WriteAllDigital(i);
    if (rememberK8055E<>LampE_on_off) then if (LampE_on_off=1) then OutputAnalogChannel(1,255)  else  OutputAnalogChannel(1,0);
    if (rememberK8055F<>LampF_on_off) then if (LampF_on_off=1) then OutputAnalogChannel(2,255)  else  OutputAnalogChannel(2,0);
    rememberK8055i:=i;
    rememberK8055E:=LampE_on_off;
    rememberK8055F:=LampF_on_off;
  end;

{$ENDIF}
{$IFDEF Unix}
  if buzzeron=1 then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio5/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio5/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;

  if (archerysystem='fitafin')then
  begin
    if viewleft.Checked=true then
    begin
      if (lamp_red_left_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if (lamp_orange_left_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if (lamp_green_left_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

    end;
    if viewright.Checked=true then
    begin
      if (lamp_red_right_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if (lamp_orange_right_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if (lamp_green_right_on_off=1) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;
    end;

  end
  else
  begin
    begin
      if ((lamp_red_left_on_off=1) or (lamp_red_right_on_off=1)) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio2/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if ((lamp_orange_left_on_off=1) or (lamp_orange_right_on_off=1)) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio3/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;

      if ((lamp_green_left_on_off=1) or (lamp_green_right_on_off=1)) then
        begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end
      else
      begin
        try
          fileDesc := fpopen('/sys/class/gpio/gpio4/value', O_WrOnly);
          gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
        finally
          gReturnCode := fpclose(fileDesc);
        end;
      end;
    end;

  end;
  if (LampA_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio17/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio17/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;
  if (LampB_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio27/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio27/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;
  if (LampC_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio22/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio22/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;
  if (LampD_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio10/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio10/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;
  if (LampE_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio9/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio9/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;
  if (LampF_on_off=1) then
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio11/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_ON[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end
  else
  begin
    try
      fileDesc := fpopen('/sys/class/gpio/gpio11/value', O_WrOnly);
      gReturnCode := fpwrite(fileDesc, PIN_OFF[0], 1);
    finally
      gReturnCode := fpclose(fileDesc);
    end;
  end;


 {$ENDIF}


// USB/serial (arduino)   and network
  if zerosec.Checked=true then nonnonzero:=1 else nonnonzero:=0;
  if(archerysystem='fitafin') or (archerysystem='manual') then archerspertarget:=0 else if (Turnsperserie * Archersperturn)<=4 then archerspertarget:= ((Turnsperserie * Archersperturn)-1) else archerspertarget:=3 ;   //kan weg?
  if (archerysystem='fitafin') then
  begin
    if fitafinarcher='right' then bit15 :=1 else bit15:=0;
    if fitafinarcher='left' then bit16 :=1 else bit16:=0;
  end
  else
  begin
    bit15 :=LampE_on_off;
    bit16 :=LampF_on_off;
  end;
  i:=
  1 shl 0+ //trafic light data (not digits)
  0 shl 1+ // 0 is standard red orange green and ABCD. (No ABCD sequence details
  0 shl 2+ // open for usage in future
  buzzeron shl 3+
  lamp_green_right_on_off shl 4+
  lamp_orange_right_on_off shl 5+
  lamp_red_right_on_off shl 6+
  lamp_green_left_on_off shl 7+
  lamp_orange_left_on_off shl 8+
  lamp_red_left_on_off shl 9+
  LampA_on_off shl 10+
  LampB_on_off shl 11+
  LampC_on_off shl 12+
  LampD_on_off shl 13+
  bit15 shl 14+
  bit16 shl 15;

  SENTLAN1:=i;
  ichar1:=
  lamp_red_left_on_off shl 0+
  lamp_orange_left_on_off shl 1+
  lamp_green_left_on_off shl 2+
  lamp_red_right_on_off shl 3+
  lamp_orange_right_on_off shl 4+
  lamp_green_right_on_off shl 5+
  buzzeron shl 6+
  1 shl 7;
  ichar2:=LampA_on_off shl 0+LampB_on_off shl 1+ LampC_on_off shl 2+ LampD_on_off shl 3+ bit15 shl 4+  bit16 shl 5 + practiseturn shl 6 +1 shl 7;
  SENTBROAD1:=char(ichar1);
  SENTBROAD10:=char(ichar2);
  atype:=0;
  stype:=state;
  if alarmstate=1 then stype:= 6;
  if (archerysystem='fita') AND NOT(showABCD)then atype:=0;
  begin
    if nrofturns=1 then atype:=0 else atype:=6;
  end;
  if (archerysystem='fita') AND (showABCD)then
  begin
    if nrofturns=1 then atype:=1 else atype:=7;
  end;

  if archerysystem='fitafin'then atype:=2;
  if archerysystem='25m1p'then atype:=3;
  if archerysystem='manual'then atype:=4;
  if archerysystem='follow'then atype:=5;
  if (archerysystem='follow') and (followsystem='2') then atype:=2;
  shtrs:=Shooters-1;
  n:=
  1 shl 0+ //trafic light data (not digits)
  1 shl 1+ // 1 is sequence details
  1 shl 2+ // state details
  1 shl 3+ // state details
  stype shl 4 +
  atype shl 7 +
  turnnumber shl 10 +
  shtrs shl 13;    //Number af archers per target.
  SENTLAN6:=n;
  ichar1:= (Turnsperserie-1) + (Archersperturn-1) shl 3+ integer(dblturn.Checked) shl 5+ (times-1) shl 6 +1 shl 7;
  ichar2:= stype+atype shl 3 + 1 shl 7;
  SENTBROAD11:=char(ichar1);
  SENTBROAD12:=char(ichar2);
  if (archerysystem='fitafin') then
  begin
    if state<>1 then
    begin
      if (state=2) and (fitafinarcher='right') then
      begin
        zerotwelve1:=11;
        zerotwelve2:=11;
        zerotwelve3:=11;
      end
      else
      begin
        if StrToInt(digit1_1.Caption)=0 then
        begin
          if (minsec.ItemIndex=0)and (nonzerosec.Checked=true) then zerotwelve1:=11 else zerotwelve1:=12
        end else zerotwelve1:=StrToInt(digit1_1.Caption);
        if StrToInt(digit2_1.Caption)=0 then
        begin
          if ((digit1_1.caption='0')and (minsec.ItemIndex=0)and (nonzerosec.Checked=true)) then zerotwelve2:=11 else zerotwelve2:=12
        end else zerotwelve2:=StrToInt(digit2_1.Caption);

        if StrToInt(digit3_1.Caption)=0 then zerotwelve3:=12 else zerotwelve3:=StrToInt(digit3_1.Caption);
      end;
      begin
        j:=      //left archer
        0 shl 0+ //digits data (not trafic lights)
        0 shl 1+ //leftside
        0 shl 2+ //0 leftright are different beause its a final round
        minsec.ItemIndex shl 3+ //Minutes or sec indication (to indicate if dots are needed
        zerotwelve3 shl 4+
        zerotwelve2 shl 8+
        zerotwelve1 shl 12  ;
      end;
      if (state=2) and (fitafinarcher='left') then
      begin
        zerotwelve1:=11;
        zerotwelve2:=11;
        zerotwelve3:=11;
      end
      else
      begin
        if StrToInt(digit1_2.Caption)=0 then
        begin
          if (minsec.ItemIndex=0)and (nonzerosec.Checked=true) then zerotwelve1:=11 else zerotwelve1:=12
        end else zerotwelve1:=StrToInt(digit1_2.Caption);
        if StrToInt(digit2_2.Caption)=0 then
        begin
          if ((digit1_2.caption='0')and (minsec.ItemIndex=0)and (nonzerosec.Checked=true)) then zerotwelve2:=11 else zerotwelve2:=12
        end else zerotwelve2:=StrToInt(digit2_2.Caption);

        if StrToInt(digit3_2.Caption)=0 then zerotwelve3:=12 else zerotwelve3:=StrToInt(digit3_2.Caption);
      end;

      begin
        k:=      //right archer
        0 shl 0+ //digits data (not trafic lights)
        1 shl 1+ //rightside
        0 shl 2+ //0 leftright are different beause its a final round
        minsec.ItemIndex shl 3+ //Minutes or sec indication (to indicate if dots are needed
        zerotwelve3 shl 4+
        zerotwelve2 shl 8+
        zerotwelve1 shl 12 ;
      end ;
      begin
        ichar1:=(StrToInt(digit3_1.Caption))+(10*(StrToInt(digit2_1.Caption)))+1 shl 7;
        ichar2:=(StrToInt(digit3_2.Caption))+(10*(StrToInt(digit2_2.Caption)))+1 shl 7;
        ichar3:=(StrToInt(digit1_1.Caption))+minsec.ItemIndex shl 6+nonnonzero shl 7;
        ichar4:=(StrToInt(digit1_2.Caption))+turnnumber shl 4+1 shl 7;
      end;
    end
    else
    begin
        j:=      //left archer
        0 shl 0+ //digits data (not trafic lights)
        0 shl 1+ //leftside
        0 shl 2+ //0 leftright are different beause its a final round
        minsec.ItemIndex shl 3+ //Minutes or sec indication (to indicate if dots are needed
        10 shl 4 + 10 shl 8 +10 shl 12;

        k:=      //right archer
        0 shl 0+ //digits data (not trafic lights)
        1 shl 1+ //rightside
        0 shl 2+ //0 leftright are different beause its a final round
        minsec.ItemIndex shl 3+ //Minutes or sec indication (to indicate if dots are neded)    no dots when dashes
        10 shl 4 + 10 shl 8 +10 shl 12;

        ichar1:=0+1 shl 7;
        ichar2:=0+1 shl 7;
        ichar3:=0+minsec.ItemIndex shl 6+nonnonzero shl 7;
        ichar4:=0+turnnumber shl 4+1 shl 7;

    end;
    SENTLAN2:=j;
    SENTLAN3:=k;

  end
  else
  begin
    if (state<>1) and (state<>5) and (archerysystem<>'manual') then
    begin
      if ((archerysystem='follow') and  (followsystem='2')) and (state=2)and (digit3_1.Visible=false) and ((rightscreen.Checked and followleft)or  (leftscreen.Checked and followright))then
      begin
        zerotwelve1:=11;
        zerotwelve2:=11;
        zerotwelve3:=11;

      end
      else
      begin
        if StrToInt(digit1_1.Caption)=0 then
        begin
          if (minsec.ItemIndex=0)and (nonzerosec.Checked=true) then zerotwelve1:=11 else zerotwelve1:=12
        end else zerotwelve1:=StrToInt(digit1_1.Caption);
        if StrToInt(digit2_1.Caption)=0 then
        begin
          if ((digit1_1.caption='0')and (minsec.ItemIndex=0)and (nonzerosec.Checked=true)) then zerotwelve2:=11 else zerotwelve2:=12
        end else zerotwelve2:=StrToInt(digit2_1.Caption);
        if StrToInt(digit3_1.Caption)=0 then zerotwelve3:=12 else zerotwelve3:=StrToInt(digit3_1.Caption);
      end;

      j:=
      0 shl 0+ //digits data (not trafic lights)
      1 shl 1+ //leftright doesn't matter since leftright are the same
      1 shl 2+ //1 because left and right side are the same. (not a final round)
      minsec.ItemIndex shl 3+  //Minutes or sec indication (to indicate if dots are needed

      zerotwelve3 shl 4+
      zerotwelve2 shl 8+
      zerotwelve1 shl 12 ;

      ichar1:=(StrToInt(digit3_1.Caption))+(10*(StrToInt(digit2_1.Caption)))+1 shl 7;
      ichar2:=(StrToInt(digit3_1.Caption))+(10*(StrToInt(digit2_1.Caption)))+1 shl 7;
      ichar3:=(StrToInt(digit1_1.Caption))+minsec.ItemIndex shl 6+nonnonzero shl 7;
      ichar4:=(StrToInt(digit1_1.Caption))+turnnumber shl 4+1 shl 7;

    end;
    if (state<>1) and (state=5) and (archerysystem<>'manual') then
    begin
      if StrToInt(digit1_3.Caption)=0 then zerotwelve1:=12 else zerotwelve1:=StrToInt(digit1_3.Caption);
      if StrToInt(digit2_3.Caption)=0 then zerotwelve2:=12 else zerotwelve2:=StrToInt(digit2_3.Caption);
      if StrToInt(digit3_3.Caption)=0 then zerotwelve3:=12 else zerotwelve3:=StrToInt(digit3_3.Caption);

      j:=
      0 shl 0+ //digits data (not trafic lights)
      1 shl 1+ //leftright doesn't matter since leftright are the same
      1 shl 2+ //1 because left and right side are the same. (not a final round)
      1 shl 3+  //precount is always minutes indication

      zerotwelve3 shl 4+
      zerotwelve2 shl 8+
      zerotwelve1 shl 12;
      ichar1:=(StrToInt(digit3_3.Caption))+(10*(StrToInt(digit2_3.Caption)))+1 shl 7;
      ichar2:=(StrToInt(digit3_3.Caption))+(10*(StrToInt(digit2_3.Caption)))+1 shl 7;
      ichar3:=(StrToInt(digit1_3.Caption))+1 shl 6+1 shl 7;
      ichar4:=(StrToInt(digit1_3.Caption))+turnnumber shl 4+1 shl 7;

    end;
    if (state =1) or (archerysystem = 'manual') then
    begin
      j:=
      0 shl 0+ //digits data (not trafic lights)
      1 shl 1+ //leftright doesn't matter since leftright are the same
      1 shl 2+ //1 because left and right side are the same. (not a final round)
      minsec.ItemIndex shl 3+  //Minutes or sec indication (to indicate if dots are needed ) no dots when dashes
      10 shl 4 + 10 shl 8 +10 shl 12;

      ichar1:=0+1 shl 7;
      ichar2:=0+1 shl 7;
      ichar3:=0+minsec.ItemIndex shl 6+nonnonzero shl 7;
      ichar4:=0+turnnumber shl 4+1 shl 7;
    end;

    K:= j;
    SENTLAN2:=j;
    SENTLAN3:=k;

  end;
  SENTBROAD2:=char(ichar1);
  SENTBROAD3:=char(ichar2);
  SENTBROAD4:=char(ichar3);
  SENTBROAD5:=char(ichar4);
  if practiseturn = 1 then leftend:=15 else if ((serienumber mod 1000)div 100)=0 then leftend:=14 else leftend:=((serienumber mod 1000)div 100);
  if ((((serienumber mod 100)div 10)=0)and (((serienumber mod 1000)div 100)=0)) then midend:=14 else midend:= ((serienumber mod 100)div 10);
  rightend:=   (serienumber mod 10);

  if leftend=0 then zerotwelve1:=12 else zerotwelve1:=leftend;
  if midend=0 then zerotwelve2:=12 else zerotwelve2:=midend;
  if rightend=0 then zerotwelve3:=12 else zerotwelve3:=rightend;

  m:=
  1 shl 0+ //trafic light data (not digits)
  1 shl 1+ // 1 is sequence details
  1 shl 2+ // end nr details
  0 shl 3+ // open for usage in future
  zerotwelve1 shl 4+   //practise turn or normal turn
  zerotwelve2 shl 8+
  zerotwelve3 shl 12
  ;
  SENTLAN5:=m;
  ichar1:=serienumber+1 shl 7;
  SENTBROAD6:=char(ichar1);

  extshooter1:=0;
  extshooter2:=3;
  extshooter3:=0;
  extshooter4:=0;

  if archerysystem='fita' then
  begin
    begin
      if (shooter1.Caption='A') then extshooter1:=1;
      if (shooter1.Caption='B') then extshooter1:=2;
      if (shooter1.Caption='C') then extshooter1:=3;
      if (shooter1.Caption='D') then extshooter1:=4;
      if (shooter1.Caption='E') then extshooter1:=5;
      if (shooter1.Caption='F') then extshooter1:=6;
    end;
    begin
      if (shooter2.Caption='A') then extshooter2:=1;
      if (shooter2.Caption='B') then extshooter2:=2;
      if (shooter2.Caption='C') then extshooter2:=3;
      if (shooter2.Caption='D') then extshooter2:=4;
      if (shooter2.Caption='E') then extshooter2:=5;
      if (shooter2.Caption='F') then extshooter2:=6;
    end;
    begin
      if (shooter3.Caption='A') then extshooter3:=1;
      if (shooter3.Caption='B') then extshooter3:=2;
      if (shooter3.Caption='C') then extshooter3:=3;
      if (shooter3.Caption='D') then extshooter3:=4;
      if (shooter3.Caption='E') then extshooter3:=5;
      if (shooter3.Caption='F') then extshooter3:=6;
    end;
    begin
      if (shooter4.Caption='A') then extshooter4:=1;
      if (shooter4.Caption='B') then extshooter4:=2;
      if (shooter4.Caption='C') then extshooter4:=3;
      if (shooter4.Caption='D') then extshooter4:=4;
      if (shooter4.Caption='E') then extshooter4:=5;
      if (shooter4.Caption='F') then extshooter4:=6;
    end;
    begin
      if (shooter5.Caption='A') then extshooter5:=1;
      if (shooter5.Caption='B') then extshooter5:=2;
      if (shooter5.Caption='C') then extshooter5:=3;
      if (shooter5.Caption='D') then extshooter5:=4;
      if (shooter5.Caption='E') then extshooter5:=5;
      if (shooter5.Caption='F') then extshooter5:=6;
    end;
    begin
      if (shooter6.Caption='A') then extshooter6:=1;
      if (shooter6.Caption='B') then extshooter6:=2;
      if (shooter6.Caption='C') then extshooter6:=3;
      if (shooter6.Caption='D') then extshooter6:=4;
      if (shooter6.Caption='E') then extshooter6:=5;
      if (shooter6.Caption='F') then extshooter6:=6;
    end;

  end;
  if archerysystem='25m1p' then
  begin
    extshooter1:=turnnumber;
  end;
  if (archerysystem<>'fita') then
  begin
    l:=

    1 shl 0+ //trafic light data (not digits)
    1 shl 1+ // is sequence details
    0 shl 2+ // 0 is ABCD sequence details
    0 shl 3+ // 0 is ABCD sequence details
    0 shl 4+
    5 shl 7+
    2 shl 10+
    5 shl 13
   ;
    l2:=

    1 shl 0+ //trafic light data (not digits)
    1 shl 1+ // is sequence details
    0 shl 2+ // 0 is ABCD sequence details
    1 shl 3+ // 1 is EF sequence details
    0 shl 4+
    5 shl 7+
    2 shl 10+
    5 shl 13
   ;
    if shootoff=0 then ichar1:=0+5 shl 3+1 shl 7 else ichar1:=0+5 shl 3+0 shl 7;
    ichar2:=2+5 shl 3+1 shl 7;
    ichar3:=0+5 shl 3+Integer(rotate25m1p.Checked) shl 6+Integer(rotate25m1p_p.Checked) shl 7;


  end
  else
  begin
   l:=

   1 shl 0+ //trafic light data (not digits)
   1 shl 1+ // is sequence details
   0 shl 2+ // 0 is ABCDEF sequence details
   0 shl 3+ // 0 is ABCD sequence details
   extshooter1 shl 4+
   extshooter2 shl 7+
   extshooter3 shl 10+
   extshooter4 shl 13
  ;
   l2:=

   1 shl 0+ //trafic light data (not digits)
   1 shl 1+ // is sequence details
   0 shl 2+ // 0 is ABCDEF sequence details
   1 shl 3+ // 1 is EF sequence details
   extshooter5 shl 4+
   extshooter6 shl 7;
   if shootoff=0 then ichar1:=extshooter1+extshooter2 shl 3+Integer(showABCD) shl 6+1 shl 7 else ichar1:=extshooter1+extshooter2 shl 3+Integer(showABCD) shl 6+0 shl 7;
   ichar2:=extshooter3+extshooter4 shl 3+Integer(ABCDperEND.Checked) shl 6+Integer(not(PABCDperEND.Checked)) shl 7;
   ichar3:=extshooter5+extshooter6 shl 3+Integer(rotate25m1p.Checked) shl 6+Integer(rotate25m1p_p.Checked) shl 7;



  end;
  SENTLAN4:=l;
  SENTLAN4b:=l2;
  if (Shutdwnremote=false)  then
  begin
    SENTBROAD7:=char(ichar1);
    SENTBROAD8:=char(ichar2);
    SENTBROAD9:=char(ichar3);
  end
  else
  begin
    SENTBROAD7:='x';
    SENTBROAD8:='G';
    SENTBROAD9:='x';
    if nrofshutdwnsignals<1 then Shutdwnremote:=false;
  end;
  begin
    if (l<>arduinowrite4) or (justconnected=true) then
    begin
      if arduinoselect1.Checked=true then
      if  (LANselect.Checked=true) then
    end;
  end;
  if Controlaudiocheckbox.Checked=true then setmusicstatus;
  justconnected:=false;
end;
procedure TCountdownform.connectports;
begin
  getPCname;
  NETWORK1.Disconnect;
  if (archerysystem<>'follow' ) then
  Begin
    rcvmcasttimer.Enabled:=false;
    if ((Lanselect.Checked=true) ) then
    begin
      networktimestamp.Enabled:=true;
    end
    else
    begin
       networktimestamp.Enabled:=false;
    end;
  end
  else
  begin
    networktimestamp.Enabled:=false;  // a follow screen never sends; before this it kept sending if Broadcast had been on
    if LANinput.Checked=true then
    begin
       rcvmcasttimer.Enabled:=true;
    end
    else
    begin
      networktimestamp.Enabled:=false;
      rcvmcasttimer.Enabled:=false;
    end;
  end;
  connect;
end;

procedure TCountdownform.getPCname;
var n: Integer;
    PCNameBuffer: array[0..255] of char;
    PCBuffer: DWord;
    {$IFDEF Windows}
    p : PHostEnt;
    s : array[0..128] of char;
    {$ENDIF}
    {$IFDEF Unix}

    sl:shortstring;
    fl:text;
    pl:LongInt;
    response:string;
    re:TRegExpr;
    {$ENDIF}
    dummy: string;

Begin
  PCBuffer := 256;

  {$IFDEF Unix}
  (*  assignfile(fl,'/proc/net/dev');
  reset(fl);
  while not eof(fl) do begin
    readln(fl,sl);
    pl:=pos(':',sl);
    if ( pl > 0 ) then begin
      delete(sl, pl, 255);
      while ( sl <> '' ) and (sl[1]=#32) do delete(sl,1,1);
      //writeln(sl);
    end;
  end;
  closefile(fl);  *)
  {$IFDEF Darwin}
  // Mac: interfaces are en0, en1...; use the one carrying the default route
  re:= TRegExpr.Create;
  re.Expression:='interface: (\S+)';
  if RunCommand('/sbin/route', ['-n', 'get', 'default'], response) and re.Exec(response) then
    if RunCommand('/usr/sbin/ipconfig', ['getifaddr', re.Match[1]], dummy) then
      HOSTNAME.caption:=Trim(dummy);
  re.Free;
  {$ELSE}
  RunCommand('/sbin/ifconfig', ['wlan0'], response);
  re:= TRegExpr.Create;
 // If linuxHW='RPI' then re.Expression:='inet ([^ ]+)' else re.Expression:='inet addr:([^ ]+)';
  re.Expression:='inet ([^ ]+)';
  re.Exec(response);
  HOSTNAME.caption:=copy(re.Match[0],6,25);
  if HOSTNAME.caption='' then
  begin
    RunCommand('/sbin/ifconfig', ['eth0'], response);
    re:= TRegExpr.Create;
    re.Expression:='inet ([^ ]+)';
    re.Exec(response);
    HOSTNAME.caption:=copy(re.Match[0],6,25);
  end;
  if HOSTNAME.caption='' then
  begin
    RunCommand('/sbin/ifconfig', ['wlan1'], response);
    re:= TRegExpr.Create;
    re.Expression:='inet ([^ ]+)';
    re.Exec(response);
    HOSTNAME.caption:=copy(re.Match[0],6,25);
  end;
  if HOSTNAME.caption='' then
  begin
    RunCommand('/sbin/ifconfig', ['eth1'], response);
    re:= TRegExpr.Create;
    re.Expression:='inet ([^ ]+)';
    re.Exec(response);
    HOSTNAME.caption:=copy(re.Match[0],6,25);
  end;
  {$ENDIF}
   if HOSTNAME.caption='' then HOSTNAME.caption:='1.1.1.1';
  // if response='' then RunCommand('/sbin/ifconfig', ['eth0'], response);
 //  if response='' then RunCommand('/sbin/ifconfig', ['wlan1'], response);
 //  if response='' then RunCommand('/sbin/ifconfig', ['eth1'], response);

  //RunCommand('/etc/hostname -I', [sl], response);
//  re:= TRegExpr.Create;
//  re.Expression:='inet addr:([^ ]+)';
//  re.Exec(response);

  //RunCommand('/etc/hostname -I',[ ], dummy);

//  HOSTNAME.caption:=copy(re.Match[0],11,30);
  IPtxt.Text:=response;
  //HOSTNAME.caption:=sl;   //(GetHostName);
  {$ENDIF}
  {$IFDEF Windows}
  GetHostName(@s, 128);

  p := GetHostByName(@s);
  HOSTNAME.caption:= iNet_ntoa(PInAddr(p^.h_addr_list^)^);
  if HOSTNAME.caption='' then HOSTNAME.caption:='1.1.1.1';
  {$ENDIF}

end;


procedure TCountdownform.resizewindowfinals;  //change  items on the screen depending on screensize during final (alternating) round
begin

  finalchoose.constraints.minwidth:=trunc ((referencesize*0.10)*mag);
  finalchoose.Width:=trunc ((referencesize*0.10)*mag);
  finalchoose.height:=trunc ((referencesize*0.04)*mag);
  finalchoose.left:=trunc (leftmarge+((referencesize*0.45)));
  finalchoose.Font.Height:=trunc ((referencesize*0.03)*mag);
  rightstart.Width:=trunc ((referencesize*0.10)*mag);
  rightstart.constraints.minwidth:=trunc ((referencesize*0.10));
  rightstart.height:=trunc ((referencesize*0.04)*mag);
  rightstart.left:=trunc (leftmarge+((referencesize*0.55)));
  rightstart.Font.Height:=trunc ((referencesize*0.02)*mag);

  leftstart.Width:=trunc ((referencesize*0.10)*mag);
  leftstart.constraints.minwidth:=trunc ((referencesize*0.10));
  leftstart.height:=trunc ((referencesize*0.04)*mag);
  leftstart.left:=trunc (leftmarge+((referencesize*0.35)));
  leftstart.Font.Height:=trunc ((referencesize*0.02)*mag);

  serienr.Left:=(trunc (referencesize*0.37)+leftmarge);
  serienr.Font.height:=trunc ((referencesize*0.2)*mag);
  serienr.Width:=trunc ((referencesize*0.25)*mag);
  serienr.constraints.minwidth:=trunc ((referencesize*0.25));
  serienr.height:=trunc ((referencesize*0.2)*mag);

  emergencytext.top:=0;
  if finarrow.Checked=true then
  begin
    digit1_1.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002)));
    digit1_1.Font.Height:= trunc (((referencesize*0.45)-(referencesize*leftscale*0.00225))*mag);
    digit1_1.Height:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002))*mag);
    digit1_1.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*leftscale*0.0038))+topmarge);

    digit1_2.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002)));
    digit1_2.Font.Height:= trunc (((referencesize*0.45)-(referencesize*rightscale*0.00225))*mag);
    digit1_2.Height:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002))*mag);
    digit1_2.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*rightscale*0.0038))+topmarge);

    digit2_1.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002)));
    digit2_1.Font.Height:= trunc (((referencesize*0.45)-(referencesize*leftscale*0.00225))*mag);
    digit2_1.Height:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002))*mag);
    digit2_1.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*leftscale*0.0038))+topmarge);

    digit2_2.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002)));
    digit2_2.Font.Height:= trunc (((referencesize*0.45)-(referencesize*rightscale*0.00225))*mag);
    digit2_2.Height:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002))*mag);
    digit2_2.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*rightscale*0.0038))+topmarge);

    digit3_1.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002)));
    digit3_1.Font.Height:= trunc (((referencesize*0.45)-(referencesize*leftscale*0.00225))*mag);
    digit3_1.Height:=trunc (((referencesize*0.4)-(referencesize*leftscale*0.002))*mag);
    digit3_1.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*leftscale*0.0038))+topmarge);

    digit3_2.Constraints.maxheight:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002)));
    digit3_2.Font.Height:= trunc (((referencesize*0.45)-(referencesize*rightscale*0.00225))*mag);
    digit3_2.Height:=trunc (((referencesize*0.4)-(referencesize*rightscale*0.002))*mag);
    digit3_2.Top:=(trunc ((referencesize*-0.05*mag*mag*mag)+(referencesize*rightscale*0.0038))+topmarge);

    dots_1.Font.Height:= trunc (((referencesize*0.29)-(referencesize*leftscale*0.00145))*mag);
    dots_1.Height:=trunc (((referencesize*0.29)-(referencesize*leftscale*0.00145))*mag);
    dots_1.Constraints.maxheight:=trunc(((referencesize*0.29)-(referencesize*leftscale*0.00145)));
    dots_1.Top:=(trunc ((referencesize*+0.02*mag*mag*mag)+(referencesize*leftscale*0.00345))+topmarge);

    dots_2.Font.Height:= trunc (((referencesize*0.29)-(referencesize*rightscale*0.00145))*mag);
    dots_2.Height:=trunc (((referencesize*0.29)-(referencesize*rightscale*0.00145))*mag);
    dots_2.Constraints.maxheight:=trunc(((referencesize*0.29)-(referencesize*rightscale*0.00145)));
    dots_2.Top:=(trunc ((referencesize*+0.02*mag*mag*mag)+(referencesize*rightscale*0.00345))+topmarge);

    setfinalsdigitposition
    end
    else
    begin
      resizewindownonfinals;

    end;

    lefttarget.Font.Height:=trunc ((referencesize*0.12)*mag);
    lefttarget.Width:=trunc ((referencesize*0.12)*mag);
    lefttarget.constraints.minwidth:=trunc ((referencesize*0.12));
    lefttarget.height:=trunc ((referencesize*0.12)*mag);
    lefttarget.top:=(trunc (referencesize*0.52)+topmarge);
    lefttarget.left:=(trunc (referencesize*0.001)+leftmarge);

    righttarget.Font.Height:=trunc ((referencesize*0.12)*mag);
    righttarget.Width:=trunc ((referencesize*0.12)*mag);
    righttarget.constraints.minwidth:=trunc ((referencesize*0.12));
    righttarget.height:=trunc ((referencesize*0.12)*mag);
    righttarget.top:=(trunc (referencesize*0.52)+topmarge);
    righttarget.left:=(trunc (referencesize*0.88)+leftmarge);
end;
Procedure TCountdownform.midbartop;
begin
  if ((((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true))and(changeendturntimer.Enabled=false)) and (state=1) and (nrofbeeps=0))  then
  begin
    shooter1.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
    shooter2.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
    shooter3.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
    shooter4.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
    shooter5.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
    shooter6.top:=Countdownform.height-iconsize-(trunc (referencesize*0.26));
  end
  else
  begin
    shooter1.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
    shooter2.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
    shooter3.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
    shooter4.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
    shooter5.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
    shooter6.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
  end;
end;

procedure TCountdownform.resizewindownonfinals;    //change  items on the screen depending on screensize during regular match (not alternating)
var pitch, pshift, psize:real;
begin
  digit1_1.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit1_1.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit1_1.Height:=trunc ((referencesize*0.5)*mag);
  digit1_1.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  digit2_1.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit2_1.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit2_1.Height:=trunc ((referencesize*0.5)*mag);
  digit2_1.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  digit3_1.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit3_1.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit3_1.Height:=trunc ((referencesize*0.5)*mag);
  digit3_1.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  dots_1.Constraints.maxheight:=trunc((referencesize*0.36));

  dots_1.Height:=trunc ((referencesize*0.36)*mag);
  dots_1.Font.Height:= trunc ((referencesize*0.36*mag));
  dots_1.Top:=(trunc (referencesize*+0.03*mag*mag*mag)+topmarge);
  setnonfinalsdigitposition;
  digit1_2.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit1_2.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit1_2.Height:=trunc ((referencesize*0.5)*mag);
  digit1_2.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  digit2_2.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit2_2.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit2_2.Height:=trunc ((referencesize*0.5)*mag);
  digit2_2.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  digit3_2.Constraints.maxheight:=trunc ((referencesize*0.5));
  digit3_2.Font.Height:= trunc ((referencesize*0.57)*mag);
  digit3_2.Height:=trunc ((referencesize*0.5)*mag);
  digit3_2.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

  dots_2.Constraints.maxheight:=trunc((referencesize*0.36));

  dots_2.Height:=trunc ((referencesize*0.36)*mag);
  dots_2.Font.Height:= trunc ((referencesize*0.36*mag));
  dots_2.Top:=(trunc (referencesize*+0.03*mag*mag*mag)+topmarge);

  case shooters of
    1,2,3,4:
    begin
      pshift:=1;
      pitch:=1;
      psize:=1;
      ptop:=1;
    end;
    5:
    begin
      pshift:=0.8;
      pitch:=0.8;
      psize:=0.9;
      ptop:=1.025;
    end;
    6:
    begin
      pshift:=0.68;
      pitch:=0.660;
      psize:=0.8;
      ptop:=1.05;
    end;
    else
    begin
      pshift:=1;
      pitch:=1;
      psize:=1;
      ptop:=1;
    end;
  end;

  shooteronearrow.Font.Height:=trunc ((referencesize*0.14)*mag);
  shooteronearrow.Width:=trunc ((referencesize*0.55)*mag);
  shooteronearrow.constraints.minwidth:=trunc ((referencesize*0.55));
  shooteronearrow.height:=trunc ((referencesize*0.14)*mag);
  shooteronearrow.top:=(trunc(referencesize*0.46)+topmarge);
  shooteronearrow.left:=(trunc (referencesize*0.15)+leftmarge);

  shooteronearrownr.Font.Height:=trunc ((referencesize*0.25)*mag);
  shooteronearrownr.Width:=trunc ((referencesize*1)*mag);
  shooteronearrownr.constraints.minwidth:=trunc ((referencesize*1));
  shooteronearrownr.height:=trunc ((referencesize*0.25)*mag);
  shooteronearrownr.top:=(trunc(referencesize*0.41)+topmarge);
  shooteronearrownr.left:=(trunc (referencesize*0.70)+leftmarge);

  TOPshooterlet.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  TOPshooterlet.Width:=trunc ((referencesize*0.3)*mag*psize);
  TOPshooterlet.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  TOPshooterlet.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  TOPshooterlet.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  TOPshooterlet.height:=trunc ((referencesize*0.25)*mag);
  TOPshooterlet.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
  TOPshooterlet.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*3*0.5*pshift))+leftmarge);

  TOPshootertxt.Font.Height:=trunc ((referencesize*0.20)*mag*mag*psize);
  TOPshootertxt.Width:=trunc ((referencesize*0.3)*mag*psize);
  TOPshootertxt.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  TOPshootertxt.height:=trunc ((referencesize*0.25)*mag);
  TOPshootertxt.top:=(trunc (referencesize*0.45 *ptop)+topmarge);
  TOPshootertxt.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.80*0.5*pshift))+trunc (referencesize*0.2*pitch)+trunc(leftmarge));

  BOTshooterlet.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  BOTshooterlet.Width:=trunc ((referencesize*0.3)*mag*psize);
  BOTshooterlet.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  BOTshooterlet.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  BOTshooterlet.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  BOTshooterlet.height:=trunc ((referencesize*0.25)*mag);
  BOTshooterlet.top:=(trunc (referencesize*0.41 *ptop)+topmarge);
  BOTshooterlet.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*3*0.5*pshift))+leftmarge);

  BOTshootertxt.Font.Height:=trunc ((referencesize*0.2)*mag*mag*psize);
  BOTshootertxt.Width:=trunc ((referencesize*0.3)*mag*psize);
  BOTshootertxt.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  BOTshootertxt.height:=trunc ((referencesize*0.25)*mag);
  BOTshootertxt.top:=(trunc (referencesize*0.45 *ptop)+topmarge);
  BOTshootertxt.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.80*0.5*pshift))+trunc (referencesize*0.2*pitch)+trunc(leftmarge));

  shooter1.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter1.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter1.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter1.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter1.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter1.height:=trunc ((referencesize*0.25)*mag);
  shooter1.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+leftmarge);

  shooter2.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter2.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter2.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter2.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter2.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter2.height:=trunc ((referencesize*0.25)*mag);
  shooter2.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+trunc (referencesize*0.2*pitch)+trunc(leftmarge));

  shooter3.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter3.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter3.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter3.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter3.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter3.height:=trunc ((referencesize*0.25)*mag);
  shooter3.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+trunc (referencesize*0.4*pitch)+trunc(leftmarge));

  shooter4.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter4.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter4.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter4.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter4.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter4.height:=trunc ((referencesize*0.25)*mag);
  shooter4.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+trunc (referencesize*0.6*pitch)+trunc(leftmarge));

  shooter5.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter5.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter5.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter5.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter5.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter5.height:=trunc ((referencesize*0.25)*mag);
  shooter5.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+trunc (referencesize*0.8*pitch)+trunc(leftmarge));

  shooter6.Font.Height:=trunc ((referencesize*0.25)*mag*psize);
  shooter6.Width:=trunc ((referencesize*0.3)*mag*psize);
  shooter6.constraints.minwidth:=trunc ((referencesize*0.2*psize));
  shooter6.constraints.maxwidth:=trunc ((referencesize*0.15*psize));
  shooter6.constraints.maxheight:=trunc ((referencesize*0.22*psize));
  shooter6.height:=trunc ((referencesize*0.25)*mag);
  shooter6.left:=(trunc (referencesize*0.59)-(trunc (referencesize*0.23*Shooters*0.5*pshift))+trunc (referencesize*1*pitch)+trunc(leftmarge));

  midbartop;
  if archerysystem<>'fitafin' then
  begin
    if ((archerysystem='follow') and (followsystem='2')) then
    begin
      serienr.Top:=(trunc (referencesize*0.4)+topmarge);
      serienr.Left:=(trunc (referencesize*0.37)+leftmarge);
      serienr.Font.height:=trunc ((referencesize*0.2)*mag);
      serienr.Width:=trunc ((referencesize*0.25)*mag);
      serienr.constraints.minwidth:=trunc ((referencesize*0.25));
      serienr.height:=trunc ((referencesize*0.2)*mag);
    end
    else
    begin
      if ((Shooters>2) or (archerysystem<>'fita')) then
      begin
        serienr.Top:=(trunc (referencesize*0.48)+topmarge);
        serienr.Left:=(trunc (referencesize*0.033)+leftmarge);

        serienr.Font.height:=trunc ((referencesize*0.09)*mag);
        serienr.Width:=trunc ((referencesize*0.09)*mag);
        serienr.constraints.minwidth:=trunc ((referencesize*0.09));
        serienr.height:=trunc ((referencesize*0.08)*mag);

        Practise.Top:= (trunc (referencesize*0.485)+topmarge);
        Practise.Left:=(trunc (referencesize*0.00001)+leftmarge);
        Practise.Font.height:=trunc ((referencesize*0.08)*mag);
        Practise.Width:=trunc ((referencesize*0.045)*mag);
        Practise.constraints.minwidth:=trunc ((referencesize*0.045)*mag);
        Practise.height:=trunc ((referencesize*0.08)*mag);
      end
      else
      begin
        serienr.Top:=(trunc (referencesize*0.45)+topmarge);
        serienr.Left:=(trunc (referencesize*0.037)+leftmarge);
        serienr.Font.height:=trunc ((referencesize*0.09)*mag*2);
        serienr.Width:=trunc ((referencesize*0.09)*mag*2);
        serienr.constraints.minwidth:=trunc ((referencesize*0.09*2));
        serienr.height:=trunc ((referencesize*0.08)*mag*2);

        Practise.Top:= (trunc (referencesize*0.475)+topmarge);
        Practise.Left:=(trunc (referencesize*0.00001)+leftmarge);
        Practise.Font.height:=trunc ((referencesize*0.08*1.5)*mag);
        Practise.Width:=trunc ((referencesize*0.045*1.5)*mag);
        Practise.constraints.minwidth:=trunc ((referencesize*0.045*1.5)*mag);
        Practise.height:=trunc ((referencesize*0.08*1.5)*mag);
      end;
    end;
  end;
  viewstateone;
  emergencytext.top:=0;
end;

procedure TCountdownform.resizewindowall;     //change  items on the screen depending on screensize. Independent what type of match
begin
  resizewindowTL;
  resizewindowsingleclock;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowpreclock;
  resizewindowlabelsiconsmenu;
end;

procedure TCountdownform.serialport1Change(Sender: TObject);
begin
  serial.Device:=serialport1.Text;
    if arduinoselect1.checked=true then
    begin
      serial.close;
      if initializationstate=false then connect;
    end;
end;



procedure TCountdownform.show_commercialTimer(Sender: TObject);
//please leave this commercial in the software. Or at least keep the text www.archeryclock.com on
//thes screen during state 1 (waiting)
//This is a free timer to give archeryclubs the possibility to hava an archerytimer for minimum costs.
//But this is the only way to let them know it exists.
var MousePos: TPoint;
begin
  labelnr :=labelnr +1;
  if labelnr>25 then labelnr:=1;
  case labelnr of
  2,3: archeryclock.caption:='Free';
  4: archeryclock.caption:='Archery';
  5: begin
       archeryclock.caption:='CountDown';
    end;
  6:
    begin
      archeryclock.caption:='Timer';
    end
    else archeryclock.caption:='www.archeryclock.com';
  end;
end;

procedure TCountdownform.TLgrnleftoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setgreen;
end;

procedure TCountdownform.TLgrnleftonClick(Sender: TObject);
begin
  If archerysystem='manual' then setgreen;
end;

procedure TCountdownform.TLgrnrightoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setgreen;
end;

procedure TCountdownform.TLgrnrightonClick(Sender: TObject);
begin
  If archerysystem='manual' then setgreen;
end;

procedure TCountdownform.TLorangeleftoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setorange;
end;

procedure TCountdownform.TLorangeleftonClick(Sender: TObject);
begin
  If archerysystem='manual' then setorange;
end;

procedure TCountdownform.TLorangerightoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setorange;
end;

procedure TCountdownform.TLorangerightonClick(Sender: TObject);
begin
  If archerysystem='manual' then setorange;
end;

procedure TCountdownform.TLredleftoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setred;
end;

procedure TCountdownform.TLredleftonClick(Sender: TObject);
begin
  If archerysystem='manual' then setred;
end;

procedure TCountdownform.TLredrightoffClick(Sender: TObject);
begin
  If archerysystem='manual' then setred;
end;

procedure TCountdownform.TLredrightonClick(Sender: TObject);
begin
  If archerysystem='manual' then setred;
end;


procedure TCountdownform.UDP1Receive(aSocket: TLSocket);
var
  s: string;
begin
  if aSocket.GetMessage(s) > 0 then
  begin
    PCnameLabel.Caption:=s;

  end;
end;

procedure TCountdownform.UDPfollowReceive(aSocket: TLSocket);
var
  s: string;
begin
  if aSocket.GetMessage(s) > 0 then
  begin
  end;
end;


procedure TCountdownform.viewleftClick(Sender: TObject);
begin
  showtarget.Checked:=false;
  showtarget.Enabled:=false;
  startupscenario.Text:='--';
  viewchangestateactive;
  viewchangestateexchange;
  TLleft.Checked:=true;
  switchbox;
  TLswitch;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowfinals;
  resizewindowTL;
  resizewindowlabelsiconsmenu;

end;

procedure TCountdownform.viewrightClick(Sender: TObject);
begin
  showtarget.Checked:=false;
  showtarget.Enabled:=false;
  startupscenario.Text:='--';

  viewchangestateactive;
  viewchangestateexchange;
  TLright.Checked:=true;
  switchbox;
  TLswitch;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowfinals;
  resizewindowTL;
  resizewindowlabelsiconsmenu;

end;
procedure TCountdownform.resizewindowreferencing;
//all resize items when window size changes. independing of system type.
begin
  if ((timeseqpanel.visible=true)or(savesettings.Visible=true))then
  begin
    screenwidth:=Countdownform.Width-menuwidth;
    screenheight:=trunc(Countdownform.height*(screenwidth / Countdownform.Width ))
  end
  else
  begin
    screenwidth:=Countdownform.Width;
    screenheight:=Countdownform.height;
  end;

  if (usetraffic.checked=true) or (archerysystem='manual') or ((archerysystem='follow') and (followsystem='4')) then //trafic lights are shown on the sreen so characters and letters need to be smaller
  begin
    aspectratio:= 1.65;   //total shown characters and pictures is widescreen because traffic lights are added next to the countdown
    if (screenwidth *1) > (Countdownform.height * aspectratio) then
    begin  //used screen is wider than aspect ratio, so size of characters is based on height of screen
      referencesize:=trunc(Countdownform.height * 1.33);

      if  ((archerysystem<>'fitafin') or ((archerysystem='fitafin')and (finarrow.Checked=false))) then
      begin          //It is not a finalround so trafic lights are only on one side. So horizontal position of countdown is depending on the location of the trafic lights (left ot right)
         if (TLright.checked=true)then leftmarge:=(trunc(((screenwidth*0.376)-(referencesize* 0.376*1.25))*1.4)) else leftmarge:=(trunc(((screenwidth* 0.376)-(referencesize* 0.376 /1.65))*1.15));
      end
      else
      begin     // it is a final round, so trafic lights are on both sides and countdown is still in the middle
        leftmarge:=((trunc(screenwidth-referencesize))div 2);
      end;
      topmarge:=0;
    end
    else
    begin  //used screen is smaller than aspect ratio, so size of characters is based on width of screen
      referencesize:= trunc (screenwidth * 1.33 /aspectratio) ;
      if  ((archerysystem<>'fitafin') or ((archerysystem='fitafin')and (finarrow.Checked=false))) then
      begin  //It is not a finalround so trafic lights are only on one side. So horizontal position of countdown is depending on the location of the trafic lights (left ot right)
        if (TLright.checked=true) then leftmarge:=0 else leftmarge:=(trunc(screenwidth-referencesize));
      end
      else
      begin
        leftmarge:=((trunc(screenwidth-referencesize))div 2);
      end;
      topmarge:=((trunc((Countdownform.height * 1.33)-referencesize))div 2);

    end;
  end
  else       //trafic lights are not shown on the sreen so characters and letters need to be bigger
  begin
    aspectratio:= 1.33;  //total shown characters and pictures is  not widescreen (4:3) because traffic lights are not added next to the countdown
    if (screenwidth *1) > (Countdownform.height * aspectratio) then
    begin  //used screen is wider than aspect ratio, so size of characters is based on height of screen
      referencesize:=trunc(Countdownform.height * 1.33 );
      leftmarge:=((trunc(screenwidth-referencesize))div 2);
      topmarge:=0;
    end
    else
    begin  //used screen is smaller than aspect ratio, so size of characters is based on width of screen
      referencesize:= trunc (screenwidth) ;
      leftmarge:=0;
      topmarge:=((trunc((Countdownform.height * 1.33)-referencesize))div 2);
    end;
  end;
  //Size of the icons is depending on the windowsize
  if (Countdownform.Width *1) > (Countdownform.height * 1.33) then
  begin
    iconsize:=trunc(Countdownform.height * 1.33/38 *(magnification.value+7)/10 );
  end
  else
  begin
    iconsize:= trunc (Countdownform.Width/38 *(magnification.value+7)/10) ;
  end;
 // if iconsize > 25 then iconsize:=25*magnification.value div 10;    //But size of the Icons does not need to be bigger than 25.
  //Addapt the size of the copyright header to the references size
  copyright.Font.Height:= trunc ((referencesize*0.02)*mag*mag);
  if Fbutonscreenbox.Checked=false then copyright.top:=0 else copyright.top:=iconsize ;
  copyright.left:=iconsize+leftmarge;
  copyright.width:= trunc (referencesize-iconsize-iconsize);
  copyright.constraints.minwidth:= trunc (referencesize-iconsize-iconsize);

  archeryclock.font.height:=trunc ((referencesize*0.06)*mag);
  archeryclock.left:=leftmarge;
  archeryclock.Width:= trunc (referencesize*1);
  archeryclock.constraints.minwidth:= trunc (referencesize*1);

  sheetdatetime1label.font.height:=trunc ((referencesize*0.15)*mag);
  sheetdatetime1label.left:=leftmarge;
  sheetdatetime1label.Width:= trunc (referencesize*1);
  sheetdatetime1label.constraints.minwidth:= trunc (referencesize*1);

  sheetdatetime2label.font.height:=trunc ((referencesize*0.21)*mag*mag);
  sheetdatetime2label.left:=leftmarge;
  sheetdatetime2label.Width:= trunc (referencesize*1);
  sheetdatetime2label.constraints.minwidth:= trunc (referencesize*1);

  sheetdatetime3label.font.height:=trunc ((referencesize*0.14)*mag);
  sheetdatetime3label.left:=leftmarge;
  sheetdatetime3label.Width:= trunc (referencesize*1);
  sheetdatetime3label.constraints.minwidth:= trunc (referencesize*1);

  sheetdatetime4label.font.height:=trunc ((referencesize*0.15)*mag);
  sheetdatetime4label.left:=leftmarge;
  sheetdatetime4label.Width:= trunc (referencesize*1);
  sheetdatetime4label.constraints.minwidth:= trunc (referencesize*1);

  if fullscreencheckbox.Checked=false then
  begin
    background1.Left:=leftmarge;
    background1.Width:=trunc (referencesize*1);
    background1.Height:= (screenheight-(trunc (referencesize*0.07)));
    background1.Top:=(Countdownform.height-screenheight)*2 div 3;
  end
  else
  begin
    background1.Left:=0;
    background1.Width:=screenwidth;
    background1.Height:= screenheight;
    background1.Top:=(Countdownform.height-screenheight)*2 div 3;
  end;

  if (Length(emergencytext.Caption)>3) then emergencytext.font.height:=trunc ((referencesize*2.0)*mag*mag/(Length(emergencytext.Caption))) else emergencytext.font.height:=trunc ((referencesize*2.0)*mag*mag/4) ;
  emergencytext.left:=leftmarge;
  emergencytext.Width:= trunc ((referencesize*1));
  emergencytext.constraints.minwidth:= trunc (referencesize*1);
  emergencytext.Constraints.MinHeight:=Countdownform.height;
  emergencytext.Constraints.MaxHeight:=Countdownform.height;
  emergencytext.height:=Countdownform.height;

  websitename.Width:= trunc (referencesize);
  websitename.left:=leftmarge;
  websitename.top:=(trunc (referencesize*0.625)+topmarge);
  websitename.font.height:=trunc ((referencesize*0.103)*mag);

  bannerpicture.Width:=trunc(referencesize*0.00114*bannerscaling*bannerAR);
  bannerpicture.Height:=trunc(referencesize*0.00114*bannerscaling);
  bannerpicture.Top:=(trunc (referencesize*0.59)+topmarge);
  bannerpicture.Left:=(trunc (referencesize*0.5)+ leftmarge - trunc(referencesize*0.00057*bannerscaling*bannerAR));

end;

procedure TCountdownform.resizewindowsingleclock;
begin
  serielabel.Top:=(trunc (referencesize*0.45)+topmarge);
  serielabel.Left:=(trunc (referencesize*0.008)+leftmarge);
  serielabel.Font.height:=trunc ((referencesize*0.035)*mag);
  serielabel.Width:=trunc ((referencesize*0.09)*mag);
  serielabel.constraints.minwidth:=trunc ((referencesize*0.09)*mag);
  serielabel.height:=trunc ((referencesize*0.035)*mag);

  arrowlabel.Top:=(trunc (referencesize*0.45)+topmarge);
  arrowlabel.Left:=(trunc (referencesize*0.008)+leftmarge);
  arrowlabel.Font.height:=trunc ((referencesize*0.035)*mag);
  arrowlabel.Width:=trunc ((referencesize*0.08)*mag);
  arrowlabel.constraints.minwidth:=trunc ((referencesize*0.08)*mag);
  arrowlabel.height:=trunc ((referencesize*0.035)*mag);

  turnlabel.Top:= (trunc (referencesize*0.45)+topmarge);
  turnlabel.Left:=(trunc (referencesize*0.88)+leftmarge);
  turnlabel.Font.height:=trunc ((referencesize*0.035)*mag);
  turnlabel.Width:=trunc ((referencesize*0.08)*mag);
  turnlabel.constraints.minwidth:=trunc ((referencesize*0.08)*mag);
  turnlabel.height:=trunc ((referencesize*0.035)*mag);


  shooternr.Top:=(trunc (referencesize*0.48)+topmarge);
  shooternr.Left:=(trunc (referencesize*0.88)+leftmarge);
  shooternr.Font.height:=trunc ((referencesize*0.07)*mag);
  shooternr.Width:=trunc ((referencesize*0.09)*mag);
  shooternr.constraints.minwidth:=trunc ((referencesize*0.09)*mag);
  shooternr.height:=trunc ((referencesize*0.06)*mag);

end;

procedure TCountdownform.resizewindowpreclock;
begin
  beforestartbg.Left:=leftmarge;
  beforestartbg.Top:=(trunc (referencesize*0.03)+topmarge);
  beforestartbg.Width:=(trunc (referencesize*0.644*1.55));
  beforestartbg.height:=(trunc (referencesize*0.266*1.55));

  beforestarttxt2.Left:=(trunc (referencesize*0.12)+ leftmarge);
  beforestarttxt2.top:=(trunc (referencesize*0.39)+topmarge);
  beforestarttxt2.Font.height:=trunc ((referencesize*0.065)*mag);
  beforestarttxt2.Width:=trunc (referencesize*0.76);
  beforestarttxt2.constraints.minwidth:=trunc (referencesize*0.76);
  beforestarttxt2.height:=trunc (referencesize*0.055);

  beforestarttxt1.Left:=(trunc (referencesize*0.12)+ leftmarge);
  beforestarttxt1.top:=(trunc (referencesize*0.02)+topmarge);
  beforestarttxt1.Font.height:=trunc ((referencesize*0.062)*mag*mag);
  beforestarttxt1.Width:=trunc (referencesize*0.77);
  beforestarttxt1.constraints.minwidth:=trunc (referencesize*0.77);
  beforestarttxt1.height:=trunc (referencesize*0.065);

  if (strtoint(digit1_3.Caption)<10) then
  begin
    if prelayoutradio1.Checked=true then
    begin
      digit1_3.Constraints.maxheight:=trunc ((referencesize*0.4));
      digit1_3.Font.Height:= trunc ((referencesize*0.47)*mag);
      digit1_3.Height:=trunc ((referencesize*0.4)*mag);
      digit1_3.Top:=(trunc (referencesize*-0.01)+topmarge);

      digit2_3.Constraints.maxheight:=trunc ((referencesize*0.4));
      digit2_3.Font.Height:= trunc ((referencesize*0.47)*mag);
      digit2_3.Height:=trunc ((referencesize*0.4)*mag);
      digit2_3.Top:=(trunc (referencesize*-0.01)+topmarge);

      digit3_3.Constraints.maxheight:=trunc ((referencesize*0.4));
      digit3_3.Font.Height:= trunc ((referencesize*0.47)*mag);
      digit3_3.Height:=trunc ((referencesize*0.4)*mag);
      digit3_3.Top:=(trunc (referencesize*-0.01)+topmarge);


      dots_3.Font.Height:= trunc ((referencesize*0.29)*mag);
      dots_3.Height:=trunc ((referencesize*0.29)*mag);
      dots_3.Constraints.maxheight:=trunc((referencesize*0.9));
      dots_3.Top:=(trunc (referencesize*+0.07)+topmarge);
      digit1_3.Left:= (trunc (referencesize*0.1)+leftmarge);
      dots_3.Left:= (trunc (referencesize*0.35)+leftmarge);
      digit2_3.Left:= (trunc (referencesize*0.43)+leftmarge);
      digit3_3.Left:= (trunc (referencesize*0.68)+leftmarge);
    end
    else
    begin
      digit1_3.Constraints.maxheight:=trunc ((referencesize*0.5));
      digit1_3.Font.Height:=trunc ((referencesize*0.57)*mag);
      digit1_3.Height:=trunc ((referencesize*0.5)*mag);
      digit1_3.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

      digit2_3.Constraints.maxheight:=trunc ((referencesize*0.5));
      digit2_3.Font.Height:=trunc ((referencesize*0.57)*mag);
      digit2_3.Height:=trunc ((referencesize*0.5)*mag);
      digit2_3.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);

      digit3_3.Constraints.maxheight:=trunc ((referencesize*0.5));
      digit3_3.Font.Height:=trunc ((referencesize*0.57)*mag);
      digit3_3.Height:=trunc ((referencesize*0.5)*mag);
      digit3_3.Top:=(trunc (referencesize*-0.07*mag*mag*mag)+topmarge);


      dots_3.Font.Height:= trunc ((referencesize*0.36*mag));
      dots_3.Height:=trunc ((referencesize*0.36)*mag);
      dots_3.Constraints.maxheight:=trunc((referencesize*0.36));
      dots_3.Top:=(trunc (referencesize*+0.03*mag*mag*mag)+topmarge);
      digit1_3.Left:= (trunc (referencesize*0.001)+leftmarge);
      dots_3.Left:= (trunc (referencesize*0.29)+leftmarge);
      digit2_3.Left:=(trunc (referencesize*0.38)+leftmarge);
      digit3_3.Left:= (trunc (referencesize*0.68)+leftmarge);
    end;
  end
  else
  begin
    if prelayoutradio1.Checked=true then
    begin
      digit1_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit1_3.Font.Height:= trunc ((referencesize*0.38)*mag);
      digit1_3.Height:=trunc ((referencesize*0.44)*mag);
      digit1_3.Top:=(trunc (referencesize*0.03)+topmarge);

      digit2_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit2_3.Font.Height:= trunc ((referencesize*0.38)*mag);
      digit2_3.Height:=trunc ((referencesize*0.44)*mag);
      digit2_3.Top:=(trunc (referencesize*0.03)+topmarge);

      digit3_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit3_3.Font.Height:= trunc ((referencesize*0.38)*mag);
      digit3_3.Height:=trunc ((referencesize*0.44)*mag);
      digit3_3.Top:=(trunc (referencesize*0.03)+topmarge);


      dots_3.Font.Height:= trunc ((referencesize*0.25)*mag);
      dots_3.Height:=trunc ((referencesize*0.25)*mag);
      dots_3.Constraints.maxheight:=trunc((referencesize*0.8));
      dots_3.Top:=(trunc (referencesize*+0.075)+topmarge);
      digit1_3.Left:= (trunc (referencesize*0.08)+leftmarge);
      dots_3.Left:= (trunc (referencesize*0.48)+leftmarge);
      digit2_3.Left:= (trunc (referencesize*0.55)+leftmarge);
      digit3_3.Left:= (trunc (referencesize*0.75)+leftmarge);
    end
    else
    begin
      digit1_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit1_3.Font.Height:= trunc ((referencesize*0.44)*mag);
      digit1_3.Height:=trunc ((referencesize*0.44)*mag);
      digit1_3.Top:=(trunc (referencesize*-0.001)+topmarge);

      digit2_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit2_3.Font.Height:= trunc ((referencesize*0.44)*mag);
      digit2_3.Height:=trunc ((referencesize*0.44)*mag);
      digit2_3.Top:=(trunc (referencesize*-0.001)+topmarge);

      digit3_3.Constraints.maxheight:=trunc ((referencesize*0.44));
      digit3_3.Font.Height:= trunc ((referencesize*0.44)*mag);
      digit3_3.Height:=trunc ((referencesize*0.44)*mag);
      digit3_3.Top:=(trunc (referencesize*-0.001)+topmarge);

      dots_3.Font.Height:= trunc ((referencesize*0.29)*mag);
      dots_3.Height:=trunc ((referencesize*0.25)*mag);
      dots_3.Constraints.maxheight:=trunc((referencesize*0.8));
      dots_3.Top:=(trunc (referencesize*+0.05)+topmarge);
      digit1_3.Left:= (trunc (referencesize*0.001)+leftmarge);
      dots_3.Left:= (trunc (referencesize*0.445)+leftmarge);
      digit2_3.Left:= (trunc (referencesize*0.52)+leftmarge);
      digit3_3.Left:= (trunc (referencesize*0.75)+leftmarge);
    end;
  end;
end;

procedure TCountdownform.resizewindowfinalturndetails;
begin
  greenleft.Width:=trunc (referencesize*0.40);
  greenleft.height:=trunc (referencesize*0.14);
  greenleft.left:=trunc (leftmarge);
  greyleft.Width:=trunc (referencesize*0.40);
  greyleft.height:=trunc (referencesize*0.14);
  greyleft.left:=trunc (leftmarge);
  greenright.Width:=trunc (referencesize*0.40);
  greenright.height:=trunc (referencesize*0.14);
  greenright.left:=trunc (leftmarge+((referencesize*0.60)));
  greyright.Width:=trunc (referencesize*0.40);
  greyright.height:=trunc (referencesize*0.14);
  greyright.left:=trunc (leftmarge+((referencesize*0.60)));
  serienr.Left:=(trunc (referencesize*0.37)+leftmarge);
  serienr.Font.height:=trunc ((referencesize*0.2)*mag);
  serienr.Width:=trunc ((referencesize*0.25)*mag);
  serienr.constraints.minwidth:=trunc ((referencesize*0.25));
  serienr.height:=trunc ((referencesize*0.2)*mag);
end;


procedure TCountdownform.resizewindowlabelsiconsmenu;
begin
  savesettings.Top:=iconsize;
  savesettings.left:=(trunc(Countdownform.Width-menuwidth));
  timeseqpanel.Top:=iconsize;
  timeseqpanel.left:=(trunc(Countdownform.Width-menuwidth));
  timeseqpanel.Width:=menuwidth;
  savesettings.Width:=menuwidth;
  savesettings.Height:=(trunc(Countdownform.Height-iconsize-iconsize));
  iconpanel.Height:=savesettings.Height-161;
  iconpanel.Top:=103;
  iconpanel.Left:=336;
  {$IFDEF Windows}
  iconpanel.Height:=savesettings.Height-161;
  IconScrollBox.Height:=savesettings.Height-171;
  iconpanel.Top:=100;
  iconpanel.Left:=330;
  iconpanel.Width:=88;
  IconScrollBox.Width:=82;
  {$ENDIF}
  {$IFDEF Unix}
  iconpanel.Height:=savesettings.Height-162;
  IconScrollBox.Height:=savesettings.Height-172;
  iconpanel.Top:=103;
  iconpanel.Left:=336;
  iconpanel.Width:=82;
  IconScrollBox.Width:=72;
  {$ENDIF}
  {$IFDEF Darwin}
  // Cocoa group boxes have a wider border than Windows ones: place the close crosses by the inside width.
  // The cross is also stretched into a 14 x 29 slot; make the slot square so it isn't squashed.
  closeimage1.Width:=closeimage1.Height;
  closeimage2.Width:=closeimage2.Height;
  closeimage1.Proportional:=true;
  closeimage2.Proportional:=true;
  closeimage1.Left:=timeseqpanel.ClientWidth-closeimage1.Width-4;
  closeimage2.Left:=savesettings.ClientWidth-closeimage2.Width-4;
  closeimage1.BringToFront; // the system pictures reach the right edge here and covered it
  closeimage2.BringToFront;
  {$ENDIF}

  ShutdownremoteButton.Top:=savesettings.Height-55;
  timeseqpanel.Height:=(trunc(Countdownform.Height-iconsize-iconsize));
  blinkredgroupbox.Top:=timeseqpanel.Height-77;

  FollowScrollBox.Height:=(trunc(Countdownform.Height-iconsize-iconsize-195));
  FITAScrollBox.Height:=(trunc(Countdownform.Height-iconsize-iconsize-195));
  FitaFinScrollBox.Height:=(trunc(Countdownform.Height-iconsize-iconsize-195));
  onearrowScrollBox.Height:=(trunc(Countdownform.Height-iconsize-iconsize-195));
  manualScrollBox.Height:=(trunc(Countdownform.Height-iconsize-iconsize-195));
  SettingsTabs.Height:=(trunc(Countdownform.Height-iconsize-iconsize-140));

  BGScrollBox.Height:=SettingsTabs.Height-38;
  SCRcolScrollBox.Height:=SettingsTabs.Height-38;
  soundScrollBox.Height:=SettingsTabs.Height-38;
  networkScrollBox.Height:=SettingsTabs.Height-38;
  ScenarioScrollBox.Height:=SettingsTabs.Height-93;
  HWScrollBox.Height:=SettingsTabs.Height-38;
  controlScrollBox.Height:=SettingsTabs.Height-38;
  Aboutmemo.Height:=SettingsTabs.Height-38;
  emergencyScrollBox.Height:=SettingsTabs.Height-38;
  ;
  enddown.Top:= Countdownform.Height-iconsize; //always left bottom of the screen
  enddown.left:= 0;

  enddown.Width:=iconsize;
  enddown.Height:=iconsize;

  timedown.Width:=iconsize;
  timedown.Height:=iconsize;
  timedown.Left:=(trunc (referencesize)+leftmarge-iconsize);
  timedown.Top:=(trunc (referencesize*0.4)+topmarge-iconsize);

  timeup.Width:=iconsize;
  timeup.Height:=iconsize;
  timeup.Left:=(trunc (referencesize)+leftmarge-iconsize);
  timeup.Top:=(trunc (referencesize*0.07)+topmarge);

  endup.top:= Countdownform.Height-iconsize;
  endup.left:= iconsize;     //allways next to enddown button

  endup.Width:=iconsize;
  endup.Height:=iconsize;

  tup.top:= Countdownform.Height-iconsize;     //always right bottom of the screen
  tup.left:= Countdownform.Width-iconsize;

  tup.Width:=iconsize;
  tup.Height:=iconsize;

  tdown.Top:= Countdownform.Height-iconsize;         //allways next to tup button
  tdown.left:= Countdownform.Width-iconsize-iconsize;

  tdown.Width:=iconsize;
  tdown.Height:=iconsize;

  nexticon.top:= Countdownform.height-iconsize-1;       //allways bottom middle
  nexticon.Left:= trunc (Countdownform.Width*0.5)-(iconsize div 2);
  nexticon.Width:=iconsize;
  nexticon.height:=iconsize;

  SOicon.top:= Countdownform.height-iconsize-1;
  SOicon.Left:= trunc (Countdownform.Width*6/23)-(iconsize div 2);
  SOicon.Width:=iconsize;
  SOicon.Height:=iconsize;

  preptime.top:=Countdownform.height-iconsize-1;
  preptime.Left:=trunc (Countdownform.Width*7/23)-(iconsize div 2);
  preptime.Width:=iconsize;
  preptime.Height:=iconsize;
  countdowntostart.Top:=Countdownform.height-iconsize+1;
  countdowntostart.Left:=trunc (Countdownform.Width*7/23)+(iconsize div 2);
  countdowntostart.Font.Size:=iconsize div 3;

  resizeicon.top:=1;            //alway left top side
  resizeicon.Left:=1;
  resizeicon.Width:=iconsize;
  resizeicon.Height:=iconsize;

  Startuplabel.Constraints.MaxWidth:=Countdownform.Width div 2;
  Startuplabel.Constraints.MinWidth:=Countdownform.Width div 2;
  Startuplabel.Width:=Countdownform.Width div 2;
  Startuplabel.Left:=Countdownform.Width div 4;
  Startuplabel.Height:=countdownform.Height div 10;
  Startuplabel.Top:=(countdownform.Height div 2)-(countdownform.Height div 20);
  Startuplabel.Font.Height:=Countdownform.Width div 40;

  closeicon.top:=1;               //always top right side
  closeicon.Left:=Countdownform.Width-iconsize-1;
  closeicon.Width:=iconsize;
  closeicon.Height:=iconsize;

  shutdownicon.top:=1;               //always top right side next to close icon
  shutdownicon.Left:=Countdownform.Width-iconsize-iconsize-1;
  shutdownicon.Width:=iconsize;
  shutdownicon.Height:=iconsize;

  Datetimelabel.Top:=Countdownform.height-iconsize-3;
  Datetimelabel.Left:=iconsize+iconsize;
  Datetimelabel.Font.Height:=iconsize;
  playpauzeicon.top:= Countdownform.height-iconsize-1;
  playpauzeicon.left:=trunc (Countdownform.Width*4/23)-(iconsize div 2);
  playpauzeicon.Width:=iconsize;
  playpauzeicon.Height:=iconsize;

  stopicon.top:= Countdownform.height-iconsize-1;
  stopicon.Left:=trunc(Countdownform.Width*5/23)-(iconsize div 2);
  stopicon.Width:=iconsize;
  stopicon.Height:=iconsize;

  danger.top:= Countdownform.height-iconsize-1;
  danger.Left:=trunc (Countdownform.Width*10/23)-(iconsize div 2)-(iconsize);
  danger.Width:=iconsize;
  danger.Height:=iconsize;

  manualred.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  manualred.Left:=trunc (Countdownform.Width*4/23)-(iconsize div 2);
  manualred.Width:=trunc(1.2*iconsize);
  manualred.Height:=trunc(1.2*iconsize);

  manualorange.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  manualorange.Left:=trunc (Countdownform.Width*5/23)-(iconsize div 2);
  manualorange.Width:=trunc(1.2*iconsize);
  manualorange.Height:=trunc(1.2*iconsize);

  manualgreen.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  manualgreen.Left:=trunc (Countdownform.Width*6/23)-(iconsize div 2);
  manualgreen.Width:=trunc(1.2*iconsize);
  manualgreen.Height:=trunc(1.2*iconsize);

  buzzicon1.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  buzzicon1.Left:=trunc (Countdownform.Width*7/23)-(iconsize div 2);
  buzzicon1.Width:=trunc(1.2*iconsize);
  buzzicon1.Height:=trunc(1.2*iconsize);

  buzzicon2.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  buzzicon2.Left:=trunc (Countdownform.Width*8/23)-(iconsize div 2);
  buzzicon2.Width:=trunc(1.2*iconsize);
  buzzicon2.Height:=trunc(1.2*iconsize);

  buzzicon3.top:= Countdownform.height-trunc(1.2*iconsize)-1;
  buzzicon3.Left:=trunc (Countdownform.Width*9/23)-(iconsize div 2);
  buzzicon3.Width:=trunc(1.2*iconsize);
  buzzicon3.Height:=trunc(1.2*iconsize);

  USB.Top:=Countdownform.height-iconsize-1;
  USB.Left:=trunc (Countdownform.Width*18/23)-(iconsize div 2);
  USB.Width:=iconsize;
  USB.Height:=(iconsize*2) div 3;
  USBconnect.Top:=Countdownform.height-iconsize+1;
  USBconnect.Left:=trunc (Countdownform.Width*14/23)-(iconsize div 2);
  USBconnect.Font.Size:=iconsize div 3;

  settings.top:= Countdownform.height-iconsize-1;
  settings.Left:=trunc (Countdownform.Width*20/23)-(iconsize div 2);
  settings.Width:=iconsize;
  settings.Height:=iconsize;

  clockicon.top:= Countdownform.height-iconsize-1;
  clockicon.Left:=trunc (Countdownform.Width*19/23)-(iconsize div 2);
  clockicon.Width:=iconsize;
  clockicon.Height:=iconsize;

  F1panel.Top:=0;
  F1panel.Width:=iconsize;
  F1panel.Height:=iconsize;
  F1panel.Font.Height:=iconsize div 2;
  F1panel.Left:=trunc (screenwidth*2/14)-(iconsize*2);

  F2panel.Top:=0;
  F2panel.Width:=iconsize;
  F2panel.Height:=iconsize;
  F2panel.Font.Height:=iconsize div 2;
  F2panel.Left:=trunc (screenwidth*3/14)-(iconsize*2);

  F3panel.Top:=0;
  F3panel.Width:=iconsize;
  F3panel.Height:=iconsize;
  F3panel.Font.Height:=iconsize div 2;
  F3panel.Left:=trunc (screenwidth*4/14)-(iconsize*2);

  F4panel.Top:=0;
  F4panel.Width:=iconsize;
  F4panel.Height:=iconsize;
  F4panel.Font.Height:=iconsize div 2;
  F4panel.Left:=trunc (screenwidth*5/14)-(iconsize*2);

  F5panel.Top:=0;
  F5panel.Width:=iconsize;
  F5panel.Height:=iconsize;
  F5panel.Font.Height:=iconsize div 2;
  F5panel.Left:=trunc (screenwidth*6/14)-(iconsize*2);

  F6panel.Top:=0;
  F6panel.Width:=iconsize;
  F6panel.Height:=iconsize;
  F6panel.Font.Height:=iconsize div 2;
  F6panel.Left:=trunc (screenwidth*7/14)-(iconsize*2);

  F7panel.Top:=0;
  F7panel.Width:=iconsize;
  F7panel.Height:=iconsize;
  F7panel.Font.Height:=iconsize div 2;
  F7panel.Left:=trunc (screenwidth*8/14)-(iconsize*2);

  F8panel.Top:=0;
  F8panel.Width:=iconsize;
  F8panel.Height:=iconsize;
  F8panel.Font.Height:=iconsize div 2;
  F8panel.Left:=trunc (screenwidth*9/14)-(iconsize*2);

  F9panel.Top:=0;
  F9panel.Width:=iconsize;
  F9panel.Height:=iconsize;
  F9panel.Font.Height:=iconsize div 2;
  F9panel.Left:=trunc (screenwidth*10/14)-(iconsize*2);

  F10panel.Top:=0;
  F10panel.Width:=iconsize;
  F10panel.Height:=iconsize;
  F10panel.Font.Height:=iconsize div 2;
  F10panel.Left:=trunc (screenwidth*11/14)-(iconsize*2);

  F11panel.Top:=0;
  F11panel.Width:=iconsize;
  F11panel.Height:=iconsize;
  F11panel.Font.Height:=iconsize div 2;
  F11panel.Left:=trunc (screenwidth*12/14)-(iconsize*2);

  F12panel.Top:=0;
  F12panel.Width:=iconsize;
  F12panel.Height:=iconsize;
  F12panel.Font.Height:=iconsize div 2;
  F12panel.Left:=trunc (screenwidth*13/14)-(iconsize*2);

  //hint labels
  {$IFDEF Windows}
  nexthelp.Top:=Countdownform.Height-trunc(iconsize*1.5); //-15;
  chooselabel.Top:=Countdownform.Height-trunc(iconsize*1.5); //-15;
  nexthelp.Left:=trunc (Countdownform.Width*0.5)-100;
  chooselabel.Left:=trunc (Countdownform.Width*0.5)-100;
  {$ENDIF}
  {$IFDEF Unix}
  nexthelp.Top:=Countdownform.Height-iconsize-22;
  chooselabel.Top:=Countdownform.Height-iconsize-22;
  nexthelp.Left:=trunc (Countdownform.Width*0.5)-250;
  chooselabel.Left:=trunc (Countdownform.Width*0.5)-250;
  {$ENDIF}
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: the sizes above are for Windows' group boxes

end;

procedure TCountdownform.resizewindowTL;
begin
  If LOWRES then
  begin
    leftredcircle.Width:=trunc (referencesize*0.22);
    leftredcircle.Height:=trunc (referencesize*0.22);
    leftredcircle.Top:=(trunc (referencesize*0.01)+topmarge);
    leftredcircle.Left:=trunc (leftmarge-(referencesize*0.23));
    leftredcircle.Pen.Width:=trunc (referencesize*0.01);

    leftyelcircle.Width:=trunc (referencesize*0.22);
    leftyelcircle.Height:=trunc (referencesize*0.22);
    leftyelcircle.top:=(trunc (referencesize*0.23)+topmarge);
    leftyelcircle.left:=trunc (leftmarge-(referencesize*0.23));
    leftyelcircle.Pen.Width:=trunc (referencesize*0.01);

    leftgrncircle.Width:=trunc (referencesize*0.22);
    leftgrncircle.Height:=trunc (referencesize*0.22);
    leftgrncircle.top:=(trunc (referencesize*0.45)+topmarge);
    leftgrncircle.left:=trunc (leftmarge-(referencesize*0.23));
    leftgrncircle.Pen.Width:=trunc (referencesize*0.01);

    rightredcircle.Width:=trunc (referencesize*0.22);
    rightredcircle.Height:=trunc (referencesize*0.22);
    rightredcircle.top:=(trunc (referencesize*0.01)+topmarge);
    rightredcircle.left:=trunc (leftmarge+(referencesize*1.01));
    rightredcircle.Pen.Width:=trunc (referencesize*0.01);

    rightyelcircle.Width:=trunc (referencesize*0.22);
    rightyelcircle.Height:=trunc (referencesize*0.22);
    rightyelcircle.top:=(trunc (referencesize*0.23)+topmarge);
    rightyelcircle.left:=trunc (leftmarge+(referencesize*1.01));
    rightyelcircle.Pen.Width:=trunc (referencesize*0.01);

    rightgrncircle.Width:=trunc (referencesize*0.22);
    rightgrncircle.Height:=trunc (referencesize*0.22);
    rightgrncircle.top:=(trunc (referencesize*0.45)+topmarge);
    rightgrncircle.left:=trunc (leftmarge+(referencesize*1.01));
    rightgrncircle.Pen.Width:=trunc (referencesize*0.01);

  end
  else
  begin
    TLredlefton.Width:=trunc (referencesize*0.22);
    TLredlefton.height:=trunc (referencesize*0.22);
    TLredlefton.top:=(trunc (referencesize*0.01)+topmarge);
    TLredlefton.left:=trunc (leftmarge-(referencesize*0.23));

    TLredleftoff.Width:=trunc (referencesize*0.22);
    TLredleftoff.height:=trunc (referencesize*0.22);
    TLredleftoff.top:=(trunc (referencesize*0.01)+topmarge);
    TLredleftoff.left:=trunc (leftmarge-(referencesize*0.23));

    TLorangelefton.Width:=trunc (referencesize*0.22);
    TLorangelefton.height:=trunc (referencesize*0.22);
    TLorangelefton.top:=(trunc (referencesize*0.23)+topmarge);
    TLorangelefton.left:=trunc (leftmarge-(referencesize*0.23));


    TLorangeleftoff.Width:=trunc (referencesize*0.22);
    TLorangeleftoff.height:=trunc (referencesize*0.22);
    TLorangeleftoff.top:=(trunc (referencesize*0.23)+topmarge);
    TLorangeleftoff.left:=trunc (leftmarge-(referencesize*0.23));

    TLgrnlefton.Width:=trunc (referencesize*0.22);
    TLgrnlefton.height:=trunc (referencesize*0.22);
    TLgrnlefton.top:=(trunc (referencesize*0.45)+topmarge);
    TLgrnlefton.left:=trunc (leftmarge-(referencesize*0.23));

    TLgrnleftoff.Width:=trunc (referencesize*0.22);
    TLgrnleftoff.height:=trunc (referencesize*0.22);
    TLgrnleftoff.top:=(trunc (referencesize*0.45)+topmarge);
    TLgrnleftoff.left:=trunc (leftmarge-(referencesize*0.23));

    TLredrighton.Width:=trunc (referencesize*0.22);
    TLredrighton.height:=trunc (referencesize*0.22);
    TLredrighton.top:=(trunc (referencesize*0.01)+topmarge);
    TLredrighton.left:=trunc (leftmarge+(referencesize*1.01));

    TLredrightoff.Width:=trunc (referencesize*0.22);
    TLredrightoff.height:=trunc (referencesize*0.22);
    TLredrightoff.top:=(trunc (referencesize*0.01)+topmarge);
    TLredrightoff.left:=trunc (leftmarge+(referencesize*1.01));

    TLorangerighton.Width:=trunc (referencesize*0.22);
    TLorangerighton.height:=trunc (referencesize*0.22);
    TLorangerighton.top:=(trunc (referencesize*0.23)+topmarge);
    TLorangerighton.left:=trunc (leftmarge+(referencesize*1.01));


    TLorangerightoff.Width:=trunc (referencesize*0.22);
    TLorangerightoff.height:=trunc (referencesize*0.22);
    TLorangerightoff.top:=(trunc (referencesize*0.23)+topmarge);
    TLorangerightoff.left:=trunc (leftmarge+(referencesize*1.01));

    TLgrnrighton.Width:=trunc (referencesize*0.22);
    TLgrnrighton.height:=trunc (referencesize*0.22);
    TLgrnrighton.top:=(trunc (referencesize*0.45)+topmarge);
    TLgrnrighton.left:=trunc (leftmarge+(referencesize*1.01));

    TLgrnrightoff.Width:=trunc (referencesize*0.22);
    TLgrnrightoff.height:=trunc (referencesize*0.22);
    TLgrnrightoff.top:=(trunc (referencesize*0.45)+topmarge);
    TLgrnrightoff.left:=trunc (leftmarge+(referencesize*1.01));

  end;

  L_EndBG.Width:=trunc (referencesize*0.22);
  L_EndBG.height:=trunc (referencesize*0.22);
  Lnextturnbg.Width:=trunc (referencesize*0.29);
  Lnextturnbg.height:=trunc (referencesize*0.29);
  Lnexttxt.Font.height:=trunc ((referencesize*0.042)*mag*mag);
  Lnexttxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  Lnexttxt.Width:=trunc (referencesize*0.29);
  Lnexttxt.height:=trunc (referencesize*0.045);
  Larchertxt.Font.height:=trunc ((referencesize*0.042)*mag*mag);
  Larchertxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  Larchertxt.Width:=trunc (referencesize*0.29);
  Larchertxt.height:=trunc (referencesize*0.045);
  if usetraffic.Checked=true then
  begin
    L_EndBG.top:=(trunc (referencesize*0.23)+topmarge);
    L_EndBG.left:=trunc (leftmarge-(referencesize*0.23));
    Lnextturnbg.left:=trunc (leftmarge-(referencesize*0.266));
    Lnextturnbg.top:=(trunc (referencesize*0.45)+topmarge);
    LABCDtxt.left:=trunc (leftmarge-(referencesize*0.266));
    LENDtxt.left:=trunc (leftmarge-(referencesize*0.266));
    LTRNtxt.left:=trunc (leftmarge-(referencesize*0.266));
    Lnexttxt.left:=trunc (leftmarge-(referencesize*0.266));
    Lnexttxt.top:=(trunc (referencesize*0.49)+topmarge);
    Larchertxt.left:=trunc (leftmarge-(referencesize*0.266));
    Larchertxt.top:=(trunc (referencesize*0.49)+topmarge);
  end
  else
  begin
    L_EndBG.top:=(trunc (referencesize*0.24)+topmarge);
    L_EndBG.left:=0 - trunc ((referencesize*0.02));
    Lnextturnbg.left:=0-trunc(referencesize*0.035);
    Lnextturnbg.top:=countdownform.Height-trunc(referencesize*0.25);
    LABCDtxt.left:=0-trunc(referencesize*0.035);
    LENDtxt.left:=0-trunc(referencesize*0.055);
    LTRNtxt.left:=0-trunc(referencesize*0.055);
    Lnexttxt.left:=0-trunc(referencesize*0.035);
    Lnexttxt.top:=countdownform.Height-trunc(referencesize*0.21);
    Larchertxt.left:=0-trunc(referencesize*0.035);
    Larchertxt.top:=countdownform.Height-trunc(referencesize*0.21);
  end;
  LABCDtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  LABCDtxt.Width:=trunc (referencesize*0.29);
  LABCDtxt.height:=trunc (referencesize*0.2);
  LENDtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  LENDtxt.Width:=trunc (referencesize*0.29);
  LENDtxt.height:=trunc (referencesize*0.2);
  LTRNtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  LTRNtxt.Width:=trunc (referencesize*0.29);
  LTRNtxt.height:=trunc (referencesize*0.2);
  R_EndBG.Width:=trunc (referencesize*0.22);
  R_EndBG.height:=trunc (referencesize*0.22);

  Rnextturnbg.Width:=trunc (referencesize*0.29);
  Rnextturnbg.height:=trunc (referencesize*0.29);
  Rnexttxt.Font.height:=trunc ((referencesize*0.042)*mag*mag);
  Rnexttxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  Rnexttxt.Width:=trunc (referencesize*0.29);
  Rnexttxt.height:=trunc (referencesize*0.045);
  Rarchertxt.Font.height:=trunc ((referencesize*0.042)*mag*mag);
  Rarchertxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  Rarchertxt.Width:=trunc (referencesize*0.29);
  Rarchertxt.height:=trunc (referencesize*0.045);

  if usetraffic.Checked=true then
  begin
    R_EndBG.top:=(trunc (referencesize*0.23)+topmarge);
    R_EndBG.left:=trunc (leftmarge+(referencesize*1.01));

    Rnextturnbg.left:=trunc (leftmarge+(referencesize*0.975));
    Rnextturnbg.top:=(trunc (referencesize*0.45)+topmarge);
    RABCDtxt.left:=trunc (leftmarge+(referencesize*0.975));
    RENDtxt.left:=trunc (leftmarge+(referencesize*0.975));
    RTRNtxt.left:=trunc (leftmarge+(referencesize*0.975));
    Rnexttxt.left:=trunc (leftmarge+(referencesize*0.975));
    Rnexttxt.top:=(trunc (referencesize*0.49)+topmarge);
    Rarchertxt.left:=trunc (leftmarge+(referencesize*0.975));
    Rarchertxt.top:=(trunc (referencesize*0.49)+topmarge);
  end
  else
  begin
    R_EndBG.top:=(trunc (referencesize*0.24)+topmarge);
    R_EndBG.left:=screenwidth - trunc ((referencesize*0.21));

    Rnextturnbg.left:=screenwidth - trunc (referencesize*0.25);
    Rnextturnbg.top:=countdownform.Height-trunc(referencesize*0.25);
    RABCDtxt.left:=screenwidth - trunc (referencesize*0.25);
    RENDtxt.left:=screenwidth - trunc (referencesize*0.24);
    RTRNtxt.left:=screenwidth - trunc (referencesize*0.24);
    Rnexttxt.left:=screenwidth - trunc (referencesize*0.25);
    Rnexttxt.top:=countdownform.Height-trunc(referencesize*0.21);
    Rarchertxt.left:=screenwidth - trunc (referencesize*0.25);
    Rarchertxt.top:=countdownform.Height-trunc(referencesize*0.21);
  end;
  RABCDtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  RABCDtxt.Width:=trunc (referencesize*0.29);
  RABCDtxt.height:=trunc (referencesize*0.2);
  RENDtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  RENDtxt.Width:=trunc (referencesize*0.29);
  RENDtxt.height:=trunc (referencesize*0.2);
  RTRNtxt.Constraints.MinWidth:=trunc (referencesize*0.29);
  RTRNtxt.Width:=trunc (referencesize*0.29);
  RTRNtxt.height:=trunc (referencesize*0.2);


end;




procedure TCountdownform.resizewindow;
// This procedure is meant to correct the size of all characters and pictures used during countdown, When the size of the window changes, or initially at startup of the program.
// Size of the characters is also depending if the trafic lights are shown on the screen. With traffic lights shown, the characters and pictures need to be smaller to fit in the window
// Depending on the aspect ratio, the size of the characters/pictures is based on width or height of the window. this is determined by checking the aspect ratio
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;

  //Addapt the size of the digits to the references size. Size of Characters is depending if final round is used or not

  if archerysystem <>'fitafin' then
  begin
    resizewindownonfinals;
  end
  else //finalround
  begin
    resizewindowfinals;
  end;
  //size the same for final and non final rounds:
  resizewindowall;
end;

procedure TCountdownform.soundsignal;

(*
This procedure manages the sound. via the pc speakers. and hardware interface.
Nr of beeps,  sound, etc are set correct. After this the sound will be done via "buzzertimer"
*)

{$IFDEF Unix}
var
  Player: TProcessUTF8;
  PlayerPath: String;
  PlayerParams: String;
{$ENDIF}
begin
  if (archerysystem = 'manual')  then         //or (archerysystem = 'follow')
  begin
    nrofbeeps:=nrofmanualbeeps;
  end
  else
  Case state of
   1: nrofbeeps:=3;
   2: begin
        if not((archerysystem='follow')and(followsystem='2'))then nrofbeeps:=2 else nrofbeeps:=1;
      end;

   3: nrofbeeps:=1;
   4: nrofbeeps:=1;
   5: nrofbeeps:=3;
   6: begin
        nrofbeeps:=minnrbeeps.Value;


     end
   else nrofbeeps:=0;
  end;
  buzzeron:=1;
  //if (archerysystem = 'manual') or (archerysystem = 'follow') then switchbox;
  if speaker.checked=true then
  begin
    wavbuffer:=soundselect.Text;
    WavFilename:=PChar(LowerCase(Filespath+'sounds/'+wavbuffer+'.wav'));

    {$IFDEF Windows}
    sndPlaySound(WavFilename, snd_Async or snd_NoDefault);
    {$ENDIF}
    {$IFDEF Darwin}
    if not MacPlayWav(WavFilename) then ShowMessage('Unable to play WAV file');
    {$ENDIF}
    {$IFDEF Unix}{$IFNDEF Darwin}
    begin
      /// SDL Stuff
      wave := Nil;

     wave := Mix_LoadWAV(WavFilename);
     if(wave = Nil) then
     begin
	ShowMessage('Unable to load WAV file');
     end;

     channel := Mix_PlayChannel(-1, wave, 0);
     if(channel = -1) then
     begin
	ShowMessage('Unable to play WAV file');
     end
     //END SDL Stuf
    end;

    {$ENDIF}{$ENDIF}
  end;
  buzzertimer.Enabled:=true;
  switchbox;

end;

procedure TCountdownform.checknextsecond;
//This is a quick and dirty solution to use the system clock. Possibly there is a better solution possible
//the reference time +1  is compared with the system time of the PC. if the difference is 0 seconds, it means it is 1 second later. The clock can show the next second.
//because the outcome of the subtraction is depending on the way the time is printed, which is depending to the country settings, there are a lot of comparations.
//for example some countries use '.' other use ':'. Some use AM/PM, some use hour values higher than 12. I tried all default country settings available in win7 to check all possible values.
begin
  if (TimeToStr(referencetime-systemtime) <> '0.00.00') and (TimeToStr(referencetime-systemtime) <> '00.00.00') and (TimeToStr(referencetime-systemtime) <> '12.00.00') and (TimeToStr(referencetime-systemtime) <> '0:00:00') and (TimeToStr(referencetime-systemtime) <> '00:00:00') and (TimeToStr(referencetime-systemtime) <> '12:00:00') and (TimeToStr(referencetime-systemtime) <> '12:00:00 PD') and (TimeToStr(referencetime-systemtime) <> '12:00:00 a.m.') and (TimeToStr(referencetime-systemtime) <> '12:00:00 AM') and (TimeToStr(referencetime-systemtime) <> '12.00.00 AM') and (TimeToStr(referencetime-systemtime) <> '12:00:00 ðì') and (TimeToStr(referencetime-systemtime) <> '12:00:00 ???') and (TimeToStr(referencetime-systemtime) <> '12:00:00 Õ') and (TimeToStr(referencetime-systemtime) <> '12:00:00 ?.?') and (TimeToStr(referencetime-systemtime) <> '?????? 12:00:00') and (TimeToStr(referencetime-systemtime) <> '¤W¤È 12:00:00') and (TimeToStr(referencetime-systemtime) <> 'AM 12:00:00')
  and (TimeToStr(referencetime-systemtime) <> '12:00:00 Safe') and (TimeToStr(referencetime-systemtime) <> '12:00:00 Ututu') and (TimeToStr(referencetime-systemtime) <> '12:00:00 saa moya z.m.') and (TimeToStr(referencetime-systemtime) <> '¿ÀÀü 12:00:00') and (TimeToStr(referencetime-systemtime) <> '12:00:00 Þ.Ù') and (TimeToStr(referencetime-systemtime) <> '???? 12:00:00') and (TimeToStr(referencetime-systemtime) <> '12:00:00 ??.?.') and (TimeToStr(referencetime-systemtime) <> '12:00:00 SA') and (TimeToStr(referencetime-systemtime) <> '12:00:00 Owuro') then
  begin
    nextsec:=1;
    fastcountdownrepeat:=fastcountdownrepeat+1;
  end
  else
  begin
    nextsec:=0;
    fastcountdownrepeat:=1;
  end;
  if (fastcountdownrepeat>2)then
  begin
    playpauze;
    playpauze;
  end;
  //copyright.Caption:=inttostr(fastcountdownrepeat);
end;

procedure TCountdownform.finalyzeturn;
begin
(*
This procedure finalyzes the turn if the trafic light is green or orange
*)
  if (((turnnumber =turnsperserie) and (serienumber mod turnsss =0)) or (Shootoff=1)) then    //finalyze the end
  begin
    FirstTimer.enabled:=false ;
    endtimout.Enabled:=true;
    if state<>6 then
    begin
      state:=1;   //if tabEmergency (stat6) first 4 soundsignals
    end;

    //starttostart;
    if (Practiseturn=1) and (Shootoff=0) then //if A
    if ((archerysystem='fita') and (serienumber>=(Practiseturns.value-times+1))) or ((archerysystem='25m1p') and (serienumber=nrof1ppractisearrows.value))then  //if B
    begin
      serienumber:=1;
      Practiseturn:=0;
    end
    else //else B
    begin
      serienumber:=serienumber+(1*times);
      if (serienumber+1) mod times = 1 then serienumber:=serienumber-1;
    end
    else //else A
    if Shootoff=0 then
    begin
      serienumber:=serienumber+(1*times);
      if (serienumber+1) mod times = 1 then serienumber:=serienumber-1;
    end;
    if Shootoff <> 1 then turnnumber:=1;
    countdowntimer:=0;
    if Shootoff=1 then
    begin
      Shootoff:=0;
      viewarchsystemchange;
    end;

    soundsignal;
    viewchangestateexchange;
    viewturnchange;

    state:=1;
    if (precountalways.Checked=true)and(archerysystem='fita')  then
    begin
      starttostart;
    end;
    viewicons;
  end
  else
  begin
    if (stopinbetweenturnsfitacheckbox.Checked) and (archerysystem='fita') then playpauze;
    if ((Shootoff=0) and (turnnumber =turnsperserie)) then
    begin
      serienumber:=serienumber+(1*times);
      if (serienumber+1) mod times = 1 then serienumber:=serienumber-1;
      turnnumber:=0;
    end;
    if state<>6 then state:=2;
    turnnumber:=turnnumber+1;
    viewchangestateactive;
    viewturnchange;
    soundsignal;
    if archerysystem='fita' then
    begin
      if redtime.Value = -1 then
      begin
        countdowntimer:=0;
        if FirstTimer.enabled=true then  playpauze;
      end
      else countdowntimer:= redtime.Value;
    end;
    if archerysystem='25m1p' then
    begin
      if redtime1p.Value = -1 then
      begin
        countdowntimer:=0;
        if FirstTimer.enabled=true then  playpauze;
      end
      else countdowntimer:= redtime1p.Value;
    end;
    state:=2;
  end;
  Checkredblink;
  viewactivate;
  TLswitch;
end;


procedure TCountdownform.FirstTimerTimer(Sender: TObject);

//This is the timer to count down. the timer is faster than 1 sec, (default 0.1 second)but the "checknextsecond" function keeps the timer in sync with the system clock
//if for some reasons the time gets a delay. (Processor overloaded, the system will correct this because it uses the system time. In that case it counts fast down (0.1sec per digit) till it is back at actual time.

begin
  systemtime:=getcurrenttime;
  begin
    if countdowntimer> 1 then   //actual time left is not 0
    begin
      checknextsecond;
      if nextsec=1 then
      begin
        referencetime:=IncSecond(referencetime, 1);      //decrease reference time with one second to triger the next count a second later
        countdowntimer:=countdowntimer-1;              //decrease the projected time with 1 second
        //if the projected time is equal to orange time setting, change to state 4: orange.

        if  (((countdowntimer <= orangetime.value)and (archerysystem='fita')and (Shootoff=0)) and (state=3))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          if (orangebeepfitacheckbox.Checked=true) then soundsignal;
          switchbox;
          TLswitch;
        end;

        if  (((countdowntimer = orangetime1p.value)and (archerysystem='25m1p')) and (state=3))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          if (orangebeep25m1pcheckbox.Checked=true) then soundsignal;
          switchbox;
          TLswitch;
        end;
        if  (((countdowntimer = (orangetimeso.Value))and (Shootoff=1)and (archerysystem='fita'))  and (state=3))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          if (orangebeepfitacheckbox.Checked=true) then soundsignal;
          switchbox;
          TLswitch;
        end;

        if  (((countdowntimer = orangefinal.value)and (archerysystem='fitafin')and (timeperturn.checked=true))and (state=3))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          switchbox;
          TLswitch;
        end;
        if  ((  (((countdowntimer = orangefinalend.value)and(Shootoff=0))or((countdowntimer = orangefinalendSO.value)and(Shootoff=1)))  and (archerysystem='fitafin')and (timeperend.checked=true))and (state=3))and (state <>2) then // state:=4;
        begin
          state:=4;
          viewchangestateactive;
          switchbox;
          TLswitch;
        end;
        viewactivate;
      end;
    end
    else
    begin                //actual time left is 0 so a state change is needed
      case state of
        1,5:    //waittime , so change to red time (state 2)
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            if state = 5 then
            begin
              state:=2;
              viewactivate;
              viewchangestateactive;
              viewchangestateinact;
            end;

            state:=2;
            soundsignal;

            if archerysystem='fita' then
            begin
              if redtime.Value = -1 then
              begin
                countdowntimer:=0;
                playpauze;
              end
              else countdowntimer:= redtime.Value;

            end;
            if archerysystem='25m1p' then
            begin
              if redtime1p.Value = -1 then
              begin
                countdowntimer:=0;
                playpauze;
              end
              else countdowntimer:= redtime1p.Value;
            end;
            if (archerysystem='fitafin')and (timeperturn.checked=true) then countdowntimer:= redfinal.Value;
            if (archerysystem='fitafin')and (timeperend.checked=true) then countdowntimer:= redfinalend.Value;
            FirstTimer.enabled:=true ;
            viewchangestateexchange;
            viewactivate;
           end;
        end;
        2:    //redtime , so change to green time (state 3)
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            if greentime.value = 0 then state:=4 else state:=3;
            if (archerysystem='fita') and (Shootoff=0) then
            begin
              if greentime.value = -1 then
              begin
                if orangetime.Value = -1 then countdowntimer:= 0 else countdowntimer:= times*(orangetime.Value);
                playpauze;

              end
              else
              begin
                if orangetime.Value = -1 then
                begin
                  countdowntimer:= times* (greentime.value)  ;
                  playpauze;
                end
                else countdowntimer:= times*(orangetime.Value +greentime.value);
              end;

            end;
            if (archerysystem='25m1p')  then countdowntimer:= orangetime1p.Value +greentime1p.value;
            if (archerysystem='fita') and (Shootoff=1) then countdowntimer:= (orangetimeso.Value)*nrofSOarrows +(greentimeso.value)*nrofSOarrows;
            if ((archerysystem='fitafin')and(timeperturn.checked=true))then countdowntimer:= (orangefinal.Value) +(greenfinal.value);
            if ((archerysystem='fitafin')and(timeperend.checked=true))then
            begin
              if Shootoff=0 then countdowntimer:= (orangefinalend.Value) +(greenfinalend.value) else countdowntimer:= (orangefinalendSO.Value) +(greenfinalendSO.value);
            end;
            if greentime.value <> -1 then FirstTimer.enabled:=true ;
            viewchangestateactive;
            soundsignal;
            TLswitch;
            viewactivate;
          end;
        end;
        3:    //greentime. Can get in this situation in case orange setting is 0. Next state is depending if this is the last turn in this end or not. This is aranged in routine finalyzeturn or nextfinal
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);

            if  (((archerysystem='fita') and (orangetime.value=-1) and (Shootoff=0)) and (state=3))and (state <>2) then
            begin
              if FirstTimer.enabled=true then  playpauze;
              state:=4;
              countdowntimer:=0;
              viewchangestateactive;
              switchbox;
              TLswitch;

            end
            else
            begin
              if archerysystem<>'fitafin' then finalyzeturn else
              begin
                endtimebuzzer:=true;
                nextfinal;
              end;
            end;


            viewactivate;
          end;

        end;
        4: //orangetime.    Next state is depending if this is the last turn in this end or not. This is aranged in routine finalyzeturn or nextfinal
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            if  (((archerysystem='fita') and (orangetime.value=-1) and (Shootoff=0))) then  // and (state <>2)
            begin

              finalyzeturn;
              if FirstTimer.enabled=true then  playpauze;
            end
            else
            begin

              if archerysystem<>'fitafin' then finalyzeturn else
              begin
                endtimebuzzer:=true;
                nextfinal;

              end;
            end;
            viewactivate;
          end //;

          else
          if ((orangetime.value=-1)  and (archerysystem='fita')) then
          begin
            state:=4;
            FirstTimer.enabled:=false ;

          end;

        end;

      End;  {End Case1}

    end;

  end;
  Checkredblink;

end;



procedure TCountdownform.FormResize(Sender: TObject);
begin
  menuscreensize;

end;


procedure TCountdownform.K8055selectChange(Sender: TObject);
begin
  if initializationstate=false then connect;
end;



Function bitstodigit (BIT1,BIT2,BIT3,BIT4:string):string;
var tot:integer;

begin
  tot:=0;
  if BIT4='1'then tot:=tot+1;
  if BIT3='1'then tot:=tot+2;
  if BIT2='1'then tot:=tot+4;
  if BIT1='1'then tot:=tot+8;

  case tot of
  15: bitstodigit:='15';
  14: bitstodigit:='0';
  12: bitstodigit:='0';
  10: bitstodigit:='0';
  0: bitstodigit:='0';
  1: bitstodigit:='1';
  2: bitstodigit:='2';
  3: bitstodigit:='3';
  4: bitstodigit:='4';
  5: bitstodigit:='5';
  6: bitstodigit:='6';
  7: bitstodigit:='7';
  8: bitstodigit:='8';
  9: bitstodigit:='9';
  else bitstodigit:='0';

  end;
end;



Procedure TCountdownform.switchfollow;
var ii, turnperend, sernum:integer;
begin
  If ((foltime1[13]='0'))then minsec.ItemIndex:=0;
  If ((foltime1[13]='1'))then minsec.ItemIndex:=1;
  if state <>5 then
  begin
    if (leftscreen.Checked=true) then
    begin
      digit3_1.Caption:= bitstodigit(foltime1[9],foltime1[10],foltime1[11],foltime1[12]);
      digit2_1.Caption:= bitstodigit(foltime1[5],foltime1[6],foltime1[7],foltime1[8]);
      digit1_1.Caption:= bitstodigit(foltime1[1],foltime1[2],foltime1[3],foltime1[4]);
    end
    else
    begin
     digit3_1.Caption:= bitstodigit(foltime2[9],foltime2[10],foltime2[11],foltime2[12]);
     digit2_1.Caption:= bitstodigit(foltime2[5],foltime2[6],foltime2[7],foltime2[8]);
     digit1_1.Caption:= bitstodigit(foltime2[1],foltime2[2],foltime2[3],foltime2[4]);

    end;
  end
  else
  begin
    digit3_3.Caption:= bitstodigit(foltime1[9],foltime1[10],foltime1[11],foltime1[12]);
    digit2_3.Caption:= bitstodigit(foltime1[5],foltime1[6],foltime1[7],foltime1[8]);
    digit1_3.Caption:= bitstodigit(foltime1[1],foltime1[2],foltime1[3],foltime1[4]);
  end;
  followsystem:= bitstodigit('0',folstate[7],folstate[8],folstate[9]); //  1='fita',2 ='fitafin,3='25m1p',4='manual'
  if followsystem='0' then
  Begin
    showABCD:=false;
    nrofturns:=1;
  end;
  if followsystem='1' then
  Begin
    showABCD:=true;
    nrofturns:=1;
  end;
  if followsystem='6' then
  Begin
    showABCD:=false;
    nrofturns:=2;
  end;
  if followsystem='7' then
  Begin
    showABCD:=true;
    nrofturns:=2;
  end;

  Shooters:=(strtoint(bitstodigit('0',folstate[1],folstate[2],folstate[3]))+1);

  ii:=0;
  if (foltrafic[1] ='1') then ii:=ii+1;
  if (foltrafic[2] ='1') then ii:=ii+1;
  if (foltrafic[3] ='1') then ii:=ii+1;
  if (foltrafic[4] ='1') then ii:=ii+1;
  if (foltrafic[5] ='1') then ii:=ii+1;
  if (foltrafic[6] ='1') then ii:=ii+1;
  if (foltrafic[1] ='0') and (foltrafic[2] ='0') and (foltrafic[3] ='0') and (foltrafic[4] ='0') and (foltrafic[5] ='0') and (foltrafic[6] ='0') then ii:=1;
  if ii<>0 then Turnsperserie:=Shooters div ii;

  if (foltrafic[1] ='1') then followleft:=true else followleft:=false;
  if (foltrafic[2] ='1') then followright:=true else followright:=false;
       viewfinupdate;
    viewturnchange;


  Archersperturn:=ii;
  if Archersperturn =1 then
  begin
    if (foltrafic[6] ='1') then turnnumber:=1;
    if (foltrafic[5] ='1') then turnnumber:=2;
    if (foltrafic[4] ='1') then turnnumber:=3;
    if (foltrafic[3] ='1') then turnnumber:=4;
    if (foltrafic[2] ='1') then turnnumber:=5;
    if (foltrafic[1] ='1') then turnnumber:=6;

  end
  else
  begin
    if (foltrafic[6] ='1') then turnnumber:=1;
    if (foltrafic[4] ='1') then turnnumber:=2;
    if (foltrafic[2] ='1') then turnnumber:=3;

  end;
  if ((((rightscreen.Checked=true) and( foltrafic[10]='1') and (bitstodigit('0',folstate[7],folstate[8],folstate[9])='2'))or((leftscreen.Checked=true) and( foltrafic[7]='1') and (bitstodigit('0',folstate[7],folstate[8],folstate[9])='2')))and (((bitstodigit('0',folstate[10],folstate[11],folstate[12]))<>'1') and ((bitstodigit('0',folstate[10],folstate[11],folstate[12]))<>'6') ))then state:=2 else
  state:= strtoint(bitstodigit('0',folstate[10],folstate[11],folstate[12]));
  turnnumber:= strtoint(bitstodigit('0',folstate[4],folstate[5],folstate[6])); //  receive turnnumber

  if   (( foltrafic[8]='1')and ( foltrafic[11]='1'))  and (bitstodigit('0',folstate[7],folstate[8],folstate[9])<>'2') then state:=4;   //if orange traffic lights are both sides on during nonfinals, state must be 3
  if   (( foltrafic[9]='1')and ( foltrafic[12]='1'))  and (bitstodigit('0',folstate[7],folstate[8],folstate[9])<>'2') then state:=3;   //if green traffic lights are both sides on during nonfinals, state must be 2

  if   ((( foltrafic[7]='1')and ( foltrafic[10]='1'))  and (bitstodigit('0',folstate[7],folstate[8],folstate[9])<>'2'))and ((state=4) or (state=3)) then state:=2;   //if red traffic lights are both sides on during nonfinals, state can not be 2 or 3. So swith to 1 (waitstate) (Maybe need to be changed to state 4 redstate. Difference is collor of digits etc.

  if ((archerysystem='follow') and (followsystem='3')) then
  begin
    if (shooteronearrownr.Caption='1') and (foltrafic[6] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
    if (shooteronearrownr.Caption='2') and (foltrafic[5] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
    if (shooteronearrownr.Caption='3') and (foltrafic[4] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
    if (shooteronearrownr.Caption='4') and (foltrafic[3] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
    if (shooteronearrownr.Caption='5') and (foltrafic[2] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
    if (shooteronearrownr.Caption='6') and (foltrafic[1] ='0') then if rotate25m1p.Checked=true then rotate25m1p.Checked:=false else rotate25m1p.Checked:=true;
  end
  else
  begin
    if (folstate <> oldfolstate) or ((folendnr <> oldfolendnr2) and (oldturnnumber <> oldturnnumber)) then
    begin



      if (turnnumber=1) then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter1.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter1.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter1.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter1.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter1.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter1.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;

      if ((turnnumber=1)and (Archersperturn>=2)) or ((turnnumber=2)and (Archersperturn=1))then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter2.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter2.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter2.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter2.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter2.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter2.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;

      if (turnnumber+Archersperturn=4) then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter3.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter3.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter3.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter3.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter3.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter3.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;

      if ((turnnumber=2)and (Archersperturn>=2)) or ((turnnumber=4)and (Archersperturn=1))then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter4.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter4.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter4.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter4.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter4.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter4.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;

      if (((turnnumber=5)and (Archersperturn=1)) or ((turnnumber=3)and (Archersperturn=2)) or ((turnnumber=2)and (Archersperturn=3)))then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter5.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter5.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter5.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter5.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter5.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter5.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;

      if (turnnumber*Archersperturn=6) then      //by verifying consistensy between trafic signal and state signal, it is possible to determine if every sequence starts with A. (or not)
      begin
        if (shooter6.Caption='A') and (foltrafic[6] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter6.Caption='B') and (foltrafic[5] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter6.Caption='C') and (foltrafic[4] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter6.Caption='D') and (foltrafic[3] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter6.Caption='E') and (foltrafic[2] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
        if (shooter6.Caption='F') and (foltrafic[1] ='0') then if ABCDperEND.Checked=true then ABCDperEND.Checked:=false else ABCDperEND.Checked:=true;
      end;
      if oldturnnumber<> turnnumber  then oldturnnumber:= turnnumber else if  oldfolendnr2<>folendnr then oldfolendnr2:=folendnr;
      oldfolstate:=folstate;
    end;

  end;

  if state<>1 then
  begin
    manualfollowmenuremove:=true;

  end
  else manualfollowmenuremove:=false;
  if (foltrafic[13] = '1') and (oldsound = '0') then
  Begin
    nrofmanualbeeps:=1;
    if state = 6 then
    begin
      alarmstate:=1; //remember we are in tabEmergency
      emergencytext.Visible:=true;
    end;
    soundsignal;
     oldsound:= foltrafic[13];
  end
  else
  begin

    if (foltrafic[13] = '0') then
    begin
      oldsound:= foltrafic[13];
    end;
  end;
  if ((bitstodigit(folendnr[9],folendnr[10],folendnr[11],folendnr[12])='15') or (bitstodigit(folendnr[5],folendnr[6],folendnr[7],folendnr[8])='15') ) then Practiseturn:=1 else Practiseturn:=0;
  sernum:=0;
  if (bitstodigit(folendnr[1],folendnr[2],folendnr[3],folendnr[4])<>'15') then sernum:=sernum+(strtoint(bitstodigit(folendnr[1],folendnr[2],folendnr[3],folendnr[4]))) else sernum:=0;
  if (bitstodigit(folendnr[5],folendnr[6],folendnr[7],folendnr[8])<>'15') then sernum:=sernum+(10*(strtoint(bitstodigit(folendnr[5],folendnr[6],folendnr[7],folendnr[8]))));

  if (bitstodigit(folendnr[9],folendnr[10],folendnr[11],folendnr[12])<>'15') then sernum:=sernum+(100*(strtoint(bitstodigit(folendnr[9],folendnr[10],folendnr[11],folendnr[12]))));
  serienumber :=sernum;
  if (state <> oldstate) then
  begin
    viewactivate;
    if ( (  (oldstate=2) and ((state=3)or(state=4)))or ((oldstate=3) and ((state=2)or(state=4)))or((oldstate=4) and ((state=3)or(state=2)))  ) then
    viewchangestateactive
    else
    begin
     if state =2 then viewchangestateactive;
     viewchangestateexchange;
    end;
    if ((state=5) or (oldstate=5)) then
    begin
      resizewindowpreclock;
      viewchangestateinact;
    end;
    oldstate:=state;
  end;
  if (followsystem <> oldfollowsystem) then
  begin
    viewicons;
    if (followsystem='2')  then
    begin
      resizewindowfinalturndetails
    end
    else
    begin
      resizewindownonfinals;
      viewchangestateinact;
    end;
    oldfollowsystem:=followsystem;
    viewarchsystemchange;
  end;
  if (turnnumber<>oldfolturnnumber) then
  begin
    viewturnchange;
    oldfolturnnumber:=turnnumber;
  end;
  if (Shooters <> oldShooters) then
  begin
    resizewindownonfinals;
    oldShooters:=Shooters;
  end;
  if (Archersperturn <> oldArchersperturn) then
  begin
    resizewindownonfinals;
    oldArchersperturn:=Archersperturn;
  end;
  if (folendnr <> oldfolendnr) then
  begin
    viewturnchange;
    oldfolendnr:=folendnr;
  end;
  Checkredblink;
  switchbox;
  viewchangestateactive;

  TLswitch;
  viewarchsystemchange;

end;

procedure TCountdownform.serialRxData(Sender: TObject);
var Ard :string;
begin
  Ard:=serial.ReadData;
  perfsercommand(Ard);
end;


procedure TCountdownform.perfsercommand(var Ard: string);
var ARD2, BITSS:string;
  calc:integer;
  P : PChar;
  //read serial data
begin
  sleep(40);

  teststringleft.Caption:= ARD;
  BITSS:='0000000000000000';
  ARD2:='000000';
  if archerysystem<>'manual'then

  begin
    if archerysystem = 'follow'then
    begin
      ARD2:='      ';
      If ARD[1]='-' then
      begin
        StringReplace(ARD, '-', '', [rfReplaceAll]);
        BITSS[1]:='1';
        ARD2[1]:='0';

      end
      else
      begin
        BITSS[1]:='0';
        if ((ARD[1]='0')or(ARD[1]='1')or(ARD[1]='2')or(ARD[1]='3')or(ARD[1]='4')or(ARD[1]='5')or(ARD[1]='6')or(ARD[1]='7')or(ARD[1]='8')or(ARD[1]='9'))  then ARD2[1]:=ARD[1];
      end;

      if ((ARD[2]='0')or(ARD[2]='1')or(ARD[2]='2')or(ARD[2]='3')or(ARD[2]='4')or(ARD[2]='5')or(ARD[2]='6')or(ARD[2]='7')or(ARD[2]='8')or(ARD[2]='9'))  then ARD2[2]:=ARD[2];
      if ((ARD[3]='0')or(ARD[3]='1')or(ARD[3]='2')or(ARD[3]='3')or(ARD[3]='4')or(ARD[3]='5')or(ARD[3]='6')or(ARD[3]='7')or(ARD[3]='8')or(ARD[3]='9'))  then ARD2[3]:=ARD[3];
      if ((ARD[4]='0')or(ARD[4]='1')or(ARD[4]='2')or(ARD[4]='3')or(ARD[4]='4')or(ARD[4]='5')or(ARD[4]='6')or(ARD[4]='7')or(ARD[4]='8')or(ARD[4]='9'))  then ARD2[4]:=ARD[4];
      if ((ARD[5]='0')or(ARD[5]='1')or(ARD[5]='2')or(ARD[5]='3')or(ARD[5]='4')or(ARD[5]='5')or(ARD[5]='6')or(ARD[5]='7')or(ARD[5]='8')or(ARD[5]='9'))  then ARD2[5]:=ARD[5];
      if ((ARD[6]='0')or(ARD[6]='1')or(ARD[6]='2')or(ARD[6]='3')or(ARD[6]='4')or(ARD[6]='5')or(ARD[6]='6')or(ARD[6]='7')or(ARD[6]='8')or(ARD[6]='9'))  then ARD2[6]:=ARD[6];
      ARD2:=trim(ARD2);
      ARD2:=StringReplace(ARD2, #32, '', [rfReplaceAll]);
      if ARD2<>'' then calc:=strtoint(ARD2) else calc:=strtoint('0000000000000001') ;
      ARD2:=inttostr(calc);
      if BITSS[1]='1'then calc:=32768-calc;

      if calc >= 16384 then
      begin
        BITSS[2]:='1';
        calc:=calc-16384;
      end
      else
      begin
        BITSS[2]:='0';
      end;
      if calc >= 8192 then
      begin
        BITSS[3]:='1';
        calc:=calc-8192;
      end
      else
      begin
        BITSS[3]:='0';
      end;
      if calc >= 4096 then
      begin
        BITSS[4]:='1';
        calc:=calc-4096;
      end
      else
      begin
        BITSS[4]:='0';
      end;
      if calc >= 2048 then
      begin
        BITSS[5]:='1';
        calc:=calc-2048;
      end
      else
      begin
        BITSS[5]:='0';
      end;
      if calc >= 1024 then
      begin
        BITSS[6]:='1';
        calc:=calc-1024;
      end
      else
      begin
        BITSS[6]:='0';
      end;
      if calc >= 512 then
      begin
        BITSS[7]:='1';
        calc:=calc-512;
      end
      else
      begin
        BITSS[7]:='0';
      end;
      if calc >= 256 then
      begin
        BITSS[8]:='1';
        calc:=calc-256;
      end
      else
      begin
        BITSS[8]:='0';
      end;
      if calc >= 128 then
      begin
        BITSS[9]:='1';
        calc:=calc-128;
      end
      else
      begin
        BITSS[9]:='0';
      end;
      if calc >= 64 then
      begin
        BITSS[10]:='1';
        calc:=calc-64;
      end
      else
      begin
        BITSS[10]:='0';
      end;
      if calc >= 32 then
      begin
        BITSS[11]:='1';
        calc:=calc-32;
      end
      else
      begin
        BITSS[11]:='0';
      end;
      if calc >= 16 then
      begin
        BITSS[12]:='1';
        calc:=calc-16;
      end
      else
      begin
        BITSS[12]:='0';
      end;
      if calc >= 8 then
      begin
        BITSS[13]:='1';
        calc:=calc-8;
      end
      else
      begin
        BITSS[13]:='0';
      end;
      if calc >= 4 then
      begin
        BITSS[14]:='1';
        calc:=calc-4;
      end
      else
      begin
        BITSS[14]:='0';
      end;
      if calc >= 2 then
      begin
        BITSS[15]:='1';
        calc:=calc-2;
      end
      else
      begin
        BITSS[15]:='0';
      end;
      if calc >= 1 then
      begin
        BITSS[16]:='1';
        calc:=calc-1;
      end
      else
      begin
        BITSS[16]:='0';
      end;
      if (BITSS[16]='0') and ((BITSS[15]='0') or (BITSS[14]='1'))  then foltime1:=BITSS;
      if (BITSS[16]='0') and ((BITSS[15]='1') or (BITSS[14]='1'))  then foltime2:=BITSS;
      if (BITSS[16]='1') and (BITSS[15]='0')  then     foltrafic:=BITSS;
      if (BITSS[16]='1') and (BITSS[15]='1') and (BITSS[14]='1') and (BITSS[13]='0')  then folendnr:=BITSS;
      if (BITSS[16]='1') and (BITSS[15]='1') and (BITSS[14]='0') and (BITSS[13]='0')  then folsecdetails:=BITSS;
      if (BITSS[16]='1') and (BITSS[15]='1') and (BITSS[14]='0') and (BITSS[13]='1')  then folsecdetailssec:=BITSS;
      if (BITSS[16]='1') and (BITSS[15]='1') and (BITSS[14]='1') and (BITSS[13]='1')  then folstate:=BITSS;
      teststring.Caption:=foltime1;
      teststringendnr.Caption:=foltime2;
      teststringendnr3.Caption:=foltrafic;
      teststringendnr1.Caption:=folendnr;
      teststringendnr2.Caption:=folsecdetailssec;
      teststringleft.Caption:=folstate;
      if ((serialinput.Checked=true)) then switchfollow;
      switchfollow;
    end
    else
    begin
    if ARD <> '' then
    begin
      if ARD='1' then
      begin
        skitem:= comboxK8055but1.ItemIndex;
        startshortcut;
      end;
      if ARD='2' then
      begin
        skitem:= comboxK8055but2.ItemIndex;
        startshortcut;
      end;
      if ARD='3' then
      begin
        skitem:= comboxK8055but3.ItemIndex;
        startshortcut;
      end;
      if ARD='4' then
      begin
        skitem:= comboxK8055but4.ItemIndex;
        startshortcut;
      end;
      if ARD='5' then
      begin
        skitem:= comboxK8055but5.ItemIndex;
        startshortcut;
      end;
    end;
    end;
  end
  else
  begin
    if ARD <> '' then
    begin
      if ARD='1' then
      begin
        case HWbutton1.ItemIndex of
          0: setred;
          1: setorange;
          2: setgreen;
          3: onebeep;
          4: twobeeps;
          5: threebeeps;
          6: stopemergency;
        end;
      end;
      if ARD='2' then
      begin
        case HWbutton2.ItemIndex of
          0: setred;
          1: setorange;
          2: setgreen;
          3: onebeep;
          4: twobeeps;
          5: threebeeps;
          6: stopemergency;
        end;
      end;
      if ARD='3' then
      begin
        case HWbutton3.ItemIndex of
          0: setred;
          1: setorange;
          2: setgreen;
          3: onebeep;
          4: twobeeps;
          5: threebeeps;
          6: stopemergency;
        end;
      end;
      if ARD='4' then
      begin
        case HWbutton4.ItemIndex of
          0: setred;
          1: setorange;
          2: setgreen;
          3: onebeep;
          4: twobeeps;
          5: threebeeps;
          6: stopemergency;
        end;
      end;
      if ARD='5' then
      begin
        case HWbutton5.ItemIndex of
          0: setred;
          1: setorange;
          2: setgreen;
          3: onebeep;
          4: twobeeps;
          5: threebeeps;
          6: stopemergency;
        end;
      end;
    end;
  end;
end;

procedure TCountdownform.ABCDperENDChange(Sender: TObject);
begin
  startupscenario.Text:='--';
  viewturnchange;
  switchbox;
  TLswitch;
  if ABCDperEND.Checked=true then
  begin
    PABCDperEND.Enabled:=false;
    repeatsequence.Enabled:=false;
    repeatsequencelabel.Enabled:=false;
  end
  else
  begin
    PABCDperEND.Enabled:=true;
    repeatsequence.Enabled:=true;
    repeatsequencelabel.Enabled:=true;
  end;
  viewstateone;
end;

procedure TCountdownform.abcd25m1pChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.ABColListBoxtimeClick(Sender: TObject);
begin
  PrepColABLabel.Font.Color:=ABColListBoxtime.Selected;
  retrColABLabel.Font.Color:=ABColListBoxtime.Selected;
  RedColABLabel.Font.Color:=ABColListBoxtime.Selected;
  GrnColABLabel.Font.Color:=ABColListBoxtime.Selected;
  OrColABLabel.Font.Color:=ABColListBoxtime.Selected;
  changecolorscheme;
end;

procedure TCountdownform.abouticonClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=abouttab;
end;


procedure TCountdownform.actualtimeTimer(Sender: TObject);
var dot:string;
begin
  dot:='';
  if lang.Text='Deutsch' then dot:='.';
  if am24.ItemIndex=1 then Datetimelabel.Caption:='['+FormatDateTime('hh:nn:ss am/pm', Now)+']' else Datetimelabel.Caption:='['+FormatDateTime('hh:nn:ss', Now)+']';
  if am24_2.ItemIndex=1 then sheetdatetime2label.Caption:=FormatDateTime('hh:nn am/pm', Now) else sheetdatetime2label.Caption:=FormatDateTime('hh:nn:ss', Now);
  sheetdatetime1label.Caption:=dayname[DayOfWeek(Now)];
  sheetdatetime3label.Caption:=FormatDateTime('d', Now)+dot+'  '+monthname[strtoint(FormatDateTime('mm', Now))] ;
  sheetdatetime4label.Caption:=FormatDateTime('yyyy', Now);
end;

procedure TCountdownform.AddimagebuttonClick(Sender: TObject);
var wasimagesselected:boolean;

begin
  wasimagesselected:= largeimagecheckbox.Checked;
  largeimagecheckbox.Checked:=false;
  { Execute an open picture dialog. }
  if OpenPictureDialog1.Execute then
    { First check if the file exists. }
    if FileExists(OpenPictureDialog1.FileName) then
    begin
      //flipsecondslabel.Caption:=OpenPictureDialog1.FileName;
      imagesListBox.Items.Add(OpenPictureDialog1.FileName);
      {$IFDEF Windows}
      imagesListBox.Items.SaveToFile('backgroundimages');
      {$ENDIF}


      {$IFDEF Unix}
      if linuxHW='RPI' then imagesListBox.Items.SaveToFile('/home/pi/archeryclock/backgroundimages') else imagesListBox.Items.SaveToFile('backgroundimages');
      {$ENDIF}
      //flipsecondslabel.Caption:=inttostr(imagesListBox.Items.Count);
    end;
  if wasimagesselected then largeimagecheckbox.Checked:=true;
end;

procedure TCountdownform.arduinoselect2Change(Sender: TObject);
begin
  if initializationstate=false then
  begin
    serialtimestamp.Interval:=1500;
    //copyright.Caption:='1500';
    connect;
    serialfreqdelay.Enabled:=true;
  end;

end;

procedure TCountdownform.AudioActionstate4Click(Sender: TObject);
begin
  Pausestate4.Checked:=true;
end;

procedure TCountdownform.backgroundtimerTimer(Sender: TObject);
begin
  if (imagesListBox.Items.Count>=1) and (largeimagecheckbox.Checked=true)    then   //and (imagecount<>-1)
  begin
    if imagecount<(imagesListBox.Items.Count-1) then
    begin
      imagecount:=imagecount+1;
    end
    else
    begin
      if (Actualtimecheckbox.Checked=true) then imagecount:=-1 else imagecount:=0;
    end;
  end;
  timevssheet;
  if (imagecount<>-1) and (imagecount<imagesListBox.Items.Count) then  // the list can be empty
  begin
    if FileExists(imagesListBox.Items.Strings[imagecount])then background1.Picture.LoadFromFile(imagesListBox.Items.Strings[imagecount] );
  end;
end;

procedure TCountdownform.BeepswitcharcherChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.blinkingredTimer(Sender: TObject);
begin
  if archeryclock.visible=true then archeryclock.visible:=false;
  if redlighton=true then
  begin
    redlighton:=false;
    if not((archerysystem='fitafin') and (fitafinarcher ='left'))then lamp_red_right_on_off:=0;
    if not((archerysystem='fitafin') and (fitafinarcher ='right'))then lamp_red_left_on_off:=0;
    if digit1_1.Font.Color<>waitcolor then
    begin
      digit1_1.Font.Color:=waitcolor;          // during red state the font of the timers are redcolor
      dots_1.Font.Color:=waitcolor;
      digit2_1.Font.Color:=waitcolor;
      digit3_1.Font.Color:=waitcolor;
    end;
    if digit1_2.Font.Color<>waitcolor then
    begin
      digit1_2.Font.Color:=waitcolor;          // during red state the font of the timers are redcolor
      dots_2.Font.Color:=waitcolor;
      digit2_2.Font.Color:=waitcolor;
      digit3_2.Font.Color:=waitcolor;
    end;
    if (Countdownform.Color<>bgwaitcolor) and ((archerysystem<>'fitafin')or((archerysystem='fitafin')and ((finarrow.Checked)or (viewleft.Checked and(fitafinarcher ='left'))or(viewright.Checked and(fitafinarcher ='right'))))) then Countdownform.Color:=bgwaitcolor;
  end
  else
  begin
    redlighton:=true;
    If ((state=1) or (state=2) or (state=5) or (state=6)) then
    begin
      lamp_red_right_on_off:=1;
      lamp_red_left_on_off:=1;
      if digit1_1.Font.Color<>redcolor then
      begin
        digit1_1.Font.Color:=redcolor;          // during red state the font of the timers are redcolor
        dots_1.Font.Color:=redcolor;
        digit2_1.Font.Color:=redcolor;
        digit3_1.Font.Color:=redcolor;
      end;
      if digit1_2.Font.Color<>redcolor then
      begin
        digit1_2.Font.Color:=redcolor;          // during red state the font of the timers are redcolor
        dots_2.Font.Color:=redcolor;
        digit2_2.Font.Color:=redcolor;
        digit3_2.Font.Color:=redcolor;
      end;

      if (Countdownform.Color<>bgredcolor) then Countdownform.Color:=bgredcolor;
    end;
  end;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.Checkredblink;
//to verify if red blinking timer needs to be on or off
begin
  if (((Blinkphase1CheckBox.Checked=true) and ((state=1)or(state=5)or(state=6))) or ((Blinkphase2CheckBox.Checked=true) and ((state=2)or((state=1)and(archerysystem='fitafin')and((fitafinarcher<>'none')     ))))) then
  begin

    blinkingred.Enabled:=true;
  end
  else
  begin
    if blinkingred.Enabled=true then
    begin
      blinkingred.Enabled:=false;
      redlighton:=true;
      If ((state=1) or (state=2) or (state=5) or (state=6)) then
      begin
        lamp_red_right_on_off:=1;
        lamp_red_left_on_off:=1;
        TLswitch;
        switchbox;
      end;
    end;
  end;
end;

procedure TCountdownform.Blinkphase1CheckBoxChange(Sender: TObject);
begin
  startupscenario.Text:='--';
  Checkredblink;
end;

procedure TCountdownform.Blinkphase2CheckBoxChange(Sender: TObject);
begin
  startupscenario.Text:='--';
  Checkredblink;
end;

procedure TCountdownform.closesystemTimer(Sender: TObject);
var dummy:string;
begin
  if (shutdownsystem=true) then
  begin
    {$IFDEF Unix}{$IFNDEF Darwin}  // Mac: never shut the computer down, just close
    RunCommand('sudo shutdown now', dummy);{$ENDIF}
    {$ENDIF}
  end;
  Close;
end;

procedure TCountdownform.writeaccessdata;
Begin
   writeln(accessfile,SSIDEdit.Text) ;
   writeln(accessfile,PWEdit.Text) ;
   writeln(accessfile,wifichannel.Value) ;
   writeln(accessfile,WIFIHWListBox.ItemIndex) ;
   writeln(accessfile,CountrycodeEdit.Text) ;
   writeln(accessfile,interfaceEdit.Text) ;
end;

procedure TCountdownform.disableaccesspointbutton1Click(Sender: TObject);
var dummy:string;
begin
  APstatuslabel.Caption:='Currently off';
  AssignFile(accessfile, Filespath+'accessp') ;
  ReWrite(accessfile) ;
  writeln(accessfile,'0') ;
  writeaccessdata;
  CloseFile(accessfile) ;
  enableaccesspointpanel.Enabled:=true;
  disableaccesspointpanel.Enabled:=false;

  {$IFDEF Unix}

  {$IFNDEF Darwin}  // Raspberry Pi access point only
  RunCommand('sudo cp '+Filespath+'dhcpcd.confx /etc/dhcpcd.conf', dummy);
  RunCommand('sudo systemctl disable systemd-networkd', dummy);
  RunCommand('sudo systemctl disable hostapd', dummy);
  RunCommand('sudo systemctl reboot', dummy);
  {$ENDIF}
  {$ENDIF}
end;

procedure TCountdownform.enableaccesspointbuttonClick(Sender: TObject);
var dummy:string;
begin
  APstatuslabel.Caption:='Currently on';
  AssignFile(accessfile, Filespath+'accessp') ;
  ReWrite(accessfile) ;
  writeln(accessfile,'1') ;
  writeaccessdata;
  CloseFile(accessfile) ;

  AssignFile(accessfile, Filespath+'hostapd.conf') ;
  ReWrite(accessfile) ;
  writeln(accessfile,'country_code='+CountrycodeEdit.Text) ;
  writeln(accessfile,'interface='+interfaceEdit.Text) ;
  writeln(accessfile,'bridge=br0') ;
  writeln(accessfile,'ssid='+SSIDEdit.Text) ;
  if (WIFIHWListBox.ItemIndex=0) then  writeln(accessfile,'hw_mode=a') ;
  if (WIFIHWListBox.ItemIndex=1) then  writeln(accessfile,'hw_mode=b') ;
  if (WIFIHWListBox.ItemIndex=2) then  writeln(accessfile,'hw_mode=g') ;
  writeln(accessfile,'channel='+inttostr(wifichannel.Value));
  writeln(accessfile,'macaddr_acl=0') ;
  writeln(accessfile,'auth_algs=1') ;
  writeln(accessfile,'ignore_broadcast_ssid=0') ;
  writeln(accessfile,'wpa=2') ;
  writeln(accessfile,'wpa_passphrase='+PWEdit.Text) ;
  writeln(accessfile,'wpa_key_mgmt=WPA-PSK') ;
  writeln(accessfile,'wpa_pairwise=TKIP') ;
  writeln(accessfile,'rsn_pairwise=CCMP') ;
  CloseFile(accessfile) ;

  {$IFDEF Unix}

  {$IFNDEF Darwin}  // Raspberry Pi access point only
  RunCommand('sudo cp '+Filespath+'hostapd.conf /etc/hostapd/hostapd.conf', dummy);
  RunCommand('sudo cp '+Filespath+'dhcpcd.conf0 /etc/dhcpcd.conf', dummy);
  RunCommand('sudo systemctl enable systemd-networkd', dummy);
  RunCommand('sudo systemctl enable hostapd', dummy);

  enableaccesspointpanel.Enabled:=false;
  disableaccesspointpanel.Enabled:=true;

  RunCommand('sudo systemctl reboot', dummy);
  {$ENDIF}{$ENDIF}
end;

procedure TCountdownform.renewserialbuttonClick(Sender: TObject);
begin
    serialtimestamp.Interval:=1500;
    //copyright.Caption:='1500';
    serialfreqdelay.Enabled:=true;

end;

procedure TCountdownform.controliconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=controltab;
end;

procedure TCountdownform.finalteamturnsSOChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.finalturnsSOChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.HWbutton1Change(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.HWbutton2Change(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.HWbutton3Change(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.HWbutton4Change(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.HWbutton5Change(Sender: TObject);
begin
  startupscenario.Text:='--';
end;


procedure TCountdownform.keyboardpref1Click(Sender: TObject);
begin
   leftarrowkeycombo.ItemIndex:=4;
   rightarrowkeycombo.ItemIndex:=5;
   uparrowkeycombo.ItemIndex:=6;
   downarrowkeycombo.ItemIndex:=7;

end;

procedure TCountdownform.keyboardpref2Click(Sender: TObject);
begin
   leftarrowkeycombo.ItemIndex:=4;
   rightarrowkeycombo.ItemIndex:=5;
   uparrowkeycombo.ItemIndex:=0;
   downarrowkeycombo.ItemIndex:=0;

end;

procedure TCountdownform.keyboardpref3Click(Sender: TObject);
begin
   leftarrowkeycombo.ItemIndex:=4;
   rightarrowkeycombo.ItemIndex:=5;
   uparrowkeycombo.ItemIndex:=5;
   downarrowkeycombo.ItemIndex:=4;

end;


procedure TCountdownform.musicvolumetimerTimer(Sender: TObject);
begin
  if musicvolume <>  newmusicvolume then
  begin
    if musicvolume<newmusicvolume then  musicvolume:=musicvolume+1 else musicvolume:=musicvolume-1;
    TCPmusicnetwork.SendMessage('volume '+inttostr(trunc(musicvolume*2.56))+chr(13));
  end
  else
  begin
    musicvolumetimer.Enabled:=false;
  end;
end;

procedure TCountdownform.nextonlybuttonClick(Sender: TObject);
begin
  pgupcombox.ItemIndex:=0;
  pgdncombox.ItemIndex:=0;
  playcombox.ItemIndex:=0;
  blnkcombox.ItemIndex:=0;
end;

procedure TCountdownform.nrgreenbuzzChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.nrorangebuzzChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.nrredbuzzChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangebeep25m1pcheckboxChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangebeepfitacheckboxChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.pauseimagestate1Click(Sender: TObject);
begin
  Pausestate1.Checked:=true;
end;

procedure TCountdownform.pauseimagestate2Click(Sender: TObject);
begin
  Pausestate2.Checked:=true;
end;

procedure TCountdownform.pauseimagestate3Click(Sender: TObject);
begin
  Pausestate3.Checked:=true;
end;

procedure TCountdownform.pauseimagestate4Click(Sender: TObject);
begin
  Pausestate4.Checked:=true;
end;

procedure TCountdownform.pauseimagestate5Click(Sender: TObject);
begin
  Pausestate5.Checked:=true;
end;

procedure TCountdownform.pauseimagestate6Click(Sender: TObject);
begin
  Pausestate6.Checked:=true;
end;

procedure TCountdownform.playimagestate1Click(Sender: TObject);
begin
  Playstate1.Checked:=true;
end;

procedure TCountdownform.playimagestate2Click(Sender: TObject);
begin
  Playstate2.Checked:=true;
end;

procedure TCountdownform.playimagestate3Click(Sender: TObject);
begin
  Playstate3.Checked:=true;
end;

procedure TCountdownform.playimagestate4Click(Sender: TObject);
begin
  Playstate4.Checked:=true;
end;

procedure TCountdownform.playimagestate5Click(Sender: TObject);
begin
  Playstate5.Checked:=true;
end;

procedure TCountdownform.playimagestate6Click(Sender: TObject);
begin
  Playstate6.Checked:=true;
end;

procedure TCountdownform.reconnectbuttonClick(Sender: TObject);

begin
  TCPmusicnetwork.Disconnect;
  TCPmusicnetwork.Connect(AudioIPedit.Text, Audioportnumber.Value);

end;

Procedure TCountdownform.setmusicstatus;
begin
  case state of
  1: begin
       if Playstate1.Checked then newmusicaction:='play';
       if (Pausestate1.Checked) or (Stopstate1.Checked) then musicvolume:=volumestate1.Value;
       if Pausestate1.Checked then newmusicaction:='pause';
       if Stopstate1.Checked then newmusicaction:='stop';
       newmusicvolume:=volumestate1.Value;

    end;
  2: begin
       if Playstate2.Checked then newmusicaction:='play';
       if (Pausestate2.Checked) or (Stopstate2.Checked) then musicvolume:=volumestate2.Value;
       if Pausestate2.Checked then newmusicaction:='pause';
       if Stopstate2.Checked then newmusicaction:='stop';
       newmusicvolume:=volumestate2.Value;

    end;
  3: begin
       if Playstate3.Checked then newmusicaction:='play';
       if (Pausestate3.Checked) or (Stopstate3.Checked) then musicvolume:=volumestate3.Value;
       if Pausestate3.Checked then newmusicaction:='pause';
       if Stopstate3.Checked then newmusicaction:='stop';
       newmusicvolume:=volumestate3.Value;

    end;
  4: begin
       if Playstate4.Checked then newmusicaction:='play';
       if (Pausestate4.Checked) or (Stopstate4.Checked) then musicvolume:=volumestate4.Value;
       if Pausestate4.Checked then newmusicaction:='pause';
       if Stopstate4.Checked then newmusicaction:='stop';
       newmusicvolume:=volumestate4.Value;

    end;
  5: begin
       if Playstate5.Checked then newmusicaction:='play';
       if (Pausestate5.Checked) or (Stopstate5.Checked) then musicvolume:=volumestate5.Value;
       if Pausestate5.Checked then newmusicaction:='pause';
       if Stopstate5.Checked then newmusicaction:='stop';
       newmusicvolume:=volumestate5.Value;

    end;
  6: begin
       TCPmusicnetwork.SendMessage('volume '+inttostr(trunc(volumestate6.Value*2.56))+chr(13));
       newmusicvolume:=volumestate6.Value;
       musicvolume:=newmusicvolume;
       if Playstate6.Checked then newmusicaction:='play';
       if Pausestate6.Checked then newmusicaction:='pause';
       if Stopstate6.Checked then newmusicaction:='stop';
    end;
  end; //case

  if newmusicaction='play' then
  begin
    if musicaction='pause' then TCPmusicnetwork.SendMessage('pause'+chr(13)) else TCPmusicnetwork.SendMessage('play'+chr(13));
    musicaction:='play';
  end;
  if newmusicaction='pause' then
  begin
    newmusicvolume:=0;
    musicvolume:=0;
    TCPmusicnetwork.SendMessage('volume 0'+chr(13));
    if musicaction='play' then
    begin
      TCPmusicnetwork.SendMessage('pause'+chr(13));
      musicaction:='pause';
    end;
  end;
  if newmusicaction='stop' then
  begin
    newmusicvolume:=0;
    musicvolume:=0;
    TCPmusicnetwork.SendMessage('volume 0'+chr(13));
    if musicaction='pause' then TCPmusicnetwork.SendMessage('pause'+chr(13));
    TCPmusicnetwork.SendMessage('stop'+chr(13));
    musicaction:='stop';
  end;


  if newmusicvolume<>musicvolume then
  begin
    musicvolumetimer.Enabled:=true;
  end;
end;

procedure TCountdownform.Button7Click(Sender: TObject);
begin
  TCPmusicnetwork.SendMessage('play'+chr(13));
end;

procedure TCountdownform.buzzicon1Click(Sender: TObject);
begin
  onebeep;
end;

procedure TCountdownform.buzzicon2Click(Sender: TObject);
begin
  twobeeps;
end;

procedure TCountdownform.buzzicon3Click(Sender: TObject);
begin
  threebeeps;


end;

procedure TCountdownform.CDColListBoxtimeClick(Sender: TObject);
begin
  PrepColCDLabel.Font.Color:=CDColListBoxtime.Selected;
  retrColCDLabel.Font.Color:=CDColListBoxtime.Selected;
  RedColCDLabel.Font.Color:=CDColListBoxtime.Selected;
  GrnColCDLabel.Font.Color:=CDColListBoxtime.Selected;
  OrColCDLabel.Font.Color:=CDColListBoxtime.Selected;
  changecolorscheme;

end;

procedure TCountdownform.changeendturntimerTimer(Sender: TObject);
begin
  changeendturntimer.Enabled:=false;
  viewstateone;
end;

procedure TCountdownform.ChoosebannerbuttonClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
  if FileExists(OpenPictureDialog1.FileName) then
  begin
    specificbannerpath.Caption:=OpenPictureDialog1.FileName;
  end;
  If specificbannerRadioButton.Checked=false then specificbannerRadioButton.Checked:=true else choosebanner;
end;

procedure TCountdownform.chooselabelClick(Sender: TObject);
begin
  next;
end;

procedure TCountdownform.coloriconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=screencolor;
end;

procedure TCountdownform.colorscheme1Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme2Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme3Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme4Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme5Change(Sender: TObject);
begin
   changecolorscheme;
end;

procedure TCountdownform.colorscheme6Change(Sender: TObject);
begin
   changecolorscheme;
end;

procedure TCountdownform.colorscheme7Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme8Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.colorscheme9Change(Sender: TObject);
begin
  changecolorscheme;
end;

procedure TCountdownform.ControlaudiocheckboxChange(Sender: TObject);
begin
  if Controlaudiocheckbox.Checked=true then
  begin
    audiovolumebox.Visible:=true;
    TCPmusicnetwork.Connect(AudioIPedit.Text, Audioportnumber.Value);
    setmusicstatus;
  end
  else
  begin
    audiovolumebox.Visible:=false;
    TCPmusicnetwork.Disconnect;
  end;
end;

procedure TCountdownform.dangerClick(Sender: TObject);
begin
  stopemergency
end;

procedure TCountdownform.defaultbannerRadioButtonChange(Sender: TObject);
begin
  choosebanner;
end;

procedure TCountdownform.emergencyiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=tabEmergency;
end;

procedure TCountdownform.EmergencytxtEditChange(Sender: TObject);
begin
  EmergencyalternativeRadioButton.Checked:=true;
end;

procedure TCountdownform.F10panelClick(Sender: TObject);
begin
  scenario:='F10';
  setvarsettings;
end;

procedure TCountdownform.F11panelClick(Sender: TObject);
begin
  scenario:='F11';
  setvarsettings;
end;

procedure TCountdownform.F12panelClick(Sender: TObject);
begin
  scenario:='F12';
  setvarsettings;
end;

procedure TCountdownform.F1panelClick(Sender: TObject);
begin
  scenario:='F1';
  setvarsettings;
end;

procedure TCountdownform.F2panelClick(Sender: TObject);
begin
  scenario:='F2';
  setvarsettings;
end;

procedure TCountdownform.F3panelClick(Sender: TObject);
begin
  scenario:='F3';
  setvarsettings;
end;

procedure TCountdownform.F4panelClick(Sender: TObject);
begin
  scenario:='F4';
  setvarsettings;
end;

procedure TCountdownform.F5panelClick(Sender: TObject);
begin
  scenario:='F5';
  setvarsettings;
end;

procedure TCountdownform.F6panelClick(Sender: TObject);
begin
  scenario:='F6';
  setvarsettings;
end;

procedure TCountdownform.F7panelClick(Sender: TObject);
begin
  scenario:='F7';
  setvarsettings;
end;

procedure TCountdownform.F8panelClick(Sender: TObject);
begin
  scenario:='F8';
  setvarsettings;
end;

procedure TCountdownform.F9panelClick(Sender: TObject);
begin
  scenario:='F9';
  setvarsettings;
end;

procedure TCountdownform.FbutonscreenboxChange(Sender: TObject);
begin
  if Fbutonscreenbox.Checked then
  begin
    F1panel.Visible:=true;
    F2panel.Visible:=true;
    F3panel.Visible:=true;
    F4panel.Visible:=true;
    F5panel.Visible:=true;
    F6panel.Visible:=true;
    F7panel.Visible:=true;
    F8panel.Visible:=true;
    F9panel.Visible:=true;
    F10panel.Visible:=true;
    F11panel.Visible:=true;
    F12panel.Visible:=true;
  end
  else
  begin
    F1panel.Visible:=false;
    F2panel.Visible:=false;
    F3panel.Visible:=false;
    F4panel.Visible:=false;
    F5panel.Visible:=false;
    F6panel.Visible:=false;
    F7panel.Visible:=false;
    F8panel.Visible:=false;
    F9panel.Visible:=false;
    F10panel.Visible:=false;
    F11panel.Visible:=false;
    F12panel.Visible:=false;
  end;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
end;

procedure TCountdownform.finalteamturnsChange(Sender: TObject);
begin
  if archerysystem='fitafin' then
  if serienumber > finalteamturns.Value then
  begin
    serienumber:=finalteamturns.Value;
    viewturnchange;

  end;
  startupscenario.Text:='--';
end;

procedure TCountdownform.fitafiniconClick(Sender: TObject);
begin
  FITAFIN.Checked:=true;
end;

procedure TCountdownform.fitaiconClick(Sender: TObject);
begin
  FITA.Checked:=true;
end;


procedure TCountdownform.followChange(Sender: TObject);
begin
  olds:='TS2000000000000';
  olds14:='0';
  olds3:='0';
  olds4:='0';
  olds15:='0';
  oldfollowsystem:='9';
 orgrepeatsequence:=repeatsequence.Value;
 orgfolabcdsec:=ABCDperEND.Checked;
 orgPABCDperEND:=PABCDperEND.Checked;
 orgfol25m1pse:=rotate25m1p.Checked;
 orgfol25m1pse_p:=rotate25m1p_p.Checked;
 if minsec.ItemIndex=0 then orgfolminsec:=false else orgfolminsec:=true;
 archerysystem:='follow';
 oldShooters:=0;

 initsystemtype;

 prevstate:=1;

end;

procedure TCountdownform.followiconClick(Sender: TObject);
begin
  follow.Checked:=true;
end;

procedure TCountdownform.followtimerTimer(Sender: TObject);
begin

  NETWORK1.Connect(fromhostrefresh.Caption, portnumber1.Value);
  NETWORK1.SendMessage('CON'+HOSTNAME.Caption);

end;

procedure TCountdownform.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
  var fileDesc: integer;
begin
  rcvmcasttimer.Enabled:=false;
   {$IFDEF Unix}
  { Free SoC pin 17: }
  try
    fileDesc := fpopen('/sys/class/gpio/unexport', O_WrOnly);

  //  gReturnCode := fpwrite(fileDesc, PIN_6[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_13[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_19[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_26[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_12[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_16[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_20[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_21[0], 2);


    gReturnCode := fpwrite(fileDesc, PIN_2[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_3[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_4[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_17[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_27[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_22[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_10[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_9[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_11[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_5[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_7[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_8[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_25[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_24[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_23[0], 2);
  //  gReturnCode := fpwrite(fileDesc, PIN_18[0], 2);

    //LogMemo.Lines.Add(IntToStr(gReturnCode));
  finally
    gReturnCode := fpclose(fileDesc);
    //LogMemo.Lines.Add(IntToStr(gReturnCode));
  end;
  {$ENDIF}
  //preclose;
end;

procedure TCountdownform.fromHOSTChange(Sender: TObject);
begin
  fromhostrefresh.Caption:=fromHOST.Text;
  connectports;
end;

procedure TCountdownform.fullscreencheckboxChange(Sender: TObject);
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
end;

procedure TCountdownform.greenfinalendsoChange(Sender: TObject);
begin
  totalfinalendso.Caption:= inttostr( trunc(orangefinalendso.value)+trunc(greenfinalendso.value));
  startupscenario.Text:='--';
end;


procedure TCountdownform.GrnColListBoxbgClick(Sender: TObject);
begin
  GrnColBGPanel.Color:=GrnColListBoxbg.Selected;
  changecolorscheme;

end;

procedure TCountdownform.GrnColListBoxtimeClick(Sender: TObject);
begin
  GrnColtimeLabel.Font.Color:=GrnColListBoxtime.Selected;
  changecolorscheme;

end;

procedure TCountdownform.HardwareiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=hardwaretab;
end;


procedure TCountdownform.icon25m1pClick(Sender: TObject);
begin
  onepijl.Checked:=true;
end;

procedure TCountdownform.Image1Click(Sender: TObject);
begin
  colorscheme1.Checked:=true;
end;

procedure TCountdownform.Image2Click(Sender: TObject);
begin
  colorscheme2.Checked:=true;
end;

procedure TCountdownform.Image3Click(Sender: TObject);
begin
  colorscheme3.Checked:=true;
end;

procedure TCountdownform.Image4Click(Sender: TObject);
begin
  colorscheme4.Checked:=true;
end;

procedure TCountdownform.Image5Click(Sender: TObject);
begin
  colorscheme5.Checked:=true;
end;

procedure TCountdownform.Image6Click(Sender: TObject);
begin
  colorscheme6.Checked:=true;
end;

procedure TCountdownform.Image7Click(Sender: TObject);
begin
  colorscheme7.Checked:=true;
end;

procedure TCountdownform.Image8Click(Sender: TObject);
begin
  colorscheme8.Checked:=true;
end;

procedure TCountdownform.indfindefbuttonClick(Sender: TObject);
begin
  timeperturn.Checked:=true;
  finalturns.Value:=3;
  finalturnsSO.Value:=1;
  greenfinal.Value:=20;
  orangefinal.Value:=0;
  redfinal.Value:=10;
  startupscenario.Text:='--';
end;

procedure TCountdownform.languageiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=tablang;
end;

procedure TCountdownform.LANinputChange(Sender: TObject);
begin
  if LANinput.Checked=true then
  begin

    connectports;
  end
  else
  begin
    Receivenetworkpanel.visible:=false;
    connectports;
  end;
  startupscenario.Text:='--';
end;

procedure TCountdownform.LanremoteselectChange(Sender: TObject);
begin
  if Lanremoteselect.Checked=true then
  begin
    if TCPnetwork.Listen(portnumber1.Value) then isserver:=true else isserver:=false;
  end
  else
  begin
    isserver:=false;
    TCPnetwork.Disconnect;
  end;
end;

procedure TCountdownform.Followlansettings;
begin
  if LANinput.Checked=true then
  begin
  end;

end;

procedure TCountdownform.LANselectChange(Sender: TObject);
begin
  connectports;
end;

procedure TCountdownform.largeimagecheckboxChange(Sender: TObject);
begin
  if (state=1) and ((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) then
  begin
    backgroundtimer.Enabled:=true;
  end
  else
  begin
    backgroundtimer.Enabled:=false;
    if (Actualtimecheckbox.Checked=true) then imagecount:=-1 else imagecount:=0;
  end;
  if (largeimagecheckbox.Checked = false)and (Actualtimecheckbox.Checked=true) then imagecount:=-1 else
  begin
    imagecount:=0;

  end;
  actualtimerstatus;
  if Actualtimecheckbox.Checked=true then
  begin
    am24_2.Enabled:=true;
  end
  else
  begin
    am24_2.Enabled:=false;
  end;
  viewarchsystemchange;
  viewchangestateexchange;
  viewchangestateinact;
  viewicons;
  viewstateone;
end;

procedure TCountdownform.layouticonClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=tabscr;
end;

procedure TCountdownform.leftscreenChange(Sender: TObject);
begin
  if (archerysystem='follow') then
  if LANinput.Checked then broadswitch else switchfollow;
  TLleft.Checked:=true;
  startupscenario.Text:='--';
end;

procedure TCountdownform.leftsideclientbuttonClick(Sender: TObject);
begin
  leftscreen.Checked:=true;
  TLleft.Checked:=true;
  Setsystemsettings;
end;


procedure TCountdownform.logpptClick(Sender: TObject);
begin
  pgupcombox.ItemIndex:=4;
  pgdncombox.ItemIndex:=5;
  playcombox.ItemIndex:=2;
  blnkcombox.ItemIndex:=0;
end;

Procedure TCountdownform.broadswitch;
begin
  olds3:='0';
  olds4:='0';
  olds15:='0';

end;


procedure TCountdownform.magnificationChange(Sender: TObject);
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowlabelsiconsmenu;
end;


procedure TCountdownform.manualiconClick(Sender: TObject);
begin
  Manual.Checked:=true;
end;

procedure TCountdownform.mxteamfindefbuttonClick(Sender: TObject);
begin
  timeperend.Checked:=true;
  finalteamturns.Value:=2;
  finalteamturnsSO.Value:=2;
  greenfinalend.Value:=50;
  orangefinalend.Value:=30;
  redfinalend.Value:=10;
  greenfinalendso.Value:=10;
  orangefinalendso.Value:=30;
  redfinalendso.Value:=10;
  startupscenario.Text:='--';
end;

procedure TCountdownform.networkiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=TabNetwork;
end;

procedure TCountdownform.networktimestampTimer(Sender: TObject);
var sntstring:string;

    List: TStrings;
begin

  sndsock:=TUDPBlockSocket.Create;

      sndsock.createsocket;
      sndsock.Bind('0.0.0.0','0');
      sndsock.MulticastTTL := 1;

      sndsock.connect(inttostr(IP1.Value)+'.'+inttostr(IP2.Value)+'.'+inttostr(IP3.Value)+'.'+inttostr(IP4.Value),inttostr(portnumber1.Value));

  begin
    sntstring:='TS20000000000000';
    sntstring[3]:=char(repeatsequence.Value+49);  //'2';
    sntstring[4]:=SENTBROAD1;
    sntstring[15]:=SENTBROAD12;
    sntstring[5]:=SENTBROAD2;
    sntstring[6]:=SENTBROAD3;
    sntstring[7]:=SENTBROAD4;
    sntstring[8]:=SENTBROAD5;
    sntstring[9]:=SENTBROAD6;
    sntstring[10]:=SENTBROAD7;
    sntstring[11]:=SENTBROAD8;
    sntstring[12]:=SENTBROAD9;
    sntstring[13]:=SENTBROAD10;
    sntstring[14]:=SENTBROAD11;



    if repeatnetworkcount=1 then repeatnetworkstring1:=sntstring;
    if repeatnetworkcount=2 then repeatnetworkstring2:=sntstring;
    if repeatnetworkcount=3 then repeatnetworkstring3:=sntstring;
    if repeatnetworkcount>3 then repeatnetworkcount:=1 else repeatnetworkcount:=repeatnetworkcount+1;
    if ((repeatnetworkstring1=repeatnetworkstring2) and (repeatnetworkstring2=repeatnetworkstring3) and (repeatnetworkstring1=repeatnetworkstring3)) then
    begin
      repeatnetworkstring1:='A';
      repeatnetworkstring2:='B';
      repeatnetworkstring3:='C';
      List := TStringList.Create;
      try
        ExtractStrings(['.'], [], PChar(HOSTNAME.Caption), List);
        sndsock.SendString('SI'+char(strtoint(List[0]))+char(strtoint(List[1]))+char(strtoint(List[2]))+char(strtoint(List[3]))+FBroad[sentscencount]);
      finally
        List.Free;
      end;
      if sentscencount>=12 then sentscencount:=1 else sentscencount:=sentscencount+1;
    end
    else
    begin
      sndsock.SendString(sntstring);
    end;


  end;
  sndsock.free;
  if (nrofshutdwnsignals<1) and Shutdwnremote=true then
  begin
    Shutdwnremote:=false;
    switchbox;
  end;
  if (nrofshutdwnsignals>0) then nrofshutdwnsignals:=nrofshutdwnsignals-1;
end;

procedure TCountdownform.nexthelpClick(Sender: TObject);
begin
  next;
end;

procedure TCountdownform.nonzerosecChange(Sender: TObject);
begin
  viewactivate;

end;

procedure TCountdownform.normalpptClick(Sender: TObject);
begin
  pgupcombox.ItemIndex:=2;
  pgdncombox.ItemIndex:=0;
  playcombox.ItemIndex:=3;
  blnkcombox.ItemIndex:=8;
end;

procedure TCountdownform.nrof1ppractisearrowsChange(Sender: TObject);
begin
  if (nrof1ppractisearrows.value< serienumber)   and (Practiseturn =1) then
  if (nrof1ppractisearrows.value=0) then Practiseturn :=0 else
  begin
    Practiseturn:=1;
    serienumber:=nrof1ppractisearrows.value;

  end;
  startupscenario.Text:='--';
  viewturnchange;
  switchbox;
  TLswitch;

end;

procedure TCountdownform.onefiveClick(Sender: TObject);
begin
  onefivesystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.onesixClick(Sender: TObject);
begin
  onesixsystem;
  showseq;
  showtime;
  startupscenario.Text:='--';

end;

procedure TCountdownform.orangefinalendsoChange(Sender: TObject);
begin
  totalfinalendso.Caption:= inttostr( trunc(orangefinalendso.value)+trunc(greenfinalendso.value));
  startupscenario.Text:='--';

end;

procedure TCountdownform.OrColBGPanelClick(Sender: TObject);
begin


end;

procedure TCountdownform.OrColListBoxbgClick(Sender: TObject);
begin
  OrColBGPanel.Color:=OrColListBoxbg.Selected;
  changecolorscheme;

end;

procedure TCountdownform.OrColListBoxtimeClick(Sender: TObject);
begin
  OrColtimeLabel.Font.Color:=OrColListBoxtime.Selected;
  changecolorscheme;

end;

procedure TCountdownform.portnumber1Change(Sender: TObject);
begin
  connectports;
end;

procedure TCountdownform.portnumberfollowChange(Sender: TObject);
begin
  Followlansettings;
end;

procedure TCountdownform.portnumberrecChange(Sender: TObject);
begin

end;

procedure TCountdownform.preborder1Click(Sender: TObject);
begin
  prelayoutradio2.Checked:=true;
end;

procedure TCountdownform.preborderClick(Sender: TObject);
begin
  prelayoutradio1.Checked:=true;
end;

procedure TCountdownform.precounticonClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=tabprecnt;
end;

procedure TCountdownform.prelayoutradio1Change(Sender: TObject);
begin
  viewchangestateinact;
  resizewindowpreclock;
end;

procedure TCountdownform.prelayoutradio2Change(Sender: TObject);
begin
  viewchangestateinact;
  resizewindowpreclock;
end;

procedure TCountdownform.PrepColListBoxbgClick(Sender: TObject);
begin
  PrepColBGPanel.Color:=PrepColListBoxbg.Selected;
  changecolorscheme;
end;


procedure TCountdownform.rcvmcasttimerTimer(Sender: TObject);
  var
    s, buf: string;

    svalue:integer;
  begin
      rcvsock:=TUDPBlockSocket.Create;
      try
        rcvsock.createsocket;
        rcvsock.Bind('0.0.0.0',inttostr(portnumber1.Value));
        rcvsock.AddMulticast(inttostr(IP1.Value)+'.'+inttostr(IP2.Value)+'.'+inttostr(IP3.Value)+'.'+inttostr(IP4.Value));
        buf:=rcvsock.RecvPacket(150);
      except
        rcvmcasttimer.Enabled:=false;
        rcvmcasttimer.Enabled:=true;
      end;

      rcvsock.Free;



    if buf <> '' then s:=buf;


    teststringleft.Caption:=s;
    if (length(s)>=3) and (s <> olds) then
    begin
      olds:=s;
      if ((s[1]='T') and (s[2]='S') and (laninput.Checked=true)) then
      begin
        if (olds3<>s[3]) then
        begin
          repeatsequence.Value:=(ord(s[3])-49);

          olds3:=s[3];
        end;
        prevfolstate:=state;
        if (olds4<>s[4])or(olds15<>s[15])  then
        begin
          if followsystem='2' then
          begin
            if (((rightscreen.Checked=true) and((Byte(s[4])and 8)shr 3=1)) or ((leftscreen.Checked=true) and( (Byte(s[4])and 1)=1)))and ((Byte(s[15])and 7<>1)  and (Byte(s[15])and 7<>6) ) then state:=2
            else state:= (Byte(s[15])and 7);
            realstate:= (Byte(s[15])and 7);
          end
          else state:= (Byte(s[15])and 7);
          if ((((Byte(s[4])and 64)shr 6) = 1) and (oldsound = '0'))and (buzzertimer.Enabled=false) then
          Begin
            nrofmanualbeeps:=1;
            if state = 6 then
            begin
              alarmstate:=1; //remember we are in tabEmergency
              emergencytext.Visible:=true;
            end;

            soundsignal;
            if ((state=1) or (state=6)) then viewstateone;
            oldsound:= inttostr((Byte(s[4])and 64)shr 6);
          end
          else
          begin
            if (((Byte(s[4])and 64)shr 6) = 0) then
            begin
              oldsound:= inttostr((Byte(s[4])and 64)shr 6);
            end;
          end;


          if (((state=1)and(oldstate=5)) or ((state=6)and(oldstate=5)) or ((state=2)and(oldstate=5))or ((state=5)and((oldstate=1)or(oldstate=6)))) then
          begin
            if state<>oldstate then viewchangestateinact;
            if state=5 then
            begin
              viewarchsystemchange;
              viewicons;
            end;
          end
          else
          begin
            prevstate:=1;
            if ((state<>oldstate) and not((state=2)and(oldstate=1)) and (state<>1)) then viewchangestateactive;

          end;

          if (((prevfolstate=2) or (prevfolstate=3) or (prevfolstate=4)) and ((state=1) or (state=5) or (state=6))) or (((prevfolstate=1) or (prevfolstate=5) or (prevfolstate=6)) and ((state=2) or (state=3) or (state=4))) then  if state<>oldstate then
          begin
            viewchangestateexchange;
            if ((prevfolstate=1)or(state=1)or(prevfolstate=6)or(state=6)) then
            begin
              viewicons;
              viewstateone;
            end;
          end;
          if (prevfolstate=5) or (prevfolstate=1) then if state<>oldstate then viewchangestateactive;
          followsystem:= inttostr((Byte(s[15])and 120) shr 3);
          if followsystem='0' then
          Begin
            showABCD:=false;
            nrofturns:=1;
          end;
          if followsystem='1' then
          Begin
            showABCD:=true;
            nrofturns:=1;
          end;
          if followsystem='6' then
          Begin
            showABCD:=false;
            nrofturns:=2;
          end;
          if followsystem='7' then
          Begin
            showABCD:=true;
            nrofturns:=2;
          end;
          oldstate:=state;

          olds4:=s[4];
          olds15:=s[15];
        end;
        begin
          if state <>5 then
          begin
            if (leftscreen.Checked=true) then
            begin
              if   (olds5<>s[5]) or (olds7<>s[7])  then
              begin
                digit3_1.Caption:= inttostr((Byte(s[5])and 127)mod 10);
                digit2_1.Caption:= inttostr(((Byte(s[5])and 127)mod 100)div 10);
                digit1_1.Caption:= inttostr((Byte(s[7])and 15)mod 10);
              end;

            end
            else
            begin
              if   (olds6<>s[6]) or (olds8<>s[8])  then
              begin
                digit3_1.Caption:= inttostr((Byte(s[6])and 127)mod 10);
                digit2_1.Caption:= inttostr(((Byte(s[6])and 127)mod 100)div 10);
                digit1_1.Caption:= inttostr((Byte(s[8])and 15)mod 10);

              end;

            end;
          end
          else
          begin
            if   (olds5<>s[5]) or (olds7<>s[7])  then
            begin
              digit3_3.Caption:= inttostr((Byte(s[5])and 127)mod 10);
              digit2_3.Caption:= inttostr(((Byte(s[5])and 127)mod 100)div 10);
              digit1_3.Caption:= inttostr((Byte(s[7])and 63)mod 100);

            end;
            if (((Byte(s[7])and 63)mod 100) >8) and ((olds7<>s[7])) then resizewindowpreclock;

          end;
          if (olds9<>s[9]) then serienumber:= (Byte(s[9])and 127);
          if (olds8<>s[8]) then turnnumber:=(Byte(s[8])and 112)shr 4;
          if (olds7<>s[7]) then
          begin
            if (Byte(s[7])and 64)=64 then minsec.ItemIndex:=1 else minsec.ItemIndex:=0;
            if (Byte(s[7])and 128)=128 then zerosec.Checked:=true else nonzerosec.Checked:=true;
          end;
          if state <>5 then
          begin
            setleftclockdigits;

          end;

          olds5:=s[5];
          olds6:=s[6];
          olds7:=s[7];
          olds8:=s[8];
        end;

        if (olds13<>s[13]) then
        begin
          Practiseturn:=((Byte(s[13])and 64)shr 6);
          if ((Byte(s[13])and 32)shr 5)=1 then followleft:=true else followleft:=false;
          if ((Byte(s[13])and 16)shr 4)=1 then followright:=true else followright:=false;
          olds13:=s[13];
        end;
        if (state<>3) and (state<>4) then
        Begin
            if ((((Byte(s[4])and 8)shr 3) = 0) and (rightscreen.Checked=true)) or ((((Byte(s[4])and 1)shr 0) = 0)and(leftscreen.Checked=true))or ( (state=6)) or ((followsystem='2') and not(followright or followleft)) then
            begin
              if ((digit1_1.Font.Color<>waitcolor)and (lamp_red_right_on_off=1))  then
              begin
                digit1_1.Font.Color:=waitcolor;          // during red state the font of the timers are redcolor
                dots_1.Font.Color:=waitcolor;
                digit2_1.Font.Color:=waitcolor;
                digit3_1.Font.Color:=waitcolor;
              end;
              if ((Countdownform.Color<>bgwaitcolor)and (lamp_red_right_on_off=1)) then Countdownform.Color:=bgwaitcolor;
              if (state <>6) then
              begin
                lamp_red_right_on_off:=0;
                lamp_red_left_on_off:=0;
              end;
            end
            else
            begin
              if ((digit1_1.Font.Color<>redcolor)and (lamp_red_right_on_off=0))and (not((followsystem='2') and not(followright or followleft))) then    //and (followright or followleft)
              begin
                digit1_1.Font.Color:=redcolor;          // during red state the font of the timers are redcolor
                dots_1.Font.Color:=redcolor;
                digit2_1.Font.Color:=redcolor;
                digit3_1.Font.Color:=redcolor;

              end;
              if ((Countdownform.Color<>bgredcolor))and ((not((followsystem='2') and not(followright or followleft)))) then
              begin
                if (followsystem='2')or (state =2) then Countdownform.Color:=bgredcolor;
              end;
              if ((((Byte(s[4])and 8)shr 3) = 1) and (rightscreen.Checked=true)) or ((((Byte(s[4])and 1)shr 0) = 1)and(leftscreen.Checked=true)) then
              begin
                lamp_red_right_on_off:=1;
                lamp_red_left_on_off:=1;
              end;
            end;
            if (((Byte(s[4])and 8)shr 3) = 1) and (((Byte(s[4])and 1)shr 0) = 1) then
            begin
              lamp_red_right_on_off:=1;
              lamp_red_left_on_off:=1;
            end;
        end
        else
        begin
          if followsystem='2' then
          begin
            if ((leftscreen.Checked=true) and (((Byte(s[4])and 1)shr 0) = 1))or((rightscreen.Checked=true) and (((Byte(s[4])and 8)shr 3) = 1)) then
            begin
              lamp_red_left_on_off:=1;
              lamp_red_right_on_off:=1;
            end
            else
            begin
              lamp_red_left_on_off:=0;
              lamp_red_right_on_off:=0;
            end;
          end;
        end;
        viewstateone;
        setleftclockdigits;
        TLswitch;
        if ((turnnumber<>oldfolturnnumber ) or (serienumber <> oldserienumber) or (Practiseturn <> oldPractiseturn)) then
        begin
          viewturnchange;
          oldfolturnnumber:=turnnumber;
          oldserienumber:=serienumber;
          oldPractiseturn:=Practiseturn;
        end;
        if (olds10<>s[10]) then
        begin
          if ((Byte(s[10])and 128)shr 7)=1 then shootoff:=0 else shootoff:=1;
          viewarchsystemchange;
          olds10:=s[10];
        end;
        if (olds11<>s[11]) then
        begin
          ABCDperEND.checked:= boolean((Byte(s[11])and 64)shr 6);
          PABCDperEND.checked:= not(boolean((Byte(s[11])and 128)shr 7));
          olds11:=s[11];
        end;
        if (olds12<>s[12]) then
        begin
          rotate25m1p.Checked:= boolean((Byte(s[12])and 64)shr 6);
          rotate25m1p_p.Checked:= boolean((Byte(s[12])and 128)shr 7);
          olds12:=s[12];
        end;
        if (olds14<>s[14]) then
        begin
          Shooters:=(((Byte(s[14])and 7)+1)*(((Byte(s[14])and 24) shr 3)+1));
          Turnsperserie:=((Byte(s[14])and 7)+1);
          Archersperturn:=(((Byte(s[14])and 24) shr 3)+1);
          olds14:=s[14];
        end;
        if (followsystem='2') and ((followleft<>oldfollowleft)or(followright<>oldfollowright))   then
        begin
          viewturnchange;
          oldfollowleft:=followleft;
          oldfollowright:=followright;
        end;

        if (followsystem <> oldfollowsystem) then
        begin
          viewarchsystemchange;
          viewturnchange;
          viewicons;
          if (followsystem='2')  then
          begin
            resizewindowfinalturndetails;
            viewstateone;
          end
          else
          begin
            resizewindownonfinals;
          end;
          oldfollowsystem:=followsystem;
        end;
        if ((turnnumber<>oldfolturnnumber ) or (Turnsperserie <> oldfolTurnsperserie) or (Archersperturn<> oldfolArchersperturn)) then
        begin
          viewturnchange;
          resizewindownonfinals;
          oldfolturnnumber:=turnnumber;
          oldfolTurnsperserie:=Turnsperserie;
          oldfolArchersperturn:=Archersperturn;
        end;
        if (Shooters <> oldShooters) then
        begin
          viewarchsystemchange;
          oldShooters:=Shooters;
        end;
        if  ((ABCDperEND.checked <> oldABCDperEND) or  (rotate25m1p.Checked <> oldrotate25m1p ) or  (rotate25m1p_p.Checked <> oldrotate25m1p_p )) then
        begin
          resizewindownonfinals;
          oldABCDperEND:= ABCDperEND.checked;
          oldrotate25m1p:= rotate25m1p.Checked;
          oldrotate25m1p_p:= rotate25m1p_p.Checked;
        end;
        if state<>1 then
        begin
          manualfollowmenuremove:=true;
        end
        else manualfollowmenuremove:=false;
        if (S <> orgS) then switchbox;
        orgS:=S;
        if (s[10]+s[11]+s[12]='xGx') and (RemshutdownCheckBox.Checked=true) then
        begin
          {$IFDEF Unix}
          shutdownsys;
          {$ENDIF}

        end;
      end;
    end;
  end;

procedure TCountdownform.reamfindefbuttonClick(Sender: TObject);
begin
  timeperend.Checked:=true;
  finalteamturns.Value:=2;
  finalteamturnsSO.Value:=3;
  greenfinalend.Value:=90;
  orangefinalend.Value:=30;
  redfinalend.Value:=10;
  greenfinalendso.Value:=30;
  orangefinalendso.Value:=30;
  redfinalendso.Value:=10;
  startupscenario.Text:='--';
end;

procedure TCountdownform.RedColCDLabelClick(Sender: TObject);
begin
  RedColBGPanel.Color:=RedColListBoxbg.Selected;
  changecolorscheme;
end;

procedure TCountdownform.RedColListBoxbgClick(Sender: TObject);
begin
  RedColBGPanel.Color:=RedColListBoxbg.Selected;
  changecolorscheme;
end;

procedure TCountdownform.RedColListBoxtimeClick(Sender: TObject);
begin
  RedColtimeLabel.Font.Color:=RedColListBoxtime.Selected;
  changecolorscheme;

end;

procedure TCountdownform.redfinalendsoChange(Sender: TObject);
begin
  startupscenario.Text:='--';

end;

procedure TCountdownform.RemoveimagebuttonClick(Sender: TObject);
var wasimagesselected:boolean;
begin
  wasimagesselected:= largeimagecheckbox.Checked;
  largeimagecheckbox.Checked:=false;
  imagesListBox.Items.Delete(imagesListBox.ItemIndex);
  {$IFDEF Windows}
  imagesListBox.Items.SaveToFile('backgroundimages');
  {$ENDIF}

  {$IFDEF Unix}
  if linuxHW='RPI' then imagesListBox.Items.SaveToFile('/home/pi/archeryclock/backgroundimages') else imagesListBox.Items.SaveToFile('backgroundimages');
  {$ENDIF}
  if wasimagesselected then largeimagecheckbox.Checked:=true;
end;

procedure TCountdownform.repeatsequenceChange(Sender: TObject);
begin
  startupscenario.Text:='--';
  viewturnchange;
end;

procedure TCountdownform.retrColListBoxbgClick(Sender: TObject);
begin
  retrColBGPanel.Color:=retrColListBoxbg.Selected;
  retrLabel.Color:=retrColListBoxbg.Selected;
  changecolorscheme;
end;

procedure TCountdownform.retrColListBoxtimeClick(Sender: TObject);
begin
  retrColtimeLabel.Font.Color:=retrColListBoxtime.Selected;
  changecolorscheme;
end;

procedure TCountdownform.rightsideclientbuttonClick(Sender: TObject);
begin
  rightscreen.Checked:=true;
  TLright.Checked:=true;
  Setsystemsettings;
end;

procedure TCountdownform.RnextturnbgClick(Sender: TObject);
begin

end;



procedure TCountdownform.rotate25m1pChange(Sender: TObject);
begin
  viewturnchange;
  switchbox;
  TLswitch;
  viewicons;
  startupscenario.Text:='--';
end;



procedure TCountdownform.scenarioiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=tabscen;
end;

procedure TCountdownform.screencolorHide(Sender: TObject);
begin
  manualcolorpanel.Visible:=false;
end;

procedure TCountdownform.screencolorShow(Sender: TObject);
begin
  if colorscheme9.Checked=true then  manualcolorpanel.Visible:=true else manualcolorpanel.Visible:=false;
end;


procedure TCountdownform.serial2RxData(Sender: TObject);

  var Ard :string;
begin
  Ard:=serial2.ReadData;
  perfsercommand(Ard);
end;

procedure TCountdownform.serialfreqdelayTimer(Sender: TObject);
begin
  serialtimestamp.Interval:=100;
  //copyright.Caption:='100';
  serialfreqdelay.Enabled:=false;
end;


procedure TCountdownform.serialport2Change(Sender: TObject);
begin
  serial2.Device:=serialport2.Text;
    if arduinoselect2.checked=true then
    begin
      serial2.close;
      if initializationstate=false then connect;
    end;


end;

procedure TCountdownform.serialtimestampTimer(Sender: TObject);

begin
  if (archerysystem<>'follow') or ((archerysystem='follow')and(LANinput.Checked)) then
  begin



  if refreshtiming > 50 then  refreshtiming:=1 else inc(refreshtiming);
  if refreshtiming=7 then serref1:=true;
  if refreshtiming=12 then serref2:=true;
  if refreshtiming=17 then serref3:=true;
  if refreshtiming=22 then serref4:=true;
  if refreshtiming=27 then serref5:=true;
  if refreshtiming=32 then serref6:=true;
  if refreshtiming=37 then serref7:=true;
  if (SENTLAN1<>arduinowrite1) then
  begin
    serint:=1;
  end
   else  if (SENTLAN2<>arduinowrite2) then serint:=2 else if (SENTLAN6<>arduinowrite6) then serint:=6 else if (SENTLAN3<>arduinowrite3) then serint:=3;
  case serint of
  6: begin
       if (SENTLAN6<>arduinowrite6) or (serref6=true) then
       begin
         serial.WriteData(inttostr(SENTLAN6)+chr(13));
         serial2.WriteData(inttostr(SENTLAN6)+chr(13));
       end;
       arduinowrite6:=SENTLAN6;
       serref6:=false;
       serint:=5;
     end;
  5: begin
       if (SENTLAN5<>arduinowrite5) or (serref5=true) then
       begin
         serial.WriteData(inttostr(SENTLAN5)+chr(13));
         serial2.WriteData(inttostr(SENTLAN5)+chr(13));
       end;
       arduinowrite5:=SENTLAN5;
       serref5:=false;

       if  archerysystem='fitafin'then serint:=1 else serint:=4;
     end;
  1: begin
       if (SENTLAN1<>arduinowrite1) or (serref1=true) then
       begin
         serial.WriteData(inttostr(SENTLAN1)+chr(13));
         serial2.WriteData(inttostr(SENTLAN1)+chr(13));
       end;
       arduinowrite1:=SENTLAN1;
       serref1:=false;
       serint:=2;
      end;
  3: begin
       if (SENTLAN3<>arduinowrite3) or (serref3=true) then
       begin
         serial.WriteData(inttostr(SENTLAN3)+chr(13));
         serial2.WriteData(inttostr(SENTLAN3)+chr(13));
       end;
       arduinowrite3:=SENTLAN3;
       serref3:=false;
       serint:=6;

     end;
  4: begin
       if (SENTLAN4<>arduinowrite4) or (serref4=true) then
       begin
         serial.WriteData(inttostr(SENTLAN4)+chr(13));
         serial2.WriteData(inttostr(SENTLAN4)+chr(13));
       end;
       arduinowrite4:=SENTLAN4;
       serref4:=false;
       if Shooters>4 then serint:=7 else serint:=1;

     end;
  7: begin
       if (SENTLAN4b<>arduinowrite7) or (serref7=true) then
       begin
         serial.WriteData(inttostr(SENTLAN4b)+chr(13));
         serial2.WriteData(inttostr(SENTLAN4b)+chr(13));
       end;
       arduinowrite7:=SENTLAN4b;
       serref7:=false;

       serint:=1;
     end;
  2: begin
       if (SENTLAN2<>arduinowrite2) or (serref2=true) then
       begin
         serial.WriteData(inttostr(SENTLAN2)+chr(13));
         serial2.WriteData(inttostr(SENTLAN2)+chr(13));
       end;
       arduinowrite2:=SENTLAN2;
       serref2:=false;
       if archerysystem='fitafin'then serint:=3 else serint:=6;

     end;
  else
     begin
       serint:=1;
     end;
  end;

  end;
end;


procedure TCountdownform.Shooter5Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if Archersperturn=1 then turnnumber:=5;
    if Archersperturn=2 then turnnumber:=3;
    if Archersperturn=3 then turnnumber:=2;

    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.Shooter6Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if Archersperturn=1 then turnnumber:=6;
    if Archersperturn=2 then turnnumber:=3;
    if Archersperturn=3 then turnnumber:=2;

    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.showendnrcheckboxChange(Sender: TObject);
begin
  viewstateone;
end;

procedure TCountdownform.showendnrlabelClick(Sender: TObject);
begin
  if showendnrcheckbox.Checked=true then showendnrcheckbox.Checked:=false else showendnrcheckbox.Checked:=true;
end;

procedure TCountdownform.shutdowniconClick(Sender: TObject);
begin
  shutdownsys;
end;
procedure TCountdownform.Shutdownremotesystem;
begin
  Shutdwnremote:=true;
  nrofshutdwnsignals:=10;
  switchbox;
end;

procedure TCountdownform.ShutdownremoteButtonClick(Sender: TObject);
begin
  Shutdownremotesystem

end;

procedure TCountdownform.slidetimeChange(Sender: TObject);
begin
  backgroundtimer.Interval:=slidetime.Value*1000;
end;

procedure TCountdownform.soundiconClick(Sender: TObject);
begin
   SettingsTabs.ActivePage:=tabsound;
end;

procedure TCountdownform.specificbannerRadioButtonChange(Sender: TObject);
begin
  choosebanner;

end;

procedure TCountdownform.StartuplabelClick(Sender: TObject);
begin
  Stopstate1.Checked:=true;
end;

procedure TCountdownform.stopimagestate1Click(Sender: TObject);
begin
  Stopstate1.Checked:=true;
end;

procedure TCountdownform.stopimagestate2Click(Sender: TObject);
begin
  Stopstate2.Checked:=true;
end;

procedure TCountdownform.stopimagestate3Click(Sender: TObject);
begin
  Stopstate3.Checked:=true;
end;

procedure TCountdownform.stopimagestate4Click(Sender: TObject);
begin
  Stopstate4.Checked:=true;
end;

procedure TCountdownform.stopimagestate5Click(Sender: TObject);
begin
  Stopstate5.Checked:=true;
end;

procedure TCountdownform.stopimagestate6Click(Sender: TObject);
begin
  Stopstate6.Checked:=true;
end;


procedure TCountdownform.shutdownsys;
var i,j:longint;
  var dummy:string;
begin
  shutdownsystem:=true;
  if LANselect.Checked then
  begin
    closesystem.Enabled:=true;
    closesystemPanel.Font.Height:=Countdownform.Width div 30;
    closesystemPanel.Top:=0;
    closesystemPanel.Left:=0;
    closesystemPanel.Width:=Countdownform.Width;
    closesystemPanel.Height:=Countdownform.Height;
    closesystemPanel.Visible:=true;
    Shutdownremotesystem;

  end;



  Shutdwnremote:=true;
  nrofshutdwnsignals:=10;
  switchbox;
  rcvmcasttimer.Enabled:=false;
  i:=

  1 shl 0+ //trafic light data (not digits)
  0 shl 1+ // 0 is standard red orange green and ABCD. (No ABCD sequence details
  0 shl 2+ //buzzer off
  0 shl 3+ 0 shl 4+ 0 shl 5+ 0 shl 6+ 0 shl 7+ 0 shl 8+ 0 shl 9+ 0 shl 10+ 0 shl 11+ 0 shl 12+ 0 shl 13+     //traffic lamps and ABCD lamps off
  0 shl 14+ 0 shl 15 //nr archers 0
  ;
  j:=
  0 shl 0+ //digits data (traffic lights)
  0 shl 1+ 1 shl 2+ //buzzer offboth sides
  0 shl  3+    //no dots
  0 shl  4+ 1 shl  5+ 0 shl  6+ 1 shl  7+ //right digit
  0 shl  8+ 1 shl  9+ 0 shl 10+ 1 shl 11+ //middle digit
  0 shl 12+ 1 shl 13+ 0 shl 14+ 1 shl 15  //left digit
  ;
  serial.WriteData(inttostr(i)+chr(13));
  sleep(60);
  serial.WriteData(inttostr(j)+chr(13));
  sleep(60);

  {$IFDEF Windows}

  if not DisableOtherFunctionCall then WriteAllDigital(0);
  OutputAnalogChannel(1,0);
  OutputAnalogChannel(2,0);
  {$ENDIF}

  sleep(60);
  if closesystem.Enabled=false then
  begin


    {$IFDEF Unix}{$IFNDEF Darwin}  // Mac: never shut the computer down, just close
    RunCommand('sudo shutdown now', dummy);{$ENDIF}


    {$ENDIF}


    Close;
  end;
end;


procedure TCountdownform.TCP1Receive(aSocket: TLSocket);
var
  s, st2, st3: string;
  svalue:integer;
begin
  if aSocket.GetMessage(s) > 0 then
  teststringleft.Caption:=s;
  if length(s)>=3 then
  begin
    st2:='0000';
    if length(s)=4 then st2:='0';
    if length(s)=5 then st2:='00';
    if length(s)=6 then st2:='000';
    if length(s)=7 then st2:='0000';
    if length(s)=8 then st2:='00000';

    if ((s[1]='T') and (s[2]='S') and (s[3]='T') and (laninput.Checked=true)) then     //timestamp
    begin
      if (s[4]='0') or (s[4]='1') or (s[4]='2') or (s[4]='3') or (s[4]='4') or (s[4]='5') or (s[4]='6') or (s[4]='7') or (s[4]='8') or (s[4]='9') then   st2:='0';
      if (s[5]='0') or (s[5]='1') or (s[5]='2') or (s[5]='3') or (s[5]='4') or (s[5]='5') or (s[5]='6') or (s[5]='7') or (s[5]='8') or (s[5]='9') then   st2:='00';
      if (s[6]='0') or (s[6]='1') or (s[6]='2') or (s[6]='3') or (s[6]='4') or (s[6]='5') or (s[6]='6') or (s[6]='7') or (s[6]='8') or (s[6]='9') then   st2:='000';
      if (s[7]='0') or (s[7]='1') or (s[7]='2') or (s[7]='3') or (s[7]='4') or (s[7]='5') or (s[7]='6') or (s[7]='7') or (s[7]='8') or (s[7]='9') then   st2:='0000';
      if (s[8]='0') or (s[8]='1') or (s[8]='2') or (s[8]='3') or (s[8]='4') or (s[8]='5') or (s[8]='6') or (s[8]='7') or (s[8]='8') or (s[8]='9') then   st2:='00000';

      if (s[4]='0') or (s[4]='1') or (s[4]='2') or (s[4]='3') or (s[4]='4') or (s[4]='5') or (s[4]='6') or (s[4]='7') or (s[4]='8') or (s[4]='9') then   st2[1]:=s[4];
      if (s[5]='0') or (s[5]='1') or (s[5]='2') or (s[5]='3') or (s[5]='4') or (s[5]='5') or (s[5]='6') or (s[5]='7') or (s[5]='8') or (s[5]='9') then   st2[2]:=s[5];
      if (s[6]='0') or (s[6]='1') or (s[6]='2') or (s[6]='3') or (s[6]='4') or (s[6]='5') or (s[6]='6') or (s[6]='7') or (s[6]='8') or (s[6]='9') then   st2[3]:=s[6];
      if (s[7]='0') or (s[7]='1') or (s[7]='2') or (s[7]='3') or (s[7]='4') or (s[7]='5') or (s[7]='6') or (s[7]='7') or (s[7]='8') or (s[7]='9') then   st2[4]:=s[7];
      if (s[8]='0') or (s[8]='1') or (s[8]='2') or (s[8]='3') or (s[8]='4') or (s[8]='5') or (s[8]='6') or (s[8]='7') or (s[8]='8') or (s[8]='9') then   st2[5]:=s[8];


      svalue:=strtoint(st2);
      teststringendnr.Caption:=inttostr(svalue);
      st3:='0000000000000000';
      if svalue>=32768 then
      begin
        st3[1]:='1';
        svalue:=svalue-32768
      end;
      if svalue>=16384 then
      begin
        st3[2]:='1';
        svalue:=svalue-16384
      end;
      if svalue>=8192 then
      begin
        st3[3]:='1';
        svalue:=svalue-8192
      end;
      if svalue>=4096 then
      begin
        st3[4]:='1';
        svalue:=svalue-4096
      end;
      if svalue>=2048 then
      begin
        st3[5]:='1';
        svalue:=svalue-2048
      end;
      if svalue>=1024 then
      begin
        st3[6]:='1';
        svalue:=svalue-1024
      end;
      if svalue>=512 then
      begin
        st3[7]:='1';
        svalue:=svalue-512
      end;
      if svalue>=256 then
      begin
        st3[8]:='1';
        svalue:=svalue-256
      end;
      if svalue>=128 then
      begin
        st3[9]:='1';
        svalue:=svalue-128
      end;
      if svalue>=64 then
      begin
        st3[10]:='1';
        svalue:=svalue-64
      end;
      if svalue>=32 then
      begin
        st3[11]:='1';
        svalue:=svalue-32
      end;
      if svalue>=16 then
      begin
        st3[12]:='1';
        svalue:=svalue-16
      end;
      if svalue>=8 then
      begin
        st3[13]:='1';
        svalue:=svalue-8
      end;
      if svalue>=4 then
      begin
        st3[14]:='1';
        svalue:=svalue-4
      end;
      if svalue>=2 then
      begin
        st3[15]:='1';
        svalue:=svalue-2
      end;
      if svalue>=1 then
      begin
        st3[16]:='1';
        svalue:=svalue-1
      end;
      if (st3[16]='0') and ((st3[15]='0') or (st3[14]='1'))  then foltime1:=st3;
      if (st3[16]='0') and ((st3[15]='1') or (st3[14]='1'))  then foltime2:=st3;

      if (st3[16]='1') and (st3[15]='0')  then     foltrafic:=st3;
      if (st3[16]='1') and (st3[15]='1') and (st3[14]='1') and (st3[13]='0')  then folendnr:=st3;
      if (st3[16]='1') and (st3[15]='1') and (st3[14]='0') and (st3[13]='0')  then folsecdetails:=st3;
      if (st3[16]='1') and (st3[15]='1') and (st3[14]='0') and (st3[13]='1')  then folsecdetailssec:=st3;
      if (st3[16]='1') and (st3[15]='1') and (st3[14]='1') and (st3[13]='1')  then folstate:=st3;

      teststring.Caption:=foltime1;
      teststringendnr.Caption:=foltime2;
      teststringendnr3.Caption:=foltrafic;
      teststringendnr1.Caption:=folendnr;
      teststringendnr2.Caption:=folsecdetailssec;
      teststringleft.Caption:=folstate;
      if ((archerysystem='follow') and (LANinput.Checked=true)) then switchfollow;
    end;
  end;
end;
procedure TCountdownform.sentstatusstring;     //notneeded
var atype,pp,finside:integer;
begin
  finside:=0;
  if fitafinarcher='left' then finside:=1;
  if fitafinarcher='right' then finside:=2;
  if fitafinarcher='none' then finside:=0;
  if ((FirstTimer.enabled=false) and (secondTimer.enabled=false)) then pp:=0 else pp:=1;
  atype:=0;
  if (archerysystem='fita') AND NOT(showABCD)then atype:=0;
  begin
    if nrofturns=1 then atype:=0 else atype:=6;
  end;
  if (archerysystem='fita') AND (showABCD)then
  begin
    if nrofturns=1 then atype:=1 else atype:=7;
  end;
  if archerysystem='fitafin'then atype:=2;
  if archerysystem='25m1p'then atype:=3;
  if archerysystem='manual'then atype:=4;
  if archerysystem='follow'then atype:=5;
  if (archerysystem='follow') and (followsystem='2') then atype:=2;
end;

procedure TCountdownform.TCPaccess1Receive(aSocket: TLSocket);
  var rectcpstring,pwnr:string;
      tmp1,i:integer; //for testing
begin
  tmp1:=0;
  for i:=1 to length(pwstring.text) do
  begin
    tmp1:=tmp1+ord(pwstring.text[i]);
  end;
  tmp1:=tmp1+10000;
  pwnr:=inttostr(tmp1);
  if aSocket.GetMessage(rectcpstring)>0 then
  begin
    if (length(rectcpstring)>=12) and ((rectcpstring[1]='c')and(rectcpstring[2]='t')and(rectcpstring[3]='r')and (rectcpstring[8]=pwnr[1])and (rectcpstring[9]=pwnr[2])and (rectcpstring[10]=pwnr[3])and (rectcpstring[11]=pwnr[4])and (rectcpstring[12]=pwnr[5]) and (Lanremoteselect.Checked=true))then
    begin
      if ((rectcpstring[4]='n')and(rectcpstring[5]='e')and(rectcpstring[6]='x')and(rectcpstring[7]='t'))then next;
      if ((rectcpstring[4]='p')and(rectcpstring[5]='l')and(rectcpstring[6]='a')and(rectcpstring[7]='y'))then playpauze;
      if ((rectcpstring[4]='s')and(rectcpstring[5]='t')and(rectcpstring[6]='o')and(rectcpstring[7]='p'))then stop;
      if ((rectcpstring[4]='e')and(rectcpstring[5]='m')and(rectcpstring[6]='e')and(rectcpstring[7]='r'))then stopemergency;
      if ((rectcpstring[4]='l')and(rectcpstring[5]='e')and(rectcpstring[6]='a')and(rectcpstring[7]='r'))then downturn;
      if ((rectcpstring[4]='r')and(rectcpstring[5]='i')and(rectcpstring[6]='a')and(rectcpstring[7]='r'))then upturn;
      if ((rectcpstring[4]='u')and(rectcpstring[5]='p')and(rectcpstring[6]='e')and(rectcpstring[7]='n'))then upserie;
      if ((rectcpstring[4]='d')and(rectcpstring[5]='n')and(rectcpstring[6]='e')and(rectcpstring[7]='n'))then downserie;
      if ((rectcpstring[4]='p')and(rectcpstring[5]='r'))then
      begin
        tostart.Value:=strtoint(rectcpstring[6]+rectcpstring[7]);
        starttostart;
      end;
      if ((rectcpstring[4]='s')and(rectcpstring[5]='o')and(rectcpstring[6]='f')and(FirstTimer.enabled=false)) then
      begin
        if (rectcpstring[7]='1')then nrofSOarrows:=1;
        if (rectcpstring[7]='2')then nrofSOarrows:=2;
        if (rectcpstring[7]='3')then nrofSOarrows:=3;
        soff;
      end;
      if ((rectcpstring[4]='s')and(rectcpstring[5]='f'))then
      begin
        if (rectcpstring[6]+rectcpstring[7])='01' then scenario:='F1';
        if (rectcpstring[6]+rectcpstring[7])='02' then scenario:='F2';
        if (rectcpstring[6]+rectcpstring[7])='03' then scenario:='F3';
        if (rectcpstring[6]+rectcpstring[7])='04' then scenario:='F4';
        if (rectcpstring[6]+rectcpstring[7])='05' then scenario:='F5';
        if (rectcpstring[6]+rectcpstring[7])='06' then scenario:='F6';
        if (rectcpstring[6]+rectcpstring[7])='07' then scenario:='F7';
        if (rectcpstring[6]+rectcpstring[7])='08' then scenario:='F8';
        if (rectcpstring[6]+rectcpstring[7])='09' then scenario:='F9';
        if (rectcpstring[6]+rectcpstring[7])='10' then scenario:='F10';
        if (rectcpstring[6]+rectcpstring[7])='11' then scenario:='F11';
        if (rectcpstring[6]+rectcpstring[7])='12' then scenario:='F12';
        setvarsettings;
      end;
    end;
  end;
end;

procedure TCountdownform.TCPfollowAccept(aSocket: TLSocket);
begin
  teststring.Caption:='ConnectOK';
end;

procedure TCountdownform.TCPfollowReceive(aSocket: TLSocket);
var
  s: string;
begin
end;

procedure TCountdownform.threetwoClick(Sender: TObject);
begin
  threetwosystem;
  showseq;
  showtime;
  startupscenario.Text:='--';

end;

Procedure TCountdownform.actualtimerstatus;
begin
  if (timecheckbox.Checked=true) or ((state=1) and (Actualtimecheckbox.Checked=true))then
  begin
    actualtime.Enabled:=true;
  end
  else
  begin
    actualtime.Enabled:=false;
  end;
end;

procedure TCountdownform.timecheckboxChange(Sender: TObject);
begin
  actualtimerstatus;
  if timecheckbox.Checked=true then
  begin
    am24.Enabled:=true;
    Datetimelabel.Visible:=true;
  end
  else
  begin
    am24.Enabled:=false;
    Datetimelabel.Visible:=false;
  end;
end;

procedure TCountdownform.Timer1Timer(Sender: TObject);
begin
  justconnected:=true;
end;

procedure TCountdownform.topbotClick(Sender: TObject);
begin
  topbotsystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.touchiconClick(Sender: TObject);
begin
  SettingsTabs.ActivePage:=Touchscreentab;
end;


procedure TCountdownform.twothreeClick(Sender: TObject);
begin
  twothreesystem;
  showseq;
  showtime;
  startupscenario.Text:='--';

end;


Procedure  TCountdownform.setgreen;
begin
  state:=3;
  Checkredblink;
  nrofmanualbeeps:=nrgreenbuzz.Value;
  manualfollowmenuremove:=true;
  viewchangestateactive;
  switchbox;
  TLswitch;
  if nrofmanualbeeps<>0 then soundsignal;
end;

Procedure  TCountdownform.setorange;
begin
  state:=4;
  nrofmanualbeeps:=nrorangebuzz.Value;
  manualfollowmenuremove:=true;
  viewchangestateactive;
  switchbox;
  TLswitch;
  if nrofmanualbeeps<>0 then soundsignal;
end;

Procedure  TCountdownform.setred;
begin
  state:=2;
  Checkredblink;
  nrofmanualbeeps:=nrredbuzz.Value;
  manualfollowmenuremove:=true;
  viewchangestateactive;
  switchbox;
  TLswitch;
  if nrofmanualbeeps<>0 then soundsignal;
end;
Procedure  TCountdownform.onebeep;
begin
  manualfollowmenuremove:=true;
  nrofmanualbeeps:=1;
  soundsignal;
end;

Procedure  TCountdownform.twobeeps;
begin
  manualfollowmenuremove:=true;
  nrofmanualbeeps:=2;
  soundsignal;
end;

Procedure  TCountdownform.threebeeps;
begin
  manualfollowmenuremove:=true;
  nrofmanualbeeps:=3;
  soundsignal;
end;


procedure TCountdownform.manualgreenClick(Sender: TObject);
begin
  setgreen;
end;

procedure TCountdownform.manualorangeClick(Sender: TObject);
begin
  setorange;
end;

procedure TCountdownform.manualredClick(Sender: TObject);
begin
  setred;
end;

procedure TCountdownform.rightscreenChange(Sender: TObject);
begin
 if (archerysystem='follow') then
 if LANinput.Checked then broadswitch else switchfollow;
 TLright.Checked:=true;
 startupscenario.Text:='--';
end;

procedure TCountdownform.showtargetChange(Sender: TObject);
begin
  if showtarget.Checked=true then number.Visible:=true else number.Visible:=false;
  startupscenario.Text:='--';
  viewchangestateexchange;
end;


procedure TCountdownform.followClick(Sender: TObject);
begin
  archerysystem:='follow';
  initsystemtype;

end;

procedure TCountdownform.ManualClick(Sender: TObject);
begin
  if archerysystem='follow' then
  begin
    archerysystem:='manual';
    repeatsequence.Value:=orgrepeatsequence;
    ABCDperEND.Checked:=orgfolabcdsec;
    PABCDperEND.Checked:=orgPABCDperEND;
    rotate25m1p.Checked:=orgfol25m1pse;
    rotate25m1p_p.Checked:=orgfol25m1pse_p;
    if orgfolminsec=false then minsec.ItemIndex:=0 else minsec.ItemIndex:=1;
  end;

  archerysystem:='manual';
  initsystemtype;
end;


procedure TCountdownform.arduinoselect1Change(Sender: TObject);
begin
  if initializationstate=false then
  begin
    serialtimestamp.Interval:=1500;
    //copyright.Caption:='1500';
    connect;
    serialfreqdelay.Enabled:=true;
  end;


end;

procedure TCountdownform.connect_delayTimer(Sender: TObject);
begin
  connect_delay.Enabled:=false;
  connect;
end;

procedure TCountdownform.connect_switch_delayTimer(Sender: TObject);
begin
  oldoutpstate:=0;
  justconnected:=true;
  refreshserial;

  connect_switch_delay.Enabled:=false;
  switchbox;

end;

procedure TCountdownform.FormCreate(Sender: TObject);
var
  wVersionRequested : WORD;
  wsaData : TWSAData;
begin
 {Start up WinSock}
  wVersionRequested := MAKEWORD(1, 1);
  WSAStartup(wVersionRequested, wsaData);
end;
procedure  TCountdownform.refreshserial;
begin
  serref1:=true;
  serref2:=true;
  serref3:=true;
  serref4:=true;
  serref5:=true;
  serref6:=true;
  serref7:=true;

end;


procedure TCountdownform.soff;
//shootoff selected
begin
   Shootoff:=1;
   next;
   viewarchsystemchange;
   viewturnchange;
end;


procedure TCountdownform.playpauze;
//play or pause selected

begin
  if (archerysystem='fitafin')and(state=1) then selectnonearcher else
  begin
  if ((archerysystem<>'manual') and (archerysystem<>'follow') and (state<>6)) then
  begin
    endtimout.Enabled:=true;
    if state<>1 then
    begin
      if archerysystem<>'fitafin' then
      begin
        if (FirstTimer.enabled=false)then
        begin
          referencetime:=getcurrenttime+1;
          FirstTimer.enabled:=true ;
          playpauzeicon.Hint:= Paustxt;
        end
        else
        begin
          FirstTimer.enabled:=false ;
          playpauzeicon.Hint:= resumetxt;
        end;
      end
      else
      begin
        if (FirstTimer.enabled=false) and (secondTimer.enabled=false)then
        begin
          referencetime:=getcurrenttime+1;
          if (fitafinarcher='right') then secondTimer.enabled:=true else FirstTimer.enabled:=true ;
          playpauzeicon.Hint:= Paustxt;
        end
        else
        begin
          FirstTimer.enabled:=false ;
          secondTimer.enabled:=false ;
          playpauzeicon.Hint:= resumetxt;
        end;
      end;
    end;
    viewicons;
    viewstateone;
  end;
  end;
end;

procedure TCountdownform.playpausebuttonClick(Sender: TObject);
begin
  playpauze;
end;


procedure TCountdownform.orangetimeChange(Sender: TObject);
begin
  totaltime.Caption:= inttostr( trunc(orangetime.value)+trunc(greentime.value));
  if orangetime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);
  if greentime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.setlanguage;
//put the correct text in the text fields depending on the selected language

var button1index, button2index, button3index, button4index, button5index, button6index, LP1index, LP2index, LP3index, LP4index, GP32index, GP33index,GP35index,GP36index,GP37index,GP38index,GP40index, KP1index, KP2index, KP3index, KP4index, KP5index, leftkeyindex, rightkeyindex, upkeyindex, downkeyindex, dropdown :integer; //to remember the itemindex of combobox during content change
begin
  if buffer ='Español' then buffer := 'Espanol';  //the  ñ character can not be used in a txtfilename
  if buffer ='Ελληνικά' then buffer := 'Greek';
  if buffer ='Slovenský' then buffer := 'Slovensky';
  if buffer ='Português' then buffer := 'Portugues';
  if buffer = 'русский' then buffer:='Russian';
  if buffer = 'Česky' then buffer:='Cesky';
  if buffer = '中文' then buffer:='Chinese';
  if (buffer = 'English') or (buffer = 'Nederlands' ) or (buffer = 'Cesky' ) or (buffer = 'Chinese' ) or (buffer = 'Polski' ) or (buffer = 'Russian' ) or (buffer = 'Portugues' ) or (buffer = 'Svenska' )or (buffer = 'Dansk') or (buffer = 'Eesti') or (buffer = 'Deutsch')  or  (buffer = 'Francais') or (buffer = 'Espanol') or (buffer = 'Italiano') or (buffer = 'Magyar')or (buffer = 'Greek')or (buffer = 'Slovensky') then
  begin
    AssignFile(langTxtFile, Filespath+'language/'+buffer) ;
    Reset(langTxtFile) ;
    ReadLn(langTxtFile, langbuffer) ;
    serielabel.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    arrowlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Practise.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    turnlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    doubleturnslabel.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    secgrnlabel5.Caption:=langbuffer;
    secgrnlabel3.Caption:=langbuffer;
    secgrnlabel4.Caption:=langbuffer;
    secgrnlabel1.Caption:=langbuffer;
    secgrnlabel2.Caption:=langbuffer;
    secgrnlabel6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    secorlabel5.Caption:=langbuffer;
    secorlabel4.Caption:=langbuffer;
    secorlabel1.Caption:=langbuffer;
    secorlabel2.Caption:=langbuffer;
    secorlabel3.Caption:=langbuffer;
    secorlabel6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    secredlabel5.Caption:=langbuffer;
    secredlabel4.Caption:=langbuffer;
    secredlabel1.Caption:=langbuffer;
    secredlabel2.Caption:=langbuffer;
    secredlabel3.Caption:=langbuffer;
    secredlabel6.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    sectotlabel5.Caption:=langbuffer;
    sectotlabel4.Caption:=langbuffer;
    sectotlabel1.Caption:=langbuffer;
    sectotlabel2.Caption:=langbuffer;
    sectotlabel3.Caption:=langbuffer;
    sectotlabel6.Caption:=langbuffer;


    ReadLn(langTxtFile, langbuffer) ;
    Archerlabel25m1p.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    shooteronearrow.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savesettings.Caption:=langbuffer;
    settings.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    newminsecbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    save.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    hideicons.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    speaker.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;

    begin
      F1waitlabel1.Caption:=langbuffer;
      F2waitlabel1.Caption:=langbuffer;
      F3waitlabel1.Caption:=langbuffer;
      F4waitlabel1.Caption:=langbuffer;
      F5waitlabel1.Caption:=langbuffer;
      F6waitlabel1.Caption:=langbuffer;
      F7waitlabel1.Caption:=langbuffer;
      F8waitlabel1.Caption:=langbuffer;
      F9waitlabel1.Caption:=langbuffer;
      F10waitlabel1.Caption:=langbuffer;
      F11waitlabel1.Caption:=langbuffer;
      F12waitlabel1.Caption:=langbuffer;
      F1waitlabel2.Caption:=langbuffer;
      F2waitlabel2.Caption:=langbuffer;
      F3waitlabel2.Caption:=langbuffer;
      F4waitlabel2.Caption:=langbuffer;
      F5waitlabel2.Caption:=langbuffer;
      F6waitlabel2.Caption:=langbuffer;
      F7waitlabel2.Caption:=langbuffer;
      F8waitlabel2.Caption:=langbuffer;
      F9waitlabel2.Caption:=langbuffer;
      F10waitlabel2.Caption:=langbuffer;
      F11waitlabel2.Caption:=langbuffer;
      F12waitlabel2.Caption:=langbuffer;

      varF1waitlabel1.Caption:=langbuffer;
      varF2waitlabel1.Caption:=langbuffer;
      varF3waitlabel1.Caption:=langbuffer;
      varF4waitlabel1.Caption:=langbuffer;
      varF5waitlabel1.Caption:=langbuffer;
      varF6waitlabel1.Caption:=langbuffer;
      varF7waitlabel1.Caption:=langbuffer;
      varF8waitlabel1.Caption:=langbuffer;
      varF9waitlabel1.Caption:=langbuffer;
      varF10waitlabel1.Caption:=langbuffer;
      varF11waitlabel1.Caption:=langbuffer;
      varF12waitlabel1.Caption:=langbuffer;
      varF1waitlabel2.Caption:=langbuffer;
      varF2waitlabel2.Caption:=langbuffer;
      varF3waitlabel2.Caption:=langbuffer;
      varF4waitlabel2.Caption:=langbuffer;
      varF5waitlabel2.Caption:=langbuffer;
      varF6waitlabel2.Caption:=langbuffer;
      varF7waitlabel2.Caption:=langbuffer;
      varF8waitlabel2.Caption:=langbuffer;
      varF9waitlabel2.Caption:=langbuffer;
      varF10waitlabel2.Caption:=langbuffer;
      varF11waitlabel2.Caption:=langbuffer;
      varF12waitlabel2.Caption:=langbuffer;
    end;
    ReadLn(langTxtFile, langbuffer) ;

    begin
      F1Shoottimelabel.Caption:=langbuffer;
      F2Shoottimelabel.Caption:=langbuffer;
      F3Shoottimelabel.Caption:=langbuffer;
      F4Shoottimelabel.Caption:=langbuffer;
      F5Shoottimelabel.Caption:=langbuffer;
      F6Shoottimelabel.Caption:=langbuffer;
      F7Shoottimelabel.Caption:=langbuffer;
      F8Shoottimelabel.Caption:=langbuffer;
      F9Shoottimelabel.Caption:=langbuffer;
      F10Shoottimelabel.Caption:=langbuffer;
      F11Shoottimelabel.Caption:=langbuffer;
      F12Shoottimelabel.Caption:=langbuffer;

      varF1Shoottimelabel.Caption:=langbuffer;
      varF2Shoottimelabel.Caption:=langbuffer;
      varF3Shoottimelabel.Caption:=langbuffer;
      varF4Shoottimelabel.Caption:=langbuffer;
      varF5Shoottimelabel.Caption:=langbuffer;
      varF6Shoottimelabel.Caption:=langbuffer;
      varF7Shoottimelabel.Caption:=langbuffer;
      varF8Shoottimelabel.Caption:=langbuffer;
      varF9Shoottimelabel.Caption:=langbuffer;
      varF10Shoottimelabel.Caption:=langbuffer;
      varF11Shoottimelabel.Caption:=langbuffer;
      varF12Shoottimelabel.Caption:=langbuffer;
    end;
    ReadLn(langTxtFile, langbuffer) ;

    begin
      F1SOtimelabel.Caption:=langbuffer;
      F2SOtimelabel.Caption:=langbuffer;
      F3SOtimelabel.Caption:=langbuffer;
      F4SOtimelabel.Caption:=langbuffer;
      F5SOtimelabel.Caption:=langbuffer;
      F6SOtimelabel.Caption:=langbuffer;
      F7SOtimelabel.Caption:=langbuffer;
      F8SOtimelabel.Caption:=langbuffer;
      F9SOtimelabel.Caption:=langbuffer;
      F10SOtimelabel.Caption:=langbuffer;
      F11SOtimelabel.Caption:=langbuffer;
      F12SOtimelabel.Caption:=langbuffer;

      varF1SOtimelabel.Caption:=langbuffer;
      varF2SOtimelabel.Caption:=langbuffer;
      varF3SOtimelabel.Caption:=langbuffer;
      varF4SOtimelabel.Caption:=langbuffer;
      varF5SOtimelabel.Caption:=langbuffer;
      varF6SOtimelabel.Caption:=langbuffer;
      varF7SOtimelabel.Caption:=langbuffer;
      varF8SOtimelabel.Caption:=langbuffer;
      varF9SOtimelabel.Caption:=langbuffer;
      varF10SOtimelabel.Caption:=langbuffer;
      varF11SOtimelabel.Caption:=langbuffer;
      varF12SOtimelabel.Caption:=langbuffer;
    end;

    ReadLn(langTxtFile, langbuffer) ;
    oneone.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    onetwo.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    onethree.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    onefour.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    twotwo.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    F1description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F2description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F3description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F4description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F5description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F6description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F7description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F8description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F9description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F10description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F11description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    F12description.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;


    ReadLn(langTxtFile, langbuffer) ;
    practiselabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    FITA.Caption:=langbuffer;
    fitaicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    FITAFINlabel.Caption:=langbuffer;
    fitafinicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    onepijl.Caption:=langbuffer;
    icon25m1p.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timing1p.Caption:=langbuffer;
    timingfitabox.Caption:=langbuffer;
    fitatimingbox.Caption:=langbuffer;
    finalstiming.Caption:=langbuffer;
    groupfinarrow.Caption:=langbuffer;
    groupfinend.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    so.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timeseqpanel.Caption:=langbuffer;
    clockicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dbltime.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dblturn.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;

    ReadLn(langTxtFile, langbuffer) ;
    showtarget.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    targetID.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timeperturn.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timeperend.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Turns_per_end.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    BCDtoROG2label.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    finalchoose.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF1button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF2button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF3button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF4button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF5button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF6button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF7button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF8button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF9button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF10button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF11button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    savevarF12button.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    abcd25m1p.caption:=langbuffer;
    ReadLn(langTxtFile, precnthintfirst) ;
    ReadLn(langTxtFile, Mintext) ;
    beforestarttxt2.Caption:=Mintext;
    precountminutelabel.Caption:=Mintext;
    ReadLn(langTxtFile, Minabr) ;

    ReadLn(langTxtFile, langbuffer) ;
    tabscr.caption:=langbuffer;
    layouticon.Hint:=langbuffer;
    pretimelayoutbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    tabsound.caption:=langbuffer;
    soundicon.Hint:=langbuffer;
    EmergencysoundGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    tabscen.caption:=langbuffer;
    scenarioicon.Hint:=langbuffer;
    selectscenariolabel.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    tabprecnt.caption:=langbuffer;
    preptime.Hint:=langbuffer;
    precounticon.Hint:=langbuffer;
    countdowntostart.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    tablang.caption:=langbuffer;
    languageicon.Hint:=langbuffer;
    selectlanguagelabel.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    TLgroup.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    usetraffic.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    showhints.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    selectsoundlabel.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    testsound.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    precountcaptionlabel.caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    starttocd.caption:=langbuffer;
    ReadLn(langTxtFile, Menudisap) ;
    menudisap1.caption:=Menudisap;
    menudisap2.caption:=Menudisap;
    ReadLn(langTxtFile, Sectext) ;
    disapsec1.Caption:= Sectext;
    disapsec2.Caption:= Sectext;
    ReadLn(langTxtFile, langbuffer) ;
    enddown.hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    endup.hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    stopicon.Hint:= langbuffer;
    ReadLn(langTxtFile, Paustxt) ;
    playpauzeicon.Hint:= Paustxt;
    ReadLn(langTxtFile, resumetxt) ;
    ReadLn(langTxtFile, NXTstart) ;
    nexticon.Hint:= NXTstart;
    ReadLn(langTxtFile, NXTnext) ;
    ReadLn(langTxtFile, NXTstop) ;
    ReadLn(langTxtFile, langbuffer) ;
    usb.Hint:= langbuffer;
    ReadLn(langTxtFile, prevarch) ;
    tdown.Hint:= prevarch;
    shooteronearrow.Hint:= prevarch;
    ReadLn(langTxtFile, nextarch) ;
    tup.Hint:= nextarch;
    shooteronearrownr.Hint:= nextarch;
    ReadLn(langTxtFile, langbuffer) ;
    serienr.Hint:= langbuffer;
    Practise.Hint:= langbuffer;
    ReadLn(langTxtFile, ActAtxt) ;
    ReadLn(langTxtFile, ActBtxt) ;
    ReadLn(langTxtFile, ActCtxt) ;
    ReadLn(langTxtFile, ActDtxt) ;
    ReadLn(langTxtFile, langbuffer) ;
    resizeicon.Hint:= langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    closeicon.Hint:= langbuffer;
    ReadLn(langTxtFile, Mainhint1) ;
    nexthelp.Caption:= Mainhint1;
    ReadLn(langTxtFile, Mainhint2) ;
    chooselabel.Caption:=Mainhint2;
    ReadLn(langTxtFile, langbuffer) ;
    TLleft.caption:= langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    TLright.caption:= langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    beforestarttxt1.caption:= langbuffer;
    ReadLn(langTxtFile, selectright) ;
    greyright.Hint:=selectright;
    ReadLn(langTxtFile, selectleft) ;
    greyleft.Hint:=selectleft;
    ReadLn(langTxtFile, Mainhint3) ;
    ReadLn(langTxtFile, Mainhint4) ;

    ReadLn(langTxtFile, Connectingstring) ;
    ReadLn(langTxtFile, Connectedstring) ;
    ReadLn(langTxtFile, Cardnotfoundstring) ;
    ReadLn(langTxtFile, Cardstring) ;
    ReadLn(langTxtFile, langbuffer) ;
    precountalways.caption:= langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    ABCDperEND.caption:= langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    abouttab.caption:= langbuffer;
    abouticon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    hardwaretab.caption:= langbuffer;
    Hardwareicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    manualred.Hint:=langbuffer;
    TLredlefton.Hint:=langbuffer;
    TLredleftoff.Hint:=langbuffer;
    TLredrighton.Hint:=langbuffer;
    TLredrightoff.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    manualorange.Hint:=langbuffer;
    TLorangelefton.Hint:=langbuffer;
    TLorangeleftoff.Hint:=langbuffer;
    TLorangerighton.Hint:=langbuffer;
    TLorangerightoff.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    manualgreen.Hint:=langbuffer;
    TLgrnlefton.Hint:=langbuffer;
    TLgrnleftoff.Hint:=langbuffer;
    TLgrnrighton.Hint:=langbuffer;
    TLgrnrightoff.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    buzzicon1.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    buzzicon2.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    buzzicon3.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    danger.Hint:=langbuffer;
    tabEmergency.Caption:=langbuffer;
    emergencyicon.Hint:=langbuffer;
    Audioboxstate6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    soundsignallabel1.Caption:=langbuffer;
    soundsignallabel2.Caption:=langbuffer;
    soundsignallabel3.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    redbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    orangebox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    greenbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    exthwbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    button1.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    button2.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    button3.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    button4.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    button5.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Manual.Caption:=langbuffer;
    manualicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    follow.Caption:=langbuffer;
    followicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    emergencytext.Caption:=langbuffer;
    EmergencydefaultRadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    followexplanation.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    leftrightbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    leftscreen.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    rightscreen.Caption:=langbuffer;

    button1index:=HWbutton1.ItemIndex;
    button2index:=HWbutton2.ItemIndex;
    button3index:=HWbutton3.ItemIndex;
    button4index:=HWbutton4.ItemIndex;
    button5index:=HWbutton5.ItemIndex;

    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Items.Delete(0);HWbutton2.Items.Delete(0);HWbutton3.Items.Delete(0);HWbutton4.Items.Delete(0);HWbutton5.Items.Delete(0);
    HWbutton1.Text:='';
    HWbutton2.Text:='';
    HWbutton3.Text:='';
    HWbutton4.Text:='';
    HWbutton5.Text:='';

    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    HWbutton1.Items.AddStrings(langbuffer);
    HWbutton2.Items.AddStrings(langbuffer);
    HWbutton3.Items.AddStrings(langbuffer);
    HWbutton4.Items.AddStrings(langbuffer);
    HWbutton5.Items.AddStrings(langbuffer);

    HWbutton1.ItemIndex:=button1index;
    HWbutton2.ItemIndex:=button2index;
    HWbutton3.ItemIndex:=button3index;
    HWbutton4.ItemIndex:=button4index;
    HWbutton5.ItemIndex:=button5index;

    ReadLn(langTxtFile, langbuffer) ;
    viewleft.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    viewright.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    finarrow.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    inputbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    serialinput.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    LANinput.Caption:=langbuffer;
    ReadLn(langTxtFile, ActEtxt) ;
    ReadLn(langTxtFile, ActFtxt) ;
    ReadLn(langTxtFile, langbuffer) ;
    onefive.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    onesix.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    twothree.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    threetwo.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Start1_1p.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    PCnameLabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    LANselect.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    serverportlabel1.Caption:=langbuffer;
    audioportlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    USBserialbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    arduinoselect1.Caption:=langbuffer;
    arduinoselect2.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    topbot.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    TOPshooterlet.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    TOPshootertxt.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    BOTshooterlet.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    BOTshootertxt.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    practiselabel25m1p1.Caption:=langbuffer;
    rotate25m1p_p.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    varF1Button.Caption:=langbuffer+' F1';
    varF2Button.Caption:=langbuffer+' F2';
    varF3Button.Caption:=langbuffer+' F3';
    varF4Button.Caption:=langbuffer+' F4';
    varF5Button.Caption:=langbuffer+' F5';
    varF6Button.Caption:=langbuffer+' F6';
    varF7Button.Caption:=langbuffer+' F7';
    varF8Button.Caption:=langbuffer+' F8';
    varF9Button.Caption:=langbuffer+' F9';
    varF10Button.Caption:=langbuffer+' F10';
    varF11Button.Caption:=langbuffer+' F11';
    varF12Button.Caption:=langbuffer+' F12';
    F1Button.Caption:=langbuffer+' shift-F1';
    F2Button.Caption:=langbuffer+' shift-F2';
    F3Button.Caption:=langbuffer+' shift-F3';
    F4Button.Caption:=langbuffer+' shift-F4';
    F5Button.Caption:=langbuffer+' shift-F5';
    F6Button.Caption:=langbuffer+' shift-F6';
    F7Button.Caption:=langbuffer+' shift-F7';
    F8Button.Caption:=langbuffer+' shift-F8';
    F9Button.Caption:=langbuffer+' shift-F9';
    F10Button.Caption:=langbuffer+' shift-F10';
    F11Button.Caption:=langbuffer+' shift-F11';
    F12Button.Caption:=langbuffer+' shift-F12';
    ReadLn(langTxtFile, langbuffer) ;
    lanselect.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    multicastlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    TabNetwork.Caption:=langbuffer;
    networkicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    laserpointerbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    pguplabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    pgdnlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    playlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    blnklabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Lanremoteselect.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    pwlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    HWP32.Caption:=langbuffer+' 32';
    HWP33.Caption:=langbuffer+' 33';
    HWP35.Caption:=langbuffer+' 35';
    HWP36.Caption:=langbuffer+' 36';
    HWP37.Caption:=langbuffer+' 37';
    HWP38.Caption:=langbuffer+' 38';
    HWP40.Caption:=langbuffer+' 40';

    LP1index:=pgupcombox.ItemIndex;
    LP2index:=pgdncombox.ItemIndex;
    LP3index:=playcombox.ItemIndex;
    LP4index:=blnkcombox.ItemIndex;
    leftkeyindex:=leftarrowkeycombo.ItemIndex;
    rightkeyindex:=rightarrowkeycombo.ItemIndex;
    upkeyindex:=uparrowkeycombo.ItemIndex;
    downkeyindex:=downarrowkeycombo.ItemIndex;
    GP32index:=comboxpn32.ItemIndex;
    GP33index:=comboxpn33.ItemIndex;
    GP35index:=comboxpn35.ItemIndex;
    GP36index:=comboxpn36.ItemIndex;
    GP37index:=comboxpn37.ItemIndex;
    GP38index:=comboxpn38.ItemIndex;
    GP40index:=comboxpn40.ItemIndex;
    KP1index:=comboxK8055but1.ItemIndex;
    KP2index:=comboxK8055but2.ItemIndex;
    KP3index:=comboxK8055but3.ItemIndex;
    KP4index:=comboxK8055but4.ItemIndex;
    KP5index:=comboxK8055but5.ItemIndex;

    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);

    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);

    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);
    pgupcombox.Items.Delete(0); pgdncombox.Items.Delete(0); playcombox.Items.Delete(0); blnkcombox.Items.Delete(0); comboxpn32.Items.Delete(0); comboxpn33.Items.Delete(0); comboxpn35.Items.Delete(0); comboxpn36.Items.Delete(0); comboxpn37.Items.Delete(0); comboxpn38.Items.Delete(0); comboxpn40.Items.Delete(0); comboxK8055but1.Items.Delete(0); comboxK8055but2.Items.Delete(0);comboxK8055but3.Items.Delete(0);comboxK8055but4.Items.Delete(0);comboxK8055but5.Items.Delete(0);leftarrowkeycombo.Items.Delete(0);rightarrowkeycombo.Items.Delete(0);uparrowkeycombo.Items.Delete(0);downarrowkeycombo.Items.Delete(0);

    pgupcombox.Text:='';
    pgdncombox.Text:='';
    playcombox.Text:='';
    blnkcombox.Text:='';
    leftarrowkeycombo.Text:='';
    rightarrowkeycombo.Text:='';
    uparrowkeycombo.Text:='';
    downarrowkeycombo.Text:='';
    comboxpn32.Text:='';
    comboxpn33.Text:='';
    comboxpn35.Text:='';
    comboxpn36.Text:='';
    comboxpn37.Text:='';
    comboxpn38.Text:='';
    comboxpn40.Text:='';
    comboxK8055but1.Text:='';
    comboxK8055but2.Text:='';
    comboxK8055but3.Text:='';
    comboxK8055but4.Text:='';
    comboxK8055but5.Text:='';

    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    shutdownicon.Hint:=(langbuffer);

    ReadLn(langTxtFile, langbuffer) ;

    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;

    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);
    ReadLn(langTxtFile, langbuffer) ;

    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);

    for dropdown:=1 to 12 do
    begin
      pgupcombox.Items.AddStrings('F'+inttostr(dropdown));
      pgdncombox.Items.AddStrings('F'+inttostr(dropdown));
      playcombox.Items.AddStrings('F'+inttostr(dropdown));
      blnkcombox.Items.AddStrings('F'+inttostr(dropdown));
      leftarrowkeycombo.Items.AddStrings('F'+inttostr(dropdown));
      rightarrowkeycombo.Items.AddStrings('F'+inttostr(dropdown));
      uparrowkeycombo.Items.AddStrings('F'+inttostr(dropdown));
      downarrowkeycombo.Items.AddStrings('F'+inttostr(dropdown));

      comboxpn32.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn33.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn35.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn36.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn37.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn38.Items.AddStrings('F'+inttostr(dropdown));
      comboxpn40.Items.AddStrings('F'+inttostr(dropdown));
      comboxK8055but1.Items.AddStrings('F'+inttostr(dropdown));
      comboxK8055but2.Items.AddStrings('F'+inttostr(dropdown));
      comboxK8055but3.Items.AddStrings('F'+inttostr(dropdown));
      comboxK8055but4.Items.AddStrings('F'+inttostr(dropdown));
      comboxK8055but5.Items.AddStrings('F'+inttostr(dropdown));
    end;
    ReadLn(langTxtFile, langbuffer) ;
    for dropdown:=1 to 6 do
    begin
      pgupcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      pgdncombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      playcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      blnkcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      leftarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      rightarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      uparrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      downarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);

      comboxpn32.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn33.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn35.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn36.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn37.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn38.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn40.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but1.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but2.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but3.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but4.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but5.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
    end;
    ReadLn(langTxtFile, langbuffer) ;
    for dropdown:=1 to 6 do
    begin
      pgupcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      pgdncombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      playcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      blnkcombox.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      leftarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      rightarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      uparrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      downarrowkeycombo.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);

      comboxpn32.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn33.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn35.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn36.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn37.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn38.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxpn40.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but1.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but2.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but3.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but4.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
      comboxK8055but5.Items.AddStrings(inttostr(dropdown)+' '+ langbuffer);
    end;



    ReadLn(langTxtFile, langbuffer) ;
    pgupcombox.Items.AddStrings(langbuffer);
    pgdncombox.Items.AddStrings(langbuffer);
    playcombox.Items.AddStrings(langbuffer);
    blnkcombox.Items.AddStrings(langbuffer);
    leftarrowkeycombo.Items.AddStrings(langbuffer);
    rightarrowkeycombo.Items.AddStrings(langbuffer);
    uparrowkeycombo.Items.AddStrings(langbuffer);
    downarrowkeycombo.Items.AddStrings(langbuffer);

    comboxpn32.Items.AddStrings(langbuffer);
    comboxpn33.Items.AddStrings(langbuffer);
    comboxpn35.Items.AddStrings(langbuffer);
    comboxpn36.Items.AddStrings(langbuffer);
    comboxpn37.Items.AddStrings(langbuffer);
    comboxpn38.Items.AddStrings(langbuffer);
    comboxpn40.Items.AddStrings(langbuffer);
    comboxK8055but1.Items.AddStrings(langbuffer);
    comboxK8055but2.Items.AddStrings(langbuffer);
    comboxK8055but3.Items.AddStrings(langbuffer);
    comboxK8055but4.Items.AddStrings(langbuffer);
    comboxK8055but5.Items.AddStrings(langbuffer);

    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;

  //add shootoff language
    pgupcombox.ItemIndex:=LP1index ;
    pgdncombox.ItemIndex:=LP2index;
    playcombox.ItemIndex:=LP3index;
    blnkcombox.ItemIndex:=LP4index;
    leftarrowkeycombo.ItemIndex:=leftkeyindex;
    rightarrowkeycombo.ItemIndex:=rightkeyindex;
    uparrowkeycombo.ItemIndex:=upkeyindex;
    downarrowkeycombo.ItemIndex:=downkeyindex;

    comboxpn32.ItemIndex:=GP32index;
    comboxpn33.ItemIndex:=GP33index;
    comboxpn35.ItemIndex:=GP35index;
    comboxpn36.ItemIndex:=GP36index;
    comboxpn37.ItemIndex:=GP37index;
    comboxpn38.ItemIndex:=GP38index;
    comboxpn40.ItemIndex:=GP40index;
    comboxK8055but1.ItemIndex:=KP1index;
    comboxK8055but2.ItemIndex:=KP2index;
    comboxK8055but3.ItemIndex:=KP3index;
    comboxK8055but4.ItemIndex:=KP4index;
    comboxK8055but5.ItemIndex:=KP5index;
    ReadLn(langTxtFile, langbuffer) ;
    screencolor.Caption:=langbuffer;
    coloricon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    serialinputbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    RPIinputbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    K8055but1.Caption:=langbuffer+' 1';
    K8055but2.Caption:=langbuffer+' 2';
    K8055but3.Caption:=langbuffer+' 3';
    K8055but4.Caption:=langbuffer+' 4';
    K8055but5.Caption:=langbuffer+' 5';
    ReadLn(langTxtFile, langbuffer) ;
    Show.Caption:=langbuffer;
    ReadLn(langTxtFile, primarytext) ;
    ReadLn(langTxtFile, secondarytext) ;
    ReadLn(langTxtFile, langbuffer) ;
    rotate25m1p.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    PABCDperEND.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    MagText.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Fbutonscreenbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Touchscreentab.Caption:=langbuffer;
    touchicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    EmergencytxtGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    EmergencyalternativeRadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    EmergencybhaviorGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Pause_emergency_RadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Stop_current_RadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Stop_next_RadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    minsoundlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    KeepbuzzingCheckBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timeup.Hint:=langbuffer;
    timedown.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    colorscheme9.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    PrepColGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    retrColGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    RedColGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    GrnColGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    OrColGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Lnexttxt.Caption:=langbuffer;
    Rnexttxt.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Larchertxt.Caption:=langbuffer;
    Rarchertxt.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    orangebeepfitacheckbox.Caption:=langbuffer;
    orangebeep25m1pcheckbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    blinkredgroupbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Blinkphase1CheckBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Blinkphase2CheckBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    indfindefbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    reamfindefbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    mxteamfindefbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Turns_per_end_SO.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    groupfinendSO.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    ShutdownremoteButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    timecheckbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    largeimagecheckbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;

    BGGroupBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    fullscreencheckbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Addimagebutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Removeimagebutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    fliplabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    flipsecondslabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Bannerbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    specificbannerRadioButton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Choosebannerbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    RemshutdownCheckBox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;

    showendnrlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Beepswitcharcher.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    fitasequence.Caption:=langbuffer;
    fitafinseqbox.Caption:=langbuffer;
    sequence25m1pbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Controlaudiocheckbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    AudioIPlabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    reconnectbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Audioboxstate1.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Audioboxstate2.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Audioboxstate3.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Audioboxstate4.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Audioboxstate5.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    AudioVolumestate1.Caption:=langbuffer+' [%]';
    AudioVolumestate2.Caption:=langbuffer+' [%]';
    AudioVolumestate3.Caption:=langbuffer+' [%]';
    AudioVolumestate4.Caption:=langbuffer+' [%]';
    AudioVolumestate5.Caption:=langbuffer+' [%]';
    AudioVolumestate6.Caption:=langbuffer+' [%]';
    ReadLn(langTxtFile, langbuffer) ;
    AudioActionstate1.Caption:=langbuffer;
    AudioActionstate2.Caption:=langbuffer;
    AudioActionstate3.Caption:=langbuffer;
    AudioActionstate4.Caption:=langbuffer;
    AudioActionstate5.Caption:=langbuffer;
    AudioActionstate6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Playstate1.Caption:=langbuffer;
    Playstate2.Caption:=langbuffer;
    Playstate3.Caption:=langbuffer;
    Playstate4.Caption:=langbuffer;
    Playstate5.Caption:=langbuffer;
    Playstate6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Pausestate1.Caption:=langbuffer;
    Pausestate2.Caption:=langbuffer;
    Pausestate3.Caption:=langbuffer;
    Pausestate4.Caption:=langbuffer;
    Pausestate5.Caption:=langbuffer;
    Pausestate6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    Stopstate1.Caption:=langbuffer;
    Stopstate2.Caption:=langbuffer;
    Stopstate3.Caption:=langbuffer;
    Stopstate4.Caption:=langbuffer;
    Stopstate5.Caption:=langbuffer;
    Stopstate6.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    startupscenariobox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    leftsideclientbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    rightsideclientbutton.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    atstartuplabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;

    ReadLn(langTxtFile, langbuffer) ;
    ReadLn(langTxtFile, langbuffer) ;
    Actualtimecheckbox.Caption:=langbuffer;;
    ReadLn(langTxtFile, langbuffer) ;
    nextonlybutton.Caption:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    dayname[2]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[3]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[4]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[5]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[6]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[7]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    dayname[1]:=langbuffer;

    ReadLn(langTxtFile, langbuffer) ;
    monthname[1]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[2]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[3]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[4]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[5]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[6]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[7]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[8]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[9]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[10]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[11]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    monthname[12]:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    repeatsequencelabel.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    controltab.Caption:=langbuffer;
    controlicon.Hint:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    keyboardinputbox.Caption:=langbuffer;
    ReadLn(langTxtFile, langbuffer) ;
    keyboardpref1.Caption:=langbuffer+' 1';
    keyboardpref2.Caption:=langbuffer+' 2';
    keyboardpref3.Caption:=langbuffer+' 3';
    ReadLn(langTxtFile, langbuffer) ;
    stopinbetweenturnsfitacheckbox.Caption:=langbuffer;
    CloseFile(langTxtFile) ;
  end;
  if initializationstate=false then connect;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  viewturnchange;

end;

procedure TCountdownform.initialize;
//initializes the system at startup (setting lanuage, archery system, etc)
var dummy:string;
Mousepos: TPoint;
begin
  {$IFDEF Unix}{$IFNDEF Darwin}
 //SDL Stuff

  if ((SDL_InitSubSystem(SDL_INIT_AUDIO) < 0)) then
  begin

    ShowMessage('Could not initialize SDL Audio' );

    SDL_Quit;
    exit;
  end;
  audio_rate := 44100;
  audio_format := AUDIO_S16SYS;
  audio_channels := 2;
  audio_buffers := 4096;
  if(Mix_OpenAudio(audio_rate, audio_format, audio_channels, audio_buffers) <> 0) then
  begin
	ShowMessage('Unable to initialize audio');
  end;
  // END SDL Stuff
  {$ENDIF}{$ENDIF}
  linuxHW:='';
  {$IFDEF Unix}
  {$IFNDEF Darwin}linuxHW:='RPI';{$ENDIF}  // Mac: no Raspberry Pi hardware

  If linuxHW='RPI' then RPIinputbox.Enabled:=true;
  If linuxHW='RPI' then LOWRES:=true else LOWRES:=false;
  {$ENDIF}
  SystemParametersInfo(SPI_SETSCREENSAVEACTIVE, 0, nil, 0); //disable the screensaver
  initializationstate:=true;
  //LOWRES:=false;

  //folowing lines are meant to set the language of an initial version which doesn't have settings yet.
  //in combination with a different banner.bmp file, it can be used for a version of a specific club.
  //one and only one language should contain 'yes'. The others 'no'
  dutchlang:='no';     //yes means initial version has dutch language
  frenchlang:='no';    //yes means initial version has french language
  englang:='yes';      //yes means initial version has English language

  //settings depending to OS
  {$IFDEF Windows}
  RemshutdownCheckBox.Enabled:=false;;
  mag:=1.000;
  screenwidth:=Countdownform.Width;
  menuwidth:=420;
  LOWRES:=false;
  //some font sizez in the menu's need to be bigger in windows as in Linux
  debugcounter:=1;
  oneone.Font.Size:=8;
  onetwo.font.size:=8;
  onethree.Font.Size:=8;
  onefour.Font.Size:=8;
  twotwo.font.Size:=8;

  topbot.Font.Size:=8;
  onefive.Font.Size:=8;
  onesix.Font.Size:=8;
  twothree.Font.Size:=8;
  threetwo.Font.Size:=8;

  doubleturnslabel.font.size:=8;
  ABCDperEND.font.size:=8;
  dbltime.Font.size:=8;
  dblturn.font.size:=8;
  doubleseq.font.Size:=8;
  doubletime.font.size:=8;
  practiselabel.font.size:=8;
  targetID.font.size:=8;
  fintarget.font.size:=8;
  finarrow.font.size:=8;
  timeperturn.font.size:=8;
  timeperend.font.size:=8;
  Turns_per_end.font.size:=8;
  Archerlabel25m1p.font.size:=8;
  secgrnlabel1.font.Size:=8;
  secgrnlabel2.font.Size:=8;
  secgrnlabel3.font.Size:=8;
  secgrnlabel4.font.Size:=8;
  secgrnlabel5.font.Size:=8;
  secorlabel1.font.Size:=8;
  secorlabel2.font.Size:=8;
  secorlabel3.font.Size:=8;
  secorlabel4.font.Size:=8;
  secorlabel5.font.Size:=8;
  secredlabel1.font.Size:=8;
  secredlabel2.font.Size:=8;
  secredlabel3.font.Size:=8;
  secredlabel4.font.Size:=8;
  secredlabel5.font.Size:=8;
  sectotlabel1.font.Size:=8;
  sectotlabel2.font.Size:=8;
  sectotlabel3.font.Size:=8;
  sectotlabel4.font.Size:=8;
  sectotlabel5.font.Size:=8;

  FITAFINlabel.Font.Size:=7;
  //helptext has different size in linux or windows
   nexthelp.Color:=clCream;
   nexthelp.Font.Color:=clBlack;
   nexthelp.Font.Size:=8;
   nexthelp.Height:=-11;
   nexthelp.Constraints.MinHeight:=14  ;
   chooselabel.Color:=clCream;
   chooselabel.Font.Color:=clBlack;
   chooselabel.Font.Size:=8;
   chooselabel.Height:=-11;
   chooselabel.Constraints.MinHeight:=14  ;

   rcvmcasttimer.Interval:=50;
   networktimestamp.Interval:=70;
   FirstTimer.Interval:=100;
   Secondtimer.Interval:=100;

   languageicon.Width:=36;
   layouticon.Width:=36;
   coloricon.Width:=36;
   soundicon.Width:=36;
   controlicon.Width:=36;
   networkicon.Width:=36;
   precounticon.Width:=36;
   emergencyicon.Width:=36;
   scenarioicon.Width:=36;
   Hardwareicon.Width:=36;
   touchicon.Width:=36;
   abouticon.Width:=36;

   languageicon.Height:=50;
   layouticon.Height:=45;
   coloricon.Height:=48;
   soundicon.Height:=51;
   controlicon.Height:=51;
   networkicon.Height:=45;
   precounticon.Height:=46;
   emergencyicon.Height:=45;
   scenarioicon.Height:=50;
   Hardwareicon.Height:=52;
   touchicon.Height:=52;
   abouticon.Height:=47;

   languageicon.Top:=8;

  {$ENDIF}
  Filespath:='';
  {$IFDEF Unix}

  Filespath:=(ParamStr(0));
  Delete(Filespath,LastDelimiter('/',Filespath),25);
  Filespath:=Filespath+'/';
  {$IFDEF Darwin}
  // Mac: an app opened from Finder starts in '/'; the slideshow list and its pictures are relative names
  SetCurrentDir(Filespath);
  {$ENDIF}
  mag:=0.83;
  screenwidth:=Countdownform.Width;
  menuwidth:=420;

  K8055select.Enabled:=false; //K8055 is not supported yet by linux


  //some font sizez in the menu's need to be smaller in Linux as in Windows
  oneone.Font.Size:=8;
  onetwo.font.size:=8;
  onethree.Font.Size:=8;
  onefour.Font.Size:=8;
  twotwo.font.Size:=8;

  topbot.Font.Size:=8;
  onefive.Font.Size:=8;
  onesix.Font.Size:=8;
  twothree.Font.Size:=8;
  threetwo.Font.Size:=8;


  doubleturnslabel.font.size:=7;
  ABCDperEND.font.size:=8;
  dbltime.Font.size:=8;
  dblturn.font.size:=8;
  doubleseq.font.Size:=8;
  doubletime.font.size:=8;
  practiselabel.font.size:=8;
  targetID.font.size:=8;
  fintarget.font.size:=8;
  finarrow.font.size:=8;
  timeperturn.font.size:=7;
  timeperend.font.size:=7;
  Turns_per_end.font.size:=8;
  Archerlabel25m1p.font.size:=8;
  secgrnlabel1.font.Size:=8;
  secgrnlabel2.font.Size:=8;
  secgrnlabel3.font.Size:=8;
  secgrnlabel4.font.Size:=8;
  secgrnlabel5.font.Size:=8;
  secorlabel1.font.Size:=8;
  secorlabel2.font.Size:=8;
  secorlabel3.font.Size:=8;
  secorlabel4.font.Size:=8;
  secorlabel5.font.Size:=8;
  secredlabel1.font.Size:=8;
  secredlabel2.font.Size:=8;
  secredlabel3.font.Size:=8;
  secredlabel4.font.Size:=8;
  secredlabel5.font.Size:=8;
  sectotlabel1.font.Size:=8;
  sectotlabel2.font.Size:=8;
  sectotlabel3.font.Size:=8;
  sectotlabel4.font.Size:=8;
  sectotlabel5.font.Size:=8;
  FITAFINlabel.Font.Size:=6;
  //helptext has different size in linux or windows

  nexthelp.Color:=clinfoBK;
  nexthelp.Font.Color:=clinfotext;
  nexthelp.Font.Size:=11;
  nexthelp.Height:=23;
  nexthelp.Constraints.MinHeight:=23  ;
  chooselabel.Color:=clinfoBK;
  chooselabel.Font.Color:=clinfotext;
  chooselabel.Font.Size:=11;
  chooselabel.Height:=23;
  chooselabel.Constraints.MinHeight:=23  ;
  {$ENDIF}

  closeimage1.Left:=menuwidth-14;
  closeimage2.Left:=menuwidth-14;

  leftreceivedvalue:='1010000000000000';
  rightreceivedvalue:='1010000000000000';
  trafficreceiveddata:='0000000000000000';
  foltime1:='0000000000000000';
  foltime2:='0000000000000000';
  foltrafic:='0000000000000000';
  folsecdetails:='0000000000000000';
  folsecdetailssec:='0000000000000000';
  folendnr:='0000000000000000';
  folstate:='0000000000000000';
  manualfollowmenuremove:=false;
  serref1:=false;
  serref2:=false;
  serref3:=false;
  serref4:=false;
  serref5:=false;
  serref6:=false;
  serref7:=false;

  NETWORK1:=LUDP1;
  TCPnetwork:=TCPaccess1;
  TCPmusicnetwork:=TCPmusiccntrl;
  isserver:=false;
  //settings of the banner
  bannerAR:=(2000/260);
  bannerscaling:=108;    //height of picture
  choosebanner;
  SettingsTabs.ActivePage:=tablang;

  //Next settings are meant for usage of external hardware to switch serial
  //for timing reasons only the delta needs to be sent to the hardware
  //For example, when red light is on, there is a check needed if the light was already on
  //only when old vallue was off, a signal needs to be sent to swith red on.
  //Below, the initial old values are set to off
  buzzeronold:=0;

  //initialize  values
  labelnr:=10;     // to start commecial initially with www.....
  nrofturns:=1;
  times:=1;
  turnsss:=1;
  ptop:=1;
  referencetime:=getcurrenttime;
  Practiseturn:=1; //practice enabled
  archerysystem:='fita';
  Shootoff:=0;
  buzzeron:=0;
  nrofbeeps:=0;
  nrofmanualbeeps:=0;
  countdowntimer:=0;
  Shooters:=4;              //shooters per serie
  serienumber:=1;            //current serie
  turnnumber:=1;             //current turn
  shooternumber:=1;         //shooter who is
  turnsperserie:=4;          //number of turns per serie
  Archersperturn:=1;          //number of archers per turn
  state:=1;
  realstate:=1;
  redlighton:=true;
  Checkredblink;
  viewstateone;
  alarmstate:=0;             //no tabEmergency yet
  shootercolor:=clLime;
  nonshootercolor:=clGray;
  waitcolor:=clGray;
  redcolor:=clRed;
  orangecolor:=clYellow;
  greencolor:=clLime;

  lamp_red_left_on_off:=0;
  lamp_red_right_on_off:=0;
  lamp_orange_left_on_off:=0;
  lamp_orange_right_on_off:=0;
  lamp_green_left_on_off:=0;
  lamp_green_right_on_off:=0;

  LampA_on_off:=0;
  LampB_on_off:=0;
  LampC_on_off:=0;
  LampD_on_off:=0;
  LampE_on_off:=0;
  LampF_on_off:=0;
  Not_LampA_on_off:=0;
  Not_LampB_on_off:=0;
  Not_LampC_on_off:=0;
  Not_LampD_on_off:=0;
  Not_LampE_on_off:=0;
  Not_LampF_on_off:=0;
  shutdownsystem:=false;
  Shutdwnremote:=false;
  //initialyze variable scenarois
  for mode := 1 to 12 do
  begin
    //Startuplabel.Caption:='Load Scenario'+inttostr(mode);
    Scenario:='F'+inttostr(mode);
    if FileExistsUTF8(Filespath+'scenarios/'+scenario)=true then  //if Fx scenario is stored from an earlier session, get the details from file and store in program
    begin
      AssignFile(scenariotextfile, Filespath+'scenarios/'+scenario) ;
      getsetting;
    end
    else              //Doesnt exist from previous sessions, so use defoults (F1 uses shift F1, F2 uses shift F2, etc.)
    begin
      Setsettings;
    end;
    //Show variable scenarios in scenario menu.
    if scenario='F1' then showF1;
    if scenario='F2' then showF2;
    if scenario='F3' then showF3;
    if scenario='F4' then showF4;
    if scenario='F5' then showF5;
    if scenario='F6' then showF6;
    if scenario='F7' then showF7;
    if scenario='F8' then showF8;
    if scenario='F9' then showF9;
    if scenario='F10' then showF10;
    if scenario='F11' then showF11;
    if scenario='F12' then showF12;
  end;
  timeperturn.Checked:=true;
  nrof1pshooters.value:=4;

    //next section is about the default settings at startup. The file 'settings' is read that contains the initial settings of the user.
  //First a check will be done if the settings file exist. if it doesnt exist, it mean it is the first time the program is used.
  //in that case a file with default settings will be created.
  if FileExistsUTF8(Filespath+'settings')=false then
  begin
     AssignFile(settingsfile, Filespath+'settings') ;
     ReWrite(settingsfile) ;
     if dutchlang='no' then writeln(settingsfile,'English') else writeln(settingsfile,'Nederlands');
     writeln(settingsfile,'Sec') ;   //show seconds, not minutes
     writeln(settingsfile,'nonHide') ; //do not hide icons
     writeln(settingsfile,'Buzzer') ;   //initially, the buzzer via speaker is enabled
     writeln(settingsfile,'shiftF5') ; //initial scenario is shiftF5
     writeln(settingsfile,'Hint');     //initially the hints are shown

     {$IFDEF Windows}
     Writeln(settingsfile,'TL');     //initially, the trafic lights are shown on the screen

     {$ENDIF}
     {$IFDEF Unix}
     Writeln(settingsfile,'TL');     //initially, the trafic lights are  shown on the screen for Unix (RPI)
     //Writeln(settingsfile,'nonTL');     //initially, the trafic lights are not shown on the screen for Unix (RPI)
     {$ENDIF}

     Writeln(settingsfile,'TLright');   //initially, the position of the trafic lights is on the right side of the screen
     writeln(settingsfile,'AC1') ;  //initial sound used is buzzr.wav
     writeln(settingsfile,'4') ;        //Initially the time before the match starts is 4 minutes
     {$IFDEF Windows}
     writeln(settingsfile,'K8055') ;      //K8055 port is default selected. System still functions without hardware
     {$ENDIF}
     {$IFDEF Unix}
     writeln(settingsfile,'na') ;
     {$ENDIF}
     {$IFDEF Windows}
     writeln(settingsfile,'COM1') ;       //serial port arduino
     {$ENDIF}
     {$IFDEF Unix}
     writeln(settingsfile,{$IFDEF Darwin}''{$ELSE}'/dev/ttyACM0'{$ENDIF}) ; // Mac: chosen from its own ports
     {$ENDIF}
     writeln(settingsfile,'nonarduino1'); //Arduino is not selected by default because it is not plug and play
     writeln(settingsfile,'noPRECOUNT') ;   //countdown to start match is not starting after every end
     writeln(settingsfile,'4665') ;       //default port adres
     writeln(settingsfile,'nonLAN');    //LAN is not selected by default because it is not plug and play
     writeln(settingsfile,'224');    //1st number of broadcast adres
     writeln(settingsfile,'25');    //1st number of broadcast adres
     writeln(settingsfile,'26');    //1st number of broadcast adres
     writeln(settingsfile,'27');    //1st number of broadcast adres
     {$IFDEF Windows}
     writeln(settingsfile,'COM2') ;       //serial port arduino
     {$ENDIF}
     {$IFDEF Unix}
     writeln(settingsfile,{$IFDEF Darwin}''{$ELSE}'/dev/ttyUSB0'{$ENDIF}) ; // Mac: chosen from its own ports
     {$ENDIF}
     writeln(settingsfile,'nonarduino2');
     writeln(settingsfile,'2');
     writeln(settingsfile,'0');
     writeln(settingsfile,'3');
     writeln(settingsfile,'8');

     writeln(settingsfile,'4');
     writeln(settingsfile,'5');
     writeln(settingsfile,'10');
     writeln(settingsfile,'9');
     writeln(settingsfile,'0');
     writeln(settingsfile,'2');
     writeln(settingsfile,'3');
     writeln(settingsfile,'col1');
     writeln(settingsfile,'3');
     writeln(settingsfile,'1');
     writeln(settingsfile,'0');
     writeln(settingsfile,'4');
     writeln(settingsfile,'5');
     writeln(settingsfile, 'nonremote');
     writeln(settingsfile,'archery');
     writeln(settingsfile,'2');
     writeln(settingsfile,'Fnotonscreen');
     writeln(settingsfile,'Stop');       //Alternative emergency text
     writeln(settingsfile,'def');        //Default emergency txt  selected.
     writeln(settingsfile,'pause');       //status after emergency is triggered. Pause or current or next
     writeln(settingsfile,'5');            // number of emergency beeps
     writeln(settingsfile,'notkeep');       //keep buzzing after emergency?
     writeln(settingsfile,'nonzero');       //show zero or nonzero (  5 or 005)
     writeln(settingsfile,'clBlue');
     writeln(settingsfile,'clAqua');
     writeln(settingsfile,'clBlack');
     writeln(settingsfile,'clGray');
     writeln(settingsfile,'clMaroon');
     writeln(settingsfile,'clRed');
     writeln(settingsfile,'clGreen');
     writeln(settingsfile,'clLime');
     writeln(settingsfile,'clOlive');
     writeln(settingsfile,'clYellow');
     writeln(settingsfile,'clLime');
     writeln(settingsfile,'clRed');
     writeln(settingsfile,'FALSE');  //timecheckbox not checked
     writeln(settingsfile,'0');    //am/pm
     writeln(settingsfile,'standard');   //standard banner
     writeln(settingsfile,'banner2.png');        //alternative bannername path
     {$IFDEF Windows}
     writeln(settingsfile,'slides');
     {$ENDIF}
     {$IFDEF Unix}
     writeln(settingsfile,'slides');
     //writeln(settingsfile,'nonslides');
     {$ENDIF}

     writeln(settingsfile,'nonfullscreen');
     writeln(settingsfile,'10');         //seconds for slides
     writeln(settingsfile,'TRUE');       //allow remote shutdown
     writeln(settingsfile,'TRUE');       // Do  show end nr in slide mode
     writeln(settingsfile,'prelayout1');  //layout for prepare shooting layout1
     writeln(settingsfile,'VLC');      //type of musicplayer
     writeln(settingsfile,'localhost');     //IP adres / hostname Musicplayer
     writeln(settingsfile,'5005');          //portnumber Musicplayer
     writeln(settingsfile,'100');           //percentage music volume state 1
     writeln(settingsfile,'play');          // action state 1
     writeln(settingsfile,'70');           //percentage music volume state 2
     writeln(settingsfile,'play');          // action state 2
     writeln(settingsfile,'50');           //percentage music volume state 3
     writeln(settingsfile,'play');          // action state 3
     writeln(settingsfile,'50');           //percentage music volume state 4
     writeln(settingsfile,'play');          // action state 4
     writeln(settingsfile,'100');           //percentage music volume state 5
     writeln(settingsfile,'play');          // action state 5
     writeln(settingsfile,'0');           //percentage music volume state 6
     writeln(settingsfile,'pause');          // action state 6

     writeln(settingsfile,'FALSE');      //enable/disable audio control
     writeln(settingsfile,'0');
     {$IFDEF Windows}

     writeln(settingsfile,'TRUE');
     {$ENDIF}
     {$IFDEF Unix}
     writeln(settingsfile,'FALSE');
     {$ENDIF}
     writeln(settingsfile,'4');
     writeln(settingsfile,'5');
     writeln(settingsfile,'6');
     writeln(settingsfile,'7');

     CloseFile(settingsfile) ;

  end;
   {$IFDEF Darwin}
  connect_switch_delay.Enabled:=true;
  MacSerialPortMenu(serialport1); // the Mac's own ports, not Linux names
  MacSerialPortMenu(serialport2);
  {$ELSE}
  {$IFDEF Unix}
  connect_switch_delay.Enabled:=true;
  serialport1.Items.Add('/dev/ttyACM0');
  serialport1.Items.Add('/dev/ttyUSB0');
  serialport1.Items.Add('/dev/ttyAMA0');
  serialport2.Items.Add('/dev/ttyACM0');
  serialport2.Items.Add('/dev/ttyUSB0');
  serialport2.Items.Add('/dev/ttyAMA0');
  {$ENDIF}
  {$ENDIF}
  {$IFDEF Windows}
  serialport1.Items.Add('COM1');
  serialport1.Items.Add('COM2');
  serialport1.Items.Add('COM3');
  serialport1.Items.Add('COM4');
  serialport1.Items.Add('COM5');
  serialport1.Items.Add('COM6');
  serialport1.Items.Add('COM7');
  serialport1.Items.Add('COM8');
  serialport1.Items.Add('COM9');
  serialport1.Items.Add('COM10');
  serialport1.Items.Add('COM11');
  serialport1.Items.Add('COM12');
  serialport2.Items.Add('COM1');
  serialport2.Items.Add('COM2');
  serialport2.Items.Add('COM3');
  serialport2.Items.Add('COM4');
  serialport2.Items.Add('COM5');
  serialport2.Items.Add('COM6');
  serialport2.Items.Add('COM7');
  serialport2.Items.Add('COM8');
  serialport2.Items.Add('COM9');
  serialport2.Items.Add('COM10');
  serialport2.Items.Add('COM11');
  serialport2.Items.Add('COM12');

  {$ENDIF}
  serialport1.ItemIndex:=0;
  serialport2.ItemIndex:=0;

  //load startup settings and initialyze the program with these settings
  begin
    AssignFile(settingsfile, Filespath+'settings') ;
    Reset(settingsfile) ;
    ReadLn(settingsfile, buffer) ;
    lang.Text:=buffer;
    setlanguage;
    lang.Text:=buffer;
    ReadLn(settingsfile, buffer) ;
    if buffer = 'Min' then
    begin
      minsec.ItemIndex:=1;
      minutes.Checked:=true;
    end
    else
    begin
      minsec.ItemIndex:=0;
      seconds.Checked:=true;
    end;
    ReadLn(settingsfile, buffer) ;
    if buffer = 'Hide' then
    begin
      Hideicons.checked:=true;
    end
    else
    begin
      Hideicons.checked:=false;
    end;
    ReadLn(settingsfile, buffer) ;
    if buffer = 'Buzzer' then
    begin
      speaker.checked:=true;
    end
    else
    begin
      speaker.checked:=false;
    end;
    ReadLn(settingsfile, buffer) ;
    startupscenario.Text:=buffer;
    buffer2:=buffer;
    changescenario;
    startupscenario.Text:=buffer2;

    if not EOF(settingsfile)then
    begin
      ReadLn(settingsfile, buffer) ;
      if buffer = 'Hint' then
      begin
        showhints.checked:=true;
      end
      else
      begin
        showhints.checked:=false;
      end;

      ReadLn(settingsfile, buffer) ;
      if buffer = 'TL' then
      begin
        usetraffic.checked:=true;
      end
      else
      begin
        usetraffic.checked:=false;
      end;
      ReadLn(settingsfile, buffer) ;
      if buffer = 'TLleft' then
      begin
        TLleft.checked:=true;
      end
      else
      begin
        TLright.checked:=true;
      end;
      ReadLn(settingsfile, buffer) ;
      soundselect.Text:=buffer;
      WavFilename:=PChar(Filespath+'sounds/'+wavbuffer+'.wav');
      ReadLn(settingsfile, buffer) ;
      tostart.value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer = 'K8055' then
      begin
        K8055select.Checked := true;
      end
      else
      begin
        K8055select.Checked := false;
      end;
      ReadLn(settingsfile, buffer) ;
      {$IFDEF Darwin}buffer:=MacPortName(buffer);{$ENDIF} // Mac: settings from Windows name COM ports
      serialport1.Text:=buffer;
      serial.Device:=buffer;
      ReadLn(settingsfile, buffer) ;
      if buffer = 'arduino1' then
      begin

        arduinoselect1.Checked := true;
        connect;
        serialfreqdelay.Enabled:=true;

      end
      else
      begin
        arduinoactive_at_init :=false;
        arduinoselect1.Checked := false;
        //serial.Active:=false;
        serial.close;
      end;

    end;
    if not EOF(settingsfile)then
    begin
      ReadLn(settingsfile, buffer) ;
      if buffer = 'PRECOUNT' then
      begin
        precountalways.Checked := true;
      end;

    end;

    if not EOF(settingsfile)then
    begin
      ReadLn(settingsfile, buffer) ;
      portnumber1.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer = 'nonLAN' then
      begin

        LANselect.Checked := false;
      end
      else
      begin

        LANselect.Checked := true;

      end;
    end;
    if not EOF(settingsfile)then
    begin
      ReadLn(settingsfile, buffer) ;
      IP1.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      IP2.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      IP3.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      IP4.Value:=strtoint(buffer);
    end;
    if not EOF(settingsfile)then
    begin

      ReadLn(settingsfile, buffer) ;
      {$IFDEF Darwin}buffer:=MacPortName(buffer);{$ENDIF} // Mac: settings from Windows name COM ports
      serialport2.Text:=buffer;
      serial2.Device:=buffer;

      ReadLn(settingsfile, buffer) ;
      if buffer = 'arduino2' then
      begin

        arduinoselect2.Checked := true;
        connect;
        serialfreqdelay.Enabled:=true;

      end
      else
      begin
        arduinoactive_at_init :=false;
        arduinoselect2.Checked := false;
        serial2.close;
      end;
      ReadLn(settingsfile, buffer) ;
      pgupcombox.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      pgdncombox.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      playcombox.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      blnkcombox.ItemIndex:=strtoint(buffer);

      ReadLn(settingsfile, buffer) ;
      comboxpn32.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn36.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn38.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn40.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn33.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn35.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxpn37.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer = 'col1'then colorscheme1.Checked:=true;
      if buffer = 'col2'then colorscheme2.Checked:=true;
      if buffer = 'col3'then colorscheme3.Checked:=true;
      if buffer = 'col4'then colorscheme4.Checked:=true;
      if buffer = 'col5'then colorscheme5.Checked:=true;
      if buffer = 'col6'then colorscheme6.Checked:=true;
      if buffer = 'col7'then colorscheme7.Checked:=true;
      if buffer = 'col8'then colorscheme8.Checked:=true;
      if buffer = 'col9'then colorscheme9.Checked:=true;
      ReadLn(settingsfile, buffer) ;
      comboxK8055but1.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxK8055but2.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxK8055but3.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxK8055but4.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      comboxK8055but5.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer = 'nonremote' then
      begin
        Lanremoteselect.Checked := false;
      end
      else
      begin
        Lanremoteselect.Checked := true;

      end;
      ReadLn(settingsfile, buffer) ;
      pwstring.Text:=buffer;
      ReadLn(settingsfile, buffer) ;
      magnification.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer = 'FonScreen' then  Fbutonscreenbox.Checked:=true else Fbutonscreenbox.Checked:=false;
      ReadLn(settingsfile, buffer) ;
      EmergencytxtEdit.Text:=buffer ;
      ReadLn(settingsfile, buffer) ;
      if buffer='def' then EmergencydefaultRadioButton.Checked:=true else EmergencyalternativeRadioButton.Checked:=true;
      ReadLn(settingsfile, buffer) ;
      if buffer='pause' then Pause_emergency_RadioButton.Checked:=true;
      if buffer='current' then Stop_current_RadioButton.Checked:=true;
      if buffer='next' then Stop_next_RadioButton.Checked:=true;
      ReadLn(settingsfile, buffer) ;
      minnrbeeps.Value:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      if buffer='keep' then KeepbuzzingCheckBox.Checked:=true else KeepbuzzingCheckBox.Checked:=false;
      Readln(settingsfile, buffer);
      if buffer='zero' then zerosec.Checked:=true else nonzerosec.Checked:=true;
      MinSecselection;
      Readln(settingsfile, buffer);
      PrepColListBoxbg.Selected:=StringToColor(buffer);
      PrepColBGPanel.Color:=PrepColListBoxbg.Selected;

      Readln(settingsfile, buffer);
      PrepColListBoxtime.Selected:=StringToColor(buffer);
      PrepColtimeLabel.font.Color:=PrepColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      retrColListBoxbg.Selected:=StringToColor(buffer);
      retrColBGPanel.Color:=retrColListBoxbg.Selected;
      retrLabel.Color:=retrColListBoxbg.Selected;

      Readln(settingsfile, buffer);
      retrColListBoxtime.Selected:=StringToColor(buffer);
      retrColtimeLabel.font.Color:=retrColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      redColListBoxbg.Selected:=StringToColor(buffer);
      redColBGPanel.Color:=redColListBoxbg.Selected;

      Readln(settingsfile, buffer);
      redColListBoxtime.Selected:=StringToColor(buffer);
      redColtimeLabel.font.Color:=redColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      GrnColListBoxbg.Selected:=StringToColor(buffer);
      GrnColBGPanel.Color:=GrnColListBoxbg.Selected;

      Readln(settingsfile, buffer);
      GrnColListBoxtime.Selected:=StringToColor(buffer);
      GrnColtimeLabel.font.Color:=GrnColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      OrColListBoxbg.Selected:=StringToColor(buffer);
      OrColBGPanel.Color:=OrColListBoxbg.Selected;

      Readln(settingsfile, buffer);
      OrColListBoxtime.Selected:=StringToColor(buffer);
      OrColtimeLabel.font.Color:=OrColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      ABColListBoxtime.Selected:=StringToColor(buffer);
      PrepColABLabel.Font.Color:=ABColListBoxtime.Selected;
      retrColABLabel.Font.Color:=ABColListBoxtime.Selected;
      RedColABLabel.Font.Color:=ABColListBoxtime.Selected;
      GrnColABLabel.Font.Color:=ABColListBoxtime.Selected;
      OrColABLabel.Font.Color:=ABColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      CDColListBoxtime.Selected:=StringToColor(buffer);
      PrepColCDLabel.Font.Color:=CDColListBoxtime.Selected;
      retrColCDLabel.Font.Color:=CDColListBoxtime.Selected;
      RedColCDLabel.Font.Color:=CDColListBoxtime.Selected;
      GrnColCDLabel.Font.Color:=CDColListBoxtime.Selected;
      OrColCDLabel.Font.Color:=CDColListBoxtime.Selected;

      Readln(settingsfile, buffer);
      if buffer='FALSE' then timecheckbox.Checked:=false else timecheckbox.Checked:=true ;   //timecheckbox  checked ?
      Readln(settingsfile, buffer);
      am24.ItemIndex:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='standard' then defaultbannerRadioButton.Checked:=true else specificbannerRadioButton.Checked:=true ;
      Readln(settingsfile, buffer);
      specificbannerpath.Caption:=buffer;
      choosebanner;
      Readln(settingsfile, buffer);
      if buffer='slides' then largeimagecheckbox.Checked:=true else largeimagecheckbox.Checked:=false ;
      Readln(settingsfile, buffer);
      if buffer='fullscreen' then fullscreencheckbox.Checked:=true else fullscreencheckbox.Checked:=false ;
      Readln(settingsfile, buffer);
      slidetime.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='FALSE' then RemshutdownCheckBox.Checked:=false else RemshutdownCheckBox.Checked:=true ;
      Readln(settingsfile, buffer);
      if buffer='FALSE' then showendnrcheckbox.Checked:=false else showendnrcheckbox.Checked:=true ;
      Readln(settingsfile, buffer);
      if buffer='prelayout1' then prelayoutradio1.Checked:=true else prelayoutradio2.Checked:=true;

      Readln(settingsfile, buffer);
      if buffer='VLC' then VLCradiobutton.Checked:=true;
      Readln(settingsfile, buffer);
      AudioIPedit.Caption:=buffer;
      Readln(settingsfile, buffer);
      Audioportnumber.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      volumestate1.Value:=strtoint(buffer);

      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate1.Checked:=true;
      if buffer='pause' then  Pausestate1.Checked:=true;
      if buffer='stop' then  Stopstate1.Checked:=true;
      Readln(settingsfile, buffer);
      volumestate2.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate2.Checked:=true;
      if buffer='pause' then  Pausestate2.Checked:=true;
      if buffer='stop' then  Stopstate2.Checked:=true;
      Readln(settingsfile, buffer);
      volumestate3.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate3.Checked:=true;
      if buffer='pause' then  Pausestate3.Checked:=true;
      if buffer='stop' then  Stopstate3.Checked:=true;
      Readln(settingsfile, buffer);
      volumestate4.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate4.Checked:=true;
      if buffer='pause' then  Pausestate4.Checked:=true;
      if buffer='stop' then  Stopstate4.Checked:=true;
      Readln(settingsfile, buffer);
      volumestate5.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate5.Checked:=true;
      if buffer='pause' then  Pausestate5.Checked:=true;
      if buffer='stop' then  Stopstate5.Checked:=true;
      Readln(settingsfile, buffer);
      volumestate6.Value:=strtoint(buffer);
      Readln(settingsfile, buffer);
      if buffer='play' then  Playstate6.Checked:=true;
      if buffer='pause' then  Pausestate6.Checked:=true;
      if buffer='stop' then  Stopstate6.Checked:=true;
      Readln(settingsfile, buffer);
      Controlaudiocheckbox.Checked:=strtobool(buffer);
      Readln(settingsfile, buffer);
      am24_2.ItemIndex:=strtoint(buffer);
      Readln(settingsfile, buffer);
      Actualtimecheckbox.Checked:=strtobool(buffer);
      ReadLn(settingsfile, buffer) ;
      leftarrowkeycombo.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      rightarrowkeycombo.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      uparrowkeycombo.ItemIndex:=strtoint(buffer);
      ReadLn(settingsfile, buffer) ;
      downarrowkeycombo.ItemIndex:=strtoint(buffer);

    end;

    CloseFile(settingsfile) ;
    updatemenu;
    changecolorscheme;
    hide2;
  end;
  prevstate:=1;
  orgrepeatsequence:=repeatsequence.Value;
  orgfolabcdsec:=ABCDperEND.Checked;
  orgPABCDperEND:=PABCDperEND.Checked;
  orgfol25m1pse:=rotate25m1p.Checked;
  orgfol25m1pse_p:=rotate25m1p_p.Checked;

    //Initialize the menus
  SettingsTabs.Top:=80;
  FITAScrollBox.Top:=110;
  FITAScrollBox.Width:=350;
  onearrowScrollBox.Top:=110;
  onearrowScrollBox.Width:=350;
  manualScrollBox.Top:=110;
  manualScrollBox.Width:=350;
  FollowScrollBox.top:=110;
  FollowScrollBox.Width:=350;
  FitaFinScrollBox.Top:=110;
  FitaFinScrollBox.Width:=350;
  groupfinend.Left:=8;
  groupfinarrow.Left:=8;
  groupfinendSO.Left:=8;
  groupfinend.Width:=304;
  groupfinarrow.Width:=304;
  groupfinendSO.Width:=304;
  finalteamturns.Left:=4;
  finalteamturnsSO.Left:=4;
  finalturns.left:= 4;
  finalturnsso.Left:=4;
  finalteamturns.top:=48;
  finalturns.top:=48;
  finalturnsso.Top:=80;
  finalteamturnsSO.top:=80;
  Turns_per_end.top:=52;
  Turns_per_end_SO.Top:=84;
  Turns_per_end.Left:=52;
  Turns_per_end_SO.Left:=52;
  timeseqpanel.Height:=320;
  getPCname;

  savesettings.height:=175; //height of the settings menu
  //Calculate the different total times (Green and red together)
  totaltime.Caption:= inttostr( trunc(orangetime.value)+trunc(greentime.value));
  if orangetime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);
  if greentime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);

  totaltimeso.Caption:= inttostr( trunc(orangetimeso.value)+trunc(greentimeso.value));
  totaltime1p.Caption:= inttostr( trunc(orangetime1p.value)+trunc(greentime1p.value));
  totalfinal.Caption:= inttostr( trunc(orangefinal.value)+trunc(greenfinal.value));
  totalfinalend.Caption:= inttostr( trunc(orangefinalend.value)+trunc(greenfinalend.value));
  totalfinalendso.Caption:= inttostr( trunc(orangefinalendso.value)+trunc(greenfinalendso.value));
  //Languagetab always active at startup
  SettingsTabs.ActivePage:=tablang;

  {$IFDEF Windows}
  if FileExists('backgroundimages') then  imagesListBox.Items.LoadFromFile('backgroundimages');
  {$ENDIF}


  {$IFDEF Unix}
  if linuxHW='RPI' then
  begin
    if FileExists('/home/pi/archeryclock/backgroundimages') then  imagesListBox.Items.LoadFromFile('/home/pi/archeryclock/backgroundimages');
  end
  else
  begin
    if FileExists('backgroundimages') then  imagesListBox.Items.LoadFromFile('backgroundimages');
  end;

  {$ENDIF}

  //initial settings for fita finals
  fitafinarcher:='none';    //not decided yet which archer starts

  //Show what needs to be visible in current mode/setting

  //Change size to current resolution
  resizewindow;
  viewchangestateactive;
  initializationstate:=false;

  connect_delay.Enabled:=true;
  viewchangmenuitems;
  if imagesListBox.Items.Count>=1 then if FileExists(imagesListBox.Items.Strings[0])then background1.Picture.LoadFromFile(imagesListBox.Items.Strings[0] );
  backgroundtimer.Interval:=slidetime.Value*1000;
  if largeimagecheckbox.Checked=true then
  begin
    backgroundtimer.Enabled:=true;
  end
  else
  begin
    backgroundtimer.Enabled:=false;
    if (Actualtimecheckbox.Checked=true) then imagecount:=-1 else imagecount:=0;
  end;
  musicaction:='init';
  if Controlaudiocheckbox.Checked=true then
  begin
    TCPmusicnetwork.Disconnect;
    TCPmusicnetwork.Connect(AudioIPedit.Text, Audioportnumber.Value);
  //  initmusicconnection;
  end;
  endtimebuzzer:=false;

  {$IFDEF Unix}
    If linuxHW='RPI' then initaccesspointmenu;
    {$IFDEF Darwin}
    // Mac: no xset; keep the display awake while the clock runs
    MacKeepDisplayAwake;
    {$ELSE}
    RunCommand('sudo xset s off', dummy);
    RunCommand('sudo xset -dpms',dummy);
    RunCommand('sudo xset s noblank',dummy);
    {$ENDIF}


    nexthelp.Color:=clinfoBK;
    nexthelp.Font.Color:=clinfotext;
    chooselabel.Color:=clinfoBK;
    chooselabel.Font.Color:=clinfotext;
    //GotoXY(10,10);
    //Mouse.SetMouseXY(1000,1000);
    //mouse.DoneMouse;
  {$ENDIF}
 // if FileExists('backgroundimages') then  imagesListBox.Items.LoadFromFile('backgroundimages');
  Startuplabel.Visible:=false;
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: lay the timing page out again after the fonts above are set

end;

procedure TCountdownform.initaccesspointmenu;
begin
  AccesspointGroupBox.Enabled:=true;
  if FileExistsUTF8(Filespath+'accessp')=true then
  begin
    AssignFile(accessfile, Filespath+'accessp');
    Reset(accessfile) ;
    ReadLn(accessfile, buffer);
    if (buffer='1') then
    begin
      APstatuslabel.Caption:='Currently on';
      enableaccesspointpanel.Enabled:=false;
      disableaccesspointpanel.Enabled:=true;
    end
    else
    begin
      APstatuslabel.Caption:='Currently off';
      enableaccesspointpanel.Enabled:=true;
      disableaccesspointpanel.Enabled:=false;
    end;
    ReadLn(accessfile, buffer);
    SSIDEdit.Text:=buffer;
    ReadLn(accessfile, buffer);
    PWEdit.Text:=buffer;
    ReadLn(accessfile, buffer);
    wifichannel.Value:=strtoint(buffer);
    ReadLn(accessfile, buffer);
    WIFIHWListBox.ItemIndex:=strtoint(buffer);
    ReadLn(accessfile, buffer);
    CountrycodeEdit.Text:=buffer;
    ReadLn(accessfile, buffer);
    interfaceEdit.Text:=buffer;

    CloseFile(accessfile);

  end
  else
  begin
    APstatuslabel.Caption:='Currently off';
    enableaccesspointpanel.Enabled:=true;
    disableaccesspointpanel.Enabled:=false;
  end;
end;

procedure TCountdownform.FormActivate(Sender: TObject);
var
  fileDesc, fileDesc2: integer;
begin
  initialize;
  {$IFDEF Unix}
  inputtimer.enabled:=true;
  { Prepare pins for access: }
  try
    fileDesc := fpopen('/sys/class/gpio/export', O_WrOnly);
 //   gReturnCode := fpwrite(fileDesc, PIN_6[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_13[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_19[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_26[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_12[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_16[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_20[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_21[0], 2);

    gReturnCode := fpwrite(fileDesc, PIN_2[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_3[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_4[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_17[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_27[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_22[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_10[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_9[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_11[0], 2);
    gReturnCode := fpwrite(fileDesc, PIN_5[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_7[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_8[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_25[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_24[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_23[0], 2);
 //   gReturnCode := fpwrite(fileDesc, PIN_18[0], 2);

  finally
    gReturnCode := fpclose(fileDesc);
  end;
  { Set SoC pin 17 as output: }
  sleep(450);
  try
    fileDesc2 := fpopen('/sys/class/gpio/gpio2/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio3/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio4/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio17/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio27/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio22/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio10/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio9/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio11/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio5/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio7/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio8/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio25/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio24/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio23/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio18/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, OUT_DIRECTION[0], 3);
    fileDesc2 := fpopen('/sys/class/gpio/gpio13/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
//    fileDesc2 := fpopen('/sys/class/gpio/gpio6/direction', O_WrOnly);
//    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);

    fileDesc2 := fpopen('/sys/class/gpio/gpio19/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
    fileDesc2 := fpopen('/sys/class/gpio/gpio26/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
    fileDesc2 := fpopen('/sys/class/gpio/gpio12/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
    fileDesc2 := fpopen('/sys/class/gpio/gpio16/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
    fileDesc2 := fpopen('/sys/class/gpio/gpio20/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
    fileDesc2 := fpopen('/sys/class/gpio/gpio21/direction', O_WrOnly);
    gReturnCode := fpwrite(fileDesc2, IN_DIRECTION[0], 2);
  finally
    gReturnCode := fpclose(fileDesc2);
  end;
  {$ENDIF}

end;

procedure TCountdownform.choosebanner;
begin
  if (specificbannerRadioButton.Checked=true) and (FileExistsUTF8(specificbannerpath.Caption)=true) then
  bannerpicture.Picture.LoadFromFile(specificbannerpath.Caption)
  else
  begin
    if (FileExistsUTF8(Filespath+'banner.png')=false)and(FileExistsUTF8(Filespath+'banner.bmp')=false) then   //banner.bmp does not exist, so the text is shown in stead of a banner
    begin  //there is no banner file
      websitename.Visible:=true;
      bannerpicture.Visible:=false;     //no file to show
      viewstateone;
    end
    else
    begin  //there is a banner file
      if (FileExistsUTF8(Filespath+'banner.png')=true) then
      bannerpicture.Picture.LoadFromFile(Filespath+'banner.png')
      else
      bannerpicture.Picture.LoadFromFile(Filespath+'banner.bmp');
      bannerpicture.Visible:=true;
      websitename.Visible:=false;
    end;
  end;
end;

procedure TCountdownform.changescenario;
begin
  for mode := 1 to 12 do
  begin
    Scenario:='F'+inttostr(mode);
    if buffer ='shiftF'+inttostr(mode) then Setsettings;
    if buffer ='F'+inttostr(mode) then
    begin
      if FileExistsUTF8(Filespath+'scenarios/'+scenario)=true then
      begin
        AssignFile(scenariotextfile, Filespath+'scenarios/'+scenario) ;
        getsetting;
      end
      else
      begin
        Setsettings;
      end;
    end;
  end;
  if buffer ='--' then
  begin
    if FileExistsUTF8(Filespath+'scenarios/'+'gen') =true then
    begin
      AssignFile(scenariotextfile, Filespath+'scenarios/'+'gen') ;
      getsetting;
    end;
  end;
end;

procedure TCountdownform.menuscreensize;
begin

  resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowTL;
  resizewindowsingleclock;
  resizewindowlabelsiconsmenu;
  if archerysystem <>'fitafin' then resizewindownonfinals  else resizewindowfinals;
  resizewindowpreclock;
  viewturnchange;
  viewstateone;

  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: a menu just opened: lay out what it shows now
end;



procedure TCountdownform.timingsettingsClick(Sender: TObject);
  //show timing menu or remove it when pressing the timing button
begin
  manualfollowmenuremove:=false;
  if (timeseqpanel.visible=false)then
  begin
    timeseqpanel.visible:=true ;
    savesettings.Visible:=false;
    manualcolorpanel.Visible:=false;
  end
  else
  begin
    timeseqpanel.visible:=false ;
  end;
  menuscreensize;
  viewchangmenuitems;
  menuremovesec:=10;
end;

procedure TCountdownform.serienrClick(Sender: TObject);
begin
  resetendnr;
end;
Procedure TCountdownform.resetendnr;
begin
  if  (archerysystem<>'follow')  then
  begin
    serienumber:=1;
    turnnumber:=1;
    if (archerysystem='fita') and (practiseturns.Value<>0) then Practiseturn:=1;
    if (archerysystem='25m1p') and (nrof1ppractisearrows.Value<>0) then Practiseturn:=1;
    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;


procedure TCountdownform.greentimeChange(Sender: TObject);
begin
  totaltime.Caption:= inttostr( trunc(orangetime.value)+trunc(greentime.value));
  if orangetime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);
  if greentime.value=-1 then totaltime.Caption:=inttostr(strtoint(totaltime.Caption)+1);
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.oneonesystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=1;
  Turnsperserie:=1;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;


procedure TCountdownform.oneoneClick(Sender: TObject);
begin
  oneonesystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;


procedure TCountdownform.onetwosystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=2;
  Turnsperserie:=2;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;

end;


procedure TCountdownform.onetwoClick(Sender: TObject);
begin
  onetwosystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.onethreesystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=3;
  Turnsperserie:=3;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;


procedure TCountdownform.onethreeClick(Sender: TObject);
begin
  onethreesystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.onefoursystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=4;
  Turnsperserie:=4;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.onefourClick(Sender: TObject);
begin
  onefoursystem;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.twotwosystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=4;
  Turnsperserie:=2;
  Archersperturn:=2;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;

end;

procedure TCountdownform.twotwoClick(Sender: TObject);
begin
twotwosystem;
showseq;
showtime;
startupscenario.Text:='--';
end;

procedure TCountdownform.onefivesystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=5;
  Turnsperserie:=5;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.onesixsystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=6;
  Turnsperserie:=6;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;
procedure TCountdownform.twothreesystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=6;
  Turnsperserie:=3;
  Archersperturn:=2;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.threetwosystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=true;
  Shooters:=6;
  Turnsperserie:=2;
  Archersperturn:=3;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;
procedure TCountdownform.topbotsystem;
begin
  if (Practiseturn=1) and (serienumber >Practiseturns.value) then serienumber:=Practiseturns.value;
  showABCD:=false;
  Shooters:=2;
  Turnsperserie:=2;
  Archersperturn:=1;
  if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;
  viewarchsystemchange;
  viewturnchange;
  switchbox;
  TLswitch;
end;


procedure TCountdownform.downserie;
//one end down
begin
  if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)  then
  begin
    changeendturntimer.Enabled:=false;
    changeendturntimer.Enabled:=true;
    viewarchsystemchange;
  end;
  if (state=6) then
  begin
    if (archerysystem <> 'fitafin')  then
    begin
      if (countdowntimer <> 0) then countdowntimer:=countdowntimer-1;
    end
    else
    begin
      if ((fitafinarcher = 'left') and (countdowntimer <> 0)) then countdowntimer:=countdowntimer-1;
      if ((fitafinarcher = 'right') and (countdowntimer2 <> 0)) then countdowntimer2:=countdowntimer2-1;
    end;
    viewactivate;
    switchbox;
  end
  else
  begin
    if Practiseturn=1 then
    begin
      if serienumber >1 then serienumber:=serienumber-1;
    end
    else
    begin
      if serienumber >1 then serienumber:=serienumber-1 else
      if archerysystem<>'fitafin' then
      begin
        if (archerysystem='fita') and (practiseturns.Value<>0) then
        begin
          serienumber:=Practiseturns.value;
          Practiseturn:=1;
        end;
        if (archerysystem='25m1p') and (nrof1ppractisearrows.Value<>0) then
        begin
          serienumber:=nrof1ppractisearrows.Value;
          Practiseturn:=1;
        end;
      end;
    end;
    viewturnchange;
    viewicons;
    viewstateone;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.decreaseseriebuttonClick(Sender: TObject);
begin
  downserie;
end;

procedure TCountdownform.upserie;
//one end up
begin
  if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true) then
  begin
    changeendturntimer.Enabled:=false;
    changeendturntimer.Enabled:=true;
    viewarchsystemchange;
  end;
  if (state=6)  then
  Begin
    if (archerysystem <> 'fitafin')  then
    begin
      if (countdowntimer <> 0) then countdowntimer:=countdowntimer+1;
    end
    else
    begin
      if ((fitafinarcher = 'left') and (countdowntimer <> 0)) then countdowntimer:=countdowntimer+1;
      if ((fitafinarcher = 'right') and (countdowntimer2 <> 0)) then countdowntimer2:=countdowntimer2+1;
    end;
    viewactivate;
    switchbox;
  end
  else
  begin
    if Practiseturn=1 then
    if ((archerysystem='fita') and (serienumber=Practiseturns.value)) or ((archerysystem='25m1p') and (serienumber=nrof1ppractisearrows.Value))then
    begin
      serienumber:=1;
      Practiseturn:=0;
    end
    else
    begin
      serienumber:=serienumber+1;
    end
    else
    if (archerysystem<>'fitafin') or (((serienumber<finalturns.Value)and (timeperturn.checked=true))or((serienumber<finalteamturns.Value)and (timeperturn.checked=false))) then  serienumber:=serienumber+1;
    viewturnchange;
    viewicons;
    viewstateone;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.increaseseriebuttonClick(Sender: TObject);
begin
  upserie;
end;

procedure TCountdownform.downturn;

//one turn down
begin
  if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true) then
  begin
    changeendturntimer.Enabled:=false;
    changeendturntimer.Enabled:=true;
    viewarchsystemchange;

  end;
  if (archerysystem = 'manual')  then
  begin
    setred;
  end;

  if archerysystem='fitafin' then selectleftarcher else
  begin
    if turnnumber =1 then
    begin
      turnnumber:=turnsperserie;
      if Practiseturn=1 then
      begin
        if serienumber >1 then serienumber:=serienumber-1;
      end
      else
      begin
        if serienumber >1 then serienumber:=serienumber-1 else
        begin
          if (archerysystem='fita') and (practiseturns.Value<>0) then
          begin
            serienumber:=Practiseturns.value;
            Practiseturn:=1;
          end;
          if (archerysystem='25m1p') and (nrof1ppractisearrows.Value<>0) then
          begin
            serienumber:=nrof1ppractisearrows.Value;
            Practiseturn:=1;
          end;
        end;
      end;
    end
    else turnnumber:=turnnumber-1;
  end;
  viewturnchange;
  viewicons;
  viewstateone;
  viewchangestateexchange;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.decreaseshooterbuttonClick(Sender: TObject);
begin
 downturn;
end;

procedure TCountdownform.nextscenario;
//to scenario to next scenario
begin
  if (startupscenario.Text='F1') then
  begin
    startupscenario.ItemIndex:=1;
    buffer:=startupscenario.Text;
    changescenario;
    startupscenario.ItemIndex:=1;
  end
  else
  begin
    if (startupscenario.Text='F2') then
    begin
      startupscenario.ItemIndex:=2;
      buffer:=startupscenario.Text;
      changescenario;
      startupscenario.ItemIndex:=2;
    end
    else
    begin
      if (startupscenario.Text='F3') then
      begin
        startupscenario.ItemIndex:=3;
        buffer:=startupscenario.Text;
        changescenario;
        startupscenario.ItemIndex:=3;
      end
      else
      begin
        if (startupscenario.Text='F4') then
        begin
          startupscenario.ItemIndex:=4;
          buffer:=startupscenario.Text;
          changescenario;
          startupscenario.ItemIndex:=4;
        end
        else
        begin
          if (startupscenario.Text='F5') then
          begin
            startupscenario.ItemIndex:=5;
            buffer:=startupscenario.Text;
            changescenario;
            startupscenario.ItemIndex:=5;
          end
          else
          begin
            if (startupscenario.Text='F6') then
            begin
              startupscenario.ItemIndex:=6;
              buffer:=startupscenario.Text;
              changescenario;
              startupscenario.ItemIndex:=6;
            end
            else
            begin
              if (startupscenario.Text='F7') then
              begin
                startupscenario.ItemIndex:=7;
                buffer:=startupscenario.Text;
                changescenario;
                startupscenario.ItemIndex:=7;
              end
              else
              begin
                if (startupscenario.Text='F8') then
                begin
                  startupscenario.ItemIndex:=8;
                  buffer:=startupscenario.Text;
                  changescenario;
                  startupscenario.ItemIndex:=8;
                end
                else
                begin
                  if (startupscenario.Text='F9') then
                  begin
                    startupscenario.ItemIndex:=9;
                    buffer:=startupscenario.Text;
                    changescenario;
                    startupscenario.ItemIndex:=9;
                  end
                  else
                  begin
                    if (startupscenario.Text='F10') then
                    begin
                      startupscenario.ItemIndex:=10;
                      buffer:=startupscenario.Text;
                      changescenario;
                      startupscenario.ItemIndex:=10;
                    end
                    else
                    begin
                      if (startupscenario.Text='F11') then
                      begin
                        startupscenario.ItemIndex:=11;
                        buffer:=startupscenario.Text;
                        changescenario;
                        startupscenario.ItemIndex:=11;
                      end
                      else
                      begin
                        startupscenario.ItemIndex:=0;
                        buffer:=startupscenario.Text;
                        changescenario;
                        startupscenario.ItemIndex:=0;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TCountdownform.prevscenario;
//to scenario to previous scenario
begin
  begin
    if (startupscenario.Text='F3') then
    begin
      startupscenario.ItemIndex:=1;
      buffer:=startupscenario.Text;
      changescenario;
      startupscenario.ItemIndex:=1;
    end
    else
    begin
      if (startupscenario.Text='F4') then
      begin
        startupscenario.ItemIndex:=2;
        buffer:=startupscenario.Text;
        changescenario;
        startupscenario.ItemIndex:=2;
      end
      else
      begin
        if (startupscenario.Text='F5') then
        begin
          startupscenario.ItemIndex:=3;
          buffer:=startupscenario.Text;
          changescenario;
          startupscenario.ItemIndex:=3;
        end
        else
        begin
          if (startupscenario.Text='F6') then
          begin
            startupscenario.ItemIndex:=4;
            buffer:=startupscenario.Text;
            changescenario;
            startupscenario.ItemIndex:=4;
          end
          else
          begin
            if (startupscenario.Text='F7') then
            begin
              startupscenario.ItemIndex:=5;
              buffer:=startupscenario.Text;
              changescenario;
              startupscenario.ItemIndex:=5;
            end
            else
            begin
              if (startupscenario.Text='F8') then
              begin
                startupscenario.ItemIndex:=6;
                buffer:=startupscenario.Text;
                changescenario;
                startupscenario.ItemIndex:=6;
              end
              else
              begin
                if (startupscenario.Text='F9') then
                begin
                  startupscenario.ItemIndex:=7;
                  buffer:=startupscenario.Text;
                  changescenario;
                  startupscenario.ItemIndex:=7;
                end
                else
                begin
                  if (startupscenario.Text='F10') then
                  begin
                    startupscenario.ItemIndex:=8;
                    buffer:=startupscenario.Text;
                    changescenario;
                    startupscenario.ItemIndex:=8;
                  end
                  else
                  begin
                    if (startupscenario.Text='F11') then
                    begin
                      startupscenario.ItemIndex:=9;
                      buffer:=startupscenario.Text;
                      changescenario;
                      startupscenario.ItemIndex:=9;
                    end
                    else
                    begin
                      if (startupscenario.Text='F12') then
                      begin
                        startupscenario.ItemIndex:=10;
                        buffer:=startupscenario.Text;
                        changescenario;
                        startupscenario.ItemIndex:=10;
                      end
                      else
                      begin
                        if (startupscenario.Text='F1') then
                        begin
                          startupscenario.ItemIndex:=11;
                          buffer:=startupscenario.Text;
                          changescenario;
                          startupscenario.ItemIndex:=11;
                        end
                        else
                        begin
                          startupscenario.ItemIndex:=0;
                          buffer:=startupscenario.Text;
                          changescenario;
                          startupscenario.ItemIndex:=0;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;


procedure TCountdownform.leftarea;
//to change settings in case the sreen is located in the left area of the archery range
begin
  if leftscreen.Checked=false then leftscreen.Checked:=true;
  if TLleft.Checked=false then TLleft.Checked:=true;
  if viewleft.checked=false then viewleft.Checked:=true;

end;

procedure TCountdownform.rightarea;
//to change settings in case the sreen is located in the right area of the archery range
begin
  if rightscreen.Checked=false then rightscreen.Checked:=true;
  if TLright.Checked=false then TLright.Checked:=true;
  if viewright.Checked=false then viewright.Checked:=true;
end;

procedure TCountdownform.upturn;
//one turn up
begin
  if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true) then
  begin
    changeendturntimer.Enabled:=false;
    changeendturntimer.Enabled:=true;
    viewarchsystemchange;

  end;
  if (archerysystem = 'manual')  then
  begin
    setgreen;
  end;

  if archerysystem='fitafin' then selectrightarcher else
  begin
    if turnnumber =turnsperserie then
    begin
      turnnumber:=1;
      if Practiseturn=1 then
      if ((archerysystem='fita') and (serienumber=Practiseturns.value)) or ((archerysystem='25m1p') and (serienumber=nrof1ppractisearrows.Value))then
      begin
        serienumber:=1;
        Practiseturn:=0;
      end
      else
      begin
        serienumber:=serienumber+1;
      end
      else
      serienumber:=serienumber+1;
    end
    else turnnumber:=turnnumber+1;
  end;
  viewturnchange;
  viewicons;
  viewstateone;
  viewchangestateexchange;
  switchbox;
  TLswitch;
end;

procedure TCountdownform.increaseshooterbuttonClick(Sender: TObject);
begin
  upturn;
end;

procedure TCountdownform.minutesClick(Sender: TObject);
//activate the change between minute or seconds selection
begin
  viewchangestateinact;
  viewchangestateexchange;
  resizewindowfinals;
  resizewindownonfinals;

end;

procedure TCountdownform.secondsClick(Sender: TObject);
//activate the change between minute or seconds selection
begin
  viewchangestateinact;
  viewchangestateexchange;
  resizewindowfinals;
  resizewindownonfinals;
end;

procedure TCountdownform.stop;
// stop function selected (via "S", stop button, etc.
begin
  if (archerysystem='fitafin')and(state=1) then selectnonearcher else
  begin

    if (archerysystem<>'manual') and (archerysystem<>'follow') and (endtimout.Enabled=false) then
    begin
      endtimout.Enabled:=true;
      FirstTimer.enabled:=false ;
      secondTimer.enabled:=false ;
      if state <> 5 then
      begin
        state:=1;
        soundsignal;
      end;
      state:=1;
      Checkredblink;
      countdowntimer:=0;
      countdowntimer2:=0;
      Shootoff:=0;
      fitafinarcher:='none';
      fitafinstartarcher:='none';
      if (archerysystem='fitafin')and(finarrow.Checked=true) then leftrightzoom.Enabled:=true;
      if (archerysystem='fitafin') then
      begin
        serienumber:=1;
        turnnumber:=1;
      end;
      viewchangestateinact;
      viewchangestateexchange;
      viewturnchange;
      viewactivate;
      Checkredblink;
      switchbox;
      TLswitch;
      viewicons;
      viewchangestateactive;
      viewstateone;
      if archerysystem='fitafin'then
      begin
        viewfinupdate;
        viewchangmenuitems;
      end
      else
      begin
        viewarchsystemchange;
      end;
    end;
    timedown.Visible:=false;
    timeup.Visible:=false;
  end;
end;

procedure TCountdownform.stopemergency;
// tabEmergency stop function selected (via "E", ).
begin
  if danger.Visible=true then
  begin
    manualfollowmenuremove:=true;
    alarmstate:=1; //remember we are in tabEmergency
    if EmergencydefaultRadioButton.Checked=true then emergencytext.Caption:=EmergencydefaultRadioButton.Caption else emergencytext.Caption := EmergencytxtEdit.Text ;
    if (Length(emergencytext.Caption)>3) then emergencytext.font.height:=trunc ((referencesize*1.7)*mag*mag/(Length(emergencytext.Caption))) else emergencytext.font.height:=trunc ((referencesize*1.7)*mag*mag/4) ;
    emergencytext.Visible:=true;
    if (archerysystem<>'manual') and (archerysystem<>'follow') then
    begin
      FirstTimer.enabled:=false ;
      secondTimer.enabled:=false ;
      if ((state =2) or (state =1) or (state =5) or(Pause_emergency_RadioButton.Checked=false)) then
      begin
        fitafinstartarcher:='none';
        countdowntimer:=0;
        countdowntimer2:=0;
        Shootoff:=0;
      end;
      if (((state <> 1) and (state <> 2) and (state <> 5)) and (Pause_emergency_RadioButton.Checked=false)) then // and (turnnumber =turnsperserie)) then
      begin
        state:=6;
        if Stop_next_RadioButton.Checked=true then
        begin
          if (turnnumber =turnsperserie) then finalyzeturn else
          begin
            turnnumber:=turnnumber+1;
            soundsignal;
          end;
        end;
        if Stop_current_RadioButton.Checked=true then
        begin
          soundsignal;
        end;
      end
      else
      begin
        state:=6;
        soundsignal;
        if ((Pause_emergency_RadioButton.Checked=true)and((countdowntimer<>0)or (countdowntimer2<>0))) then
        begin
          timedown.Visible:=true;
          timeup.Visible:=true;
        end;
      end;
      if ((countdowntimer=0) or (Pause_emergency_RadioButton.Checked=false)) then
      Begin
        state:=1;
        viewstateone;
      end;
      if (Pause_emergency_RadioButton.Checked=false) then fitafinstartarcher:='none';
      if (((archerysystem='fitafin'))and((Pause_emergency_RadioButton.Checked=false)or((countdowntimer=0)and(countdowntimer2=0)))) then
      begin
        fitafinarcher:='none';
        if (finarrow.Checked=true) then leftrightzoom.Enabled:=true;
      end;
      if archerysystem='fitafin'then
      begin
        viewfinupdate;
        viewchangmenuitems;
        resizewindowfinals;
      end
      else
      begin
        viewarchsystemchange;
      end;
    end
    else
    begin
      state:=1;
      nrofmanualbeeps:=minnrbeeps.Value;
      soundsignal;
      viewstateone;
    end;
    Checkredblink;
    viewchangestateexchange;
    viewturnchange;
    viewactivate;
    switchbox;
    TLswitch;

    viewchangestateactive;
    viewchangestateinact;
    viewicons;
  end;
end;

procedure TCountdownform.nextfinal;
//nextfinal is used in finalrounds for switching between archers.
//switching is depending of arrow number (only after the last arrow, stop switching
//also depending to right or left archer and depending if time per turn or time per arrow is selected
begin
  endtimout.Enabled:=true;
  if ((((((serienumber>=finalturns.value)and (Shootoff=0))or((serienumber>=finalturnsSO.value)and (Shootoff=1))) and (timeperturn.checked=true))or((((serienumber>=finalteamturns.Value)and (Shootoff=0))or((serienumber>=finalteamturnsSO.Value)and (Shootoff=1))) and (timeperturn.checked=false)) )and(((fitafinarcher='right') and (fitafinstartarcher = 'left')  )or ((fitafinarcher='left') and (fitafinstartarcher = 'right'))))then
  begin       //last archer ready
    state:=1;
    soundsignal;
    Shootoff:=0;
    fitafinarcher:='none';
    fitafinstartarcher:='none';
    viewicons;
    viewchangmenuitems;
    viewstateone;
  end
  else    //next archer or team
  begin
    if fitafinarcher='right'then  //if rightside archer was active, switch over to left side archer
    begin
      if (Beepswitcharcher.Checked=true) or endtimebuzzer then soundsignal;
      endtimebuzzer:=false;
      fitafinarcher:='left';
      FirstTimer.enabled:=true ;
      secondTimer.enabled:=false ;
      if timeperturn.checked=true then
      begin
        if (((serienumber=finalturns.value)and (Shootoff=0))or((serienumber=finalturnsSO.value)and (Shootoff=1))) then countdowntimer2:=0 else countdowntimer2:= (orangefinal.Value +greenfinal.value);
        state:=3;
      end
      else
      begin
        if (((serienumber=finalteamturns.value)and (Shootoff=0))or((serienumber=finalteamturnsSO.value)and (Shootoff=1))) then countdowntimer2:=0 else if countdowntimer2=1 then countdowntimer2:=0;
        if (((countdowntimer > orangefinalend.Value)and (Shootoff=0))or((countdowntimer > orangefinalendSO.Value)and (Shootoff=1))) then state:=3 else state:=4;
      end;
      if (fitafinstartarcher = 'left')and(((((serienumber<finalturns.value)and (Shootoff=0))or((serienumber<finalturnsSO.value)and (Shootoff=1)))and(timeperturn.checked=true))or(  (((serienumber<finalteamturns.value)and(Shootoff=0))or((serienumber<finalteamturnsSO.value)and(Shootoff=1)))  and(timeperturn.checked=false))) then serienumber:=serienumber+1;
    end
    else
    if fitafinarcher<>'none'then
    begin  //if leftside archer was active, switch over to right side archer
      if (Beepswitcharcher.Checked=true) or endtimebuzzer then soundsignal;
      endtimebuzzer:=false;
      fitafinarcher:='right';
      FirstTimer.enabled:=false;
      secondTimer.enabled:=true ;
      if timeperturn.checked=true then
      begin
        if (((serienumber=finalturns.value)and (Shootoff=0))or((serienumber=finalturnsSO.value)and (Shootoff=1))) then countdowntimer:=0 else countdowntimer:= (orangefinal.Value +greenfinal.value);
        state:=3;
      end
      else
      begin
        if (((serienumber=finalteamturns.value)and (Shootoff=0))or((serienumber=finalteamturnsSO.value)and (Shootoff=1))) then countdowntimer:=0 else if countdowntimer=1 then countdowntimer:=0;
        if (((countdowntimer2 > orangefinalend.Value)and (Shootoff=0))or((countdowntimer2 > orangefinalendSO.Value)and (Shootoff=1))) then state:=3 else state:=4;
      end;
      if (fitafinstartarcher = 'right')and(((((serienumber<finalturns.value)and (Shootoff=0))or((serienumber<finalturnsSO.value)and (Shootoff=1)))and(timeperturn.checked=true))or((((serienumber<finalteamturns.value)and(Shootoff=0))or((serienumber<finalteamturnsSO.value)and(Shootoff=1)))and(timeperturn.checked=false))) then serienumber:=serienumber+1;
    end;
  end;
  if fitafinarcher='none' then
  begin
    FirstTimer.enabled:=false;
    secondTimer.enabled:=false ;
    countdowntimer2:=0;
    countdowntimer:=0;
    state:=1;
    serienumber:=1;
    viewactivate;
    viewchangestateexchange;
    viewicons;
    viewstateone;
  end;
  Checkredblink;
  viewfinupdate;
  viewturnchange;
  viewchangestateactive;
  TLswitch;
  if finarrow.Checked=true then leftrightzoom.Enabled:=true;
end;

procedure TCountdownform.restorestate;
begin
  if archerysystem='fita' then
  begin
    if countdowntimer =0 then state:=1 else

    begin
      if countdowntimer<= orangetime.Value then state:=4 else state:=3;
    end;
    viewchangestateactive;
    TLswitch;
    soundsignal;
  end;
  if archerysystem='25m1p' then
  begin
    if countdowntimer =0 then state :=1 else
    begin
      if countdowntimer<= orangetime1p.Value then state:=4 else state:=3;
    end;
    viewchangestateactive;
    TLswitch;
    soundsignal;
  end;
  if archerysystem='fitafin' then
  begin

  end;
  Checkredblink;
end;

procedure TCountdownform.next;
begin
  if (archerysystem = 'manual')  then
  begin
    case state of
    2: setgreen;
    3: setorange;
    else setred;
    end;

  end;
//when next is selected the window changes in a bar-less window. On the current position
  leftalign:=countdownform.Left;  //remember horizontal position
  topalign:=countdownform.Top;     //remember vertical position
  countdownform.borderstyle:=bsnone;  //remove bar/frame
  countdownform.Left:=leftalign;     //restore horizontal position
  countdownform.Top:=topalign;       //restore vertical position
  if (archerysystem <> 'manual') and (archerysystem<>'follow')then //and (alarmstate<>1)
  begin
    If state=6 then
    begin
      restorestate;
    end;
    if (archerysystem='fitafin') and (endtimout.Enabled=false) then  //actions in final round are different than other rounds
    begin
      if ((countdowntimer=0) and (countdowntimer2=0) and (state =6)) then
      begin
        state:=1;
        viewstateone;
      end;
      referencetime:=getcurrenttime; //time starts from zero, so need to catch the current time since the system clock is th reference
      if fitafinarcher='left' then
      begin
        FirstTimer.enabled:=false ;
        FirstTimer.enabled:=true ;
      end;
      if fitafinarcher='right' then
      begin
        secondTimer.enabled:=false ;
        secondTimer.enabled:=true ;
      end;
      if fitafinarcher<>'none' then
      //result of 'next' is depending on the state of the timer.
      begin
        case state of
        1:begin     //wait state
            if endtimout.Enabled=false then  //to prevent double press
            begin
              if fitafinarcher='left' then
              begin
                FirstTimer.enabled:=true ;
              end;
              if fitafinarcher='right' then
              begin
                secondTimer.enabled:=true ;
              end;
              state:=2;  //after wait state, timer goes always to red state
              soundsignal;  //start sound signal
              viewchangmenuitems;
              viewstateone;
              if ((largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true)) then viewchangestateexchange;
              if (fitafinarcher='left') then
              begin
                if timeperturn.checked=true then
                begin
                  countdowntimer:= redfinal.Value;
                  countdowntimer2:= (orangefinal.Value +greenfinal.value) ;
                end
                else
                begin
                  if Shootoff=0 then
                  begin
                    countdowntimer:= redfinalend.Value;
                    countdowntimer2:= (orangefinalend.Value +greenfinalend.value);
                  end
                  else
                  begin
                    countdowntimer:= redfinalendSO.Value;
                    countdowntimer2:= (orangefinalendSO.Value +greenfinalendSO.value);
                  end;
                end;
              end;
              if (fitafinarcher='right') then
              begin
                if timeperturn.checked=true then
                begin
                  countdowntimer2:= redfinal.Value;
                  countdowntimer:= (orangefinal.Value +greenfinal.value);
                end
                else
                begin
                  if Shootoff=0 then
                  begin
                    countdowntimer2:= redfinalend.Value;
                    countdowntimer:= (orangefinalend.Value +greenfinalend.value) ;
                  end
                  else
                  begin
                    countdowntimer2:= redfinalendSO.Value;
                    countdowntimer:= (orangefinalendSO.Value +greenfinalendSO.value) ;
                  end;
                end;
              end;
              viewicons;
            end;
          end;
          2:begin //no action if state is 2 (red state) because timer has to run till state 3 without intervention.
          end;
          3:begin  //green
            nextfinal;//means all archers in this turn are ready, continue with next turn
          end;
          4:begin  //yellow
            nextfinal; //means all archers in this turn are ready, continue with next turn
          end;
          6:begin
            if (countdowntimer=0) and (countdowntimer2=0) then
            begin
              state:=1;
              viewstateone;
            end
            else
            begin
              if  (timeperturn.Checked) then
              begin
                if (((fitafinarcher='right') and (countdowntimer2<= orangefinal.Value)) or ((fitafinarcher='left') and (countdowntimer<= orangefinal.Value)))then  state:=4 else state:=3;
              end;
              if  (timeperend.Checked) then
              begin
                if (((fitafinarcher='right') and (((countdowntimer2<= orangefinalend.Value)and(Shootoff=0))or((countdowntimer2<= orangefinalendSO.Value)and(Shootoff=1)))) or ((fitafinarcher='left') and (((countdowntimer<= orangefinalend.Value)and(Shootoff=0))or((countdowntimer<= orangefinalendSO.Value)and(Shootoff=1)))))then  state:=4 else state:=3;
              end;
              soundsignal;
            end;
          end;
        end;
      end;
      viewchangestateactive;
      viewactivate;
      TLswitch;
    end
    else  //non-final run
    begin
      if endtimout.Enabled=false then   //prevent doublepress
      if ((FirstTimer.enabled=false)and ((state=2) or (state=3) or (state=4))) then
      begin
        if (stopinbetweenturnsfitacheckbox.Checked) and (archerysystem='fita') then soundsignal;
        playpauze;
      end
       else
      begin
        referencetime:=getcurrenttime; //next key  means new timing start, so need to measure current time from system clock for reference.
        FirstTimer.enabled:=false ; //for a fresh start
        FirstTimer.enabled:=true ;
        case state of
      1:  begin  //wait state, waiting for start signal
            if endtimout.Enabled=false then
            begin
              FirstTimer.enabled:=true ;
              state:=2; //after wait state starts red state
              soundsignal;    //start sound
              viewstateone;
              //time for red is depending on system and stored time
              if (archerysystem='fita') and (Shootoff=0) then
              begin
                if redtime.Value = -1 then
                begin
                  countdowntimer:=0;
                  playpauze;
                end
                else countdowntimer:= redtime.Value;
              end;
              if archerysystem='25m1p' then
              begin
                if redtime1p.Value = -1 then
                begin
                  countdowntimer:=0;
                  playpauze;
                end
                else countdowntimer:= redtime1p.Value;
              end;
              if (archerysystem='fita') and (Shootoff=1) then countdowntimer:= redtimeso.Value;
              viewactivate;
              viewchangestateactive;
              viewchangestateexchange;
              viewicons;
            end;
          end;
      2:  begin //no action if state is 2 (red state) because timer has to run till state 3 without intervention.

          end;
      3:  begin
            finalyzeturn;       // green, ending this turn
          end;
      4:  begin
            finalyzeturn;       // orange, ending this turn
          end;
      5:  begin  //state countdown to start of match    next means start the match
            if endtimout.Enabled=false then   //to prevent double pressing
            begin
              FirstTimer.enabled:=false ;
              FirstTimer.enabled:=true ;
              state:=2;         //next state is red state
              soundsignal;      //activate state
             //red time is depending on system and settings
              if (archerysystem='fita') and (Shootoff=0) then
              begin
                if redtime.Value = -1 then
                begin
                  countdowntimer:=0;
                  playpauze;
                end
                else countdowntimer:= redtime.Value;
              end;
              if archerysystem='25m1p' then
              begin
                if redtime1p.Value = -1 then
                begin
                  countdowntimer:=0;
                  playpauze;
                end
                else countdowntimer:= redtime1p.Value;
              end;
              if (archerysystem='fita') and (Shootoff=1) then countdowntimer:= redtimeso.Value;
              viewactivate;
              viewchangestateinact;
              viewchangestateactive;
              viewchangestateexchange;
            end;
          end;
        End;  {End Case1}
      end;
    end;
  end;
  Checkredblink;
  timedown.Visible:=false;
  timeup.Visible:=false;
end;


procedure TCountdownform.startnextbuttonClick(Sender: TObject);
begin
  next;
end;

procedure TCountdownform.buzzerTimerTimer(Sender: TObject);
//this timer is meant to use for the buszzer. depending on the number of beeps, the buzzer needs to switch on or of after interval of buzzertimer
{$IFDEF Unix}
var

  Player: TProcessUTF8;
  PlayerPath: String;
  PlayerParams: String;
{$ENDIF}
begin  //buzzeron
  if buzzeron=1 then
  begin
    buzzeron:=0;
    if ((nrofbeeps<2) and (state=6) and (KeepbuzzingCheckBox.Checked=true) ) then nrofbeeps:=nrofbeeps else  nrofbeeps:=nrofbeeps-1;

    emergencytext.Visible:=false;
    if nrofbeeps= 0 then alarmstate:=0; // allarmstate (if ther is one) always ends after the last beep
  end
  else
  begin
    buzzeron:=1;
    if alarmstate=1 then  emergencytext.Visible:=true else emergencytext.Visible:=false;

    WavFilename:=PChar(LowerCase(Filespath+'sounds/'+wavbuffer+'.wav'));
   //Writeln(WavFilename);
    if speaker.checked=true then
    begin

    {$IFDEF Windows}
    sndPlaySound(WavFilename, snd_Async or snd_NoDefault);
    {$ENDIF}
    {$IFDEF Darwin}
    if not MacPlayWav(WavFilename) then ShowMessage('Unable to play WAV file');
    {$ENDIF}
    {$IFDEF Unix}{$IFNDEF Darwin}
    begin

           /// SDL Stuff
     wave := Nil;

    wave := Mix_LoadWAV(WavFilename);
    if(wave = Nil) then
    begin
	ShowMessage('Unable to load WAV file');
    end;

    channel := Mix_PlayChannel(-1, wave, 0);
    if(channel = -1) then
    begin
	ShowMessage('Unable to play WAV file');
    end
    end;

    {$ENDIF}{$ENDIF}
    end;
  end;
  switchbox;

  if nrofbeeps =0 then
  begin
    buzzertimer.Enabled:=false;
    if state=1 then viewstateone;
    if ((FirstTimer.Enabled=false) and (secondTimer.Enabled=false)) then
    begin
      if largeimagecheckbox.Checked=true then
      begin
        imagecount:=0;
        if FileExists(imagesListBox.Items.Strings[imagecount])then background1.Picture.LoadFromFile(imagesListBox.Items.Strings[imagecount] );
      end
      else imagecount:=-1;
      if (state =1) and ((largeimagecheckbox.Checked) or (Actualtimecheckbox.Checked)) then timevssheet;
    end;

  end;
end;

procedure TCountdownform.windowsize;
//changes the windowsize (pressed left top button or esc button
begin
if countdownform.borderstyle=bsSizeable then
begin
  countdownform.borderstyle:=bsnone;
  countdownform.WindowState:=wsMaximized;
end
else
begin
  leftalign:=countdownform.Left;
  topalign:=countdownform.Top;
  Countdownform.Width:=640;
  countdownform.Height:=480;
  countdownform.borderstyle:=bsSizeable;
  countdownform.WindowState:=wsnormal;
  countdownform.Left:=leftalign;
  countdownform.Top:=topalign;
end;

end;



procedure TCountdownform.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);

//detect keys pressed on kexboard
begin
  if (Key = VK_SPACE) then next;
  if (Key = VK_TAB) then next;
  if (Key = VK_NEXT) then
  begin
    skitem:= pgdncombox.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_PRIOR) then
  begin
    skitem:= pgupcombox.ItemIndex;
    startshortcut;
  end;
  if (Key = 66) then
  begin
    skitem:= blnkcombox.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_OEM_PERIOD) then
  begin
    skitem:= blnkcombox.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_ESCape) then
  begin
    if prevkey ='esc' then
    begin
      stopemergency; //windowsize;
      prevkey:='none';
    end
    else
    begin
      if prevkey='F5' then
      begin
        skitem:= playcombox.ItemIndex;
        startshortcut;
        prevkey:='none';
      end
      else prevkey:='esc';
    end;
  end;
  if (Key = VK_F5)and (Shift <> [ssShift]) then
  begin
    if prevkey ='F5' then
    begin
      scenario:='F5';
      setvarsettings;
      prevkey:='none';
    end
    else
    begin
      if prevkey='esc' then
      begin
        skitem:= playcombox.ItemIndex;
        startshortcut;
        prevkey:='none';
      end
      else prevkey:='F5';
    end;
  end;

  if (Key = VK_UP) then
  begin
    skitem:= uparrowkeycombo.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_DOWN) then
  begin
    skitem:= downarrowkeycombo.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_RIGHT) then
  begin
    skitem:= rightarrowkeycombo.ItemIndex;
    startshortcut;
  end;
  if (Key = VK_LEFT) then
  begin
    skitem:= leftarrowkeycombo.ItemIndex;
    startshortcut;
  end;

  if (Key = 83) and (timeseqpanel.visible=false) and (savesettings.Visible=false) then stop;
  if ((Key = 80)) and (timeseqpanel.visible=false) and (savesettings.Visible=false) then playpauze;
  if ((Key = 69) )and (timeseqpanel.visible=false) and (savesettings.Visible=false)then stopemergency;

  if (Key = 49) and (Shift = [ssShift])  then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=1;
      state:=2;
      soff;
    end;
  end;

  if (Key = 50) and (Shift = [ssShift])  then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=2;
      state:=2;
      soff;
    end;
  end;

    if (Key = 51) and (Shift = [ssShift])  then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=3;
      state:=2;
      soff;
    end;
  end;
    if (Key = 52) and (Shift = [ssShift])  then
    begin
      if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
      begin
        nrofSOarrows:=4;
        state:=2;
        soff;
      end;
    end;
    if (Key = 53) and (Shift = [ssShift])  then
    begin
      if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
      begin
        nrofSOarrows:=5;
        state:=2;
        soff;
      end;
    end;
    if (Key = 54) and (Shift = [ssShift])  then
    begin
      if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
      begin
        nrofSOarrows:=6;
        state:=2;
        soff;
      end;
    end;


  if (Key = 49) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=1;
      soff;
    end;
  end;
  if (Key = 50) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=2;
      soff;
    end;
  end;
  if (Key = 51) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=3;
      soff;
    end;
  end;
  if (Key = 52) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=4;
      soff;
    end;
  end;
  if (Key = 53) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=5;
      soff;
    end;
  end;
  if (Key = 54) then
  begin
    if (FirstTimer.enabled=false) and  (timeseqpanel.visible=false) and (savesettings.Visible=false) then
    begin
      nrofSOarrows:=6;
      soff;
    end;
  end;

  if (Key = 67) and (timeseqpanel.visible=false) and (savesettings.Visible=false) then
  begin
    if (preptime.Visible=true) then starttostart;
  end;

  if (Key = 72) and (timeseqpanel.visible=false) and (savesettings.Visible=false) then
  begin
    if hideicons.checked=true then hideicons.checked:=false else hideicons.checked:=true;
    hide2;

  end;
  if (Key = 77)  and (timeseqpanel.visible=false) and (savesettings.Visible=false) then
  begin
    if minsec.itemindex=1 then minsec.itemindex:=0 else minsec.itemindex:=1;
  end;
  if (Key = VK_F1) and (Shift = [ssShift]) then
  begin
    scenario:='F1';
    Setsettings;
  end;
  if (Key = VK_F2) and (Shift = [ssShift])  then
  begin
    scenario:='F2';
    Setsettings;
  end;
  if (Key = VK_F3) and (Shift = [ssShift])  then
  begin
    scenario:='F3';
    Setsettings;
  end;
  if (Key = VK_F4) and (Shift = [ssShift])  then
  begin
    scenario:='F4';
    Setsettings;
  end;
  if (Key = VK_F5) and (Shift = [ssShift])  then
  begin
    scenario:='F5';
    Setsettings;
  end;
  if (Key = VK_F6) and (Shift = [ssShift])  then
  begin
    scenario:='F6';
    Setsettings;
  end;
  if (Key = VK_F7) and (Shift = [ssShift])  then
  begin
    scenario:='F7';
    Setsettings;
  end;
  if (Key = VK_F8) and (Shift = [ssShift])  then
  begin
    scenario:='F8';
    Setsettings;
  end;
  if (Key = VK_F9) and (Shift = [ssShift])  then
  begin
    scenario:='F9';
    Setsettings;
  end;
  if (Key = VK_F10) and (Shift = [ssShift])  then
  begin
    scenario:='F10';
    Setsettings;
  end;
  if (Key = VK_F11) and (Shift = [ssShift])  then
  begin
    scenario:='F11';
    Setsettings;
  end;
  if (Key = VK_F12) and (Shift = [ssShift])  then
  begin
    scenario:='F12';
    Setsettings;
  end;
  if (Key = VK_F1)and (Shift <> [ssShift]) then
  begin
    scenario:='F1';
    setvarsettings;
  end;
  if (Key = VK_F2)and (Shift <> [ssShift]) then
  begin
    scenario:='F2';
    setvarsettings;
  end;
  if (Key = VK_F3)and (Shift <> [ssShift]) then
  begin
    scenario:='F3';
    setvarsettings;
  end;
  if (Key = VK_F4)and (Shift <> [ssShift]) then
  begin
    scenario:='F4';
    setvarsettings;
  end;
  if (Key = VK_F6)and (Shift <> [ssShift]) then
  begin
    scenario:='F6';
    setvarsettings;
  end;
  if (Key = VK_F7)and (Shift <> [ssShift]) then
  begin
    scenario:='F7';
    setvarsettings;
  end;
  if (Key = VK_F8)and (Shift <> [ssShift]) then
  begin
    scenario:='F8';
    setvarsettings;
  end;
  if (Key = VK_F9)and (Shift <> [ssShift]) then
  begin
    scenario:='F9';
    setvarsettings;
  end;
  if (Key = VK_F10)and (Shift <> [ssShift]) then
  begin
    scenario:='F10';
    setvarsettings;
  end;
  if (Key = VK_F11)and (Shift <> [ssShift]) then
  begin
    scenario:='F11';
    setvarsettings;
  end;
  if (Key = VK_F12)and (Shift <> [ssShift]) then
  begin
    scenario:='F12';
    setvarsettings;
  end;
  if ((key = VK_END) and (Shift = [ssCtrl])) then
  begin
    Shutdownremotesystem;
  end;

  if ((key = VK_HOME) and (Shift = [ssCtrl])) then
  begin
    shutdownsys;
  end;
end;

procedure TCountdownform.stopbuttonClick(Sender: TObject);
begin
  stop;
end;

procedure TCountdownform.startupdelayTimer(Sender: TObject);

//This timer is meant to use at startup of the program. To be sure fullscreen mode is enabled, and hardware gets connected at startup.

begin
  countdownform.WindowState:=wsMaximized;
  countdownform.borderstyle:=bsnone;
  if arduinoactive_at_init=true then arduinoselect1.Checked := true;

  startupdelay.enabled:=false;
end;

procedure TCountdownform.preclose;
var i,j:longint;
begin
  {$IFDEF Windows}
  if LANselect.Checked then
  begin
    closesystem.Enabled:=true;
    closesystemPanel.Font.Height:=Countdownform.Width div 30;
    closesystemPanel.Top:=0;
    closesystemPanel.Left:=0;
    closesystemPanel.Width:=Countdownform.Width;
    closesystemPanel.Height:=Countdownform.Height;
    closesystemPanel.Visible:=true;
    Shutdownremotesystem;

  end;
  {$ENDIF}
  rcvmcasttimer.Enabled:=false;
  i:=

  1 shl 0+ //trafic light data (not digits)
  0 shl 1+ // 0 is standard red orange green and ABCD. (No ABCD sequence details
  0 shl 2+ //buzzer off
  0 shl 3+ 0 shl 4+ 0 shl 5+ 0 shl 6+ 0 shl 7+ 0 shl 8+ 0 shl 9+ 0 shl 10+ 0 shl 11+ 0 shl 12+ 0 shl 13+     //traffic lamps and ABCD lamps off
  0 shl 14+ 0 shl 15 //nr archers 0
;
  j:=
  0 shl 0+ //digits data (traffic lights)
  0 shl 1+ 1 shl 2+ //buzzer offboth sides
  0 shl  3+    //no dots
  0 shl  4+ 1 shl  5+ 0 shl  6+ 1 shl  7+ //right digit
  0 shl  8+ 1 shl  9+ 0 shl 10+ 1 shl 11+ //middle digit
  0 shl 12+ 1 shl 13+ 0 shl 14+ 1 shl 15  //left digit
;
  serial.WriteData(inttostr(i)+chr(13));
  sleep(50);
  serial.WriteData(inttostr(j)+chr(13));
  sleep(50);

{$IFDEF Windows}

  if not DisableOtherFunctionCall then WriteAllDigital(0);
  OutputAnalogChannel(1,0);
  OutputAnalogChannel(2,0);
{$ENDIF}

  sleep(50);
  if closesystem.Enabled=false then Close;


end;
procedure TCountdownform.closeiconClick(Sender: TObject);
begin
  preclose;
end;

procedure TCountdownform.endtimoutTimer(Sender: TObject);
//endtimout is meant to prevent double pressing the space bar or other triggers to go to next archer.
begin
  endtimout.Enabled:=false;
end;

Procedure TCountdownform.connect;
var h,i,j,m:longint;
  lanstringg, RPIstringg:string;
  PortsMissing:string; //Mac: serial ports that could not be opened
begin

  h:=-1;
 {$IFDEF Windows}  //K8055 not yet supported by linux
  if K8055select.Checked=true then

  begin
    connect_switch_delay.Enabled:=true;
    USBconnect.Caption:=Connectingstring;
    CardAddr:=0;
    h:= OpenDevice(CardAddr);
    if h=-1 then CardAddr:=1;
    h:= OpenDevice(CardAddr);
    case h of
      0..3:
      begin
        inputtimer.enabled:=true;
        inputtimernext.enabled:=true;
        rememberK8055i:=0;
        rememberK8055E:=0;
        rememberK8055F:=0;
      end;
      -1:
      begin
        inputtimer.enabled:=false;
        inputtimernext.enabled:=false;

      end;
    end;
  end
  else
  begin
    if not DisableOtherFunctionCall then WriteAllDigital(0);
    OutputAnalogChannel(1,0);
    OutputAnalogChannel(2,0);

    CloseDevice;
  end;

  {$ENDIF}
  if (LANselect.Checked=true)or ((archerysystem='follow')and(LANinput.Checked=true)) then lanstringg:='LAN, ' else lanstringg:='';
  if linuxHW='RPI' then RPIstringg:='GPIO, ' else RPIstringg:='';
  if (arduinoselect1.Checked=true) or (arduinoselect2.Checked=true) then
  begin


    PortsMissing:='';
    if arduinoselect1.Checked=true then
    begin
     {$IFDEF Darwin}if not MacOpenPort(serial) then PortsMissing:=PortsMissing+' '+serial.Device;{$ELSE}
     serial.open;{$ENDIF}
    end;
    if arduinoselect2.Checked=true then
    begin
     {$IFDEF Darwin}if not MacOpenPort(serial2) then PortsMissing:=PortsMissing+' '+serial2.Device;{$ELSE}
     serial2.open;{$ENDIF}
    end;

    serialtimestamp.Enabled:=true;
    connect_switch_delay.Enabled:=true;


    inputtimer.enabled:=true;

    if ((h= -1) and (arduinoselect1.Checked=true)) then  USBconnect.Caption:=RPIstringg+lanstringg+Cardstring+' v3 '+Connectedstring;
    if ((h<>-1) and (arduinoselect1.Checked=true)) then  USBconnect.Caption:=RPIstringg+lanstringg+Cardstring+' v2.'+inttostr(h)+', v3 '+Connectedstring;
    {$IFDEF Darwin}
    if PortsMissing<>'' then USBconnect.Caption:='Serial port not found:'+PortsMissing; // Mac: unplugged or wrong port
    {$ENDIF}

  end
  else
  begin
    serialtimestamp.Enabled:=false;
    i:=

    1 shl 0+ //trafic light data (not digits)
    0 shl 1+ // 0 is standard red orange green and ABCD. (No ABCD sequence details
    0 shl 2+ //buzzer off
    0 shl 3+ 0 shl 4+ 0 shl 5+ 0 shl 6+ 0 shl 7+ 0 shl 8+ 0 shl 9+ 0 shl 10+ 0 shl 11+ 0 shl 12+ 0 shl 13+     //traffic lamps and ABCD lamps off
    0 shl 14+ 0 shl 15 //nr archers 0

   ;

    m:=   //end details

    1 shl 0+
    1 shl 1+
    1 shl 2+
    0 shl 3+
    0 shl  4+ 1 shl  5+ 0 shl  6+ 1 shl  7+
    0 shl  8+ 1 shl  9+ 0 shl 10+ 1 shl 11+
    0 shl 12+ 1 shl 13+ 0 shl 14+ 1 shl 15

   ;

    j:=
    0 shl 0+ //digits data (traffic lights)
    0 shl 1+ 1 shl 2+ //buzzer offboth sides
    0 shl  3+    //no dots
    0 shl  4+ 1 shl  5+ 0 shl  6+ 1 shl  7+ //right digit
    0 shl  8+ 1 shl  9+ 0 shl 10+ 1 shl 11+ //middle digit
    0 shl 12+ 1 shl 13+ 0 shl 14+ 1 shl 15  //left digit

    ;
    if arduinoselect1.Checked=false then
    begin
      serial.WriteData(inttostr(i)+chr(13));
      sleep(25);
      serial.WriteData(inttostr(j)+chr(13));
      sleep(25);
      serial.WriteData(inttostr(m)+chr(13));
      sleep(25);
      serial.Close;
    end;
    if arduinoselect2.Checked=false then
    begin
      serial2.WriteData(inttostr(i)+chr(13));
      sleep(25);
      serial2.WriteData(inttostr(j)+chr(13));
      sleep(25);
      serial2.WriteData(inttostr(m)+chr(13));
      sleep(25);
      serial2.Close;
    end;



    //serial.Active:=false;

    if (h= -1) then
    begin
      {$IFDEF Windows}



      inputtimer.enabled:=false;
     {$ENDIF}
      if (RPIstringg='') and (lanstringg='') then USBconnect.Caption:=Cardnotfoundstring else USBconnect.Caption:=RPIstringg+lanstringg;
    end
    else
    begin
      inputtimer.enabled:=true;
      USBconnect.Caption:=RPIstringg+lanstringg+Cardstring+' v2.'+ inttostr(h) +' '+Connectedstring;
    end;
  end;


end;


procedure TCountdownform.hide;
begin
  if hideicons.checked=true then hideicons.checked:=false else hideicons.checked:=true;
end;





procedure TCountdownform.hide2;
begin
  if hideicons.checked=true then
  begin
    SOicon.visible:=false;
    nexticon.visible:=false;
    playpauzeicon.Visible:=false;
    stopicon.Visible:=false;

    resizeicon.Visible:=false;
    tup.Visible:=false;
    tdown.Visible:=false;
    enddown.Visible:=false;
    endup.Visible:=false;

    turnlabel.Visible:=false;
    serielabel.Visible:=false;
    arrowlabel.Visible:=false;
    shooternr.Visible:=false;
    USBconnect.Visible:=false;
    USB.Visible:=false;
  end
  else
  begin
    clockicon.Visible:=true;
    settings.Visible:=true;
    resizeicon.Visible:=true;
    closeicon.Visible:=true;
    {$IFDEF Unix}
    If linuxHW='RPI' then shutdownicon.Visible:=true;
    {$ENDIF}
    if (archerysystem <> 'manual') and (archerysystem<>'follow') then
    begin
      nexticon.visible:=true;
      playpauzeicon.Visible:=true;
      stopicon.Visible:=true;
      tup.Visible:=true;
      tdown.Visible:=true;
      enddown.Visible:=true;
      endup.Visible:=true;
      danger.Visible:=true;
      if archerysystem<>'fitafin'then turnlabel.Visible:=true;
      if archerysystem='fita' then serielabel.Visible:=true;
      if archerysystem='25m1p' then arrowlabel.Visible:=true;
      if archerysystem<>'fitafin'then shooternr.Visible:=true;
    end;
    USBconnect.Visible:=true;
    USB.Visible:=true;
    viewicons;
    viewstateone;
  end;
end;


procedure TCountdownform.dots_1Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectleftarcher else hide;
end;

procedure TCountdownform.digit2_1Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectleftarcher else hide;
end;

procedure TCountdownform.digit1_1Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectleftarcher else
   begin
     if hideicons.checked=true then hideicons.checked:=false else hideicons.checked:=true;
     hide2;
   end;
end;

procedure TCountdownform.USBconnectClick(Sender: TObject);
begin
  connect;
end;

procedure TCountdownform.inputtimerTimer(Sender: TObject);
var k, fileDesc: longint;
  buttonStatus: string[1] ='1';

  //inputtimer is meant to read the button in the external hardware and prevent 'dendering'
  //the next button has a separate timer
begin
  inputtimer.Enabled:=false;
  inputtimer.Interval:=50;

  {$IFDEF Windows}

  k:=ReadAllDigital;
  if  (k and 1)>0 then
  begin
    if archerysystem<>'manual' then
    begin
      skitem:= comboxK8055but1.ItemIndex;
      startshortcut;
    end
    else
    begin
      case HWbutton1.ItemIndex of
        0: setred;
        1: setorange;
        2: setgreen;
        3: onebeep;
        4: twobeeps;
        5: threebeeps;
        6: stopemergency;
      end;
    end;
    inputtimer.Interval:=350;
  end;
  if  (k and 2)>0 then
  begin
    if archerysystem<>'manual' then
    begin
      skitem:= comboxK8055but2.ItemIndex;
      startshortcut;
    end
    else
    begin
      case HWbutton2.ItemIndex of
        0: setred;
        1: setorange;
        2: setgreen;
        3: onebeep;
        4: twobeeps;
        5: threebeeps;
        6: stopemergency;
      end;
    end;
    inputtimer.Interval:=350;
  end;
  if  (k and 4)>0 then
  begin
    if archerysystem='manual' then
    begin
      case HWbutton3.ItemIndex of
        0: setred;
        1: setorange;
        2: setgreen;
        3: onebeep;
        4: twobeeps;
        5: threebeeps;
        6: stopemergency;
      end;
    end;
    inputtimer.Interval:=350;
  end;
  if  (k and 8)>0 then
  begin
    if archerysystem<>'manual' then
    begin
      skitem:= comboxK8055but4.ItemIndex;
      startshortcut;
    end
    else
    begin
      case HWbutton4.ItemIndex of
        0: setred;
        1: setorange;
        2: setgreen;
        3: onebeep;
        4: twobeeps;
        5: threebeeps;
        6: stopemergency;
      end;
    end;
    inputtimer.Interval:=350;
  end;
  if  (k and 16)>0 then
  begin
    if archerysystem<>'manual' then
    begin
      skitem:= comboxK8055but5.ItemIndex;
      startshortcut;
    end
    else
    begin
      case HWbutton5.ItemIndex of
        0: setred;
        1: setorange;
        2: setgreen;
        3: onebeep;
        4: twobeeps;
        5: threebeeps;
        6: stopemergency;
      end;
    end;
    inputtimer.Interval:=350;
  end;
 {$ENDIF}

 {$IFDEF Unix}
//  fileDesc := fpopen('/sys/class/gpio/gpio18/value', O_RdOnly);
  fileDesc := fpopen('/sys/class/gpio/gpio6/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '0' then
        stop;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio13/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
      begin
        skitem:= comboxpn33.ItemIndex;
        startshortcut;
      end;

    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio19/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn35.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio26/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn37.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio12/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn32.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio16/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn36.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio20/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn38.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);
  fileDesc := fpopen('/sys/class/gpio/gpio21/value', O_RdOnly);
  if fileDesc > 0 then
    begin
      { Read status of this pin (0: button pressed, 1: button released): }
      gReturnCode := fpread(fileDesc, buttonStatus[1], 1);
      if buttonStatus = '1' then
        begin
          skitem:= comboxpn40.ItemIndex;
          startshortcut;
        end;
    end;
  fpclose(fileDesc);


  inputtimer.Interval:=350;
 {$ENDIF}
 inputtimer.Enabled:=true;
end;

procedure TCountdownform.inputtimernextTimer(Sender: TObject);
var k : longint;
begin
 inputtimernext.Enabled:=false;
{$IFDEF Windows}
  k:=ReadAllDigital;

  if  (k and 4)>0 then
  begin
    if archerysystem<>'manual' then
    begin
      skitem:= comboxK8055but3.ItemIndex;
      startshortcut;
    end
  end;
  {$ENDIF}
  inputtimernext.Enabled:=true;
end;

procedure TCountdownform.usbClick(Sender: TObject);
begin
  connect;
end;

procedure TCountdownform.Shooter2Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if Archersperturn=1 then turnnumber:=2 else turnnumber:=1 ;
    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.Shooter4Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if Archersperturn=1 then turnnumber:=4 else turnnumber:=2 ;
    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.Shooter3Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if Archersperturn=1 then turnnumber:=3;
    if Archersperturn=2 then turnnumber:=2;
    if Archersperturn=3 then turnnumber:=1;

    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.Shooter1Click(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    turnnumber:=1;
    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.greentimesoChange(Sender: TObject);
begin
  totaltimeso.Caption:= inttostr( trunc(orangetimeso.value)+trunc(greentimeso.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangetimesoChange(Sender: TObject);
begin
  totaltimeso.Caption:= inttostr( trunc(orangetimeso.value)+trunc(greentimeso.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.greentime1pChange(Sender: TObject);
begin
  totaltime1p.Caption:= inttostr( trunc(orangetime1p.value)+trunc(greentime1p.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangetime1pChange(Sender: TObject);
begin
  totaltime1p.Caption:= inttostr( trunc(orangetime1p.value)+trunc(greentime1p.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.nrof1pshootersChange(Sender: TObject);
begin
  if onepijl.checked=true then
  begin
    startupscenario.Text:='--';
    Shooters:=nrof1pshooters.Value;
    Turnsperserie:=nrof1pshooters.Value;
    if turnnumber > nrof1pshooters.Value then  turnnumber:=nrof1pshooters.Value;

    viewturnchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.SOiconClick(Sender: TObject);
begin
  if (FirstTimer.enabled=false) then
  begin
    nrofSOarrows:=1;
    soff;
  end;

end;

procedure TCountdownform.shooteronearrownrClick(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    upturn;
  end;
end;

procedure TCountdownform.shooteronearrowClick(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    downturn;
  end;
end;

procedure TCountdownform.showseq;
begin
  if topbot.checked=true then
  begin
    fitaseq:='T-B';
    if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
  end;

  if oneone.checked=true then
  begin
    fitaseq:='A';
    fitaseq2:='A';
  end;
  if onetwo.checked=true then
  begin
    fitaseq:='A-B';
    if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
  end;
  if onethree.checked=true then
  begin
    fitaseq:='A-B-C';
    if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
  end;
  if onefour.checked=true then
  begin
    fitaseq:='A-B-C-D';
    if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
  end;
  if onefive.checked=true then
  begin
    fitaseq:='A-B-C-D-E';
    if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
  end;
  if onesix.checked=true then
  begin
    fitaseq:='A-B-C-D-E-F';
    if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
  end;

  if twotwo.checked=true then
  begin
    fitaseq:='AB-CD';
    if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
  end;
  if twothree.checked=true then
  begin
    fitaseq:='AB-CD-EF';
    if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
  end;
  if threetwo.checked=true then
  begin
    fitaseq:='ABC-DEF';
    if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
  end;

  if dbltime.checked=true then doubleseq.caption:= Concat('[',fitaseq,']');
  if dblturn.checked=true then doubleseq.caption:= Concat('[',fitaseq,'-',fitaseq,']');
  resizewindownonfinals;
end;
procedure TCountdownform.showtime;

begin
  if dbltime.checked=true then duration :=Concat( inttostr((greentime.value)+(orangetime.value)+(greentime.value)+(orangetime.value)),' sec. ');
  if dblturn.checked=true then duration :=Concat( inttostr((greentime.value)+(orangetime.value)),' sec. ');
  if Turnsperserie=2 then duration := Concat(duration,'+',duration);
  if Turnsperserie=3 then duration := Concat(duration,'+',duration,'+',duration);
  if Turnsperserie=4 then duration := Concat(duration,'+',duration,'+',duration,'+',duration);
  if Turnsperserie=5 then duration := Concat(duration,'+',duration,'+',duration,'+',duration,'+',duration);
  if Turnsperserie=6 then duration := Concat(duration,'+',duration,'+',duration,'+',duration,'+',duration,'+',duration);
  if dbltime.checked=true then doubletime.caption:= Concat('(',duration,')');
  if dblturn.checked=true then doubletime.caption:= Concat('(',duration,'+',duration,')');
end;

procedure TCountdownform.doubleturnsClick(Sender: TObject);
begin
  if doubleturns.checked=true then
  begin
    dbltime.Visible:=true;
    dblturn.Visible:=true;
    doubleseq.Visible:=true;
    doubletime.Visible:=true;
    groupsign.Visible:=true;
    nrofturns:=2;
    if dblturn.Checked=true then
    begin
      times:=1;
      turnsss:=2
    end;
    if dbltime.Checked=true then
    begin
      times:=2;
      turnsss:=1
    end;
  end
  else
  begin
    dbltime.Visible:=false;
    dblturn.Visible:=false;
    doubleseq.Visible:=false;
    doubletime.Visible:=false;
    groupsign.Visible:=false;
    nrofturns:=1;
    times:=1;
    turnsss:=1
  end;
  showseq;
  showtime;
  startupscenario.Text:='--';
  viewturnchange;
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: make room for the double ends choices, or close the gap
end;

procedure TCountdownform.resizeiconClick(Sender: TObject);
begin
  windowsize;
end;



procedure TCountdownform.websitenameClick(Sender: TObject);
begin
  next;
end;

procedure TCountdownform.archeryclockClick(Sender: TObject);
begin
  next;
end;
Procedure TCountdownform.MinSecselection;
Begin
  if minsec.ItemIndex=1 then minutes.Checked:=true else seconds.Checked:=true;
  if archerysystem<>'fitafin'then resizewindownonfinals else resizewindowfinals;
  if minsec.ItemIndex=0 then
  begin
    zerosec.Enabled:=true;
    nonzerosec.Enabled:=true;
  end
  else
  begin
    zerosec.Enabled:=false;
    nonzerosec.Enabled:=false;
  end;
  viewactivate;
end;

procedure TCountdownform.minsecClick(Sender: TObject);
begin
  MinSecselection;
end;
Procedure TCountdownform.Setsystemsettings;
begin
  AssignFile(settingsfile, Filespath+'settings') ;
  ReWrite(settingsfile) ;
  writeln(settingsfile,lang.text) ;
  if minsec.itemindex=0 then writeln(settingsfile,'Sec')else Writeln(settingsfile,'Min');
  if hideicons.checked=true then writeln(settingsfile,'Hide')else Writeln(settingsfile,'nonHide');
  if speaker.checked=true then writeln(settingsfile,'Buzzer')else Writeln(settingsfile,'nonBuzzer');
  writeln(settingsfile,startupscenario.text) ;
  if showhints.checked=true then writeln(settingsfile,'Hint')else Writeln(settingsfile,'nonHint');
  if usetraffic.checked=true then writeln(settingsfile,'TL')else Writeln(settingsfile,'nonTL');
  if TLleft.checked=true then writeln(settingsfile,'TLleft')else Writeln(settingsfile,'TLright');
  writeln(settingsfile,soundselect.text) ;
  writeln(settingsfile,tostart.value) ;
  if K8055select.Checked=true then writeln(settingsfile,'K8055')else writeln(settingsfile,'nonK8055');
  writeln(settingsfile,serialport1.Text);
  if arduinoselect1.Checked=true then writeln(settingsfile,'arduino1')else writeln(settingsfile,'nonarduino1');
  if precountalways.Checked=true then writeln(settingsfile,'PRECOUNT')else writeln(settingsfile,'noPRECOUNT');
  writeln(settingsfile, inttostr(portnumber1.value));
  if LANselect.Checked=true then writeln(settingsfile,'LAN')else writeln(settingsfile,'nonLAN');
  writeln(settingsfile,IP1.value);
  writeln(settingsfile,IP2.value);
  writeln(settingsfile,IP3.value);
  writeln(settingsfile,IP4.value);
  writeln(settingsfile,serialport2.Text);
  if arduinoselect2.Checked=true then writeln(settingsfile,'arduino2')else writeln(settingsfile,'nonarduino2');
  writeln(settingsfile,pgupcombox.ItemIndex);
  writeln(settingsfile,pgdncombox.ItemIndex);
  writeln(settingsfile,playcombox.ItemIndex);
  writeln(settingsfile,blnkcombox.ItemIndex);
  writeln(settingsfile,comboxpn32.ItemIndex);
  writeln(settingsfile,comboxpn36.ItemIndex);
  writeln(settingsfile,comboxpn38.ItemIndex);
  writeln(settingsfile,comboxpn40.ItemIndex);
  writeln(settingsfile,comboxpn33.ItemIndex);
  writeln(settingsfile,comboxpn35.ItemIndex);
  writeln(settingsfile,comboxpn37.ItemIndex);
  if colorscheme1.Checked=true then writeln(settingsfile,'col1');
  if colorscheme2.Checked=true then writeln(settingsfile,'col2');
  if colorscheme3.Checked=true then writeln(settingsfile,'col3');
  if colorscheme4.Checked=true then writeln(settingsfile,'col4');
  if colorscheme5.Checked=true then writeln(settingsfile,'col5');
  if colorscheme6.Checked=true then writeln(settingsfile,'col6');
  if colorscheme7.Checked=true then writeln(settingsfile,'col7');
  if colorscheme8.Checked=true then writeln(settingsfile,'col8');
  if colorscheme9.Checked=true then writeln(settingsfile,'col9');
  writeln(settingsfile,comboxK8055but1.ItemIndex);
  writeln(settingsfile,comboxK8055but2.ItemIndex);
  writeln(settingsfile,comboxK8055but3.ItemIndex);
  writeln(settingsfile,comboxK8055but4.ItemIndex);
  writeln(settingsfile,comboxK8055but5.ItemIndex);
  if Lanremoteselect.Checked=true then writeln(settingsfile,'remote')else writeln(settingsfile,'nonremote');
  writeln(settingsfile, pwstring.Text);
  writeln(settingsfile, magnification.Value);
  if Fbutonscreenbox.Checked=true then writeln(settingsfile, 'FonScreen') else writeln(settingsfile, 'Fnotscreen');
  writeln(settingsfile, EmergencytxtEdit.Text);
  if EmergencydefaultRadioButton.Checked=true then writeln(settingsfile,'def') else writeln(settingsfile,'alt');
  If Pause_emergency_RadioButton.Checked=true then buffer:='pause';
  If Stop_current_RadioButton.Checked=true then buffer:='current';
  If Stop_next_RadioButton.Checked=true then buffer:='next';
  writeln(settingsfile, buffer);
  writeln(settingsfile, minnrbeeps.Value);
  If KeepbuzzingCheckBox.Checked=true then  writeln(settingsfile,'keep') else writeln(settingsfile,'notkeep');
  If zerosec.Checked=true then writeln(settingsfile,'zero') else writeln(settingsfile,'nonzero');
  writeln(settingsfile, colortostring(PrepColListBoxbg.Selected));
  writeln(settingsfile, colortostring(PrepColListBoxtime.Selected));
  writeln(settingsfile, colortostring(retrColListBoxbg.Selected));
  writeln(settingsfile, colortostring(retrColListBoxtime.Selected));
  writeln(settingsfile, colortostring(RedColListBoxbg.Selected));
  writeln(settingsfile, colortostring(RedColListBoxtime.Selected));
  writeln(settingsfile, colortostring(GrnColListBoxbg.Selected));
  writeln(settingsfile, colortostring(GrnColListBoxtime.Selected));
  writeln(settingsfile, colortostring(OrColListBoxbg.Selected));
  writeln(settingsfile, colortostring(OrColListBoxtime.Selected));
  writeln(settingsfile, colortostring(ABColListBoxtime.Selected));
  writeln(settingsfile, colortostring(CDColListBoxtime.Selected));
  writeln(settingsfile, timecheckbox.Checked);
  writeln(settingsfile, am24.ItemIndex);
  if defaultbannerRadioButton.Checked then writeln(settingsfile, 'standard') else  writeln(settingsfile, 'nonstandard');
  writeln(settingsfile, specificbannerpath.Caption);
  if largeimagecheckbox.Checked then writeln(settingsfile, 'slides') else  writeln(settingsfile, 'nonslides') ;
  if fullscreencheckbox.Checked then writeln(settingsfile, 'fullscreen') else  writeln(settingsfile, 'nonfullscreen') ;
  writeln(settingsfile, slidetime.Value);
  writeln(settingsfile, RemshutdownCheckBox.Checked);
  writeln(settingsfile, showendnrcheckbox.Checked);
  if prelayoutradio1.Checked=true then writeln(settingsfile, 'prelayout1') else writeln(settingsfile, 'prelayout2');
  if VLCradiobutton.Checked=true then writeln(settingsfile, 'VLC');
  writeln(settingsfile, AudioIPedit.Caption);
  writeln(settingsfile, inttostr(Audioportnumber.Value));
  writeln(settingsfile, inttostr(volumestate1.Value));
  if Playstate1.Checked=true then writeln(settingsfile,'play');
  if Pausestate1.Checked=true then writeln(settingsfile,'pause');
  if Stopstate1.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile, inttostr(volumestate2.Value));
  if Playstate2.Checked=true then writeln(settingsfile,'play');
  if Pausestate2.Checked=true then writeln(settingsfile,'pause');
  if Stopstate2.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile, inttostr(volumestate3.Value));
  if Playstate3.Checked=true then writeln(settingsfile,'play');
  if Pausestate3.Checked=true then writeln(settingsfile,'pause');
  if Stopstate3.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile, inttostr(volumestate4.Value));
  if Playstate4.Checked=true then writeln(settingsfile,'play');
  if Pausestate4.Checked=true then writeln(settingsfile,'pause');
  if Stopstate4.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile, inttostr(volumestate5.Value));
  if Playstate5.Checked=true then writeln(settingsfile,'play');
  if Pausestate5.Checked=true then writeln(settingsfile,'pause');
  if Stopstate5.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile, inttostr(volumestate6.Value));
  if Playstate6.Checked=true then writeln(settingsfile,'play');
  if Pausestate6.Checked=true then writeln(settingsfile,'pause');
  if Stopstate6.Checked=true then writeln(settingsfile,'stop');
  writeln(settingsfile,booltostr(Controlaudiocheckbox.Checked));
  writeln(settingsfile, am24_2.ItemIndex);
  writeln(settingsfile,booltostr(Actualtimecheckbox.Checked)); //if Actualtimecheckbox.Checked=true then writeln(settingsfile,'showtimeslide') else writeln(settingsfile,'notimeslide');
  writeln(settingsfile,leftarrowkeycombo.ItemIndex);
  writeln(settingsfile,rightarrowkeycombo.ItemIndex);
  writeln(settingsfile,uparrowkeycombo.ItemIndex);
  writeln(settingsfile,downarrowkeycombo.ItemIndex);
  CloseFile(settingsfile) ;
  if startupscenario.text='--' then
  begin
    Fstore:='gen';
    storeF;
  end;
end;

procedure TCountdownform.saveClick(Sender: TObject);
//save settings to settings file
begin
   Setsystemsettings;
end;

procedure TCountdownform.LangChange(Sender: TObject);
begin
  buffer:=lang.Text ;
  setlanguage;
end;

procedure TCountdownform.settingsClick(Sender: TObject);
//show or hide the settings menu
begin
  manualfollowmenuremove:=false;
  if savesettings.visible=true then
  begin
    savesettings.Visible:=false;
    manualcolorpanel.Visible:=false;
  end
  else
  begin
    savesettings.Visible:=true;
    if (SettingsTabs.ActivePage=screencolor) and (colorscheme9.Checked=true) then manualcolorpanel.Visible:=true else manualcolorpanel.Visible:=false;;
    timeseqpanel.visible:=false ;
    //screenwidth:=Countdownform.Width-640;
    //menuscreensize;
  end;
  menuscreensize;
  menuremovesec:=10;
  menudisap1.Visible:=false;
  cdmenu.Visible:=false;
  disapsec1.Visible:=false;
  menudisap2.Visible:=false;
  cdmenu2.Visible:=false;
  disapsec2.Visible:=false;
  viewchangmenuitems;
end;

procedure TCountdownform.closeimage2Click(Sender: TObject);
begin
  savesettings.Visible:=false;
  manualcolorpanel.Visible:=false;
  menuscreensize;
  viewchangmenuitems;
end;

procedure TCountdownform.hideiconsClick(Sender: TObject);
begin
Hide2;
end;
Procedure TCountdownform.Setsettings;
//set the correct scenario settings
begin
  ABCDperEND.checked:=false;
  PABCDperEND.checked:=false;
  If (scenario='F1') or (scenario='F2') or(scenario='F3') or(scenario='F4') or(scenario='F5') or(scenario='F6') or(scenario='F7') then
  begin
    FITA.Checked:=true;
    greentime.Value:=90;
    orangetime.Value:=30;
    redtime.Value:=10;
    greentimeso.Value:=10;
    orangetimeso.Value:=30;
    redtimeso.Value:=10;
    practiseturns.Value:=2;

  end;
  If (scenario='F1') or (scenario='F2') or(scenario='F3') or(scenario='F4') or(scenario='F5') then
  begin
    doubleturns.Checked:=false;
  end;
  If (scenario='F6') or (scenario='F7') then
  begin
    twotwo.checked:=true;
    doubleturns.Checked:=true;
  end;
  If (scenario='F8') or (scenario='F9') then
  begin
    FITAFIN.Checked:=true;
    finarrow.Checked:=true;
  end;
  If (scenario='F10') or (scenario='F11') or (scenario='F12') then
  begin
    onepijl.checked:=true;
    greentime1p.Value:=30;
    orangetime1p.Value:=15;
    redtime1p.Value:=10;
  end;
  If (scenario='F1') then
  begin
    oneone.checked:=true;
    startupscenario.Text:='shiftF1';
  end;
  If (scenario='F2') then
  begin
    onetwo.checked:=true;
    startupscenario.Text:='shiftF2';
  end;
  If (scenario='F3') then
  begin
    onethree.checked:=true;
    startupscenario.Text:='shiftF3';
  end;
  If (scenario='F4') then
  begin
    onefour.checked:=true;
    startupscenario.Text:='shiftF4';
  end;
  If (scenario='F5') then
  begin
    twotwo.checked:=true;
    startupscenario.Text:='shiftF5';
  end;
  If (scenario='F6') then
  begin
    dblturn.Checked:=true;
    startupscenario.Text:='shiftF6';
  end;
  If (scenario='F7') then
  begin
    dbltime.Checked:=true;
    startupscenario.Text:='shiftF7';
  end;
  If (scenario='F8') then
  begin
    timeperturn.Checked:=true;
    startupscenario.Text:='shiftF8';
    finalturns.Value:=3;
    greenfinal.Value:=20;
    orangefinal.Value:=0;
    redfinal.Value:=10;
  end;
  If (scenario='F9') then
  begin
    timeperend.Checked:=true;
    startupscenario.Text:='shiftF9';
    finalteamturns.Value:=2;
    greenfinalend.Value:=90;
    orangefinalend.Value:=30;
    redfinalend.Value:=10;
  end;
  If (scenario='F10') then
  begin
    nrof1pshooters.value:=4;
    startupscenario.Text:='shiftF10';
  end;
  If (scenario='F11') then
  begin
    nrof1pshooters.value:=5;
    startupscenario.Text:='shiftF11';
  end;
  If (scenario='F12') then
  begin
    nrof1pshooters.value:=6;
    startupscenario.Text:='shiftF12';
  end;
  initsystemtype;
end;


procedure TCountdownform.F1ButtonClick(Sender: TObject);
begin
  scenario:='F1';
  Setsettings;
end;


procedure TCountdownform.F2ButtonClick(Sender: TObject);
begin
  scenario:='F2';
  Setsettings;
end;

procedure TCountdownform.F3ButtonClick(Sender: TObject);
begin
  scenario:='F3';
  Setsettings;
end;

procedure TCountdownform.F4ButtonClick(Sender: TObject);
begin
  scenario:='F4';
  Setsettings;
end;

procedure TCountdownform.F5ButtonClick(Sender: TObject);
begin
  scenario:='F5';
  Setsettings;
end;

procedure TCountdownform.F6ButtonClick(Sender: TObject);
begin
  scenario:='F6';
  Setsettings;
end;

procedure TCountdownform.F7ButtonClick(Sender: TObject);
begin
  scenario:='F7';
  Setsettings;
end;

procedure TCountdownform.F8ButtonClick(Sender: TObject);
begin
  scenario:='F8';
  Setsettings;
end;

procedure TCountdownform.F9ButtonClick(Sender: TObject);
begin
  scenario:='F9';
  Setsettings;
end;

procedure TCountdownform.F10ButtonClick(Sender: TObject);
begin
  scenario:='F10';
  Setsettings;
end;

procedure TCountdownform.F11ButtonClick(Sender: TObject);
begin
  scenario:='F11';
  Setsettings;
end;

procedure TCountdownform.F12ButtonClick(Sender: TObject);
begin
  scenario:='F12';
  Setsettings;
end;

procedure TCountdownform.practiseturnsChange(Sender: TObject);
begin
  if (Practiseturns.value< serienumber)   and (Practiseturn =1) then
  if (Practiseturns.value=0) then Practiseturn :=0 else
  begin
    Practiseturn:=1;
    serienumber:=Practiseturns.value;
  end;
  startupscenario.Text:='--';
  viewturnchange;
end;

procedure TCountdownform.startupscenarioChange(Sender: TObject);
begin
  buffer:=startupscenario.Text;
  changescenario;
end;


Procedure TCountdownform.getsetting;
//read the settings from file
begin
   Reset(scenariotextfile) ;
   ReadLn(scenariotextfile, archerysystem) ;
   if archerysystem='25m1p' then
   begin
     onepijl.Checked:=true;
   end;
   if archerysystem='fita' then
   begin
     FITA.Checked:=true;
   end;
   if archerysystem='fitafin' then
   begin
     FITAFIN.Checked:=true;
   end;
   if archerysystem='manual' then
   begin
     manual.Checked:=true;
   end;
   if archerysystem='follow' then
   begin
     follow.Checked:=true;
   end;
   ReadLn(scenariotextfile, buffer) ;  //Fitafinal or fita/25m1p
   ReadLn(scenariotextfile, fitamode) ;
   if fitamode=0 then topbot.checked:=true;
   if fitamode=1 then oneone.checked:=true;
   if fitamode=2 then onetwo.checked:=true;
   if fitamode=3 then onethree.checked:=true;
   if fitamode=4 then onefour.checked:=true;
   if fitamode=5 then twotwo.checked:=true;
   if fitamode=6 then onefive.checked:=true;
   if fitamode=7 then onesix.checked:=true;
   if fitamode=8 then twothree.checked:=true;
   if fitamode=9 then threetwo.checked:=true;

   readln(scenariotextfile,nrofturns); //double turn or not?
   if nrofturns=1 then doubleturns.checked:=false else doubleturns.checked:=true;

   readln(scenariotextfile,buffer); //seconds green fita system
   greentime.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds orange fita system
   orangetime.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds red fita system
   redtime.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds greeen for Fita shootoff
   greentimeso.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds orange for Fita shootoff
   orangetimeso.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds red for Fita shootoff
   redtimeso.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds green for  25m1p system
   greentime1p.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds orange for 25m1p system
   orangetime1p.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //seconds red for 25m1p system
   redtime1p.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); // nr of practise arrows Fita
   practiseturns.Value:=StrToInt(buffer);
   if (practiseturns.Value=0) and (archerysystem='fita') then Practiseturn :=0;
   readln(scenariotextfile,buffer); //nr of archers per target 25m1p
   if archerysystem='25m1p' then nrof1pshooters.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); // single or double turns (long distances?)
   if buffer = 'TRUE' then doubleturns.checked:=true else doubleturns.Checked:=false;
   readln(scenariotextfile,buffer); // single or double time
   if buffer = 'TRUE' then dbltime.checked:=true else dbltime.checked:= false;
   readln(scenariotextfile,buffer); // single or double turns
   if buffer = 'TRUE' then dblturn.checked:=true else dblturn.Checked:=false;

   readln(scenariotextfile,buffer); //

   if buffer<>'' then showtarget.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then finarrow.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   //if buffer<>'' then finname.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then timeperturn.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then timeperend.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then leftnumber.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then rightnumber.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then finalturns.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then finalteamturns.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then greenfinal.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then orangefinal.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then redfinal.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then greenfinalend.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then orangefinalend.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then redfinalend.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then BCDtoROG2.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then abcd25m1p.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   ABCDperEND.checked:=false;
   if buffer<>'' then ABCDperEND.checked:=StrToBool(buffer); //

   readln(scenariotextfile,buffer); //
   if buffer<>'' then nrredbuzz.Value:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then nrorangebuzz.Value:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then nrgreenbuzz.Value:=StrToint(buffer);

   readln(scenariotextfile,buffer); //
   if buffer<>'' then HWbutton1.ItemIndex:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then HWbutton2.ItemIndex:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then HWbutton3.ItemIndex:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then HWbutton4.ItemIndex:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   if buffer<>'' then HWbutton5.ItemIndex:=StrToint(buffer);
   readln(scenariotextfile,buffer); //
   readln(scenariotextfile,buffer); //
   if buffer='right' then rightscreen.Checked:=true else leftscreen.Checked:=true;
   readln(scenariotextfile,buffer); //
   if buffer='followLAN' then LANinput.Checked:=true else serialinput.Checked:=true;
   readln(scenariotextfile,buffer); // nr of practise arrows 25m1p
   nrof1ppractisearrows.Value:=StrToInt(buffer);
   if (nrof1ppractisearrows.Value=0) and (archerysystem='25m1p') then Practiseturn :=0;
   readln(scenariotextfile,buffer); //
   if buffer<>'' then viewleft.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then viewright.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then rotate25m1p.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then fromHOST.Text:=buffer;
   fromhostrefresh.Caption:=fromHOST.Text;
   readln(scenariotextfile,buffer); //
   if buffer<>'' then rotate25m1p_p.checked:=StrToBool(buffer); //
   readln(scenariotextfile,buffer); //
   readln(scenariotextfile,buffer); //
   if buffer<>'' then PABCDperEND.checked:=StrToBool(buffer); //

   readln(scenariotextfile,buffer);
   if buffer<>'' then orangebeepfitacheckbox.Checked:=StrToBool(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then orangebeep25m1pcheckbox.Checked:=StrToBool(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then Blinkphase1CheckBox.Checked:=StrToBool(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then Blinkphase2CheckBox.Checked:=StrToBool(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then greenfinalendso.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then orangefinalendso.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then redfinalendso.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then finalturnsSO.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then finalteamturnsSO.Value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then Beepswitcharcher.Checked:=StrToBool(buffer);
   readln(scenariotextfile,buffer); //repeating ends
   repeatsequence.value:=StrToInt(buffer);
   readln(scenariotextfile,buffer);
   if buffer<>'' then stopinbetweenturnsfitacheckbox.Checked:=StrToBool(buffer);


   connectports;
   CloseFile(scenariotextfile) ;
   if archerysystem='25m1p' then
   begin
      nrofturns:=1;
      times:=1;
      turnsss:=1;
   end;
   resetendnr;

end;
procedure TCountdownform.getscenario;
begin
  if FileExistsUTF8(Filespath+'scenarios/'+scenario)=true then
  begin
    AssignFile(scenariotextfile, Filespath+'scenarios/'+scenario) ;
    getsetting;
  end;
end;



procedure TCountdownform.showF8;    //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F8sequence.Visible:=true;
    varF8SOtimelabel.Visible:=true;
    varF8SOtime.Visible:=true;
    varF8SOredtime.Visible:=true;
    varF8waitlabel2.Visible:=true;
    varF8shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF8SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF8shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF8SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;
    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;

    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF8sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F8sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF8sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F8sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF8sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F8sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF8shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;
  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F8sequence.Visible:=false;
    varF8SOtimelabel.Visible:=false;
    varF8SOtime.Visible:=false;
    varF8SOredtime.Visible:=false;
    varF8waitlabel2.Visible:=false;
    varF8shoottime.caption:='manual';
    varF8shootredtime.caption:='';
    varF8sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F8sequence.Visible:=false;
    varF8SOtimelabel.Visible:=false;
    varF8SOtime.Visible:=false;
    varF8SOredtime.Visible:=false;
    varF8waitlabel2.Visible:=false;
    varF8shoottime.caption:='follow';
    varF8shootredtime.caption:='';
    varF8sequence.Caption:='';
  end;
  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F8sequence.Visible:=false;
    varF8SOtimelabel.Visible:=true;
    varF8SOtime.Visible:=true;
    varF8SOredtime.Visible:=true;
    varF8waitlabel2.Visible:=true;
    varF8shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF8SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF8shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF8SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF8sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F8sequence.Visible:=true;

    if timeperturn.Checked=true then
    begin
      varF8SOtimelabel.Visible:=false;
      varF8SOtime.Visible:=false;
      varF8SOredtime.Visible:=false;
      varF8waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF8shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF8sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F8sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF8shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF8SOtimelabel.Visible:=true;
      varF8SOtime.Visible:=true;
      varF8SOredtime.Visible:=true;
      varF8waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF8shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF8sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F8sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF8shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF8SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF8SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[8]:=char(8 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;


procedure TCountdownform.showF1;    //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F1sequence.Visible:=true;
    varF1SOtimelabel.Visible:=true;
    varF1SOtime.Visible:=true;
    varF1SOredtime.Visible:=true;
    varF1waitlabel2.Visible:=true;
    varF1shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF1SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF1shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF1SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;

    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;

    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;

    if nrofturns=1 then
    begin
      varF1sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F1sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF1sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F1sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF1sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F1sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF1shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F1sequence.Visible:=false;
    varF1SOtimelabel.Visible:=false;
    varF1SOtime.Visible:=false;
    varF1SOredtime.Visible:=false;
    varF1waitlabel2.Visible:=false;
    varF1shoottime.caption:='manual';
    varF1shootredtime.caption:='';
    varF1sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F1sequence.Visible:=false;
    varF1SOtimelabel.Visible:=false;
    varF1SOtime.Visible:=false;
    varF1SOredtime.Visible:=false;
    varF1waitlabel2.Visible:=false;
    varF1shoottime.caption:='follow';
    varF1shootredtime.caption:='';
    varF1sequence.Caption:='';
  end;

  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F1sequence.Visible:=false;
    varF1SOtimelabel.Visible:=true;
    varF1SOtime.Visible:=true;
    varF1SOredtime.Visible:=true;
    varF1waitlabel2.Visible:=true;
    varF1shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF1SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF1shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF1SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF1sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F1sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF1SOtimelabel.Visible:=false;
      varF1SOtime.Visible:=false;
      varF1SOredtime.Visible:=false;
      varF1waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF1shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF1sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F1sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF1shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF1SOtimelabel.Visible:=true;
      varF1SOtime.Visible:=true;
      varF1SOredtime.Visible:=true;
      varF1waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF1shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF1sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F1sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF1shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF1SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF1SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;
  end;
  FBroad[1]:=char(1 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);
end;

procedure TCountdownform.showF2;    //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;

Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;

    var2F2sequence.Visible:=true;
    varF2SOtimelabel.Visible:=true;
    varF2SOtime.Visible:=true;
    varF2SOredtime.Visible:=true;
    varF2waitlabel2.Visible:=true;
    varF2shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF2SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF2shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF2SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';
    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;
    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;
    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;

    if nrofturns=1 then
    begin
      varF2sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F2sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF2sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F2sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF2sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F2sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF2shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;
  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;

    var2F2sequence.Visible:=false;
    varF2SOtimelabel.Visible:=false;
    varF2SOtime.Visible:=false;
    varF2SOredtime.Visible:=false;
    varF2waitlabel2.Visible:=false;
    varF2shoottime.caption:='manual';
    varF2shootredtime.caption:='';
    varF2sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F2sequence.Visible:=false;
    varF2SOtimelabel.Visible:=false;
    varF2SOtime.Visible:=false;
    varF2SOredtime.Visible:=false;
    varF2waitlabel2.Visible:=false;
    varF2shoottime.caption:='follow';
    varF2shootredtime.caption:='';
    varF2sequence.Caption:='';
  end;
  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;

    var2F2sequence.Visible:=false;
    varF2SOtimelabel.Visible:=true;
    varF2SOtime.Visible:=true;
    varF2SOredtime.Visible:=true;
    varF2waitlabel2.Visible:=true;
    varF2shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF2SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF2shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF2SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF2sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F2sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF2SOtimelabel.Visible:=false;
      varF2SOtime.Visible:=false;
      varF2SOredtime.Visible:=false;
      varF2waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF2shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF2sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F2sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF2shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF2SOtimelabel.Visible:=true;
      varF2SOtime.Visible:=true;
      varF2SOredtime.Visible:=true;
      varF2waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF2shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF2sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F2sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF2shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF2SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF2SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[2]:=char(2 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;


procedure TCountdownform.showF3;      //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F3sequence.Visible:=true;
    varF3SOtimelabel.Visible:=true;
    varF3SOtime.Visible:=true;
    varF3SOredtime.Visible:=true;
    varF3waitlabel2.Visible:=true;
    varF3shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF3SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF3shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF3SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;
    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF3sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F3sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF3sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F3sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF3sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F3sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF3shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;
  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F3sequence.Visible:=false;
    varF3SOtimelabel.Visible:=false;
    varF3SOtime.Visible:=false;
    varF3SOredtime.Visible:=false;
    varF3waitlabel2.Visible:=false;
    varF3shoottime.caption:='manual';
    varF3shootredtime.caption:='';
    varF3sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F3sequence.Visible:=false;
    varF3SOtimelabel.Visible:=false;
    varF3SOtime.Visible:=false;
    varF3SOredtime.Visible:=false;
    varF3waitlabel2.Visible:=false;
    varF3shoottime.caption:='follow';
    varF3shootredtime.caption:='';
    varF3sequence.Caption:='';
  end;
  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F3sequence.Visible:=false;
    varF3SOtimelabel.Visible:=true;
    varF3SOtime.Visible:=true;
    varF3SOredtime.Visible:=true;
    varF3waitlabel2.Visible:=true;
    varF3shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF3SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF3shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF3SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF3sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F3sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF3SOtimelabel.Visible:=false;
      varF3SOtime.Visible:=false;
      varF3SOredtime.Visible:=false;
      varF3waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF3shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF3sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F3sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF3shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF3SOtimelabel.Visible:=true;
      varF3SOtime.Visible:=true;
      varF3SOredtime.Visible:=true;
      varF3waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF3shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF3sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F3sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF3shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF3SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF3SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;
  end;
  FBroad[3]:=char(3 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;


procedure TCountdownform.showF4;        //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F4sequence.Visible:=true;
    varF4SOtimelabel.Visible:=true;
    varF4SOtime.Visible:=true;
    varF4SOredtime.Visible:=true;
    varF4waitlabel2.Visible:=true;
    varF4shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF4SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF4shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF4SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;
    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;

    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;
    if nrofturns=1 then
    begin
      varF4sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F4sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF4sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F4sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF4sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F4sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF4shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;
  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F4sequence.Visible:=false;
    varF4SOtimelabel.Visible:=false;
    varF4SOtime.Visible:=false;
    varF4SOredtime.Visible:=false;
    varF4waitlabel2.Visible:=false;
    varF4shoottime.caption:='manual';
    varF4shootredtime.caption:='';
    varF4sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F4sequence.Visible:=false;
    varF4SOtimelabel.Visible:=false;
    varF4SOtime.Visible:=false;
    varF4SOredtime.Visible:=false;
    varF4waitlabel2.Visible:=false;
    varF4shoottime.caption:='follow';
    varF4shootredtime.caption:='';
    varF4sequence.Caption:='';
  end;

  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F4sequence.Visible:=false;
    varF4SOtimelabel.Visible:=true;
    varF4SOtime.Visible:=true;
    varF4SOredtime.Visible:=true;
    varF4waitlabel2.Visible:=true;
    varF4shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF4SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF4shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF4SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF4sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F4sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF4SOtimelabel.Visible:=false;
      varF4SOtime.Visible:=false;
      varF4SOredtime.Visible:=false;
      varF4waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF4shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF4sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F4sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF4shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF4SOtimelabel.Visible:=true;
      varF4SOtime.Visible:=true;
      varF4SOredtime.Visible:=true;
      varF4waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF4shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF4sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F4sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF4shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF4SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF4SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[4]:=char(4 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;


procedure TCountdownform.showF5;       //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F5sequence.Visible:=true;
    varF5SOtimelabel.Visible:=true;
    varF5SOtime.Visible:=true;
    varF5SOredtime.Visible:=true;
    varF5waitlabel2.Visible:=true;
    varF5shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF5SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF5shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF5SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF5sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F5sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF5sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F5sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF5sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F5sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF5shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F5sequence.Visible:=false;
    varF5SOtimelabel.Visible:=false;
    varF5SOtime.Visible:=false;
    varF5SOredtime.Visible:=false;
    varF5waitlabel2.Visible:=false;
    varF5shoottime.caption:='manual';
    varF5shootredtime.caption:='';
    varF5sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F5sequence.Visible:=false;
    varF5SOtimelabel.Visible:=false;
    varF5SOtime.Visible:=false;
    varF5SOredtime.Visible:=false;
    varF5waitlabel2.Visible:=false;
    varF5shoottime.caption:='follow';
    varF5shootredtime.caption:='';
    varF5sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F5sequence.Visible:=false;
    varF5SOtimelabel.Visible:=true;
    varF5SOtime.Visible:=true;
    varF5SOredtime.Visible:=true;
    varF5waitlabel2.Visible:=true;
    varF5shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF5SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF5shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF5SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF5sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F5sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF5SOtimelabel.Visible:=false;
      varF5SOtime.Visible:=false;
      varF5SOredtime.Visible:=false;
      varF5waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF5shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF5sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F5sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF5shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF5SOtimelabel.Visible:=true;
      varF5SOtime.Visible:=true;
      varF5SOredtime.Visible:=true;
      varF5waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF5shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF5sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F5sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF5shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF5SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF5SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[5]:=char(5 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;

procedure TCountdownform.showF6;        //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F6sequence.Visible:=true;
    varF6SOtimelabel.Visible:=true;
    varF6SOtime.Visible:=true;
    varF6SOredtime.Visible:=true;
    varF6waitlabel2.Visible:=true;
    varF6shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF6SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF6shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF6SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;



    if nrofturns=1 then
    begin
      varF6sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F6sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF6sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F6sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF6sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F6sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF6shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F6sequence.Visible:=false;
    varF6SOtimelabel.Visible:=false;
    varF6SOtime.Visible:=false;
    varF6SOredtime.Visible:=false;
    varF6waitlabel2.Visible:=false;
    varF6shoottime.caption:='manual';
    varF6shootredtime.caption:='';
    varF6sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F6sequence.Visible:=false;
    varF6SOtimelabel.Visible:=false;
    varF6SOtime.Visible:=false;
    varF6SOredtime.Visible:=false;
    varF6waitlabel2.Visible:=false;
    varF6shoottime.caption:='follow';
    varF6shootredtime.caption:='';
    varF6sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F6sequence.Visible:=false;
    varF6SOtimelabel.Visible:=true;
    varF6SOtime.Visible:=true;
    varF6SOredtime.Visible:=true;
    varF6waitlabel2.Visible:=true;
    varF6shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF6SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF6shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF6SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF6sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F6sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF6SOtimelabel.Visible:=false;
      varF6SOtime.Visible:=false;
      varF6SOredtime.Visible:=false;
      varF6waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF6shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF6sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F6sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF6shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF6SOtimelabel.Visible:=true;
      varF6SOtime.Visible:=true;
      varF6SOredtime.Visible:=true;
      varF6waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF6shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF6sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F6sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF6shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF6SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF6SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[6]:=char(6 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;

procedure TCountdownform.showF7;         //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F7sequence.Visible:=true;
    varF7SOtimelabel.Visible:=true;
    varF7SOtime.Visible:=true;
    varF7SOredtime.Visible:=true;
    varF7waitlabel2.Visible:=true;
    varF7shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF7SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF7shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF7SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF7sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F7sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF7sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F7sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF7sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F7sequence.Caption:=Concat('2: [2x ',fitaseq2,']');
      varF7shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F7sequence.Visible:=false;
    varF7SOtimelabel.Visible:=false;
    varF7SOtime.Visible:=false;
    varF7SOredtime.Visible:=false;
    varF7waitlabel2.Visible:=false;
    varF7shoottime.caption:='manual';
    varF7shootredtime.caption:='';
    varF7sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F7sequence.Visible:=false;
    varF7SOtimelabel.Visible:=false;
    varF7SOtime.Visible:=false;
    varF7SOredtime.Visible:=false;
    varF7waitlabel2.Visible:=false;
    varF7shoottime.caption:='follow';
    varF7shootredtime.caption:='';
    varF7sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F7sequence.Visible:=false;
    varF7SOtimelabel.Visible:=true;
    varF7SOtime.Visible:=true;
    varF7SOredtime.Visible:=true;
    varF7waitlabel2.Visible:=true;
    varF7shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF7SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF7shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF7SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF7sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F7sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF7SOtimelabel.Visible:=false;
      varF7SOtime.Visible:=false;
      varF7SOredtime.Visible:=false;
      varF7waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF7shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF7sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F7sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF7shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF7SOtimelabel.Visible:=true;
      varF7SOtime.Visible:=true;
      varF7SOredtime.Visible:=true;
      varF7waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF7shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF7sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F7sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF7shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF7SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF7SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[7]:=char(7 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;

procedure TCountdownform.showF9;             //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F9sequence.Visible:=true;
    varF9SOtimelabel.Visible:=true;
    varF9SOtime.Visible:=true;
    varF9SOredtime.Visible:=true;
    varF9waitlabel2.Visible:=true;
    varF9shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF9SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF9shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF9SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF9sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F9sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF9sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F9sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF9sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F9sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF9shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;


  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F9sequence.Visible:=false;
    varF9SOtimelabel.Visible:=false;
    varF9SOtime.Visible:=false;
    varF9SOredtime.Visible:=false;
    varF9waitlabel2.Visible:=false;
    varF9shoottime.caption:='manual';
    varF9shootredtime.caption:='';
    varF9sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F9sequence.Visible:=false;
    varF9SOtimelabel.Visible:=false;
    varF9SOtime.Visible:=false;
    varF9SOredtime.Visible:=false;
    varF9waitlabel2.Visible:=false;
    varF9shoottime.caption:='follow';
    varF9shootredtime.caption:='';
    varF9sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F9sequence.Visible:=false;
    varF9SOtimelabel.Visible:=true;
    varF9SOtime.Visible:=true;
    varF9SOredtime.Visible:=true;
    varF9waitlabel2.Visible:=true;
    varF9shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF9SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF9shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF9SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF9sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F9sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF9SOtimelabel.Visible:=false;
      varF9SOtime.Visible:=false;
      varF9SOredtime.Visible:=false;
      varF9waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF9shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF9sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F9sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF9shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF9SOtimelabel.Visible:=true;
      varF9SOtime.Visible:=true;
      varF9SOredtime.Visible:=true;
      varF9waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF9shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF9sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F9sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF9shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF9SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF9SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[9]:=char(9 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;

procedure TCountdownform.showF10;             //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F10sequence.Visible:=true;
    varF10SOtimelabel.Visible:=true;
    varF10SOtime.Visible:=true;
    varF10SOredtime.Visible:=true;
    varF10waitlabel2.Visible:=true;
    varF10shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF10SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF10shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF10SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF10sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F10sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF10sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F10sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF10sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F10sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF10shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F10sequence.Visible:=false;
    varF10SOtimelabel.Visible:=false;
    varF10SOtime.Visible:=false;
    varF10SOredtime.Visible:=false;
    varF10waitlabel2.Visible:=false;
    varF10shoottime.caption:='manual';
    varF10shootredtime.caption:='';
    varF10sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F10sequence.Visible:=false;
    varF10SOtimelabel.Visible:=false;
    varF10SOtime.Visible:=false;
    varF10SOredtime.Visible:=false;
    varF10waitlabel2.Visible:=false;
    varF10shoottime.caption:='follow';
    varF10shootredtime.caption:='';
    varF10sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F10sequence.Visible:=false;
    varF10SOtimelabel.Visible:=true;
    varF10SOtime.Visible:=true;
    varF10SOredtime.Visible:=true;
    varF10waitlabel2.Visible:=true;
    varF10shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF10SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF10shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF10SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF10sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F10sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF10SOtimelabel.Visible:=false;
      varF10SOtime.Visible:=false;
      varF10SOredtime.Visible:=false;
      varF10waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF10shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF10sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F10sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF10shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF10SOtimelabel.Visible:=true;
      varF10SOtime.Visible:=true;
      varF10SOredtime.Visible:=true;
      varF10waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF10shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF10sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F10sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF10shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF10SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF10SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[10]:=char(10 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;

procedure TCountdownform.showF11;   //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F11sequence.Visible:=true;
    varF11SOtimelabel.Visible:=true;
    varF11SOtime.Visible:=true;
    varF11SOredtime.Visible:=true;
    varF11waitlabel2.Visible:=true;
    varF11shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF11SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF11shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF11SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;
    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF11sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F11sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF11sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F11sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF11sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F11sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF11shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F11sequence.Visible:=false;
    varF11SOtimelabel.Visible:=false;
    varF11SOtime.Visible:=false;
    varF11SOredtime.Visible:=false;
    varF11waitlabel2.Visible:=false;
    varF11shoottime.caption:='manual';
    varF11shootredtime.caption:='';
    varF11sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F11sequence.Visible:=false;
    varF11SOtimelabel.Visible:=false;
    varF11SOtime.Visible:=false;
    varF11SOredtime.Visible:=false;
    varF11waitlabel2.Visible:=false;
    varF11shoottime.caption:='follow';
    varF11shootredtime.caption:='';
    varF11sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F11sequence.Visible:=false;
    varF11SOtimelabel.Visible:=true;
    varF11SOtime.Visible:=true;
    varF11SOredtime.Visible:=true;
    varF11waitlabel2.Visible:=true;
    varF11shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF11SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF11shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF11SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF11sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F11sequence.Visible:=true;
        if timeperturn.Checked=true then
    begin
      varF11SOtimelabel.Visible:=false;
      varF11SOtime.Visible:=false;
      varF11SOredtime.Visible:=false;
      varF11waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF11shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF11sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F11sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF11shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF11SOtimelabel.Visible:=true;
      varF11SOtime.Visible:=true;
      varF11SOredtime.Visible:=true;
      varF11waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF11shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF11sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F11sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF11shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF11SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF11SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[11]:=char(11 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;


procedure TCountdownform.showF12;            //showF1 to show F12 are almost identical and needs to be combined to one procedure (not done yet for priority reasons)
var
  sys:integer;
  brred, bryel, brgrn : integer;
Begin
  sys:=0;
  if archerysystem='fita' then
  begin
    sys:=1;
    brred:=redtime.value;
    bryel:=orangetime.value;
    brgrn:=greentime.value;
    var2F12sequence.Visible:=true;
    varF12SOtimelabel.Visible:=true;
    varF12SOtime.Visible:=true;
    varF12SOredtime.Visible:=true;
    varF12waitlabel2.Visible:=true;
    varF12shoottime.caption:=Concat(inttostr(greentime.value),'+', inttostr(orangetime.value),'=',inttostr((greentime.value)+(orangetime.value)),' sec,');
    varF12SOtime.caption:=Concat(inttostr(greentimeso.value),'+', inttostr(orangetimeso.value),'=',inttostr((greentimeso.value)+(orangetimeso.value)),' sec,');
    varF12shootredtime.caption:=Concat(inttostr(redtime.value),' sec');
    varF12SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    fitaseq:='';

    if topbot.checked=true then
    begin
      fitaseq:='T-B';
      if ABCDperEND.Checked=true then fitaseq2:='T-B' else fitaseq2:='B-T';
    end;


    if oneone.checked=true then
    begin
      fitaseq:='A';
      fitaseq2:='A';
    end;
    if onetwo.checked=true then
    begin
      fitaseq:='A-B';
      if ABCDperEND.Checked=true then fitaseq2:='A-B' else fitaseq2:='B-A';
    end;
    if onethree.checked=true then
    begin
      fitaseq:='A-B-C';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C' else fitaseq2:='C-A-B';
    end;
    if onefour.checked=true then
    begin
      fitaseq:='A-B-C-D';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D' else fitaseq2:='D-A-B-C';
    end;
    if twotwo.checked=true then
    begin
      fitaseq:='AB-CD';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD' else fitaseq2:='CD-AB';
    end;

    if onefive.checked=true then
    begin
      fitaseq:='A-B-C-D-E';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E' else fitaseq2:='E-A-B-C-D';
    end;
    if onesix.checked=true then
    begin
      fitaseq:='A-B-C-D-E-F';
      if ABCDperEND.Checked=true then fitaseq2:='A-B-C-D-E-F' else fitaseq2:='F-A-B-C-D-E';
    end;

    if twothree.checked=true then
    begin
      fitaseq:='AB-CD-EF';
      if ABCDperEND.Checked=true then fitaseq2:='AB-CD-EF' else fitaseq2:='EF-AB-CD';
    end;

    if threetwo.checked=true then
    begin
      fitaseq:='ABC-DEF';
      if ABCDperEND.Checked=true then fitaseq2:='ABC-DEF' else fitaseq2:='DEF-ABC';
    end;


    if nrofturns=1 then
    begin
      varF12sequence.Caption:=Concat('1: [',fitaseq,']');
      var2F12sequence.Caption:=Concat('2: [',fitaseq2,']');
    end;
    if (nrofturns=2) and (turnsss=2) then
    begin
      varF12sequence.Caption:=Concat('1: [',fitaseq,'-',fitaseq,']');
      var2F12sequence.Caption:=Concat('2: [',fitaseq2,'-',fitaseq2,']');
    end;
    if (nrofturns=2) and (times=2) then
    begin
      varF12sequence.Caption:=Concat('1: [2x ',fitaseq,']');
      var2F12sequence.Caption:=Concat('1: [2x ',fitaseq2,']');
      varF12shoottime.caption:=Concat(inttostr((greentime.value)+(greentime.value)+(orangetime.value)),'+', inttostr(orangetime.value),'=',inttostr(2*((greentime.value)+(orangetime.value))),' sec,');
    end;

  end;
  if archerysystem='manual' then
  begin
    sys:=5;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F12sequence.Visible:=false;
    varF12SOtimelabel.Visible:=false;
    varF12SOtime.Visible:=false;
    varF12SOredtime.Visible:=false;
    varF12waitlabel2.Visible:=false;
    varF12shoottime.caption:='manual';
    varF12shootredtime.caption:='';
    varF12sequence.Caption:='';
  end;
  if archerysystem='follow' then
  begin
    sys:=4;
    brred:=0;
    bryel:=0;
    brgrn:=0;
    var2F12sequence.Visible:=false;
    varF12SOtimelabel.Visible:=false;
    varF12SOtime.Visible:=false;
    varF12SOredtime.Visible:=false;
    varF12waitlabel2.Visible:=false;
    varF12shoottime.caption:='follow';
    varF12shootredtime.caption:='';
    varF12sequence.Caption:='';
  end;


  if archerysystem='25m1p' then
  begin
    sys:=3;
    brred:=redtime1p.value;
    bryel:=orangetime1p.value;
    brgrn:=greentime1p.value;
    var2F12sequence.Visible:=false;
    varF12SOtimelabel.Visible:=true;
    varF12SOtime.Visible:=true;
    varF12SOredtime.Visible:=true;
    varF12waitlabel2.Visible:=true;
    varF12shoottime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF12SOtime.caption:=Concat(inttostr(greentime1p.value),'+', inttostr(orangetime1p.value),'=',inttostr((greentime1p.value)+(orangetime1p.value)),' sec,');
    varF12shootredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF12SOredtime.caption:=Concat(inttostr(redtime1p.value),' sec');
    varF12sequence.Caption:=Concat('1--',inttostr(nrof1pshooters.value));
  end;
  if archerysystem='fitafin' then
  begin
    sys:=2;
    var2F12sequence.Visible:=true;
    if timeperturn.Checked=true then
    begin
      varF12SOtimelabel.Visible:=false;
      varF12SOtime.Visible:=false;
      varF12SOredtime.Visible:=false;
      varF12waitlabel2.Visible:=false;
      brred:=redfinal.value;
      bryel:=orangefinal.value;
      brgrn:=greenfinal.value;
      varF12shoottime.caption:=Concat(inttostr(greenfinal.value),'+', inttostr(orangefinal.value),'=',inttostr((greenfinal.value)+(orangefinal.value)),' sec,');
      varF12sequence.caption:=Concat(inttostr(finalturns.Value),'X Finalround ind.');
      var2F12sequence.Caption:=Concat(inttostr(finalturnsSO.value),'X shootoff / archer');
      varF12shootredtime.caption:=Concat(inttostr(redfinal.value),' sec');
    end
    else
    begin
      varF12SOtimelabel.Visible:=true;
      varF12SOtime.Visible:=true;
      varF12SOredtime.Visible:=true;
      varF12waitlabel2.Visible:=true;
      brred:=redfinalend.value;
      bryel:=orangefinalend.value;
      brgrn:=greenfinalend.value;
      varF12shoottime.caption:=Concat(inttostr(greenfinalend.value),'+', inttostr(orangefinalend.value),'=',inttostr((greenfinalend.value)+(orangefinalend.value)),' sec,');
      varF12sequence.caption:=Concat(inttostr(finalteamturns.Value),'X Finalround team');
      var2F12sequence.Caption:=Concat(inttostr(finalteamturnsSO.value),'X shootoff / team');
      varF12shootredtime.caption:=Concat(inttostr(redfinalend.value),' sec');
      varF12SOtime.caption:=Concat(inttostr(greenfinalendso.value),'+', inttostr(orangefinalendso.value),'=',inttostr((greenfinalendso.value)+(orangefinalendso.value)),' sec,');
      varF12SOredtime.caption:=Concat(inttostr(redtimeso.value),' sec');
    end;

  end;
  FBroad[12]:=char(12 shl 4+sys)+char(brred)+char(brgrn mod 256)+char((brgrn div 256)shl 7+bryel);

end;





procedure TCountdownform.storeF;
begin
   AssignFile(settingsfile, Filespath+'scenarios/'+Fstore) ;
   ReWrite(settingsfile) ;

   writeln(settingsfile,archerysystem) ; //fita or 25m1p
   writeln(settingsfile,0) ;  //Fitafinal or fita/25m1p
   fitamode:=0;
   if topbot.checked=true then fitamode:=0;
   if oneone.checked=true then fitamode:=1;
   if onetwo.checked=true then fitamode:=2;
   if onethree.checked=true then fitamode:=3;
   if onefour.checked=true then fitamode:=4;
   if twotwo.checked=true then fitamode:=5;
   if onefive.checked=true then fitamode:=6;
   if onesix.checked=true then fitamode:=7;
   if twothree.checked=true then fitamode:=8;
   if threetwo.checked=true then fitamode:=9;
   writeln(settingsfile,fitamode) ; //fita mode (A, A-B, A-B-C, etc)
   writeln(settingsfile,nrofturns); //dubbele beurt of niet

   writeln(settingsfile,greentime.value); //seconds green Fita system
   writeln(settingsfile,orangetime.value); //seconds orange Fita system
   writeln(settingsfile,redtime.value); //seconds red Fita system

   writeln(settingsfile,greentimeso.value); //seconds green Fita shootoff
   writeln(settingsfile,orangetimeso.value); //seconds orange Fita shootoff
   writeln(settingsfile,redtimeso.value); //seconds red Fita shootoff

   writeln(settingsfile,greentime1p.value); //seconds green 25m1p system
   writeln(settingsfile,orangetime1p.value); //seconds orange 25m1p system
   writeln(settingsfile,redtime1p.value); //seconds red 25m1p system
   writeln(settingsfile,practiseturns.Value); // nr of practise ends Fita
   writeln(settingsfile,nrof1pshooters.Value); //archers per target 25m1p
   writeln(settingsfile,doubleturns.checked); //
   writeln(settingsfile,dbltime.checked); //
   writeln(settingsfile,dblturn.checked); //
   //add in v21
   writeln(settingsfile,showtarget.checked); //
   writeln(settingsfile,finarrow.checked); //
  // writeln(settingsfile,finname.checked); //
   writeln(settingsfile,'empty'); //
   writeln(settingsfile,timeperturn.checked); //
   writeln(settingsfile,timeperend.checked); //
   writeln(settingsfile,leftnumber.value); //
   writeln(settingsfile,rightnumber.value); //
   writeln(settingsfile,finalturns.value); //
   writeln(settingsfile,finalteamturns.value); //
   writeln(settingsfile,greenfinal.value); //
   writeln(settingsfile,orangefinal.value); //
   writeln(settingsfile,redfinal.value); //
   writeln(settingsfile,greenfinalend.value); //
   writeln(settingsfile,orangefinalend.value); //
   writeln(settingsfile,redfinalend.value); //
   writeln(settingsfile,BCDtoROG2.checked); //
   writeln(settingsfile,abcd25m1p.checked);
   writeln(settingsfile,ABCDperEND.checked);

   writeln(settingsfile,nrredbuzz.Value );
   writeln(settingsfile,nrorangebuzz.Value );
   writeln(settingsfile,nrgreenbuzz.Value );
   writeln(settingsfile,HWbutton1.ItemIndex );
   writeln(settingsfile,HWbutton2.ItemIndex );
   writeln(settingsfile,HWbutton3.ItemIndex );
   writeln(settingsfile,HWbutton4.ItemIndex );
   writeln(settingsfile,HWbutton5.ItemIndex );
   writeln(settingsfile,HWbutton5.ItemIndex );  //reservation for sixth button
   if leftscreen.Checked=true then writeln(settingsfile,'left')else writeln(settingsfile,'right');
   if serialinput.Checked=true then writeln(settingsfile,'followserial')else writeln(settingsfile,'followLAN');
   writeln(settingsfile,nrof1ppractisearrows.Value); // nr of practise arrows 25m1p
   writeln(settingsfile,viewleft.checked); //
   writeln(settingsfile,viewright.checked); //
   writeln(settingsfile,rotate25m1p.checked); //
   writeln(settingsfile,fromHOST.Text); //
   writeln(settingsfile,rotate25m1p_p.checked); //

   writeln(settingsfile,'dummy'); //reservation for future follow mode
   writeln(settingsfile,PABCDperEND.checked);

   writeln(settingsfile,orangebeepfitacheckbox.Checked);
   writeln(settingsfile,orangebeep25m1pcheckbox.Checked);
   writeln(settingsfile,Blinkphase1CheckBox.Checked);
   writeln(settingsfile,Blinkphase2CheckBox.Checked);
   writeln(settingsfile,greenfinalendso.Value);
   writeln(settingsfile,orangefinalendso.Value);
   writeln(settingsfile,redfinalendso.Value);
   writeln(settingsfile,finalturnsSO.Value);
   writeln(settingsfile,finalteamturnsSO.Value);
   writeln(settingsfile,Beepswitcharcher.Checked);
   writeln(settingsfile,repeatsequence.value);
   writeln(settingsfile,stopinbetweenturnsfitacheckbox.Checked);
   CloseFile(settingsfile) ;

end;


procedure TCountdownform.initsystemtype;   //change systemtype (Fita, fitafin,etc
begin
   NETWORK1.Disconnect;

  serienumber:=1;
  turnnumber:=1;
  FirstTimer.Enabled:=false;
  secondTimer.Enabled:=false;
  FirstTimer.Enabled:=false;
  secondTimer.Enabled:=false;
  countdowntimer:=0;
  countdowntimer2:=0;
  fitafinstartarcher:='none';
  fitafinarcher:='none';
  state:=1;
  leftscale:=100;
  rightscale:=100;
  updatemenu;

  if archerysystem='fita' then
  begin
    if practiseturns.Value=0 then Practiseturn:=0 else Practiseturn:=1;
    if doubleturns.checked=false then
    begin
      nrofturns:=1;
      times:=1;
      turnsss:=1
    end
    else
    begin
      nrofturns:=2;
      if dblturn.Checked=true then
      begin
        times:=1;
        turnsss:=2
      end;
      if dbltime.Checked=true then
      begin
        times:=2;
        turnsss:=1
      end;
    end;
    FITAScrollBox.Visible:=true;
    FitaFinScrollBox.Visible:=false;
    onearrowScrollBox.Visible:=false;
    manualScrollBox.Visible:=false;
    FollowScrollBox.Visible:=false;
    if oneone.Checked=true then oneonesystem;
    if onetwo.checked=true then onetwosystem;
    if onethree.checked=true then onethreesystem;
    if onefour.checked=true then onefoursystem;
    if twotwo.checked=true then twotwosystem;
    if onefive.Checked=true then onefivesystem;
    if onesix.Checked=true then onesixsystem;
    if twothree.Checked=true then twothreesystem;

    if threetwo.Checked=true then threetwosystem;
    if topbot.Checked=true then topbotsystem;

  end;//archerysystem Fita

  if archerysystem='25m1p' then
  begin
      nrofturns:=1;
      times:=1;
      turnsss:=1;

    if nrof1ppractisearrows.Value=0 then Practiseturn:=0 else Practiseturn:=1;

    startupscenario.Text:='--';
    nrofturns:=1;
    turnsss:=1;
    times:=1;
    FITAScrollBox.Visible:=false;
    FitaFinScrollBox.Visible:=false;
    onearrowScrollBox.Visible:=true;
    manualScrollBox.Visible:=false;
    FollowScrollBox.Visible:=false;
    Shooters:=nrof1pshooters.Value;
    Turnsperserie:=nrof1pshooters.Value;
    Archersperturn:=1;

    if turnnumber >  Turnsperserie then turnnumber:= Turnsperserie;


  end; //archerysystem 25m1p

  if archerysystem='fitafin' then
  begin


    Practiseturn:=0;
    FITAScrollBox.Visible:=false;
    FitaFinScrollBox.Visible:=true;
    onearrowScrollBox.Visible:=false;
    manualScrollBox.Visible:=false;
    FollowScrollBox.Visible:=false;

  end; //archerysystem fitafin

  if (archerysystem= 'manual') or (archerysystem= 'follow') then
  begin
    Practiseturn:=0;
    FITAScrollBox.Visible:=false;
    FitaFinScrollBox.Visible:=false;
    onearrowScrollBox.Visible:=false;
    FollowScrollBox.Visible:=false;
    nexticon.visible:=false;
    playpauzeicon.Visible:=false;
    stopicon.Visible:=false;
    tup.Visible:=false;
    tdown.Visible:=false;
    enddown.Visible:=false;
    endup.Visible:=false;
    if archerysystem = 'manual' then
    begin
      manualScrollBox.Visible:=true;
      FollowScrollBox.Visible:=false;
      buzzicon1.Visible:=true;
      buzzicon2.Visible:=true;
      buzzicon3.Visible:=true;
      manualred.Visible:=true;
      manualorange.Visible:=true;
      manualgreen.Visible:=true;
      Danger.Visible:=true;
      if showhints.Checked=true then
      begin
        Practise.showhint:=true;
        serienr.showhint:=true;
      end;
    end
    else
    begin
      manualScrollBox.Visible:=false;
      FollowScrollBox.Visible:=true;
      buzzicon1.Visible:=false;
      buzzicon2.Visible:=false;
      buzzicon3.Visible:=false;
      manualred.Visible:=false;
      manualorange.Visible:=false;
      manualgreen.Visible:=false;
      Danger.Visible:=false;
      Practise.showhint:=false;
      serienr.showhint:=false;
      shooter1.ShowHint:=false;
      shooter2.ShowHint:=false;
      shooter3.ShowHint:=false;
      shooter4.ShowHint:=false;
      shooter5.ShowHint:=false;
      shooter6.ShowHint:=false;
    end;
  end
  else
  begin
    if hideicons.checked=false then
    begin
      nexticon.visible:=true;
      playpauzeicon.Visible:=true;
      stopicon.Visible:=true;
      tup.Visible:=true;
      tdown.Visible:=true;
      enddown.Visible:=true;
      endup.Visible:=true;
      shooter1.ShowHint:=true;
      shooter2.ShowHint:=true;
      shooter3.ShowHint:=true;
      shooter4.ShowHint:=true;
      shooter5.ShowHint:=true;
      shooter6.ShowHint:=true;
    end;
    Danger.Visible:=true;
    if showhints.Checked=true then
    begin
      Practise.showhint:=true;
      serienr.showhint:=true;
    end;
    buzzicon1.Visible:=false;
    buzzicon2.Visible:=false;
    buzzicon3.Visible:=false;
    manualred.Visible:=false;
    manualorange.Visible:=false;
    manualgreen.Visible:=false;
    shooter1.ShowHint:=false;
    shooter2.ShowHint:=false;
    shooter3.ShowHint:=false;
    shooter4.ShowHint:=false;
    shooter5.ShowHint:=false;
    shooter6.ShowHint:=false;
  end;
  if archerysystem = 'follow' then
  begin
    Followlansettings;
  end;
  connectports;
  startupscenario.Text:='--';
  viewactivate;
  viewchangmenuitems;
  viewarchsystemchange;
  viewicons;
  viewchangestateinact;
  viewchangestateexchange;
  viewturnchange;
  viewfinupdate;
  viewchangestateactive;
  switchbox;
  TLswitch;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowTL;
  resizewindowsingleclock;
  resizewindowlabelsiconsmenu;
  viewstateone;
  if archerysystem <>'fitafin' then resizewindownonfinals  else resizewindowfinals;
  Checkredblink;
end;

procedure TCountdownform.FITAClick(Sender: TObject);
begin
  if archerysystem='follow' then
  begin
    archerysystem:='fita';
    repeatsequence.Value:=orgrepeatsequence;
    ABCDperEND.Checked:=orgfolabcdsec;
    PABCDperEND.Checked:=orgPABCDperEND;
    rotate25m1p.Checked:=orgfol25m1pse;
    rotate25m1p_p.Checked:=orgfol25m1pse_p;
    if orgfolminsec=false then minsec.ItemIndex:=0 else minsec.ItemIndex:=1;
  end;
  archerysystem:='fita';
  initsystemtype;
end;

procedure TCountdownform.FITAFINClick(Sender: TObject);
begin
  if archerysystem='follow' then
  begin
    archerysystem:='fitafin';
    repeatsequence.Value:=orgrepeatsequence;
    ABCDperEND.Checked:=orgfolabcdsec;
    PABCDperEND.Checked:=orgPABCDperEND;
    rotate25m1p.Checked:=orgfol25m1pse;
    rotate25m1p_p.Checked:=orgfol25m1pse_p;
    if orgfolminsec=false then minsec.ItemIndex:=0 else minsec.ItemIndex:=1;
  end;
  FITAFIN.Checked:=true;
  archerysystem:='fitafin';
  initsystemtype;
end;



procedure TCountdownform.onepijlClick(Sender: TObject);
begin
  if archerysystem='follow' then
  begin
    archerysystem:='25m1p';
    repeatsequence.Value:=orgrepeatsequence;
    ABCDperEND.Checked:=orgfolabcdsec;
    PABCDperEND.Checked:=orgPABCDperEND;
    rotate25m1p.Checked:=orgfol25m1pse;
    rotate25m1p_p.Checked:=orgfol25m1pse_p;
    if orgfolminsec=false then minsec.ItemIndex:=0 else minsec.ItemIndex:=1;
  end;
  archerysystem:='25m1p';
  initsystemtype;
end;

procedure TCountdownform.closeimage1Click(Sender: TObject);
begin
  timeseqpanel.Visible:=false;
  menuscreensize;
  viewchangmenuitems;
end;

procedure TCountdownform.redtimeChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.redtimesoChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.redtime1pChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;


procedure TCountdownform.finnameClick(Sender: TObject);
begin

  number.Visible:=false;
  startupscenario.Text:='--';
end;

procedure TCountdownform.finarrowClick(Sender: TObject);
begin
  showtarget.Enabled:=true;
  startupscenario.Text:='--';
  viewchangestateactive;
  viewchangestateexchange;
  switchbox;
  TLswitch;
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowfinals;
  resizewindowTL;
  resizewindowlabelsiconsmenu;
  leftrightzoom.Enabled:=true;
end;

procedure TCountdownform.fintargetClick(Sender: TObject);
begin

  number.Visible:=true;
  startupscenario.Text:='--';
end;

procedure TCountdownform.numberClick(Sender: TObject);
begin

  number.Visible:=true;
end;

procedure TCountdownform.dblturnClick(Sender: TObject);
begin
  if dblturn.Checked=true then
  begin
    times:=1;
    turnsss:=2
  end;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;

procedure TCountdownform.dbltimeClick(Sender: TObject);
begin
  if dbltime.Checked=true then
  begin
    times:=2;
    turnsss:=1
  end;
  showseq;
  showtime;
  startupscenario.Text:='--';
end;


Procedure TCountdownform.removemenu;
begin
  cdmenu.caption:=CurrToStr(menuremovesec);
  cdmenu2.caption:=CurrToStr(menuremovesec);
  menuremovesec:=menuremovesec-1;

  if  menuremovesec<-1 then
  begin
    savesettings.Visible:=false;
    timeseqpanel.Visible:=false;
    manualcolorpanel.Visible:=false;

    cdmenu.caption:=CurrToStr(menuremovedelay.Interval div 1000);
    cdmenu2.caption:=CurrToStr(menuremovedelay.Interval div 1000);
    menudisap1.Visible:=false;
    cdmenu.Visible:=false;
    disapsec1.Visible:=false;
    menudisap2.Visible:=false;
    cdmenu2.Visible:=false;
    disapsec2.Visible:=false;
    menuremovedelay.enabled:=false;
    menuscreensize;
  end
  else
  begin
    menudisap1.Visible:=true;
    cdmenu.Visible:=true;
    disapsec1.Visible:=true;
    menudisap2.Visible:=true;
    cdmenu2.Visible:=true;
    disapsec2.Visible:=true;
    menuremovedelay.enabled:=true;
  end;
end;


procedure TCountdownform.menuremovedelayTimer(Sender: TObject);
//this timer is used to remove the menu when timer is running. Time left is visible via removemenu
begin
  removemenu;

end;

procedure TCountdownform.selectleftarcher;
begin
  fitafinarcher:='left';
  fitafinstartarcher:='left';
  if archeryclock.visible=true then archeryclock.visible:=false;
  if state <> 1 then
  begin
    FirstTimer.enabled:=true;
    secondTimer.Enabled:=false;
    countdowntimertmp:=countdowntimer;
    countdowntimer:=countdowntimer2;
    countdowntimer2:=countdowntimertmp;
  end
  else
  begin
    viewfinupdate;
    viewturnchange;
  end;
  Checkredblink;
  switchbox;
  if finarrow.Checked=true then leftrightzoom.Enabled:=true;
  viewfinupdate;
  viewchangestateexchange;
  viewchangestateactive;
end;

procedure TCountdownform.selectrightarcher;
begin
  fitafinarcher:='right';
  fitafinstartarcher:='right';
  if archeryclock.visible=true then archeryclock.visible:=false;
  if state <> 1 then
  begin
    FirstTimer.enabled:=false;
    secondTimer.Enabled:=true;
    countdowntimertmp:=countdowntimer;
    countdowntimer:=countdowntimer2;
    countdowntimer2:=countdowntimertmp;
  end;
  Checkredblink;
  switchbox;
  if finarrow.Checked=true then leftrightzoom.Enabled:=true;
  viewfinupdate;
  viewchangestateexchange;
  viewchangestateactive;
end;

procedure TCountdownform.selectnonearcher;
begin
  if state = 1 then
  begin
    fitafinstartarcher:='none';
    fitafinarcher:='none';
    if finarrow.Checked=true then leftrightzoom.Enabled:=true;
  end;
  Checkredblink;
  viewstateone;
  switchbox;
  switchbox;
  viewfinupdate;
  viewchangestateexchange;
  viewchangestateactive;
end;


procedure TCountdownform.greyleftClick(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true) then
    begin
      changeendturntimer.Enabled:=false;
      changeendturntimer.Enabled:=true;
      viewarchsystemchange;
    end;
    selectleftarcher;
    viewstateone;
    viewchangestateexchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.greyrightClick(Sender: TObject);
begin
  if archerysystem<>'follow' then
  begin
    if (largeimagecheckbox.Checked=true)or(Actualtimecheckbox.Checked=true) then
    begin
      changeendturntimer.Enabled:=false;
      changeendturntimer.Enabled:=true;
      viewarchsystemchange;
    end;
    selectrightarcher;
    viewstateone;
    viewchangestateexchange;
    switchbox;
    TLswitch;
  end;
end;

procedure TCountdownform.finalchooseClick(Sender: TObject);
begin
  selectnonearcher;
end;

procedure TCountdownform.leftrightzoomTimer(Sender: TObject);
  //this timer is used to slow zoom the timers in final rounds when left to right or right to left changes.
begin
  if (fitafinarcher='right') then
  begin
    if (leftscale<100) then
    begin
      if leftscale < 80 then leftscale:=leftscale+20 else leftscale:=leftscale+4;
    end;
    if (rightscale>0) then
    begin
      if (rightscale > 80)and(leftscale<>100) then rightscale:=rightscale-4 else rightscale:=rightscale-20;
    end;
    if (rightscale <= 0) and (leftscale >= 100) then leftrightzoom.Enabled:=false;
  end;
  if (fitafinarcher='left')then
  begin
    if  (leftscale>0) then
    begin
      if (leftscale > 80)and(rightscale<>100) then leftscale:=leftscale-4 else leftscale:=leftscale-20;
    end;
    if (rightscale<100) then
    begin
      if rightscale < 80 then rightscale:=rightscale+20 else rightscale:=rightscale+4;
    end;
    if (rightscale >= 100) and (leftscale <= 0 ) then leftrightzoom.Enabled:=false;
  end;
  if (fitafinarcher='none') then
  begin
    if (rightscale<100) then
    begin
      rightscale:=rightscale+20;
    end;
    if  (leftscale<100) then
    begin
      leftscale:=leftscale+20;
    end;
    if (rightscale >= 100) and (leftscale >= 100) then leftrightzoom.Enabled:=false;
  end;
  resizewindowfinals;
end;

procedure TCountdownform.secondTimerTimer(Sender: TObject);
//secondtimer is only used in finalrounds. Because other rounds only need 1 timer
//functionality of secondtimer is comparable to first timer
begin
  systemtime:=getcurrenttime;
  begin
    if countdowntimer2> 1 then //actual time left is not 0
    begin
      checknextsecond;
      if nextsec=1 then
      begin
        referencetime:=IncSecond(referencetime, 1);  //decrease reference time with one second to triger the next count a second later
        countdowntimer2:=countdowntimer2-1;          //decrease the projected time with 1 second
        //if the projected time is equal to orange time setting, change to state 4: orange.
        if  ((countdowntimer2 = orangefinal.value)and (state=3)and (timeperturn.checked=true))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          TLswitch;
        end;
        if  (  (((countdowntimer2 = orangefinalend.value)and (Shootoff=0))or((countdowntimer2 = orangefinalendSO.value)and (Shootoff=1)))   and (state=3)and (timeperend.checked=true))and (state <>2) then
        begin
          state:=4;
          viewchangestateactive;
          TLswitch;
        end;
        viewactivate;
      end;
    end
    else
    begin  //actual time left is 0 so a state change is needed
      case state of
        1:    //waittime  , so change to red time (state 2)
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            state:=2;
            soundsignal;
            //TLswitch;
            if (timeperturn.checked=true) then countdowntimer:= redfinal.Value else countdowntimer:= redfinalend.Value;
            secondTimer.enabled:=true ;
            viewchangestateexchange;
          end;
        end;
        2:    //redtime , so change to green time (state 3)
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            state:=3;
            soundsignal;
            viewchangestateactive;
            TLswitch;
            if (archerysystem='fitafin')and (timeperturn.checked=true)then countdowntimer2:= (orangefinal.Value) +(greenfinal.value);
            if (archerysystem='fitafin')and (timeperend.checked=true)then
            begin
              if Shootoff=0 then  countdowntimer2:= (orangefinalend.Value) +(greenfinalend.value) else countdowntimer2:= (orangefinalendSO.Value) +(greenfinalendSO.value);
            end;
            secondTimer.enabled:=true ;
            viewactivate;
          end;
        end;
        3:    //greentime. Can get in this situation in case orange setting is 0. Next state is depending if this is the last turn in this end or not. This is aranged in routine nextfinal
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            endtimebuzzer:=true;
            nextfinal;

            TLswitch;
            viewactivate;
          end;
        end;
        4: //orangetime  Next state is depending if this is the last turn in this end or not. This is aranged in routine nextfinal
        begin
          checknextsecond;
          if nextsec=1 then
          begin
            referencetime:=IncSecond(referencetime, 1);
            endtimebuzzer:=true;
            nextfinal;
            viewactivate;
            TLswitch;
          end;
        end;
      End;  {End Case1}

    end;

  end;
  Checkredblink;
end;

procedure TCountdownform.timeperendClick(Sender: TObject);
begin
  groupfinend.Visible:=true;
  finalteamturns.Visible:=true;
  finalteamturnsSO.Visible:=true;
  groupfinarrow.Visible:=false;
  groupfinendSO.Visible:=true;
  finalturns.Visible:=false;
  finalturnsso.Visible:=false;
  startupscenario.Text:='--';
  serienumber:=1;
  viewturnchange;
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: other timing boxes are shown now: lay them out
end;

procedure TCountdownform.timeperturnClick(Sender: TObject);
begin
  groupfinend.Visible:=false;
  finalteamturns.Visible:=false;
  finalteamturnsSO.Visible:=false;
  groupfinarrow.Visible:=true;
  groupfinendSO.Visible:=false;
  finalturns.Visible:=true;
  finalturnsso.Visible:=true;
  startupscenario.Text:='--';
  serienumber:=1;
  viewturnchange;
  {$IFDEF Darwin}MacTidyTimingPage;{$ENDIF} // Mac: other timing boxes are shown now: lay them out
end;

procedure TCountdownform.greenfinalChange(Sender: TObject);
begin
  totalfinal.Caption:= inttostr( trunc(orangefinal.value)+trunc(greenfinal.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangefinalChange(Sender: TObject);
begin
  totalfinal.Caption:= inttostr( trunc(orangefinal.value)+trunc(greenfinal.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.greenfinalendChange(Sender: TObject);
begin
  totalfinalend.Caption:= inttostr( trunc(orangefinalend.value)+trunc(greenfinalend.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.orangefinalendChange(Sender: TObject);
begin
  totalfinalend.Caption:= inttostr( trunc(orangefinalend.value)+trunc(greenfinalend.value));
  startupscenario.Text:='--';
end;

procedure TCountdownform.digit3_2Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectrightarcher else hide;
end;

procedure TCountdownform.digit2_2Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectrightarcher else hide;
end;

procedure TCountdownform.dots_2Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectrightarcher else hide;
end;

procedure TCountdownform.digit1_2Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true) then selectrightarcher else hide;
end;

procedure TCountdownform.digit3_1Click(Sender: TObject);
begin
  if (archerysystem='fitafin') and (finarrow.Checked=true)  then selectleftarcher else hide;
end;

procedure TCountdownform.Changestartarcher;
begin
  if fitafinstartarcher='left'  then fitafinstartarcher:='right'
  else
  if fitafinstartarcher='right' then fitafinstartarcher:='left';
  viewfinupdate;
end;

procedure TCountdownform.rightstartClick(Sender: TObject);
begin
  Changestartarcher;
end;

procedure TCountdownform.leftstartClick(Sender: TObject);
begin
  Changestartarcher;
end;

procedure TCountdownform.finalturnsChange(Sender: TObject);
begin
  if archerysystem='fitafin' then
  if serienumber > finalturns.Value then
  begin
    serienumber:=finalturns.Value;
    viewturnchange;

  end;
  startupscenario.Text:='--';
end;

procedure TCountdownform.leftnumberChange(Sender: TObject);
begin
  lefttarget.Caption:=CurrToStr(leftnumber.Value);
end;

procedure TCountdownform.rightnumberChange(Sender: TObject);
begin
  righttarget.Caption:=CurrToStr(rightnumber.Value);
end;

procedure TCountdownform.BCDtoROG2Click(Sender: TObject);
begin
  if CardAddr=0 then switchbox;
  startupscenario.Text:='--';
end;

procedure TCountdownform.savevarF8buttonClick(Sender: TObject);   //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F8';
  storeF;
  showF8;
  startupscenario.text:='F8';
end;


procedure TCountdownform.savevarF1buttonClick(Sender: TObject);  //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons

begin
  Fstore:='F1';
  storeF;
  showF1;
  startupscenario.text:='F1';
end;

procedure TCountdownform.savevarF2buttonClick(Sender: TObject);   //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F2';
  storeF;
  showF2;
  startupscenario.text:='F2';
end;

procedure TCountdownform.savevarF3buttonClick(Sender: TObject);  //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F3';
  storeF;
  showF3;
  startupscenario.text:='F3';
end;

procedure TCountdownform.savevarF4buttonClick(Sender: TObject); //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F4';
  storeF;
  showF4;
  startupscenario.text:='F4';
end;

procedure TCountdownform.savevarF5buttonClick(Sender: TObject);  //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F5';
  storeF;
  showF5;
  startupscenario.text:='F5';
end;

procedure TCountdownform.savevarF6buttonClick(Sender: TObject);  //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F6';
  storeF;
  showF6;
  startupscenario.text:='F6';
end;

procedure TCountdownform.savevarF7buttonClick(Sender: TObject); //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F7';
  storeF;
  showF7;
  startupscenario.text:='F7';
end;

procedure TCountdownform.savevarF9buttonClick(Sender: TObject);  //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F9';
  storeF;
  showF9;
  startupscenario.text:='F9';
end;

procedure TCountdownform.savevarF10buttonClick(Sender: TObject); //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F10';
  storeF;
  showF10;
  startupscenario.text:='F10';
end;

procedure TCountdownform.savevarF11buttonClick(Sender: TObject); //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F11';
  storeF;
  showF11;
  startupscenario.text:='F11';
end;

procedure TCountdownform.savevarF12buttonClick(Sender: TObject); //savevarF1buttonClick to savevarF12buttonClick  needs to be optimized to one procedure (not done yet because of priority reasons
begin
  Fstore:='F12';
  storeF;
  showF12;
  startupscenario.text:='F12';
end;

Procedure  TCountdownform.setvarsettings;
begin
  if FileExistsUTF8(Filespath+'scenarios/'+scenario)=true then
  begin
    AssignFile(scenariotextfile, Filespath+'scenarios/'+scenario) ;
    getsetting;
  end
  else
  begin
    Setsettings;
  end;
  startupscenario.Text:=scenario;
end;

procedure TCountdownform.varF1ButtonClick(Sender: TObject);
begin
  scenario:='F1';
  setvarsettings;
end;


procedure TCountdownform.varF2ButtonClick(Sender: TObject);
begin
  scenario:='F2';
  setvarsettings;
end;


procedure TCountdownform.varF3ButtonClick(Sender: TObject);
begin
  scenario:='F3';
  setvarsettings;
end;


procedure TCountdownform.varF4ButtonClick(Sender: TObject);
begin
  scenario:='F4';
  setvarsettings;
end;


procedure TCountdownform.varF5ButtonClick(Sender: TObject);
begin
  scenario:='F5';
  setvarsettings;
end;


procedure TCountdownform.varF6ButtonClick(Sender: TObject);
begin
  scenario:='F6';
  setvarsettings;
end;


procedure TCountdownform.varF7ButtonClick(Sender: TObject);
begin
  scenario:='F7';
  setvarsettings;
end;


procedure TCountdownform.varF8ButtonClick(Sender: TObject);
begin
  scenario:='F8';
  setvarsettings;
end;


procedure TCountdownform.varF9ButtonClick(Sender: TObject);
begin
  scenario:='F9';
  setvarsettings;
end;


procedure TCountdownform.varF10ButtonClick(Sender: TObject);
begin
  scenario:='F10';
  setvarsettings;
end;


procedure TCountdownform.varF11ButtonClick(Sender: TObject);
begin
  scenario:='F11';
  setvarsettings;
end;

procedure TCountdownform.varF12ButtonClick(Sender: TObject);
begin
  scenario:='F12';
  setvarsettings;
end;

procedure TCountdownform.redfinalChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.redfinalendChange(Sender: TObject);
begin
  startupscenario.Text:='--';
end;

procedure TCountdownform.abcd25m1pClick(Sender: TObject);
begin
  viewturnchange;
  switchbox;
end;

procedure TCountdownform.TLleftClick(Sender: TObject);
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowTL;
  resizewindowsingleclock;
  resizewindowlabelsiconsmenu;
  if archerysystem <>'fitafin' then resizewindownonfinals  else resizewindowfinals;
  resizewindowpreclock;
  TLswitch;
end;

procedure TCountdownform.TLrightClick(Sender: TObject);
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowTL;
  resizewindowsingleclock;
  resizewindowlabelsiconsmenu;
  if archerysystem <>'fitafin' then resizewindownonfinals  else resizewindowfinals;
  resizewindowpreclock;
  TLswitch;
end;



procedure TCountdownform.usetrafficClick(Sender: TObject);
begin
  screenwidth:=Countdownform.Width;   resizewindowreferencing;
  resizewindowfinalturndetails;
  resizewindowTL;
  resizewindowsingleclock;
  resizewindowlabelsiconsmenu;
  if archerysystem <>'fitafin' then resizewindownonfinals  else resizewindowfinals;
  resizewindowpreclock;
  viewturnchange;
  viewstateone;
  TLswitch;
end;

procedure TCountdownform.soundselectChange(Sender: TObject);
begin
  updatemenu;
end;

procedure TCountdownform.testsoundClick(Sender: TObject);
begin
  soundsignal;

end;

procedure TCountdownform.starttostart;
begin
  if ((state=1) and (archerysystem<>'fitafin') and (archerysystem<>'manual') and (archerysystem<>'follow')) then
  begin
    if ((endtimout.Enabled=false) or (precountalways.Checked ))and (alarmstate<>1) then
    begin
      countdowntimer:= tostart.Value*60;
      referencetime:=getcurrenttime;

      FirstTimer.enabled:=false ;
      FirstTimer.enabled:=true ;
      state:=5;

      viewstateone;
      viewarchsystemchange;
      viewactivate;
      Checkredblink;

      viewchangestateexchange;
      viewchangestateinact;
      resizewindowpreclock;
      viewicons;
    end;
  end;
end;

procedure TCountdownform.starttocdClick(Sender: TObject);
begin
  starttostart;
  savesettings.Visible:=false;
  menuscreensize;
end;

procedure TCountdownform.countdowntostartClick(Sender: TObject);
begin
  starttostart;
end;

procedure TCountdownform.tostartChange(Sender: TObject);
begin
  countdowntostart.Caption:=(CurrToStr(tostart.value)+ ' '+Minabr);

end;

procedure TCountdownform.speakerClick(Sender: TObject);
begin
  if speaker.checked=true then
  begin
    selectsoundlabel.Enabled:=true;
    soundselect.Enabled:=true;
    testsound.Enabled:=true;
  end
  else
  begin
    selectsoundlabel.Enabled:=false;
    soundselect.Enabled:=false;
    testsound.Enabled:=false;
  end;
end;

procedure TCountdownform.updatemenu;
//update menu
begin
If showhints.checked=true then      //depending if "hints" are set to show or not, they are shown or hidden.
begin
  nexticon.showhint:=true;
  if archerysystem<>'follow'then
  begin
    Shooter1.showhint:=true;
    Shooter2.showhint:=true;
    Shooter3.showhint:=true;
    Shooter4.showhint:=true;
    Shooter5.showhint:=true;
    Shooter6.showhint:=true;
    greyleft.showhint:=true;
    greyright.showhint:=true;
  end
  else
  begin
    Shooter1.showhint:=false;
    Shooter2.showhint:=false;
    Shooter3.showhint:=false;
    Shooter4.showhint:=false;
    Shooter5.showhint:=false;
    Shooter6.showhint:=false;
    greyleft.showhint:=false;
    greyright.showhint:=false;
  end;
  enddown.showhint:=true;
  endup.showhint:=true;
  timedown.showhint:=true;
  timeup.showhint:=true;
  playpauzeicon.showhint:=true;
  stopicon.showhint:=true;
  SOicon.showhint:=true;
  preptime.showhint:=true;
  countdowntostart.showhint:=true;
  usb.showhint:=true;
  clockicon.showhint:=true;
  settings.showhint:=true;
  tdown.showhint:=true;
  tup.showhint:=true;
  shooteronearrownr.showhint:=true;
  shooteronearrow.showhint:=true;
  if archerysystem <> 'follow' then Practise.showhint:=true;
  if archerysystem <> 'follow' then serienr.showhint:=true;
  closeicon.showhint:=true;
  {$IFDEF Unix}
  shutdownicon.showhint:=true;
  {$ENDIF}
  resizeicon.showhint:=true;
  danger.ShowHint:=true;
  buzzicon3.ShowHint:=true;
  buzzicon2.ShowHint:=true;
  buzzicon1.ShowHint:=true;
  manualred.ShowHint:=true;
  manualorange.ShowHint:=true;
  manualgreen.ShowHint:=true;
  if archerysystem='manual' then
  begin
    TLredlefton.ShowHint:=true;
    TLredleftoff.ShowHint:=true;
    TLredrighton.ShowHint:=true;
    TLredrightoff.ShowHint:=true;
    TLorangelefton.ShowHint:=true;
    TLorangeleftoff.ShowHint:=true;
    TLorangerighton.ShowHint:=true;
    TLorangerightoff.ShowHint:=true;
    TLgrnlefton.ShowHint:=true;
    TLgrnleftoff.ShowHint:=true;
    TLgrnrighton.ShowHint:=true;
    TLgrnrightoff.ShowHint:=true;
  end
  else
  begin
    TLredlefton.ShowHint:=false;
    TLredleftoff.ShowHint:=false;
    TLredrighton.ShowHint:=false;
    TLredrightoff.ShowHint:=false;
    TLorangelefton.ShowHint:=false;
    TLorangeleftoff.ShowHint:=false;
    TLorangerighton.ShowHint:=false;
    TLorangerightoff.ShowHint:=false;
    TLgrnlefton.ShowHint:=false;
    TLgrnleftoff.ShowHint:=false;
    TLgrnrighton.ShowHint:=false;
    TLgrnrightoff.ShowHint:=false;
  end;
end
else
begin
  nexticon.showhint:=false;
  Shooter1.showhint:=false;
  Shooter2.showhint:=false;
  Shooter3.showhint:=false;
  Shooter4.showhint:=false;
  Shooter5.showhint:=false;
  Shooter6.showhint:=false;
  greyleft.showhint:=false;
  greyright.showhint:=false;
  enddown.showhint:=false;
  endup.showhint:=false;
  timedown.showhint:=false;
  timeup.showhint:=false;
  playpauzeicon.showhint:=false;
  stopicon.showhint:=false;
  SOicon.showhint:=false;
  preptime.showhint:=false;
  countdowntostart.showhint:=false;
  usb.showhint:=false;
  clockicon.showhint:=false;
  settings.showhint:=false;
  tdown.showhint:=false;
  tup.showhint:=false;
  shooteronearrownr.showhint:=false;
  shooteronearrow.showhint:=false;
  Practise.showhint:=false;
  serienr.showhint:=false;
  closeicon.showhint:=false;
  {$IFDEF Unix}
  shutdownicon.showhint:=false;
  {$ENDIF}
  resizeicon.showhint:=false;
  danger.ShowHint:=false;
  buzzicon3.ShowHint:=false;
  buzzicon2.ShowHint:=false;
  buzzicon1.ShowHint:=false;
  manualred.ShowHint:=false;
  manualorange.ShowHint:=false;
  manualgreen.ShowHint:=false;
  TLredlefton.ShowHint:=false;
  TLredleftoff.ShowHint:=false;
  TLredrighton.ShowHint:=false;
  TLredrightoff.ShowHint:=false;
  TLorangelefton.ShowHint:=false;
  TLorangeleftoff.ShowHint:=false;
  TLorangerighton.ShowHint:=false;
  TLorangerightoff.ShowHint:=false;
  TLgrnlefton.ShowHint:=false;
  TLgrnleftoff.ShowHint:=false;
  TLgrnrighton.ShowHint:=false;
  TLgrnrightoff.ShowHint:=false;
end;
//correct the wav file selection
  wavbuffer:=soundselect.Text;
  if (wavbuffer = 'AC1') or (wavbuffer = 'BELL1') or(wavbuffer = 'BEEP1') or (wavbuffer = 'BEEP2') or (wavbuffer = 'BEEP3') or (wavbuffer = 'BEEP4') or (wavbuffer = 'BEEP5') or (wavbuffer = 'BEEP6') or (wavbuffer = 'BEEP7') or (wavbuffer = 'BUZZER1') or (wavbuffer = 'BUZZER2') or (wavbuffer = 'BUZZER3') or (wavbuffer = 'BUZZER4') or (wavbuffer = 'BUZZER5') or (wavbuffer = 'BUZZER6') or (wavbuffer = 'BUZZER7') or (wavbuffer = 'BUZZER8') or (wavbuffer = 'FLUTE1') or (wavbuffer = 'HORN1') or (wavbuffer = 'HORN2') or (wavbuffer = 'HORN3') or (wavbuffer = 'HORN4') or (wavbuffer = 'HORN5') or (wavbuffer = 'HORN6') or (wavbuffer = 'OINK1') or (wavbuffer = 'PLOINK1')  or (wavbuffer = 'WHISTLE1') then
  begin
    if wavbuffer ='WHISTLE1' then buzzerTimer.Interval:=300 else buzzerTimer.Interval:=850;
  end
  else
  begin
    soundselect.Text:='buzzer';   //the chosen sound was not a valid sound so switched back to default sound.
    buzzerTimer.Interval:=850;
  end;
end;

procedure TCountdownform.showhintsClick(Sender: TObject);
begin
  updatemenu;
  viewchangestateexchange;
  viewchangestateactive;
  viewicons;
  viewstateone;
end;



end.
.
