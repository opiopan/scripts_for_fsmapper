local instr = [[
----DED  LINE  1
--CNI
DEDLayout_l1["UHF Mode Rotary"] = { 1, 3, 0, "_inv", "I" }
DEDLayout_l1["UHF IncDecSymbol"] = { 5, 1 }
DEDLayout_l1["Selected UHF Frequency"] = { 6, 6 }
DEDLayout_l1["Steerpoint Use"] = { 14, 4 }
DEDLayout_l1["WPT IncDecSymbol"] = { 19, 1 }
DEDLayout_l1["Selected Steerpoint"] = { 20, 3 }
--COM
DEDLayout_l1["Secure Voice"] = { 1, 3 }
DEDLayout_l1["COM 1 Mode"] = { 5, 3 }
DEDLayout_l1["Receiver Mode"] = { 13, 4 }
DEDLayout_l1["COM 1 Power Status"] = { 13, 2 }
DEDLayout_l1["COM 2 Mode"] = { 9, 3 }
DEDLayout_l1["COM 2 Mode Voice"] = { 8, 3 }
DEDLayout_l1["Receiver Power Status"] = { 15, 2 }
DEDLayout_l1["GUARD VHF Label"] = { 8, 3 }
DEDLayout_l1["GUARD COM 2 Receiver Mode"] = { 13, 2 }
--IFF
DEDLayout_l1["STAT IFF label"] = { 1, 3 }
DEDLayout_l1["STAT IFF Power Status"] = { 5, 3 }
DEDLayout_l1["STAT Mode label"] = { 12, 3 }
DEDLayout_l1["STAT Event Occured"] = { 18, 3 }
DEDLayout_l1["POS IFF label"] = { 1, 3 }
DEDLayout_l1["POS IFF Power Status"] = { 5, 3, 0, "", "I" }
DEDLayout_l1["POS Event Occured"] = { 18, 3, 0, "", "I" }
DEDLayout_l1["POS Mode Group State"] = { 22, 1 }
DEDLayout_l1["POS IncDec Symbol"] = { 23, 1 }
DEDLayout_l1["TIM IFF label"] = { 1, 3 }
DEDLayout_l1["TIM IFF Power Status"] = { 5, 3 }
DEDLayout_l1["TIM Event Occured"] = { 18, 3, 0, "", "I" }
DEDLayout_l1["TIM Code Group State"] = { 22, 1 }
DEDLayout_l1["TIM IncDec Symbol"] = { 23, 1 }
DEDLayout_l1["IFF label"] = { 8, 3 }
DEDLayout_l1["IFF Status"] = { 12, 4 }
--List
DEDLayout_l1["LIST LIST Label"] = { 10, 4 }
DEDLayout_l1["LIST Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["LIST WPT IncDecSymbol"] = { 23, 1 }

--T-ILS
DEDLayout_l1["TCN Label"] = { 1, 3 }
DEDLayout_l1["TCN Mode"] = { 5, 3 }
DEDLayout_l1["TCN BIG OFF Label"] = { 5, 3, 0, "", "B", "OFF" }
DEDLayout_l1["ILS Label"] = { 13, 3 }
DEDLayout_l1["ILS Mode"] = { 18, 3 }
--ALOW
DEDLayout_l1["ALOW ALOW label"] = { 10, 4 }
DEDLayout_l1["ALOW Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["ALOW WPT IncDecSymbol"] = { 23, 1 }
--STPT
DEDLayout_l1["STEERPOINT LABEL"] = { 6, 4 }
DEDLayout_l1["STEERPOINT NUMBER"] = { 12, 3, 0, "_inv", "I" }
DEDLayout_l1["STEERPOINT IncDecSymbol"] = { 16, 1 }
DEDLayout_l1["STEERPOINT SEQUENCE"] = { 18, 4 }
DEDLayout_l1["STEERPOINT NUMBER Asteriscs_both"] = { 11, 1, 15, "", "I" }
DEDLayout_l1["STEERPOINT SEQUENCE Asteriscs_both"] = { 17, 1, 22, "", "I" }
-- STPT MGRS
DEDLayout_l1["STEERPOINT UTM LABEL"] = { 2, 3 }
--TIME
DEDLayout_l1["TIME_label"] = { 9, 4 }
--BINGO
DEDLayout_l1["BINGO label"] = { 9, 5 }
DEDLayout_l1["BINGO STPT Num"] = { 20, 2 }
DEDLayout_l1["BINGO IncDecSymbol"] = { 23, 1 }
--NAV
DEDLayout_l1["NAV STATUS NAV Status lbl"] = { 7, 10 }
DEDLayout_l1["NAV COMMANDS NAV Status lbl"] = { 6, 12 }
DEDLayout_l1["NAV STATUS INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["NAV STATUS INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["NAV COMMANDS INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["NAV COMMANDS INS_STPT_IncDecSymbol"] = { 23, 1 }
--MAN
DEDLayout_l1["MAN Label"] = { 10, 3 }
DEDLayout_l1["MAN STPT Num"] = { 20, 2 }
DEDLayout_l1["MAN IncDecSymbol"] = { 23, 1 }
--INS
DEDLayout_l1["INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["INS_lbl"] = { 2, 3 }
DEDLayout_l1["INS_AlignTime"] = { 7, 4 }
DEDLayout_l1["INS_AlignSlash"] = { 11, 1 }
DEDLayout_l1["INS_AlignStatusCode"] = { 12, 2 }
DEDLayout_l1["INS_Ready"] = { 15, 3 }
DEDLayout_l1["INFLT ALGN INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["INFLT ALGN INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["INFLT ALGN INS_lbl"] = { 4, 3 }
DEDLayout_l1["INFLT ALGN INS_INFLT_ALGN_lbl"] = { 8, 10 }
--CMDS
DEDLayout_l1["CMDS_Prog_label"] = { 15, 4 }
DEDLayout_l1["CMDS_Selected_Program"] = { 21, 2 }
DEDLayout_l1["CMDS_Prog_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["CMDS  BINGO CMDS_BINGO_label"] = { 5, 11 }
DEDLayout_l1["CMDS  BINGO Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["CMDS  BINGO WPT IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["CMDS_CHAFF_label"] = { 2, 9 }
DEDLayout_l1["CMDS_FLARE_label"] = { 2, 9 }
DEDLayout_l1["CMDS_OTHER1_label"] = { 2, 10 }
DEDLayout_l1["CMDS_OTHER2_label"] = { 2, 10 }
--Mode
DEDLayout_l1["MODE Master_mode_label"] = { 4, 4 }
DEDLayout_l1["MODE Master_mode"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l1["MODE Master_mode_ast_both"] = { 9, 1, 13, "", "I" }
DEDLayout_l1["MODE Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["MODE WPT IncDecSymbol"] = { 23, 1 }
-- DLNK
DEDLayout_l1["TNDL LINK16 lbl"] = { 9, 4 }
DEDLayout_l1["TNDL Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["TNDL WPT IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["NET STATUS NET STATUS lbl"] = { 5, 10 }
DEDLayout_l1["NET STATUS Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["NET STATUS WPT IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["TNDL   STN LINK16 STN lbl"] = { 7, 10 }
DEDLayout_l1["TNDL   STN Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["TNDL   STN WPT IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["AG DL lbl"] = { 7, 6 }
DEDLayout_l1["INTRAFLIGHT INTRAFLIGHT lbl"] = { 7, 11 }
--Misc
DEDLayout_l1["MISC MISC Label"] = { 10, 4 }
DEDLayout_l1["MISC Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["MISC WPT IncDecSymbol"] = { 23, 1 }
--MAGV
DEDLayout_l1["MAGV lbl"] = { 7, 4 }
DEDLayout_l1["MAGV Mode"] = { 13, 4 }
DEDLayout_l1["Asterisks_on_MAGV_Mode_both"] = { 12, 1, 17, "", "I" }
--LASER
DEDLayout_l1["LASR LASR LABEL"] = { 11, 4 }
DEDLayout_l1["LASR Selected Steerpoint"] = { 20, 3 }
DEDLayout_l1["LASR WPT IncDecSymbol"] = { 23, 1 }

--INTG
DEDLayout_l1["INTG INTG label"] = { 13, 4 }
DEDLayout_l1["INTG INTG Mode"] = { 8, 4 }
DEDLayout_l1["INTG TIM Event"] = { 20, 3 }
--HARM
DEDLayout_l1["HARM HARM"] = { 1, 4 }
DEDLayout_l1["HARM TblNum"] = { 6, 4 }
DEDLayout_l1["HARM Angles"] = { 10, 1 }
DEDLayout_l1["HARM T1"] = { 14, 2 }
DEDLayout_l1["HARM T1_code"] = { 18, 3, 0, "_inv", "I" }
DEDLayout_l1["HARM Asterisks_T1_both"] = { 17, 1, 21, "", "I" }
-- VIP
DEDLayout_l1["Visual initial point to TGT Label"] = { 6, 10, 0, "_inv", "I" }
DEDLayout_l1["VIP to TGT Label Asteriscs_both"] = { 5, 1, 16, "", "I" }
-- VRP
DEDLayout_l1["Target to VRP Label"] = { 6, 10, 0, "_inv", "I" }
DEDLayout_l1["Target to VRP Label Asteriscs_both"] = { 5, 1, 16, "", "I" }
--HMCS
DEDLayout_l1["HMCS DISPLAY HMCS_DISPLAY_label"] = { 7, 12 }
DEDLayout_l1["HMCS DISPLAY INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["HMCS DISPLAY INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["HMCS ALIGN HMCS_ALIGN_label"] = { 6, 10 }
DEDLayout_l1["HMCS ALIGN INS_SelectedSteerpoint"] = { 20, 2 }
DEDLayout_l1["HMCS ALIGN INS_STPT_IncDecSymbol"] = { 23, 1 }
--BULL
DEDLayout_l1["BULLSEYE LABEL"] = { 6, 8, 0, "_inv", "I" }
DEDLayout_l1["BULLSEYE LABEL Asteriscs_both"] = { 5, 1, 14, "", "I" }
--MARK
DEDLayout_l1["MARK"] = { 1, 4 }
DEDLayout_l1["MARK SOURCE"] = { 7, 4 }
DEDLayout_l1["MARK SOURCE Asteriscs_both"] = { 6, 1, 11, "", "I" }
DEDLayout_l1["STPT NUMBER"] = { 14, 3, 0, "_inv", "I" }
DEDLayout_l1["MARK IncDecSymbol"] = { 17, 1 }
DEDLayout_l1["MARK Number Asteriscs_both"] = { 13, 1, 18, "", "I" }
DEDLayout_l1["STPT"] = { 19, 4 }
--DEST DIR
DEDLayout_l1["DEST_DIR"] = { 2, 8 }
DEDLayout_l1["DEST_DIR_SelectedSteerpoint"] = { 12, 3, 0, "_inv", "I" }
DEDLayout_l1["DEST_DIR_STPT_IncDecSymbol"] = { 16, 1 }
DEDLayout_l1["Asterisks_NUM_STEERPOINT_both"] = { 11, 1, 14, "", "I" }
--UMT DIR
DEDLayout_l1["UTM_DEST"] = { 2, 8 }
DEDLayout_l1["UTM_DEST_SelectedSteerpoint"] = { 12, 3, 0, "_inv", "I" }
DEDLayout_l1["UTM_DEST_STPT_IncDecSymbol"] = { 16, 1 }
DEDLayout_l1["Asterisks_NUM_STEERPOINT_both"] = { 11, 1, 15, "", "I" }
--DEST OA1
DEDLayout_l1["DEST_OA1"] = { 2, 8 }
DEDLayout_l1["DEST_OA1_SelectedSteerpoint"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l1["DEST_OA1_STPT_IncDecSymbol"] = { 15, 1 }
DEDLayout_l1["Asterisks_NUM_STEERPOINT"] = { 10, 1, 14, "", "I" }
--DEST OA2
DEDLayout_l1["DEST_OA2"] = { 2, 8 }
DEDLayout_l1["DEST_OA2_SelectedSteerpoint"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l1["DEST_OA2_STPT_IncDecSymbol"] = { 15, 1 }
DEDLayout_l1["Asterisks_NUM_STEERPOINT"] = { 10, 1, 14, "", "I" }
--CRUS TOS
DEDLayout_l1["CRUS_MODE"] = { 7, 4 }
DEDLayout_l1["INS_SelectedSteerpoint"] = { 20, 3 }
DEDLayout_l1["INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["TOS_MODE"] = { 13, 3, 0, "_inv", "I" }
DEDLayout_l1["Asterisks_TOS_MODE_both"] = { 12, 1, 16, "", "I" }
--CRUS EDR
DEDLayout_l1["EDR_MODE"] = { 13, 4, 0, "_inv", "I" }
DEDLayout_l1["Asterisks_RNG_MODE_both"] = { 12, 1, 16, "", "I" }
--CRUS HOME
DEDLayout_l1["HOME CRUS_MODE"] = { 7, 4 } --added for duplicated label & different label size
DEDLayout_l1["HOME HOME_MODE"] = { 13, 4, 0, "_inv", "I" }
DEDLayout_l1["HOME Asterisks_RNG_MODE_both"] = { 12, 1, 17, "", "I" }
--CRUS RNG
DEDLayout_l1["RNG_MODE"] = { 13, 3, 0, "_inv", "I" }
DEDLayout_l1["Asterisks_RNG_MODE_both"] = { 12, 1, 16, "", "I" }
--FIX
DEDLayout_l1["FIX FIX_SENSORS"] = { 6, 3 }
DEDLayout_l1["FIX FIX_SelectedSensors"] = { 11, 4, 0, "_inv", "I" }
DEDLayout_l1["FIX Asterisks_FIX_SENSORS_both"] = { 10, 1, 15, "", "I" }
--A CAL MAN
DEDLayout_l1["ACAL_SENSORS"] = { 1, 4 }
DEDLayout_l1["ACAL_SelectedSensors"] = { 8, 4, 0, "_inv", "I" }
DEDLayout_l1["Asterisks_ACAL_SENSORS_both"] = { 7, 1, 12, "", "I" }
DEDLayout_l1["ACAL_ALT_label"] = { 14, 4, 0, "_inv", "I" }
--A CAL AUTO
DEDLayout_l1["INS_SelectedSteerpoint"] = { 20, 3 }
DEDLayout_l1["INS_STPT_IncDecSymbol"] = { 23, 1 }
DEDLayout_l1["AUTO_ACAL"] = { 1, 9 }
DEDLayout_l1["ACAL_AUTO_Sensors"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l1["Asterisks_AUTO_both"] = { 11, 1, 16, "", "I" }
--HTS MAN
DEDLayout_l1["HTS MAN HTS"] = { 8, 7 }
--HTS SEAD
DEDLayout_l1["HTS"] = { 4, 4 }

--DEDLayout_l1[""] = {,}

----DED LINE 2
--TODO
DEDLayout_l2["TODO remove lbl"] = { 4, 20 }
--CNI
DEDLayout_l2["UHF Status"] = { 1, 1 }
DEDLayout_l2["Default Value Indication"] = { 11, 1 }
DEDLayout_l2["Wind Magnetic Direction"] = { 16, 2 }
DEDLayout_l2["Wind Speed"] = { 20, 2 }
--COM
DEDLayout_l2["Active Frequency or Channel"] = { 2, 6 }
DEDLayout_l2["Active Frequency or Channe"] = { 2, 6 }
--IFF
DEDLayout_l2["STAT Mode Asterisks_both"] = { 17, 1, 23, "", "I" }
DEDLayout_l2["STAT Mode Scratchpad"] = { 18, 5, 0, "_inv", "I" }
--List
DEDLayout_l2["List Item 1 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l2["List Item 1 Name"] = { 1, 4 }
DEDLayout_l2["List Item 2 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l2["List Item 2 Name"] = { 7, 4 }
DEDLayout_l2["List Item 3 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l2["List Item 3 Name"] = { 13, 4 }
DEDLayout_l2["List Item R Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l2["List Item R Name"] = { 19, 4 }
--STPT
DEDLayout_l2["STEERPOINT Latitude"] = { 3, 3 }
DEDLayout_l2["STEERPOINT Latitude Value"] = { 8, 12, 0, "_inv", "I" }
DEDLayout_l2["STEERPOINT Latitude Asteriscs_both"] = { 7, 1, 20, "", "I" }
-- STPT MGRS
DEDLayout_l2["STEERPOINT GRID"] = { 6, 4 }
DEDLayout_l2["STEERPOINT GRID DIGIT Value"] = { 12, 2, 0, "_inv", "I" }
DEDLayout_l2["STEERPOINT GRID SYMBOL Value"] = { 14, 1, 0, "_inv", "I" }
DEDLayout_l2["STEERPOINT GRID DIGIT Asteriscs_both"] = { 11, 1, 15, "", "I" }
DEDLayout_l2["STEERPOINT GRID SYMBOL Asteriscs_both"] = { 11, 1, 15, "", "I" }
DEDLayout_l2["STEERPOINT GRID CNVRT"] = { 17, 5, 0, "_inv", "I" }
DEDLayout_l2["STEERPOINT CNVRT Asteriscs_both"] = { 16, 1, 22, "", "I" }
--TIME
DEDLayout_l2["SYSTEM_label"] = { 4, 6 }
DEDLayout_l2["GPS_SYSTEM_label"] = { 0, 10 }
DEDLayout_l2["SYSTEM_value"] = { 13, 8, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_on_SYSTEM_both"] = { 12, 1, 21, "", "I" }
--NAV
DEDLayout_l2["NAV STATUS SYS ACCURACY label"] = { 3, 9 }
DEDLayout_l2["NAV STATUS SYS ACCURACY value"] = { 14, 4 }
--MAN
DEDLayout_l2["WSPAN Label"] = { 6, 5 }
DEDLayout_l2["WSPAN DATA"] = { 13, 5, 0, "_inv", "I" }
DEDLayout_l2["WSPAN Asteriscs_both"] = { 12, 1, 18, "", "I" }
--INS
DEDLayout_l2["INS_LAT_lbl"] = { 2, 3 }
DEDLayout_l2["INS_LAT_Scratchpad"] = { 7, 10, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_on_LAT_Scratchpad_both"] = { 6, 1, 17, "", "I" }
--CMDS
DEDLayout_l2["CMDS_BQ_lbl"] = { 6, 2 }
DEDLayout_l2["CMDS_BQ_Scratchpad"] = { 10, 2, 0, "_inv", "I" }
DEDLayout_l2["CMDS_BQ_Asterisks_both"] = { 9, 1, 12, "", "I" }
DEDLayout_l2["CMDS_CH_lbl"] = { 2, 2 }
DEDLayout_l2["CMDS_CH_Scratchpad"] = { 7, 2, 0, "_inv", "I" }
DEDLayout_l2["CMDS_CH_Asterisks_both"] = { 6, 1, 9, "", "I" }
-- DLNK
DEDLayout_l2["FC lbl"] = { 3, 2 }
DEDLayout_l2["FC value"] = { 6, 3, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on FC_both"] = { 5, 1, 9, "", "I" }
DEDLayout_l2["CallSign Name char1"] = { 11, 1, 0, "_inv", "I" }
DEDLayout_l2["CallSign Name char2"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on CS Name_both"] = { 10, 1, 13, "", "I" }
DEDLayout_l2["VCS IncDecSymbol"] = { 14, 1 }
DEDLayout_l2["CallSign Number"] = { 16, 2, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on CS Number_both"] = { 15, 1, 18, "", "I" }
DEDLayout_l2["STN id lbl_1"] = { 0, 1 }
DEDLayout_l2["STN TDOA value_1"] = { 2, 1, 0, "_inv", "I" }
DEDLayout_l2["STN value_1"] = { 4, 5, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on STN TDOA_1_both"] = { 1, 1, 3, "", "I" }
DEDLayout_l2["Asterisks on STN_1_both"] = { 3, 1, 9, "", "I" }
DEDLayout_l2["STN id lbl_5"] = { 10, 2 }
DEDLayout_l2["STN TDOA value_5"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l2["STN value_5"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on STN TDOA_5_both"] = { 11, 1, 13, "", "I" }
DEDLayout_l2["Asterisks on STN_5_both"] = { 13, 1, 19, "", "I" }
DEDLayout_l2["OWN lbl"] = { 20, 3 }
DEDLayout_l2["GPS TIME lbl"] = { 0, 8 }
DEDLayout_l2["GPS TIME status"] = { 9, 3, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on ETR_both"] = { 8, 1, 12, "", "I" }
DEDLayout_l2["IPF Reset lbl"] = { 14, 9, 0, "_inv", "I" }
DEDLayout_l2["Asterisks on IPF_both"] = { 13, 1, 23, "", "I" }
DEDLayout_l2["A-G DL XMT lbl"] = { 3, 3 }
DEDLayout_l2["A-G DL XMT value"] = { 7, 2 }
DEDLayout_l2["A-G DL COMM lbl"] = { 12, 4 }
DEDLayout_l2["A-G DL COMM status"] = { 17, 3 }
DEDLayout_l2["INTRAFLIGHT STN id lbl1"] = { 1, 2 }
DEDLayout_l2["INTRAFLIGHT STN value1"] = { 4, 5 }
DEDLayout_l2["INTRAFLIGHT STN id lbl5"] = { 7, 2 }
DEDLayout_l2["INTRAFLIGHT STN value5"] = { 10, 5 }
DEDLayout_l2["INTRAFLIGHT COMM lbl"] = { 13, 4 }
DEDLayout_l2["INTRAFLIGHT COMM status"] = { 18, 3 }
--Misc
DEDLayout_l2["Misc Item 1 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l2["Misc Item 1 Name"] = { 1, 4 }
DEDLayout_l2["Misc Item 2 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l2["Misc Item 2 Name"] = { 7, 4 }
DEDLayout_l2["Misc Item 3 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l2["Misc Item 3 Name"] = { 13, 4 }
DEDLayout_l2["Misc Item R Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l2["Misc Item R Name"] = { 19, 4 }
--LASER
DEDLayout_l2["TGP CODE LABEL"] = { 1, 8 }
DEDLayout_l2["TGP CODE VALUE"] = { 13, 4, 0, "_inv", "I" }
DEDLayout_l2["TGP CODE Asteriscs_both"] = { 12, 1, 17, "", "I" }
--HARM
DEDLayout_l2["HARM T2"] = { 14, 2 }
DEDLayout_l2["HARM T2_code"] = { 18, 3, 0, "_inv", "I" }
DEDLayout_l2["HARM Asterisks_T2_both"] = { 17, 1, 21, "", "I" }
-- VIP
DEDLayout_l2["Visual initial point number"] = { 5, 3 }
DEDLayout_l2["VIP number value"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l2["VIP number up down arrows"] = { 14, 1 }
DEDLayout_l2["VIP number Asteriscs_both"] = { 9, 1, 13, "", "I" }
-- VRP
DEDLayout_l2["Target number"] = { 5, 3 }
DEDLayout_l2["Target number value"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l2["Target number up down arrows"] = { 14, 1 }
DEDLayout_l2["Target number Asteriscs_both"] = { 9, 1, 13, "", "I" }
--HMCS
DEDLayout_l2["HMCS DISPLAY HMCS_HUD_BLANK"] = { 3, 8, 0, "_inv", "I" }
DEDLayout_l2["HMCS DISPLAY Asterisks_HUD_BLANK_both"] = { 2, 1, 11, "", "I" }
DEDLayout_l2["HMCS ALIGN HMCS_COARSE"] = { 2, 6, 0, "_inv", "I" }
DEDLayout_l2["HMCS ALIGN Asterisks_COARSE_both"] = { 1, 1, 8, "", "I" }
--BULL
DEDLayout_l2["BULL POINT LABEL"] = { 6, 4 }
DEDLayout_l2["BULLSEYE NUMBER"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l2["BULLSEYE IncDecSymbol"] = { 16, 1 }
DEDLayout_l2["BULLSEYE SEQUENCE Asteriscs_both"] = { 11, 1, 15, "", "I" }
--MARK
DEDLayout_l2["MARK Latitude"] = { 2, 3 }
DEDLayout_l2["MARK Latitude Value"] = { 6, 12, 0, "_inv", "I" }
DEDLayout_l2["MARK Latitude Asteriscs_both"] = { 5, 1, 18, "", "I" }
--DEST DIR
DEDLayout_l2["DEST_LAT"] = { 3, 3 }
DEDLayout_l2["LAT"] = { 8, 12, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_LAT_both"] = { 7, 1, 20, "", "I" }
--UTM DEST
DEDLayout_l2["UTM_DEST_GRID"] = { 6, 4 }
DEDLayout_l2["GRID_DIGIT"] = { 12, 2, 0, "_inv", "I" }
DEDLayout_l2["GRID_SYMBOL"] = { 14, 1, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_GRID_DIGIT_both"] = { 11, 1, 15, "", "I" }
DEDLayout_l2["Asterisks_GRID_SYMBOL_both"] = { 11, 1, 15, "", "I" }
DEDLayout_l2["UTM_DEST_CNVRT"] = { 18, 5, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_CNVRT_both"] = { 17, 1, 23, "", "I" }
--CRUS TOS
DEDLayout_l2["TOS_SYSTEM_TIME_label"] = { 7, 4 }
DEDLayout_l2["TOS_SYSTEM_TIME_value"] = { 13, 8 }
--CRUS EDR
DEDLayout_l2["EDR_STPT_NUM"] = { 7, 4 }
DEDLayout_l2["EDR_INS_SelectedSteerpoint"] = { 12, 3 }
DEDLayout_l2["EDR_INS_STPT_IncDecSymbol"] = { 16, 1 }
--CRUS HOME
DEDLayout_l2["HOME_STPT_NUM"] = { 7, 4 }
DEDLayout_l2["Asterisks_HOME_STPT_NUM_both"] = { 11, 1, 17, "", "I" }
DEDLayout_l2["HOME_INS_SelectedSteerpoint"] = { 12, 3, 0, "_inv", "I" }
DEDLayout_l2["HOME_INS_STPT_IncDecSymbol"] = { 16, 1 }
--CRUS RNG
DEDLayout_l2["RNG_STPT_NUM"] = { 7, 4 }
DEDLayout_l2["RNG_INS_SelectedSteerpoint"] = { 12, 3 }
DEDLayout_l2["RNG_INS_STPT_IncDecSymbol"] = { 16, 1 }
--FIX
DEDLayout_l2["FIX FIX_STPT"] = { 4, 4 }
DEDLayout_l2["FIX INS_SelectedSteerpoint"] = { 10, 3, 0, "_inv", "I" }
DEDLayout_l2["FIX Asterisks_STPT_NUMBER_both"] = { 9, 1, 13, "", "I" }
DEDLayout_l2["FIX INS_STPT_IncDecSymbol"] = { 14, 1 }
--A CAL MAN
DEDLayout_l2["ACAL_MODE"] = { 8, 4 }
DEDLayout_l2["Asterisks_ACAL_SelectedMode_both"] = { 7, 1, 12, "", "I" }
--A CAL AUTO
DEDLayout_l2["NAV_FILTER_label"] = { 2, 10 }
DEDLayout_l2["NAV_FILTER_mode"] = { 14, 4 }
--HTS MAN
DEDLayout_l2["T1"] = { 1, 1 }
DEDLayout_l2["T1_code"] = { 3, 4, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_T1_both"] = { 2, 1, 7, "", "I" }
DEDLayout_l2["T5"] = { 10, 1 }
DEDLayout_l2["T5_code"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l2["Asterisks_T5_both"] = { 11, 1, 16, "", "I" }
--HTS SEAD
DEDLayout_l2["HTS_LAT_lbl"] = { 2, 3 }
DEDLayout_l2["HTS_LAT"] = { 7, 10 }
--DEDLayout_l2[""] = {,}

----DED LINE 3
--CNI
DEDLayout_l3["VHF Label"] = { 1, 3, 0, "_inv", "I" }
DEDLayout_l3["VHF IncDecSymbol"] = { 5, 1 }
DEDLayout_l3["Selected VHF Frequency"] = { 6, 6 }
DEDLayout_l3["System Time"] = { 15, 8 }
--COM
DEDLayout_l3["Scratchpad"] = { 14, 6, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on Scratchpad_both"] = { 13, 1, 20, "", "I" }
DEDLayout_l3["Guard or Backup Status"] = { 9, 5 }
DEDLayout_l3["GUARD COM 2 Receiver Band"] = { 8, 2 }
DEDLayout_l3["GUARD Guard Label"] = { 12, 5 }
--IFF
DEDLayout_l3["STAT M1 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l3["STAT M1 Lockout Status"] = { 3, 1 }
DEDLayout_l3["STAT M1 Code"] = { 4, 2 }
DEDLayout_l3["STAT M4 Mode"] = { 8, 2, 0, "_inv", "I" }
DEDLayout_l3["STAT M4 Code"] = { 12, 1 }
DEDLayout_l3["STAT M4 Key"] = { 14, 3 }
DEDLayout_l3["STAT POS EVENT - Side"] = { 19, 1 }
DEDLayout_l3["STAT POS EVENT - OF"] = { 20, 2 }
DEDLayout_l3["STAT POS EVENT - Number"] = { 22, 1 }
DEDLayout_l3["POS M1 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l3["POS M1 Lockout Status"] = { 3, 1 }
DEDLayout_l3["POS M1 Code"] = { 4, 5 }
DEDLayout_l3["POS M4 Mode"] = { 9, 2, 0, "_inv", "I" }
DEDLayout_l3["POS M4 Code"] = { 13, 1 }
DEDLayout_l3["POS M4 Key"] = { 14, 2 }
DEDLayout_l3["POS Mode Asterisks_both"] = { 18, 1, 23, "", "I" }
DEDLayout_l3["POS Mode Scratchpad"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l3["TIM M1 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l3["TIM M1 Lockout Status"] = { 3, 1 }
DEDLayout_l3["TIM M1 Code"] = { 4, 5 }
DEDLayout_l3["TIM M4 Mode"] = { 9, 2, 0, "_inv", "I" }
DEDLayout_l3["TIM M4 Code"] = { 13, 1 }
DEDLayout_l3["TIM M4 Key"] = { 14, 2 }
DEDLayout_l3["TIM Mode Asterisks_both"] = { 18, 1, 23, "", "I" }
DEDLayout_l3["TIM Mode Scratchpad"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l3["BACKUP label"] = { 9, 6 }
--List
DEDLayout_l3["List Item 4 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l3["List Item 4 Name"] = { 1, 4 }
DEDLayout_l3["List Item 5 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l3["List Item 5 Name"] = { 7, 4 }
DEDLayout_l3["List Item 6 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l3["List Item 6 Name"] = { 13, 4 }
DEDLayout_l3["List Item E Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l3["List Item E Name"] = { 19, 4 }
--T-ILS
DEDLayout_l3["TILS Scratchpad"] = { 8, 6, 0, "_inv", "I" }
DEDLayout_l3["TILS Asterisks_both"] = { 7, 1, 14, "", "I" }
DEDLayout_l3["ILS CMD STRG"] = { 15, 8 }
DEDLayout_l3["TCN BCN Label"] = { 0, 3 }
DEDLayout_l3["TCN BCN ID"] = { 4, 3 }
--ALOW
DEDLayout_l3["CARA ALOW label"] = { 3, 9 }
DEDLayout_l3["CARA ALOW Scratchpad"] = { 15, 7, 0, "_inv", "I" }
DEDLayout_l3["CARA ALOW Asterisks_both"] = { 14, 1, 22, "", "I" }
--STPT
DEDLayout_l3["STEERPOINT Longitude"] = { 3, 3 }
DEDLayout_l3["STEERPOINT Longitude Value"] = { 8, 12, 0, "_inv", "I" }
DEDLayout_l3["STEERPOINT Longitude Asteriscs_both"] = { 7, 1, 20, "", "I" }
-- STPT MGRS
DEDLayout_l3["STEERPOINT SQUARE"] = { 4, 6 }
DEDLayout_l3["STEERPOINT SQUARE Value1"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l3["STEERPOINT SQUARE Value2"] = { 13, 1, 0, "_inv", "I" }
DEDLayout_l3["STEERPOINT SQUARE Asteriscs_both"] = { 11, 1, 14, "", "I" }
DEDLayout_l3["STEERPOINT SQUARE2 Asteriscs_both"] = { 11, 1, 14, "", "I" }
--TIME
DEDLayout_l3["HACK_label"] = { 6, 4 }
DEDLayout_l3["HACK_value"] = { 13, 8, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_on_HACK_both"] = { 12, 1, 21, "", "I" }
DEDLayout_l3["HACK_IncDecSymbol"] = { 23, 1 }
--BINGO
DEDLayout_l3["SET label"] = { 6, 3 }
DEDLayout_l3["BINGO Asterisks_both"] = { 10, 1, 19, "", "I" }
DEDLayout_l3["BINGO Scratchpad"] = { 11, 8, 0, "_inv", "I" }
--NAV
DEDLayout_l3["NAV STATUS GPS ACCURACY label"] = { 3, 9 }
DEDLayout_l3["NAV STATUS GPS ACCURACY value"] = { 14, 5 }
DEDLayout_l3["NAV COMMANDS FILTER MODE label"] = { 3, 11 }
DEDLayout_l3["NAV COMMANDS FILTER MODE value"] = { 16, 4 }
DEDLayout_l3["NAV COMMANDS Asterisks_both"] = { 15, 1, 20, "", "I" }
--MAN
DEDLayout_l3["MBAL Label"] = { 10, 4 }
--INS
DEDLayout_l3["INS_LNG_lbl"] = { 2, 3 }
DEDLayout_l3["INS_LNG_Scratchpad"] = { 7, 10, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_on_LNG_Scratchpad_both"] = { 6, 1, 17, "", "I" }
DEDLayout_l3["INFLT ALGN INS_COMPASS_HDG_lbl"] = { 3, 11 }
DEDLayout_l3["INFLT ALGN INS_CompassHdgScratchpad"] = { 16, 4, 0, "_inv", "I" }
DEDLayout_l3["INFLT ALGN Asterisks on Scratchpad_both"] = { 15, 1, 20, "", "I" }
--CMDS
DEDLayout_l3["CMDS_BI_lbl"] = { 6, 2 }
DEDLayout_l3["CMDS_BI_Scratchpad"] = { 10, 6, 0, "_inv", "I" }
DEDLayout_l3["CMDS_BI_Asterisks_both"] = { 9, 1, 16, "", "I" }
DEDLayout_l3["CMDS_FL_lbl"] = { 2, 2 }
DEDLayout_l3["CMDS_FL_Scratchpad"] = { 7, 2, 0, "_inv", "I" }
DEDLayout_l3["CMDS_FL_Asterisks_both"] = { 6, 1, 9, "", "I" }
DEDLayout_l3["CMDS_FDBK_lbl"] = { 11, 4 }
DEDLayout_l3["CMDS_FDBK_value"] = { 19, 3, 0, "_inv", "I" }
DEDLayout_l3["CMDS_FDBK_Asterisks_both"] = { 18, 1, 22, "", "I" }
-- DLNK
DEDLayout_l3["MC lbl"] = { 3, 2 }
DEDLayout_l3["MC value"] = { 6, 3, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on MC_both"] = { 5, 1, 9, "", "I" }
DEDLayout_l3["FL lbl"] = { 12, 2 }
DEDLayout_l3["FL status"] = { 16, 3, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on FL_both"] = { 15, 1, 19, "", "I" }
DEDLayout_l3["NUM lbl"] = { 20, 1 }
DEDLayout_l3["Own num value"] = { 22, 1, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on Own_both"] = { 21, 1, 23, "", "I" }
DEDLayout_l3["TIME lbl"] = { 4, 4 }
DEDLayout_l3["TIME value"] = { 9, 8, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on TIME_both"] = { 8, 1, 17, "", "I" }

DEDLayout_l3["STN id lbl_2"] = { 0, 1 }
DEDLayout_l3["STN TDOA value_2"] = { 2, 1, 0, "_inv", "I" }
DEDLayout_l3["STN value_2"] = { 4, 5, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on STN TDOA_2_both"] = { 1, 1, 3, "", "I" }
DEDLayout_l3["Asterisks on STN_2_both"] = { 3, 1, 9, "", "I" }
DEDLayout_l3["STN id lbl_6"] = { 10, 2 }
DEDLayout_l3["STN TDOA value_6"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l3["STN value_6"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l3["Asterisks on STN TDOA_6_both"] = { 11, 1, 13, "", "I" }
DEDLayout_l3["Asterisks on STN_6_both"] = { 13, 1, 19, "", "I" }
-- DEDLayout_l3["OWN lbl"] = {3,3}
DEDLayout_l3["OWN value"] = { 7, 2 }
DEDLayout_l3["DATA lbl"] = { 12, 4 }
DEDLayout_l3["DATA value"] = { 7, 3 }
DEDLayout_l3["INTRAFLIGHT STN id lbl2"] = { 1, 2 }
DEDLayout_l3["INTRAFLIGHT STN value2"] = { 4, 5 }
DEDLayout_l3["INTRAFLIGHT STN id lbl6"] = { 7, 2 }
DEDLayout_l3["INTRAFLIGHT STN value6"] = { 10, 5 }
DEDLayout_l3["INTRAFLIGHT DATA lbl"] = { 13, 4 }
DEDLayout_l3["INTRAFLIGHT DATA value"] = { 18, 3 }
--Misc
DEDLayout_l3["Misc Item 4 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l3["Misc Item 4 Name"] = { 1, 4 }
DEDLayout_l3["Misc Item 5 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l3["Misc Item 5 Name"] = { 7, 4 }
DEDLayout_l3["Misc Item 6 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l3["Misc Item 6 Name"] = { 13, 4 }
DEDLayout_l3["Misc Item E Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l3["Misc Item E Name"] = { 19, 4 }
--MAGV
DEDLayout_l3["INS_MAGV_Scratchpad"] = { 9, 6, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_on_MAGV_Scratchpad_both"] = { 8, 1, 15, "", "I" }
--LASER
DEDLayout_l3["LST CODE LABEL"] = { 1, 8 }
DEDLayout_l3["LST CODE VALUE"] = { 13, 4, 0, "_inv", "I" }
DEDLayout_l3["LST CODE Asteriscs_both"] = { 12, 1, 17, "", "I" }
--INTG
DEDLayout_l3["INTG M1 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l3["INTG M1 Decoupled Status"] = { 3, 1 }
DEDLayout_l3["INTG M1 Code"] = { 4, 2 }
DEDLayout_l3["INTG M4 Mode"] = { 16, 2, 0, "_inv", "I" }
DEDLayout_l3["INTG M4 Decoupled Status"] = { 19, 1 }
DEDLayout_l3["INTG M4 Code"] = { 20, 1, 0, "_inv", "I" }
DEDLayout_l3["INTG M4 Key"] = { 21, 3 }
--HARM
DEDLayout_l3["HARM T3"] = { 14, 2 }
DEDLayout_l3["HARM T3_code"] = { 18, 3, 0, "_inv", "I" }
DEDLayout_l3["HARM Asterisks_T3_both"] = { 17, 1, 21, "", "I" }
-- VIP
DEDLayout_l3["VIP bearing"] = { 4, 4 }
DEDLayout_l3["VIP bearing value"] = { 10, 6, 0, "_inv", "I" }
DEDLayout_l3["VIP bearing Asteriscs_both"] = { 9, 1, 16, "", "I" }
-- VRP
DEDLayout_l3["Target bearing"] = { 4, 4 }
DEDLayout_l3["Target bearing value"] = { 10, 6, 0, "_inv", "I" }
DEDLayout_l3["Target bearing Asteriscs_both"] = { 9, 1, 16, "", "I" }
--HMCS
DEDLayout_l3["HMCS DISPLAY HMCS_CKPT_BLANK"] = { 3, 9, 0, "_inv", "I" }
DEDLayout_l3["HMCS DISPLAY Asterisks_CKPT_BLANK_both"] = { 2, 1, 12, "", "I" }
DEDLayout_l3["HMCS ALIGN HMCS_AZ_EL"] = { 2, 5, 0, "_inv", "I" }
DEDLayout_l3["HMCS ALIGN Asterisks_AZ_ELAZ_EL_both"] = { 1, 1, 7, "", "I" }
--MARK
DEDLayout_l3["MARK Longitude"] = { 2, 3 }
DEDLayout_l3["MARK Longitude Value"] = { 6, 12, 0, "_inv", "I" }
DEDLayout_l3["MARK Longitude Asteriscs_both"] = { 5, 1, 18, "", "I" }
--DEST_DIR
DEDLayout_l3["DEST_LON"] = { 3, 3 }
DEDLayout_l3["LON"] = { 8, 12, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_LON_both"] = { 7, 1, 20, "", "I" }
--UMT DEST
DEDLayout_l3["UTM_DEST_SQUARE"] = { 4, 6 }
DEDLayout_l3["SQUARE"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l3["SQUARE2"] = { 13, 1, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_SQUARE_both"] = { 11, 1, 14, "", "I" }
DEDLayout_l3["Asterisks_SQUARE2_both"] = { 11, 1, 14, "", "I" }
--DEST 0A1
DEDLayout_l3["DEST_OA1_RNG"] = { 3, 3 }
DEDLayout_l3["RNG"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_RNG_both"] = { 7, 1, 16, "", "I" }
--DEST 0A1
DEDLayout_l3["DEST_OA2_RNG"] = { 3, 3 }
DEDLayout_l3["RNG"] = { 8, 8, 0, "_inv", "I" }
-- DEDLayout_l3["Asterisks_RNG_both"] = {7,1,16,"","I"}
--CRUS TOS
DEDLayout_l3["TOS_DES_TOS_label"] = { 4, 7 }
DEDLayout_l3["TOS_DES_TOS_value"] = { 13, 8, 0, "_inv", "I" } -- Frk
DEDLayout_l3["Asterisks_DES_TOS_both"] = { 12, 1, 21, "", "I" }
--CRUS EDR
DEDLayout_l3["EDR_TO_BINGO_label"] = { 4, 7 }
DEDLayout_l3["EDR_TO_BINGO_value"] = { 13, 8 }
--CRUS HOME
DEDLayout_l3["HOME_FUEL_REMANING"] = { 7, 4 }
DEDLayout_l3["HOME_FUEL_REMANING_Value"] = { 12, 8 }
--CRUS RNG
DEDLayout_l3["RNG_FUEL_REMANING"] = { 7, 4 }
DEDLayout_l3["RNG_FUEL_REMANING_Value"] = { 12, 8 }
--FIX
DEDLayout_l3["FIX FIX_DELTA"] = { 3, 5 }
DEDLayout_l3["FIX DELTA"] = { 13, 7 }
--A CAL MAN
DEDLayout_l3["ACAL ACAL_ALEV"] = { 8, 4 }
DEDLayout_l3["ACAL ELEV"] = { 16, 7, 0, "_inv", "I" }
DEDLayout_l3["ACAL Asterisks_ELEV_both"] = { 15, 1, 23, "", "I" }
--A CAL AUTO
DEDLayout_l3["GPS_ACCURACY_label"] = { 3, 9 }
DEDLayout_l3["GPS_ACCURACY_value"] = { 14, 4 }
--HTS MAN
DEDLayout_l3["T2"] = { 1, 1 }
DEDLayout_l3["T2_code"] = { 3, 4, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_T2_both"] = { 2, 1, 7, "", "I" }
DEDLayout_l3["T6"] = { 10, 1 }
DEDLayout_l3["T6_code"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l3["Asterisks_T6_both"] = { 11, 1, 16, "", "I" }
--HTS SEAD
DEDLayout_l3["HTS_LNG_lbl"] = { 2, 3 }
DEDLayout_l3["HTS_LNG"] = { 7, 10 }

--DEDLayout_l3[""] = {,}

----DED LINE 4
--TODO
DEDLayout_l4["TODO remove label"] = { 4, 20 }
--CNI
DEDLayout_l4["VHF Status"] = { 1, 1 }
DEDLayout_l4["Hack Time"] = { 15, 8 }
--COM
DEDLayout_l4["Preset Label"] = { 2, 9 }
DEDLayout_l4["Preset Number"] = { 7, 2, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on PresetChannel_both"] = { 6, 1, 9, "", "I" }
DEDLayout_l4["TOD Label"] = { 17, 3 }
--IFF
DEDLayout_l4["STAT M2 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l4["STAT M2 Lockout Status"] = { 3, 1 }
DEDLayout_l4["STAT M2 Code"] = { 4, 4 }
DEDLayout_l4["STAT MC Mode"] = { 9, 2, 0, "_inv", "I" }
DEDLayout_l4["STAT MC Code"] = { 12, 1 }
DEDLayout_l4["STAT MC Key"] = { 14, 3 }
DEDLayout_l4["STAT M2 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l4["STAT M2 Lockout Status"] = { 3, 1 }
DEDLayout_l4["STAT M2 Code"] = { 4, 4 }
DEDLayout_l4["STAT MC Mode"] = { 9, 2, 0, "_inv", "I" }
DEDLayout_l4["STAT MC Code"] = { 12, 1 }
DEDLayout_l4["STAT MC Key"] = { 14, 3 }
DEDLayout_l4["STAT TIM EVENT - Time"] = { 18, 5 }
DEDLayout_l4["POS M2 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l4["POS M2 Lockout Status"] = { 3, 1 }
DEDLayout_l4["POS M2 Code"] = { 4, 4, 0, "_inv", "I" }
DEDLayout_l4["POS MC Mode"] = { 9, 2 }
DEDLayout_l4["POS MC Code"] = { 12, 1 }
DEDLayout_l4["POS MC Key"] = { 14, 3 }
DEDLayout_l4["POS POS EVENT - Side"] = { 19, 1 }
DEDLayout_l4["POS POS EVENT - OF"] = { 20, 2 }
DEDLayout_l4["POS POS EVENT - Number"] = { 22, 1 }
DEDLayout_l4["TIM M2 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l4["TIM M2 Lockout Status"] = { 3, 1 }
DEDLayout_l4["TIM M2 Lockout Status"] = { 4, 4 }
DEDLayout_l4["TIM MC Mode"] = { 9, 2 }
DEDLayout_l4["TIM MC Code"] = { 12, 1 }
DEDLayout_l4["TIM MC Key"] = { 14, 3 }
DEDLayout_l4["TIM EVENT - Time"] = { 18, 5 }
--List
DEDLayout_l4["List Item 7 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l4["List Item 7 Name"] = { 1, 4 }
DEDLayout_l4["List Item 8 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l4["List Item 8 Name"] = { 7, 4 }
DEDLayout_l4["List Item 9 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l4["List Item 9 Name"] = { 13, 4 }
DEDLayout_l4["List Item 0 Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l4["List Item 0 Name"] = { 19, 4 }
--T-ILS
DEDLayout_l4["ILS FRQ Label"] = { 12, 3 }
DEDLayout_l4["ILS FRQ Scratchpad"] = { 17, 6, 0, "_inv", "I" }
DEDLayout_l4["ILS FRQ Asterisks_both"] = { 16, 1, 23, "", "I" }
DEDLayout_l4["TCN CHAN Label"] = { 0, 4 }
DEDLayout_l4["TCN CHAN Scratchpad"] = { 5, 3, 0, "_inv", "I" }
DEDLayout_l4["TCN CHAN Asterisks_both"] = { 4, 1, 8, "", "I" }
DEDLayout_l4["BACKUP lbl"] = { 2, 6 }
--ALOW
DEDLayout_l4["MSL FLOOR label"] = { 3, 9 }
DEDLayout_l4["MSL FLOOR Scratchpad"] = { 15, 7, 0, "_inv", "I" }
DEDLayout_l4["MSL FLOOR Asterisks_both"] = { 14, 1, 22, "", "I" }
--STPT
DEDLayout_l4["STEERPOINT Elevation"] = { 2, 3 }
DEDLayout_l4["STEERPOINT Elevation Value"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l4["STEERPOINT Elevation Asteriscs_both"] = { 7, 1, 16, "", "I" }
-- STPT MGRS
DEDLayout_l4["STEERPOINT EAST NORTH"] = { 0, 10 }
DEDLayout_l4["STEERPOINT EAST NORTH Value"] = { 12, 11, 0, "_inv", "I" }
DEDLayout_l4["STEERPOINT EAST NORTH Asteriscs_both"] = { 11, 1, 23, "", "I" }
--TIME
DEDLayout_l4["DELTA_TOS_label"] = { 1, 9 }
DEDLayout_l4["DELTA_TOS_value"] = { 12, 9, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_on_DELTA_TOS_both"] = { 11, 1, 21, "", "I" }
--BINGO
DEDLayout_l4["TOTAL label"] = { 4, 5 }
DEDLayout_l4["TOTAL value"] = { 11, 5 }
DEDLayout_l4["TOTAL LBS label"] = { 16, 3 }
--NAV
DEDLayout_l4["NAV STATUS MSN DUR label"] = { 3, 7 }
DEDLayout_l4["NAV STATUS DAYS label"] = { 16, 4 }
DEDLayout_l4["NAV STATUS Scratchpad"] = { 12, 2, 0, "_inv", "I" }
DEDLayout_l4["NAV STATUS Asterisks on Scratchpad_both"] = { 11, 1, 14, "", "I" }
DEDLayout_l4["NAV COMMANDS RESET GPS label"] = { 6, 11 }
DEDLayout_l4["NAV COMMANDS Asterisks on RESET_both"] = { 5, 1, 17, "", "I" }
--MAN
DEDLayout_l4["RNG Label"] = { 8, 3 }
DEDLayout_l4["RNG Data"] = { 11, 7 }
DEDLayout_l4["RNG FT"] = { 18, 2 }
--INS
DEDLayout_l4["INS_SALT_lbl"] = { 1, 4 }
DEDLayout_l4["INS_SALT_Scratchpad"] = { 8, 7, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_on_SALT_Scratchpad_both"] = { 7, 1, 15, "", "I" }
DEDLayout_l4["INS_FIX_NECESSARY_lbl"] = { 3, 17 }
--CMDS
DEDLayout_l4["CMDS_SQ_lbl"] = { 6, 2 }
DEDLayout_l4["CMDS_SQ_Scratchpad"] = { 10, 2, 0, "_inv", "I" }
DEDLayout_l4["CMDS_SQ_Asterisks_both"] = { 9, 1, 12, "", "I" }
DEDLayout_l4["CMDS_O1_lbl"] = { 2, 2 }
DEDLayout_l4["CMDS_O1_Scratchpad"] = { 7, 2, 0, "_inv", "I" }
DEDLayout_l4["CMDS_O1_Asterisks_both"] = { 6, 1, 9, "", "I" }
DEDLayout_l4["CMDS_REQCTR_lbl"] = { 11, 6 }
DEDLayout_l4["CMDS_REQCTR_value"] = { 19, 3, 0, "_inv", "I" }
DEDLayout_l4["CMDS_REQCTR_Asterisks_both"] = { 18, 1, 22, "", "I" }
-- DLNK
DEDLayout_l4["SC lbl"] = { 3, 2 }
DEDLayout_l4["SC value"] = { 6, 3, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on SC_both"] = { 5, 1, 9, "", "I" }
DEDLayout_l4["XMT lbl"] = { 11, 3 }
DEDLayout_l4["XMT status"] = { 16, 2, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on XMT_both"] = { 15, 1, 20, "", "I" }
DEDLayout_l4["NTR lbl"] = { 5, 3 }
DEDLayout_l4["NTR status"] = { 9, 3, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on NTR_both"] = { 8, 1, 12, "", "I" }

DEDLayout_l4["STN id lbl_3"] = { 0, 1 }
DEDLayout_l4["STN TDOA value_3"] = { 2, 1, 0, "_inv", "I" }
DEDLayout_l4["STN value_3"] = { 4, 5, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on STN TDOA_3_both"] = { 1, 1, 3, "", "I" }
DEDLayout_l4["Asterisks on STN_3_both"] = { 3, 1, 9, "", "I" }
DEDLayout_l4["STN id lbl_7"] = { 10, 2 }
DEDLayout_l4["STN TDOA value_7"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l4["STN value_7"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l4["Asterisks on STN TDOA_7_both"] = { 11, 1, 13, "", "I" }
DEDLayout_l4["Asterisks on STN_7_both"] = { 13, 1, 19, "", "I" }

DEDLayout_l4["FILL lbl"] = { 2, 4 }
DEDLayout_l4["FILL status"] = { 7, 3 }
DEDLayout_l4["PRTL lbl"] = { 12, 4 }
DEDLayout_l4["PRTL status"] = { 17, 5 }
DEDLayout_l4["INTRAFLIGHT STN id lbl3"] = { 1, 2 }
DEDLayout_l4["INTRAFLIGHT STN value3"] = { 4, 5 }
DEDLayout_l4["INTRAFLIGHT STN id lbl7"] = { 7, 2 }
DEDLayout_l4["INTRAFLIGHT STN value7"] = { 10, 5 }
DEDLayout_l4["INTRAFLIGHT OWN lbl"] = { 14, 4 }
DEDLayout_l4["INTRAFLIGHT Own value"] = { 18, 2 }
--Misc
DEDLayout_l4["Misc Item 7 Number"] = { 0, 1, 0, "", "I" }
DEDLayout_l4["Misc Item 7 Name"] = { 1, 4 }
DEDLayout_l4["Misc Item 8 Number"] = { 6, 1, 0, "", "I" }
DEDLayout_l4["Misc Item 8 Name"] = { 7, 4 }
DEDLayout_l4["Misc Item 9 Number"] = { 12, 1, 0, "", "I" }
DEDLayout_l4["Misc Item 9 Name"] = { 13, 4 }
DEDLayout_l4["Misc Item 0 Number"] = { 18, 1, 0, "", "I" }
DEDLayout_l4["Misc Item 0 Name"] = { 19, 4 }
--INTG
DEDLayout_l4["INTG M2 Mode"] = { 0, 2 }
DEDLayout_l4["INTG M2 Decoupled Status"] = { 3, 1 }
DEDLayout_l4["INTG M2 Code"] = { 4, 4 }
DEDLayout_l4["INTG IJAM Mode"] = { 15, 4 }
DEDLayout_l4["INTG IJAM Key"] = { 20, 3 }
--HARM
DEDLayout_l4["HARM T4"] = { 14, 2 }
DEDLayout_l4["HARM T4_code"] = { 18, 3, 0, "_inv", "I" }
DEDLayout_l4["HARM Asterisks_T4_both"] = { 17, 1, 21, "", "I" }
-- VRP
DEDLayout_l4["TGT-TO-VRP Range"] = { 5, 3 }
DEDLayout_l4["TGT-TO-VRP Range value"] = { 10, 8, 0, "_inv", "I" }
DEDLayout_l4["TGT-TO-VRP Range Asteriscs_both"] = { 9, 1, 18, "", "I" }
DEDLayout_l4["TGT-TO-VRP Range NM"] = { 17, 2 }
-- VRP PUP - VRP next page ... due to duplicate key names with VIP, VRP is usig Feet (FT) and VIP NM with different input lenght
DEDLayout_l4["TGT-TO-PUP Range"] = { 5, 3 }
DEDLayout_l4["TGT-TO-PUP Range value"] = { 10, 8, 0, "_inv", "I" }
DEDLayout_l4["TGT-TO-PUP Range Asteriscs_both"] = { 9, 1, 18, "", "I" }
DEDLayout_l4["TGT-TO-PUP Range NM"] = { 17, 2 }
-- VIP
DEDLayout_l4["VIP-TO-TGT Range"] = { 5, 3 }
DEDLayout_l4["VIP-TO-TGT Range value"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l4["VIP-TO-TGT Range Asteriscs_both"] = { 11, 1, 16, "", "I" }
DEDLayout_l4["VIP-TO-TGT Range NM"] = { 17, 2 }
-- VIP PUP - VIP next page ... due to duplicate key names with VRP
DEDLayout_l4["VIP-TO-PUP Range"] = { 5, 3 }
DEDLayout_l4["VIP-TO-PUP Range value"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l4["VIP-TO-PUP Range Asteriscs_both"] = { 11, 1, 16, "", "I" }
DEDLayout_l4["VIP-TO-PUP Range NM"] = { 17, 2 }
--HMCS
DEDLayout_l4["HMCS DISPLAY HMCS_DECLUTTER"] = { 3, 14 }
DEDLayout_l4["HMCS DISPLAY HMCS_DECLUTTER_STATUS"] = { 17, 1 }
DEDLayout_l4["HMCS DISPLAY Asterisks_DECLUTTER_both"] = { 12, 1, 18, "", "I" }
DEDLayout_l4["HMCS ALIGN HMCS_ROLL"] = { 2, 4, 0, "_inv", "I" }
DEDLayout_l4["HMCS ALIGN Asterisks_ROLL_both"] = { 1, 1, 6, "", "I" }
--MARK
DEDLayout_l4["MARK Elevation"] = { 1, 4 }
DEDLayout_l4["MARK Elevation Value"] = { 6, 8, 0, "_inv", "I" }
DEDLayout_l4["MARK Elevation Asteriscs_both"] = { 5, 1, 14, "", "I" }
--DEST_DIR
DEDLayout_l4["DEST DIR DEST_ELEV"] = { 2, 4 }
DEDLayout_l4["DEST DIR ELEV"] = { 8, 7, 0, "_inv", "I" }
DEDLayout_l4["DEST DIR Asterisks_ELEV_both"] = { 7, 1, 15, "", "I" }
--UTM DEST
DEDLayout_l4["UTM_DEST_EAST/NORTH"] = { 0, 10 }
DEDLayout_l4["EAST/NORTH"] = { 12, 11, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_EAST/NORTH_both"] = { 11, 1, 23, "", "I" }
--DEST_OA1
DEDLayout_l4["DEST_OA1_BRG"] = { 3, 3 }
DEDLayout_l4["BRG"] = { 8, 6, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_BRG_both"] = { 7, 1, 14, "", "I" }
--DEST_OA2
DEDLayout_l4["DEST_OA2_BRG"] = { 3, 3 }
DEDLayout_l4["BRG"] = { 8, 6, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_BRG_both"] = { 7, 1, 14, "", "I" }
--CRUS TOS
DEDLayout_l4["TOS_ETA_label"] = { 8, 3 }
DEDLayout_l4["TOS_ETA_value"] = { 13, 8 }
--CRUS EDR
DEDLayout_l4["EDR_OPT_MACH_label"] = { 3, 8 }
DEDLayout_l4["EDR_OPT_MACH_value"] = { 13, 8 } --- DIM???
--CRUS HOME
DEDLayout_l4["HOME_OPT_ALT_label"] = { 4, 7 }
DEDLayout_l4["HOME_OPT_ALT_value"] = { 13, 8 }
--FIX
DEDLayout_l4["FIX SYS ACCURACY label"] = { 4, 9 }
DEDLayout_l4["FIX SYS ACCURACY value"] = { 14, 4 }
--A CAL MAN
DEDLayout_l4["ACAL_ALT_DELTA"] = { 8, 5 }
DEDLayout_l4["ACAL_ALT_DELTA_label"] = { 2, 8 }
DEDLayout_l4["DELTA_ALT"] = { 16, 7, 0, "_inv", "I" }
--A CAL AUTO
DEDLayout_l4["DTS_STATUS_label"] = { 3, 3 }
DEDLayout_l4["DTS_STATUS_value"] = { 14, 3 }
DEDLayout_l4["DTS_ACCURACY_HPU_label"] = { 21, 2 }
DEDLayout_l4["DTS_ACCURACY_HPU_value"] = { 23, 1 }
--HTS MAN
DEDLayout_l4["T3"] = { 1, 1 }
DEDLayout_l4["T3_code"] = { 3, 4, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_T3_both"] = { 2, 1, 7, "", "I" }
DEDLayout_l4["T7"] = { 10, 1 }
DEDLayout_l4["T7_code"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l4["Asterisks_T7_both"] = { 11, 1, 16, "", "I" }
--HTS SEAD
DEDLayout_l4["HTS_ELEV_lbl"] = { 2, 3 }
DEDLayout_l4["HTS_ELEV"] = { 7, 10 }

--DEDLayout_l4[""] = {,}

----DED LINE 5

--CNI
DEDLayout_l5["IFF Modes Label"] = { 1, 1 }
DEDLayout_l5["IFF Modes Enabled"] = { 2, 6 }
DEDLayout_l5["Active Mode 3 Code"] = { 9, 4 }
DEDLayout_l5["IFF Switching"] = { 14, 1 }
DEDLayout_l5["TACAN Label"] = { 19, 1 }
DEDLayout_l5["TACAN Channel"] = { 20, 3 }
DEDLayout_l5["TACAN Band"] = { 23, 1 }
DEDLayout_l5["TACAN A-A Distance"] = { 19, 5 }
--COM
DEDLayout_l5["Preset Frequency"] = { 5, 6, 0, "_inv", "I" }
DEDLayout_l5["Asterisks on PresetFrequency_both"] = { 4, 1, 11, "", "I" }
DEDLayout_l5["Bandwidth"] = { 18, 2, 0, "_inv", "I" }
DEDLayout_l5["Asterisks on Band_both"] = { 17, 1, 20, "", "I" }
DEDLayout_l5["Preset Channel Number"] = { 20, 2 }
DEDLayout_l5["Guard or Backup Frequency"] = { 10, 6 }
--IFF
DEDLayout_l5["STAT M3 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l5["STAT M3 Lockout Status"] = { 3, 1 }
DEDLayout_l5["STAT M3 Code"] = { 4, 4 }
DEDLayout_l5["STAT M4 Monitoring"] = { 9, 3 }
DEDLayout_l5["STAT M4 Monitoring Key"] = { 14, 3 }
DEDLayout_l5["STAT MS Mode"] = { 18, 2, 0, "_inv", "I" }
DEDLayout_l5["STAT MS Code"] = { 20, 1 }
DEDLayout_l5["STAT MS Key"] = { 21, 3 }
DEDLayout_l5["POS M3 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l5["POS M3 Lockout Status"] = { 3, 1 }
DEDLayout_l5["POS M3 Code"] = { 4, 4 }
DEDLayout_l5["POS M4 Monitoring"] = { 9, 3 }
DEDLayout_l5["POS M4 Monitoring Key"] = { 14, 3 }
DEDLayout_l5["POS MS Mode"] = { 18, 2, 0, "_inv", "I" }
DEDLayout_l5["POS MS Code"] = { 20, 1 }
DEDLayout_l5["POS MS Key"] = { 21, 3 }
DEDLayout_l5["TIM M3 Mode"] = { 1, 2, 0, "_inv", "I" }
DEDLayout_l5["TIM M3 Lockout Status"] = { 3, 1 }
DEDLayout_l5["TIM M3 Code"] = { 4, 4 }
DEDLayout_l5["TIM M4 Monitoring"] = { 9, 3 }
DEDLayout_l5["TIM M4 Monitoring Key"] = { 14, 3 }
DEDLayout_l5["TIM MS Mode"] = { 18, 2, 0, "_inv", "I" }
DEDLayout_l5["TIM MS Code"] = { 20, 1 }
DEDLayout_l5["TIM MS Key"] = { 21, 3 }
--T-ILS
DEDLayout_l5["ILS CRS Label"] = { 12, 3 }
DEDLayout_l5["ILS CRS Scratchpad"] = { 17, 4, 0, "_inv", "I" }
DEDLayout_l5["ILS CRS Asterisks_both"] = { 16, 1, 21, "", "I" }
DEDLayout_l5["TCN BAND Label"] = { 0, 4 }
DEDLayout_l5["TCN BAND XY"] = { 5, 1 }
DEDLayout_l5["TCN BAND Key"] = { 6, 3 }
--STPT
DEDLayout_l5["STEERPOINT Time over current STP"] = { 3, 3 }
DEDLayout_l5["STEERPOINT TOS Value"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l5["STEERPOINT TOS Asteriscs_both"] = { 7, 1, 16, "", "I" }
-- STPT MGRS
DEDLayout_l5["STEERPOINT ElevationMGRS"] = { 6, 4 }
DEDLayout_l5["STEERPOINT ElevationMGRS Value"] = { 11, 8, 0, "_inv", "I" }
DEDLayout_l5["STEERPOINT ElevationMGRS Asteriscs_both"] = { 11, 1, 20, "", "I" }
--TIME
DEDLayout_l5["DATE_FORMAT_label"] = { 2, 8 }
DEDLayout_l5["DATE_value"] = { 13, 8, 0, "_inv", "I" }
DEDLayout_l5["Asterisks_on_DATE_both"] = { 12, 1, 21, "", "I" }
--NAV
DEDLayout_l5["NAV STATUS Keys Msg"] = { 3, 18 }
DEDLayout_l5["NAV COMMANDS ZEROIZE GPS label"] = { 6, 11 }
DEDLayout_l5["NAV COMMANDS Asterisks on ZEROIZE_both"] = { 5, 1, 17, "", "I" }
--MAN
DEDLayout_l5["TOF Label"] = { 8, 3 }
DEDLayout_l5["TOF Data"] = { 11, 6 }
DEDLayout_l5["TOF SEC"] = { 17, 3 }
--INS
DEDLayout_l5["INS_THDG_lbl"] = { 1, 4 }
DEDLayout_l5["INS_THDG_Scratchpad"] = { 7, 6, 0, "_inv", "I" }
DEDLayout_l5["Asterisks_on_THDG_Scratchpad"] = { 6, 1, 13, "", "I" }
DEDLayout_l5["INS_GS_lbl"] = { 16, 3 }
DEDLayout_l5["INS_GS_value"] = { 20, 3 }
--CMDS
DEDLayout_l5["CMDS_SI_lbl"] = { 6, 2 }
DEDLayout_l5["CMDS_SI_Scratchpad"] = { 10, 6, 0, "_inv", "I" }
DEDLayout_l5["CMDS_SI_Asterisks_both"] = { 9, 1, 16, "", "I" }
DEDLayout_l5["CMDS_O2_lbl"] = { 2, 2 }
DEDLayout_l5["CMDS_O2_Scratchpad"] = { 7, 2, 0, "_inv", "I" }
DEDLayout_l5["CMDS_O2_Asterisks_both"] = { 6, 1, 9, "", "I" }
DEDLayout_l5["CMDS_BINGO_lbl"] = { 11, 5 }
DEDLayout_l5["CMDS_BINGO_value"] = { 19, 3, 0, "_inv", "I" }
DEDLayout_l5["CMDS_BINGO_Asterisks_both"] = { 18, 1, 22, "", "I" }
-- DLNK
DEDLayout_l5["P2 lbl"] = { 21, 3 }
DEDLayout_l5["P3 lbl"] = { 21, 3 }
DEDLayout_l5["SYNC lbl"] = { 4, 4 }
DEDLayout_l5["SYNC status"] = { 9, 4, 0, "_inv", "I" }
DEDLayout_l5["Asterisks on SYNC_both"] = { 8, 1, 15, "", "I" }
DEDLayout_l5["P1 lbl"] = { 21, 3 }

DEDLayout_l5["STN id lbl_4"] = { 0, 1 }
DEDLayout_l5["STN TDOA value_4"] = { 2, 1, 0, "_inv", "I" }
DEDLayout_l5["STN value_4"] = { 4, 5, 0, "_inv", "I" }
DEDLayout_l5["Asterisks on STN TDOA_4_both"] = { 1, 1, 3, "", "I" }
DEDLayout_l5["Asterisks on STN_4_both"] = { 3, 1, 9, "", "I" }
DEDLayout_l5["STN id lbl_8"] = { 10, 2 }
DEDLayout_l5["STN TDOA value_8"] = { 12, 1, 0, "_inv", "I" }
DEDLayout_l5["STN value_8"] = { 14, 5, 0, "_inv", "I" }
DEDLayout_l5["Asterisks on STN TDOA_8_both"] = { 11, 1, 13, "", "I" }
DEDLayout_l5["Asterisks on STN_8_both"] = { 13, 1, 19, "", "I" }

DEDLayout_l5["P5 lbl"] = { 21, 3 }
DEDLayout_l5["INTRAFLIGHT STN id lbl4"] = { 1, 2 }
DEDLayout_l5["INTRAFLIGHT STN value4"] = { 4, 5 }
DEDLayout_l5["INTRAFLIGHT STN id lbl8"] = { 7, 2 }
DEDLayout_l5["INTRAFLIGHT STN value8"] = { 10, 5 }
DEDLayout_l5["INTRAFLIGHT LAST lbl"] = { 13, 4 }
DEDLayout_l5["INTRAFLIGHT LAST value"] = { 18, 2 }
DEDLayout_l5["INTRAFLIGHT P6 lbl"] = { 21, 3 }
--LASER
DEDLayout_l5["Laser ST Time LABEL"] = { 1, 13 }
DEDLayout_l5["Laser ST Time VALUE"] = { 16, 3, 0, "_inv", "I" }
DEDLayout_l5["Laser ST Time Asteriscs_both"] = { 15, 1, 19, "", "I" }
--INTG
DEDLayout_l5["INTG M3 Mode"] = { 0, 2, 0, "_inv", "I" }
DEDLayout_l5["INTG M3 Decoupled Status"] = { 3, 1 }
DEDLayout_l5["INTG M3 Code"] = { 4, 4 }
DEDLayout_l5["INTG Asterisks_both"] = { 9, 1, 15, "", "I" }
DEDLayout_l5["INTG Scratchpad"] = { 10, 5, 0, "_inv", "I" }
DEDLayout_l5["INTG COUPLE Mode"] = { 16, 4, 0, "_inv", "I" }
DEDLayout_l5["INTG COUPLE Key"] = { 20, 3 }
--HARM
DEDLayout_l5["HARM T5"] = { 14, 2 }
DEDLayout_l5["HARM T5_code"] = { 18, 3, 0, "_inv", "I" }
DEDLayout_l5["HARM Asterisks_T5_both"] = { 17, 1, 21, "", "I" }
-- VIP & VRP
DEDLayout_l5["Elevation"] = { 4, 4 }
DEDLayout_l5["Elevation value"] = { 10, 8, 0, "_inv", "I" }
DEDLayout_l5["Elevation Asteriscs_both"] = { 9, 1, 18, "", "I" }
--HMCS
DEDLayout_l5["HMCS DISPLAY HMCS_RWR_DISPLAY"] = { 3, 9 }
DEDLayout_l5["HMCS DISPLAY HMCS_RWR_DISPLAY_STATUS"] = { 13, 3 }
DEDLayout_l5["HMCS DISPLAY Asterisks_RWR_DISPLAY_both"] = { 12, 1, 16, "", "I" }
--MARK
DEDLayout_l5["MARK MGRS"] = { 1, 4 }
DEDLayout_l5["MARK GRID DIGIT Value"] = { 6, 2, 0, "_inv", "I" }
DEDLayout_l5["MARK GRID SYMBOL Value"] = { 8, 1, 0, "_inv", "I" }
DEDLayout_l5["MARK SQUARE Value1"] = { 9, 1, 0, "_inv", "I" }
DEDLayout_l5["MARK SQUARE Value2"] = { 10, 1, 0, "_inv", "I" }
DEDLayout_l5["MARK EAST Value"] = { 12, 5, 0, "_inv", "I" }
DEDLayout_l5["MARK Slash"] = { 17, 1 }
DEDLayout_l5["MARK NORTH Value"] = { 18, 5, 0, "_inv", "I" }
DEDLayout_l5["MARK MGRS Asteriscs_both"] = { 5, 1, 23, "", "I" }
--DEST_DIR
DEDLayout_l5["DEST_TOS"] = { 3, 3 }
DEDLayout_l5["TOS"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l5["Asterisks_TOS_both"] = { 7, 1, 16, "", "I" }
DEDLayout_l5["P2lbl"] = { 21, 3 }
--UTM DEST
DEDLayout_l5["UTM DEST UTM_DEST_ELEV"] = { 6, 4 }
DEDLayout_l5["UTM DEST ELEV"] = { 12, 7, 0, "_inv", "I" }
DEDLayout_l5["UTM DEST Asterisks_ELEV_both"] = { 11, 1, 19, "", "I" }
DEDLayout_l5["UTM DEST P1 lbl"] = { 21, 3 }
--DEST_OA1
DEDLayout_l5["DEST OA1 DEST_OA1_ELEV"] = { 2, 3 }
DEDLayout_l5["DEST OA1 ELEV"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l5["DEST OA1 Asterisks_ELEV_both"] = { 7, 1, 16, "", "I" }
DEDLayout_l5["DEST OA1 P3lbl"] = { 21, 3 }
--DEST_OA2
DEDLayout_l5["DEST OA2 DEST_OA2_BRG"] = { 2, 3 }
DEDLayout_l5["DEST OA2 ELEV"] = { 8, 8, 0, "_inv", "I" }
DEDLayout_l5["DEST OA2 Asterisks_ELEV_both"] = { 7, 1, 16, "", "I" }
DEDLayout_l5["DEST OA2 P4lbl"] = { 21, 3 }
--CRUS-TOS
DEDLayout_l5["TOS_REQ_GS_label"] = { 4, 7 }
DEDLayout_l5["TOS_REQ_GS_value"] = { 13, 7 }
--CRUS-EDR
DEDLayout_l5["EDR_WIND_AT_ALTITUDE"] = { 7, 4 }
DEDLayout_l5["EDR_WIND_AT_ALTITUDE_Value"] = { 13, 10 }
--CRUS RNG
DEDLayout_l5["RNG_WIND_AT_ALTITUDE"] = { 7, 4 }
DEDLayout_l5["RNG_WIND_AT_ALTITUDE_Value"] = { 13, 10 }
--CRUS-HOME
DEDLayout_l5["HOME_WIND_AT_ALTITUDE"] = { 7, 4 }
DEDLayout_l5["HOME_WIND_AT_ALTITUDE_Value"] = { 13, 10 }
--FIX
DEDLayout_l5["FIX GPS ACCURACY label"] = { 4, 9 }
DEDLayout_l5["FIX GPS ACCURACY value"] = { 14, 4 }
--A CAL MAN
DEDLayout_l5["ACAL_POS_DELTA"] = { 8, 5 }
DEDLayout_l5["ACAL_POS_DELTA_label"] = { 2, 3 }
DEDLayout_l5["DELTA_POS"] = { 16, 7, 0, "_inv", "I" }
--A CAL AUTO
DEDLayout_l5["DTS_ACCURACY_VPU_label"] = { 21, 2 }
DEDLayout_l5["DTS_ACCURACY_VPU_value"] = { 23, 1 }
--HTS MAN
DEDLayout_l5["T4"] = { 1, 1 }
DEDLayout_l5["T4_code"] = { 3, 4, 0, "_inv", "I" }
DEDLayout_l5["Asterisks_T4_both"] = { 2, 1, 7, "", "I" }
DEDLayout_l5["T8"] = { 10, 1 }
DEDLayout_l5["T8_code"] = { 12, 4, 0, "_inv", "I" }
DEDLayout_l5["Asterisks_T8_both"] = { 11, 1, 16, "", "I" }
--HTS SEAD
DEDLayout_l5["HTS_TOT_lbl"] = { 2, 3 }
DEDLayout_l5["HTS_TOT"] = { 7, 10 }
]]

local function deftostr(def)
    local pos, len, dup, inv1, inv2, rval = load('return ' .. def)()
    dup = dup or 0
    rval = rval and "'"..rval.."'" or 'nil'
    local inv = (inv1 == '' and inv2 == 'I') and 'true' or 'false'
    return string.format('%d, %d, %d, %s, %s', pos, len, dup, inv, rval)
end

local cat_list = {}
local cat_dict = {}
local rules = {}
local keys = {}
local is_duplicated = false

local current_cat = nil
for line in instr:gmatch('([^\n]*)\n') do
    local comment = line:sub(1,2)
    local cat = line:sub(3)
    if comment == '--' and not line:find('DEDLayout_') and line:sub(1, 3) ~= '---' then
        current_cat = cat
        if not cat_dict[cat] then
            cat_list[#cat_list + 1] = cat
            cat_dict[cat] = true
        end
    elseif line:find('DEDLayout_') and comment ~= '--' then
        local l, label, def = line:gmatch('DEDLayout_l([0-9])[^"]*"([^"]*)"[^{]*{([^}]*)')()
        l = tonumber(l)
        rules[l] = rules[l] or {}
        rules[l][current_cat] = rules[l][current_cat] or {}
        local current = rules[l][current_cat]
        current[#current + 1] = {line_no=l, label=label, others=def}
        -- if keys[label] then
        --     print('duplicated key: ' .. label)
        --     is_duplicated = true
        -- end
        -- keys[label] = true
    end
end

if is_duplicated then
    return
end

print('layout_defs = {}')
for line, line_defs in ipairs(rules) do
    print(string.format('\nlayout_defs[%d] = {', line))
    for _, cat in ipairs(cat_list) do
        local current = line_defs[cat]
        if current and #current > 0 then
            print('\n    --'..cat)
            for _, rule in ipairs(current) do
                print(string.format('    [\'%s\'] = {%s},', rule.label, deftostr(rule.others)))
            end
        end
    end
    print('}')
end