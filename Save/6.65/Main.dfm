�
 TFRMMAIN 0  TPF0TfrmMainfrmMainLeftPTop� AlphaBlendValue� Caption-Miracle Programming Company - Weather RecordsClientHeight�ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 	FormStylefsStayOnTopMenumenuMainPosition
poDesignedVisible	OnCreate
FormCreate	OnDestroyFormDestroy
TextHeight TLabellblQueryRangeLeftTopOWidthHeight	AlignmenttaCenterAutoSizeCaptionlblQueryRangeFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontVisible  TButtonbtnResetLeftTopGWidthQHeightCaption&Reset formTabOrder OnClickbtnResetClick  TButtonbtnStatsLeft� TopGWidthKHeightCaption&StatsTabOrderOnClickbtnStatsClick  TPanel
panelStatsLeft�Top'WidthHeightParentBackgroundTabOrderVisible TLabelLabel1LeftHTop(Width>HeightCaptionFromFont.CharsetDEFAULT_CHARSET
Font.ColorclGreenFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel2Left�Top(Width!HeightCaptionToFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel3Left� TopWidth� Height%CaptionQuery RangeFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TMonthCalendarcalQueryEndDateLeft<TopHWidth� Height� Date      e�@TabOrder OnClickcalQueryEndDateClick  TButtonbtnRefreshStatsLeft>Top� WidthQHeightCaption&Refresh StatsTabOrderOnClickbtnRefreshStatsClick  TButtonbtnCancelRefreshLeft�Top� WidthQHeightCaption&Cancel RefreshTabOrderOnClickbtnCancelRefreshClick  TMonthCalendarcalQueryStartDateLeftTopHWidth� Height� Date      e�@TabOrderOnClickcalQueryStartDateClick  TButton
btnMidYearLeft� Top`WidthKHeightCaption	&Mid YearTabOrderOnClickbtnMidYearClick  TButtonbtnCurrentYearLeft� Top� WidthKHeightCaption&Current YearTabOrderOnClickbtnCurrentYearClick  TButtonbtnFullDatabaseLeft� Top� WidthKHeightCaption&Full DatabaseTabOrderOnClickbtnFullDatabaseClick  	TCheckBoxcbCompareToDateLeft� Top� WidthyHeight!CaptionCompare Pg 1 && 2 Date to DateChecked	State	cbCheckedTabOrderWordWrap	OnClickcbCompareToDateClick   TButtonbtnDefaultStatsLeftNTopGWidthKHeightCaption&Default StatsTabOrderOnClickbtnDefaultStatsClick  
TStatusBar
StatusBar1Left Top�Width�Height PanelsWidth�  ExplicitTopExplicitWidth�  TPanel	pnlWxGridLeftTop'Width�Height� 
BevelOuterbvNoneCaption	pnlWxGridParentBackgroundTabOrder TPageControlpgCtrTempGridLeftTop)WidthfHeightr	MultiLine	Style	tsButtonsTabOrder OnChangepgCtrTempGridChange   TPanelpnlAllStatsLeft�Top'WidthHeight� 
BevelOuterbvNoneParentBackgroundTabOrderVisible TPageControlpgCtrAllStatsLeft
Top WidthHeight� 	MultiLine	Style	tsButtonsTabOrder OnChangepgCtrAllStatsChange   TPanelpnlChartLeft TopWidth�Height
BevelOuterbvNoneParentBackgroundTabOrder TPageControl
pgCTRChartLeft�TopWidth�Height� 	MultiLine	Style	tsButtonsTabOrder OnChangepgCTRChartChange   	TMainMenumenuMainLeft�  	TMenuItemFile1Caption&File 	TMenuItem
menuImportAction	actImport  	TMenuItemmenufileOnTopActionactOnTop  	TMenuItem	menuSetupActionactSetup  	TMenuItemFileExitActionactFileExit   	TMenuItemMIHelpCaption&Help 	TMenuItemAbout1ActionactAboutBox    TActionListActionList1Left0 TActionactFileExitCategoryFileCaptionE&xit	OnExecuteactFileExitExecute  TActionactOnTopCategoryFileCaptionAlways on &Top	OnExecuteactOnTopExecute  TAction	actImportCategoryFileCaption&Import File	OnExecuteactImportExecute  TActionactBtnLACaption&LA  TAction	actBtnPhxCaption&Phoenix  TAction	actBtnSNACaptionS&NA  TActionactCloseWebFrmCaption&Close	OnExecuteactCloseWebFrmExecute  TActionactSetupCategoryFileCaption&Setup	OnExecuteactSetupExecute  TActionactAboutCaption&About	OnExecuteactAboutBoxExecute  TActionactAboutBoxCategoryFileCaption&About	OnExecuteactAboutBoxExecute   TSQLConnection
conWeather
DriverNameMSSQLLoginPromptParams.StringsUser_Name=userSchemaOverride=%.dboDriverUnit=Data.DBXMSSQLCDriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver160.bpl�DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borland.Data.DbxCommonDriver,Version=16.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1bKMetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDriver160.bpl�MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFactory,Borland.Data.DbxMSSQLDriver,Version=16.0.0.0,Culture=neutral,PublicKeyToken=91d62ebb5b0d1b1bGetDriverFunc=getSQLDriverMSSQLLibraryName=dbxmss.dllVendorLib=sqlncli10.dllVendorLibWin64=sqlncli10.dllHostName=(local)Database=weatherMaxBlobSize=-1LocaleCode=0000IsolationLevel=ReadCommittedOSAuthentication=FalsePrepareSQL=TruePassword=passwordBlobSize=-1ErrorResourceFile=OS Authentication=TruePrepare SQL=False LefthTop   