�
 TFRMMAIN 0�)  TPF0TfrmMainfrmMainLeftPTop� AlphaBlendValue� Caption-Miracle Programming Company - Weather RecordsClientHeight_ClientWidth�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.Style 	FormStylefsStayOnTopMenumenuMainOldCreateOrder	Position
poDesignedVisible	OnCreate
FormCreate	OnDestroyFormDestroyOnShowFormShowPixelsPerInch`
TextHeight TLabellblQueryRangeLeftTopGWidthHeight	AlignmenttaCenterAutoSizeCaptionlblQueryRangeFont.CharsetDEFAULT_CHARSET
Font.ColorclNavyFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontVisible  TLabellblRecordCountLeftTop0WidthqHeightAutoSizeCaptionlblRecordCount  TButtonbtnResetLeft� Top0WidthQHeightCaption&Reset formTabOrder OnClickbtnResetClick  TButtonbtnStatsLeft� Top'WidthKHeightCaption&StatsTabOrderOnClickbtnStatsClick  TPanel
panelStatsLeft�Top'WidthHeightParentBackgroundTabOrderVisible TLabelLabel1LeftHTop(Width>HeightCaptionFromFont.CharsetDEFAULT_CHARSET
Font.ColorclGreenFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel2Left�Top(Width!HeightCaptionToFont.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TLabelLabel3Left� TopWidth� Height%CaptionQuery RangeFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFont  TMonthCalendarcalQueryEndDateLeft<TopHWidth� Height� Date ���dte�@TabOrder OnClickcalQueryEndDateClick  TButtonbtnRefreshStatsLeft>Top� WidthQHeightCaption&Refresh StatsTabOrderOnClickbtnRefreshStatsClick  TButtonbtnCancelRefreshLeft�Top� WidthQHeightCaption&Cancel RefreshTabOrderOnClickbtnCancelRefreshClick  TMonthCalendarcalQueryStartDateLeftTopHWidth� Height� Date 81�dte�@TabOrderOnClickcalQueryStartDateClick  TButton
btnMidYearLeft� Top`WidthKHeightCaption	&Mid YearTabOrderOnClickbtnMidYearClick  TButtonbtnCurrentYearLeft� Top� WidthKHeightCaption&Current YearTabOrderOnClickbtnCurrentYearClick  TButtonbtnFullDatabaseLeft� Top� WidthKHeightCaption&Full DatabaseTabOrderOnClickbtnFullDatabaseClick  	TCheckBoxcbCompareToDateLeft� Top� WidthyHeight!CaptionCompare Pg 1 && 2 Date to DateChecked	State	cbCheckedTabOrderWordWrap	   TButtonbtnDefaultStatsLeftNTop'WidthKHeightCaption&Default StatsTabOrderOnClickbtnDefaultStatsClick  TPageControlpgcontrolChartLeft Top Width�Height!
ActivePage	tsHighLowStyle	tsButtonsTabOrder 	TTabSheet	tsHighLowCaptionHighs && Lows TDBChartchartHighLowLeft Top�Width�HeightBackWall.Brush.ColorclWhiteBackWall.Brush.StylebsClearTitle.Font.ColorclTealTitle.Font.Height�Title.Font.StylefsBoldfsUnderline Title.Frame.Color��  Title.Frame.Style	psDashDotTitle.Text.StringsTDBChart BottomAxis.DateTimeFormatmm/dd/yyChart3DPercentDepthAxis.AutomaticDepthAxis.AutomaticMaximumDepthAxis.AutomaticMinimumDepthAxis.Maximum ���Q���?DepthAxis.Minimum 0{�G���?DepthTopAxis.AutomaticDepthTopAxis.AutomaticMaximumDepthTopAxis.AutomaticMinimumDepthTopAxis.Maximum ���Q���?DepthTopAxis.Minimum 0{�G���?LeftAxis.Title.CaptionTempLegend.VisibleTopAxis.Title.CaptionTempView3DView3DWallsAlignalBottomTabOrder VisiblePrintMargins%%  	TCheckBoxcbLAHighLeftTopWidthKHeightCaptionLA HighsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrder OnClickcbLAHighClick  	TCheckBoxcbLALowLeftWTopWidthIHeightCaptionLA LowsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrderOnClickcbLALowClick  	TCheckBox	cbPhxHighLeft�TopWidthSHeightCaption	Phx HighsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrderOnClickcbPhxHighClick  	TCheckBoxcbPhxLowLeftRTopWidthOHeightCaptionPhx LowsChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrderOnClickcbPhxLowClick  TLineSeriesseriesHighLowHighMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Visible
DataSourceqryForChartTitleLowPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSourceiLow_001  TLineSeriesseriesHighLowLowMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Visible
DataSourceqryForChartSeriesColorclRedTitleHighPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSource	iHigh_001  TLineSeriesseriesHighLAMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Visible
DataSourceqryForChartSeriesColorclBlueTitleHighLaPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSource	iHigh_002  TLineSeriesseriesLowLAMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Visible
DataSourceqryForChartSeriesColorclBlueTitleLowLAPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSourceiLow_002    	TTabSheet	tsAverageCaptionAverage Temperature
ImageIndex TDBChartchartAverageLeft Top Width�Height
BackWall.Brush.ColorclWhiteBackWall.Brush.StylebsClearTitle.Font.ColorclTealTitle.Font.Height�Title.Font.StylefsBoldfsUnderline Title.Frame.Color��  Title.Frame.Style	psDashDotTitle.Text.StringsTDBChart BottomAxis.DateTimeFormatmm/dd/yyChart3DPercentLeftAxis.Title.CaptionTempLegend.VisibleView3DView3DWallsAlignalTopTabOrder VisiblePrintMargins&&  	TCheckBoxcbPhxAvgLeftOTopWidthaHeightCaptionPhx AverageChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclRedFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrder OnClickcbPhxAvgClick  	TCheckBoxcbLAAvgLeft7TopWidthaHeightCaption
LA AverageChecked	Font.CharsetDEFAULT_CHARSET
Font.ColorclBlueFont.Height�	Font.NameMS Sans Serif
Font.StylefsBold 
ParentFontState	cbCheckedTabOrderOnClickcbLAAvgClick  TLineSeriesseriesAverageAverageMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Visible
DataSourceqryForChartTitleAverageLinePen.WidthPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSourceAverage  TLineSeriesseriesAvgLAMarks.Arrow.Visible	Marks.Callout.Brush.ColorclBlackMarks.Callout.Arrow.Visible	Marks.Font.StylefsBold Marks.Visible
DataSourceqryForChartSeriesColorclBlueTitle	AverageLALinePen.WidthPointer.InflateMargins	Pointer.StylepsRectanglePointer.VisibleXValues.DateTime	XValues.NameXXValues.OrderloAscendingXValues.ValueSourcedtDateYValues.NameYYValues.OrderloNoneYValues.ValueSource	AverageLA     
TStatusBar
StatusBar1Left Top^Width�HeightPanelsWidth�    TPanel	pnlWxGridLeftTop'Width�Height� 
BevelOuterbvNoneCaption	pnlWxGridParentBackgroundTabOrder TPageControlpgCtrTempGridLeftTopWidthfHeight� 	MultiLine	Style	tsButtonsTabOrder    TPanelpnlAllStatsLeft�Top'WidthHeight
BevelOuterbvNoneParentBackgroundTabOrderVisible TPageControlpgCtrAllStatsLeftTopWidthHeight� 	MultiLine	Style	tsButtonsTabOrder    	TMainMenumenuMainLeft� Top 	TMenuItemFile1Caption&File 	TMenuItem
menuImportAction	actImport  	TMenuItemmenufileOnTopActionactOnTop  	TMenuItem	menuSetupActionactSetup  	TMenuItemFileExitActionactFileExit   	TMenuItemReports1Caption&ReportsVisible 	TMenuItemReportsSummaryMonthlyActionactReportsSummaryMonthlyEnabled   	TMenuItemHelp1Caption&Help 	TMenuItem	HelpAboutActionactHelpAbout    TActionListActionList1Left(Top  TActionactFileExitCategoryFileCaptionE&xit	OnExecuteactFileExitExecute  TActionactReportsSummaryMonthlyCategoryReportsCaption&Monthly Summary  TActionactHelpAboutCategoryHelpCaption&About	OnExecuteactHelpAboutExecute  TActionactOnTopCategoryFileCaptionAlways on &Top	OnExecuteactOnTopExecute  TAction	actImportCategoryFileCaption&Import File	OnExecuteactImportExecute  TActionactBtnLACaption&LA  TAction	actBtnPhxCaption&Phoenix  TAction	actBtnSNACaptionS&NA  TActionactCloseWebFrmCaption&Close	OnExecuteactCloseWebFrmExecute  TActionactSetupCategoryFileCaption&Setup	OnExecuteactSetupExecute   TDataSourcedsRecordCountDataSetspRecordCountLeftTopp  TADOConnectionconnWeather	Connected	ConnectionStringrProvider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=Weather;Data Source=cwaz1LoginPromptProvider
SQLOLEDB.1LeftTop8  TADOStoredProcspRecordCount
ConnectionconnWeatherProcedureNamempc_RecordCount;1
Parameters Left@Topp  TADOStoredProcqryForChartAutoCalcFields
ConnectionconnWeather
CursorTypectStaticProcedureNamempc_ChartData;1
ParametersName@RETURN_VALUEDataType	ftInteger	DirectionpdReturnValue	Precision
Value  Name
@NumOfDays
Attributes
paNullable DataType	ftInteger	Precision
Valuem  LeftxTopH  TADOStoredProcadoStProcLastDate
ConnectionconnWeatherProcedureNamempc_LastDate;1
Parameters LeftxTopp   