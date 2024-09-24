
layout_defs = {}

layout_defs[1] = {
    --CNI
    ['UHF Mode Rotary'] = {1, 3, 0, false, nil},
    ['UHF IncDecSymbol'] = {5, 1, 0, false, nil},
    ['Selected UHF Frequency'] = {6, 6, 0, false, nil},
    ['Steerpoint Use'] = {14, 4, 0, false, nil},
    ['WPT IncDecSymbol'] = {19, 1, 0, false, nil},
    ['Selected Steerpoint'] = {20, 3, 0, false, nil},

    --COM
    ['Secure Voice'] = {1, 3, 0, false, nil},
    ['COM 1 Mode'] = {5, 3, 0, false, nil},
    ['Receiver Mode'] = {13, 4, 0, false, nil},
    ['COM 1 Power Status'] = {13, 2, 0, false, nil},
    ['COM 2 Mode'] = {9, 3, 0, false, nil},
    ['COM 2 Mode Voice'] = {8, 3, 0, false, nil},
    ['Receiver Power Status'] = {15, 2, 0, false, nil},
    ['GUARD VHF Label'] = {8, 3, 0, false, nil},
    ['GUARD COM 2 Receiver Mode'] = {13, 2, 0, false, nil},

    --IFF
    ['STAT IFF label'] = {1, 3, 0, false, nil},
    ['STAT IFF Power Status'] = {5, 3, 0, false, nil},
    ['STAT Mode label'] = {12, 3, 0, false, nil},
    ['STAT Event Occured'] = {18, 3, 0, false, nil},
    ['POS IFF label'] = {1, 3, 0, false, nil},
    ['POS IFF Power Status'] = {5, 3, 0, true, nil},
    ['POS Event Occured'] = {18, 3, 0, true, nil},
    ['POS Mode Group State'] = {22, 1, 0, false, nil},
    ['POS IncDec Symbol'] = {23, 1, 0, false, nil},
    ['TIM IFF label'] = {1, 3, 0, false, nil},
    ['TIM IFF Power Status'] = {5, 3, 0, false, nil},
    ['TIM Event Occured'] = {18, 3, 0, true, nil},
    ['TIM Code Group State'] = {22, 1, 0, false, nil},
    ['TIM IncDec Symbol'] = {23, 1, 0, false, nil},
    ['IFF label'] = {8, 3, 0, false, nil},
    ['IFF Status'] = {12, 4, 0, false, nil},

    --List
    ['LIST LIST Label'] = {10, 4, 0, false, nil},
    ['LIST Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['LIST WPT IncDecSymbol'] = {23, 1, 0, false, nil},

    --T-ILS
    ['TCN Label'] = {1, 3, 0, false, nil},
    ['TCN Mode'] = {5, 3, 0, false, nil},
    ['TCN BIG OFF Label'] = {5, 3, 0, false, 'OFF'},
    ['ILS Label'] = {13, 3, 0, false, nil},
    ['ILS Mode'] = {18, 3, 0, false, nil},

    --ALOW
    ['ALOW ALOW label'] = {10, 4, 0, false, nil},
    ['ALOW Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['ALOW WPT IncDecSymbol'] = {23, 1, 0, false, nil},

    --STPT
    ['STEERPOINT LABEL'] = {6, 4, 0, false, nil},
    ['STEERPOINT NUMBER'] = {12, 3, 0, false, nil},
    ['STEERPOINT IncDecSymbol'] = {16, 1, 0, false, nil},
    ['STEERPOINT SEQUENCE'] = {18, 4, 0, false, nil},
    ['STEERPOINT NUMBER Asteriscs_both'] = {11, 1, 15, true, nil},
    ['STEERPOINT SEQUENCE Asteriscs_both'] = {17, 1, 22, true, nil},

    --STPT MGRS
    ['STEERPOINT UTM LABEL'] = {2, 3, 0, false, nil},

    --TIME
    ['TIME_label'] = {9, 4, 0, false, nil},

    --BINGO
    ['BINGO label'] = {9, 5, 0, false, nil},
    ['BINGO STPT Num'] = {20, 2, 0, false, nil},
    ['BINGO IncDecSymbol'] = {23, 1, 0, false, nil},

    --NAV
    ['NAV STATUS NAV Status lbl'] = {7, 10, 0, false, nil},
    ['NAV COMMANDS NAV Status lbl'] = {6, 12, 0, false, nil},
    ['NAV STATUS INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['NAV STATUS INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['NAV COMMANDS INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['NAV COMMANDS INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},

    --MAN
    ['MAN Label'] = {10, 3, 0, false, nil},
    ['MAN STPT Num'] = {20, 2, 0, false, nil},
    ['MAN IncDecSymbol'] = {23, 1, 0, false, nil},

    --INS
    ['INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['INS_lbl'] = {2, 3, 0, false, nil},
    ['INS_AlignTime'] = {7, 4, 0, false, nil},
    ['INS_AlignSlash'] = {11, 1, 0, false, nil},
    ['INS_AlignStatusCode'] = {12, 2, 0, false, nil},
    ['INS_Ready'] = {15, 3, 0, false, nil},
    ['INFLT ALGN INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['INFLT ALGN INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['INFLT ALGN INS_lbl'] = {4, 3, 0, false, nil},
    ['INFLT ALGN INS_INFLT_ALGN_lbl'] = {8, 10, 0, false, nil},

    --CMDS
    ['CMDS_Prog_label'] = {15, 4, 0, false, nil},
    ['CMDS_Selected_Program'] = {21, 2, 0, false, nil},
    ['CMDS_Prog_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['CMDS  BINGO CMDS_BINGO_label'] = {5, 11, 0, false, nil},
    ['CMDS  BINGO Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['CMDS  BINGO WPT IncDecSymbol'] = {23, 1, 0, false, nil},
    ['CMDS_CHAFF_label'] = {2, 9, 0, false, nil},
    ['CMDS_FLARE_label'] = {2, 9, 0, false, nil},
    ['CMDS_OTHER1_label'] = {2, 10, 0, false, nil},
    ['CMDS_OTHER2_label'] = {2, 10, 0, false, nil},

    --Mode
    ['MODE Master_mode_label'] = {4, 4, 0, false, nil},
    ['MODE Master_mode'] = {10, 3, 0, false, nil},
    ['MODE Master_mode_ast_both'] = {9, 1, 13, true, nil},
    ['MODE Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['MODE WPT IncDecSymbol'] = {23, 1, 0, false, nil},

    --DLNK
    ['TNDL LINK16 lbl'] = {9, 4, 0, false, nil},
    ['TNDL Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['TNDL WPT IncDecSymbol'] = {23, 1, 0, false, nil},
    ['NET STATUS NET STATUS lbl'] = {5, 10, 0, false, nil},
    ['NET STATUS Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['NET STATUS WPT IncDecSymbol'] = {23, 1, 0, false, nil},
    ['TNDL   STN LINK16 STN lbl'] = {7, 10, 0, false, nil},
    ['TNDL   STN Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['TNDL   STN WPT IncDecSymbol'] = {23, 1, 0, false, nil},
    ['AG DL lbl'] = {7, 6, 0, false, nil},
    ['INTRAFLIGHT INTRAFLIGHT lbl'] = {7, 11, 0, false, nil},

    --Misc
    ['MISC MISC Label'] = {10, 4, 0, false, nil},
    ['MISC Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['MISC WPT IncDecSymbol'] = {23, 1, 0, false, nil},

    --MAGV
    ['MAGV lbl'] = {7, 4, 0, false, nil},
    ['MAGV Mode'] = {13, 4, 0, false, nil},
    ['Asterisks_on_MAGV_Mode_both'] = {12, 1, 17, true, nil},

    --LASER
    ['LASR LASR LABEL'] = {11, 4, 0, false, nil},
    ['LASR Selected Steerpoint'] = {20, 3, 0, false, nil},
    ['LASR WPT IncDecSymbol'] = {23, 1, 0, false, nil},

    --INTG
    ['INTG INTG label'] = {13, 4, 0, false, nil},
    ['INTG INTG Mode'] = {8, 4, 0, false, nil},
    ['INTG TIM Event'] = {20, 3, 0, false, nil},

    --HARM
    ['HARM HARM'] = {1, 4, 0, false, nil},
    ['HARM TblNum'] = {6, 4, 0, false, nil},
    ['HARM Angles'] = {10, 1, 0, false, nil},
    ['HARM T1'] = {14, 2, 0, false, nil},
    ['HARM T1_code'] = {18, 3, 0, false, nil},
    ['HARM Asterisks_T1_both'] = {17, 1, 21, true, nil},

    --VIP
    ['VIP-TO-TGT Visual initial point to TGT Label'] = {6, 10, 0, false, nil},
    ['VIP-TO-TGT VIP to TGT Label Asteriscs_both'] = {5, 1, 16, true, nil},

    --VIP PUP
    ['VIP-TO-PUP Visual initial point to TGT Label'] = {6, 10, 0, false, nil},
    ['VIP-TO-PUP VIP to TGT Label Asteriscs_both'] = {5, 1, 16, true, nil},

    --VRP
    ['TGT-TO-VRP Target to VRP Label'] = {6, 10, 0, false, nil},
    ['TGT-TO-VRP Target to VRP Label Asteriscs_both'] = {5, 1, 16, true, nil},

    --VRP PUP
    ['TGT-TO-PUP Target to VRP Label'] = {6, 10, 0, false, nil},
    ['TGT-TO-PUP Target to VRP Label Asteriscs_both'] = {5, 1, 16, true, nil},

    --HMCS
    ['HMCS DISPLAY HMCS_DISPLAY_label'] = {7, 12, 0, false, nil},
    ['HMCS DISPLAY INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['HMCS DISPLAY INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['HMCS ALIGN HMCS_ALIGN_label'] = {6, 10, 0, false, nil},
    ['HMCS ALIGN INS_SelectedSteerpoint'] = {20, 2, 0, false, nil},
    ['HMCS ALIGN INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},

    --BULL
    ['BULLSEYE LABEL'] = {6, 8, 0, false, nil},
    ['BULLSEYE LABEL Asteriscs_both'] = {5, 1, 14, true, nil},

    --MARK
    ['MARK'] = {1, 4, 0, false, nil},
    ['MARK SOURCE'] = {7, 4, 0, false, nil},
    ['MARK SOURCE Asteriscs_both'] = {6, 1, 11, true, nil},
    ['STPT NUMBER'] = {14, 3, 0, false, nil},
    ['MARK IncDecSymbol'] = {17, 1, 0, false, nil},
    ['MARK Number Asteriscs_both'] = {13, 1, 18, true, nil},
    ['STPT'] = {19, 4, 0, false, nil},

    --DEST_DIR
    ['DEST DIR DEST_DIR'] = {2, 8, 0, false, nil},
    ['DEST DIR DEST_DIR_SelectedSteerpoint'] = {12, 3, 0, false, nil},
    ['DEST DIR DEST_DIR_STPT_IncDecSymbol'] = {16, 1, 0, false, nil},
    ['DEST DIR Asterisks_NUM_STEERPOINT_both'] = {11, 1, 15, true, nil},

    --UTM DEST
    ['UTM DEST UTM_DEST'] = {2, 8, 0, false, nil},
    ['UTM DEST UTM_DEST_SelectedSteerpoint'] = {12, 3, 0, false, nil},
    ['UTM DEST UTM_DEST_STPT_IncDecSymbol'] = {16, 1, 0, false, nil},
    ['UTM DEST Asterisks_NUM_STEERPOINT_both'] = {11, 1, 15, true, nil},

    --DEST_OA1
    ['DEST OA1 DEST_OA1'] = {2, 8, 0, false, nil},
    ['DEST OA1 DEST_OA1_SelectedSteerpoint'] = {11, 3, 0, false, nil},
    ['DEST OA1 DEST_OA1_STPT_IncDecSymbol'] = {15, 1, 0, false, nil},
    ['DEST OA1 Asterisks_NUM_STEERPOINT'] = {10, 1, 14, true, nil},
    ['DEST OA1 Asterisks_NUM_STEERPOINT_both'] = {10, 1, 14, true, nil},

    --DEST_OA2
    ['DEST OA2 DEST_OA2'] = {2, 8, 0, false, nil},
    ['DEST OA2 DEST_OA2_SelectedSteerpoint'] = {11, 3, 0, false, nil},
    ['DEST OA2 DEST_OA2_STPT_IncDecSymbol'] = {15, 1, 0, false, nil},
    ['DEST OA2 Asterisks_NUM_STEERPOINT'] = {10, 1, 14, true, nil},
    ['DEST OA2 Asterisks_NUM_STEERPOINT_both'] = {10, 1, 14, true, nil},

    --CRUS TOS
    ['CRUS_MODE'] = {7, 4, 0, false, nil},
    ['INS_SelectedSteerpoint'] = {20, 3, 0, false, nil},
    ['INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['TOS_MODE'] = {13, 3, 0, false, nil},
    ['Asterisks_TOS_MODE_both'] = {12, 1, 16, true, nil},

    --CRUS EDR
    ['EDR_MODE'] = {13, 4, 0, false, nil},
    ['Asterisks_RNG_MODE_both'] = {12, 1, 16, true, nil},

    --CRUS HOME
    ['HOME CRUS_MODE'] = {7, 4, 0, false, nil},
    ['HOME HOME_MODE'] = {13, 4, 0, false, nil},
    ['HOME Asterisks_RNG_MODE_both'] = {12, 1, 17, true, nil},

    --CRUS RNG
    ['RNG_MODE'] = {13, 3, 0, false, nil},
    ['Asterisks_RNG_MODE_both'] = {12, 1, 16, true, nil},

    --FIX
    ['FIX FIX_SENSORS'] = {6, 3, 0, false, nil},
    ['FIX FIX_SelectedSensors'] = {11, 4, 0, false, nil},
    ['FIX Asterisks_FIX_SENSORS_both'] = {10, 1, 15, true, nil},

    --A CAL MAN
    ['ACAL ACAL_SENSORS'] = {1, 4, 0, false, nil},
    ['ACAL ACAL_SelectedSensors'] = {8, 4, 0, false, nil},
    ['ACAL Asterisks_ACAL_SENSORS_both'] = {7, 1, 12, true, nil},
    ['ACAL ACAL_ALT_label'] = {14, 4, 0, false, nil},

    --A CAL AUTO
    ['INS_SelectedSteerpoint'] = {20, 3, 0, false, nil},
    ['INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},
    ['AUTO_ACAL'] = {1, 9, 0, false, nil},
    ['ACAL_AUTO_Sensors'] = {12, 4, 0, false, nil},
    ['Asterisks_AUTO_both'] = {11, 1, 16, true, nil},

    --HTS MAN
    ['HTS MAN HTS'] = {8, 7, 0, false, nil},
    ['HTS MAN INS_SelectedSteerpoint'] = {20, 3, 0, false, nil},
    ['HTS MAN INS_STPT_IncDecSymbol'] = {23, 1, 0, false, nil},

    --HTS SEAD
    ['HTS'] = {4, 4, 0, false, nil},
}

layout_defs[2] = {
    --CNI
    ['UHF Status'] = {1, 1, 0, false, nil},
    ['Default Value Indication'] = {11, 1, 0, false, nil},
    ['Wind Magnetic Direction'] = {16, 2, 0, false, nil},
    ['Wind Speed'] = {20, 2, 0, false, nil},

    --COM
    ['Active Frequency or Channel'] = {2, 6, 0, false, nil},
    ['Active Frequency or Channe'] = {2, 6, 0, false, nil},

    --IFF
    ['STAT Mode Asterisks_both'] = {17, 1, 23, true, nil},
    ['STAT Mode Scratchpad'] = {18, 5, 0, false, nil},

    --List
    ['LIST List Item 1 Number'] = {0, 1, 0, true, nil},
    ['LIST List Item 1 Name'] = {1, 4, 0, false, nil},
    ['LIST List Item 2 Number'] = {6, 1, 0, true, nil},
    ['LIST List Item 2 Name'] = {7, 4, 0, false, nil},
    ['LIST List Item 3 Number'] = {12, 1, 0, true, nil},
    ['LIST List Item 3 Name'] = {13, 4, 0, false, nil},
    ['LIST List Item R Number'] = {18, 1, 0, true, nil},
    ['LIST List Item R Name'] = {19, 4, 0, false, nil},

    --STPT
    ['STEERPOINT Latitude'] = {3, 3, 0, false, nil},
    ['STEERPOINT Latitude Value'] = {8, 12, 0, false, nil},
    ['STEERPOINT Latitude Asteriscs_both'] = {7, 1, 20, true, nil},

    --STPT MGRS
    ['STEERPOINT GRID'] = {6, 4, 0, false, nil},
    ['STEERPOINT GRID DIGIT Value'] = {12, 2, 0, false, nil},
    ['STEERPOINT GRID SYMBOL Value'] = {14, 1, 0, false, nil},
    ['STEERPOINT GRID DIGIT Asteriscs_both'] = {11, 1, 15, true, nil},
    ['STEERPOINT GRID SYMBOL Asteriscs_both'] = {11, 1, 15, true, nil},
    ['STEERPOINT GRID CNVRT'] = {17, 5, 0, false, nil},
    ['STEERPOINT CNVRT Asteriscs_both'] = {16, 1, 22, true, nil},

    --TIME
    ['SYSTEM_label'] = {4, 6, 0, false, nil},
    ['GPS_SYSTEM_label'] = {0, 10, 0, false, nil},
    ['SYSTEM_value'] = {13, 8, 0, false, nil},
    ['Asterisks_on_SYSTEM_both'] = {12, 1, 21, true, nil},

    --NAV
    ['NAV STATUS SYS ACCURACY label'] = {3, 9, 0, false, nil},
    ['NAV STATUS SYS ACCURACY value'] = {14, 4, 0, false, nil},

    --MAN
    ['WSPAN Label'] = {6, 5, 0, false, nil},
    ['WSPAN DATA'] = {13, 5, 0, false, nil},
    ['WSPAN Asteriscs_both'] = {12, 1, 18, true, nil},

    --INS
    ['INS_LAT_lbl'] = {2, 3, 0, false, nil},
    ['INS_LAT_Scratchpad'] = {7, 10, 0, false, nil},
    ['Asterisks_on_LAT_Scratchpad_both'] = {6, 1, 17, true, nil},

    --CMDS
    ['CMDS_BQ_lbl'] = {6, 2, 0, false, nil},
    ['CMDS_BQ_Scratchpad'] = {10, 2, 0, false, nil},
    ['CMDS_BQ_Asterisks_both'] = {9, 1, 12, true, nil},
    ['CMDS  BINGO CMDS_CH_lbl'] = {2, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_CH_Scratchpad'] = {7, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_CH_Asterisks_both'] = {6, 1, 9, true, nil},

    --DLNK
    ['TNDL FC lbl'] = {3, 2, 0, false, nil},
    ['TNDL FC value'] = {6, 3, 0, false, nil},
    ['TNDL Asterisks on FC_both'] = {5, 1, 9, true, nil},
    ['TNDL CallSign Name char1'] = {11, 1, 0, false, nil},
    ['TNDL CallSign Name char2'] = {12, 1, 0, false, nil},
    ['TNDL Asterisks on CS Name_both'] = {10, 1, 13, true, nil},
    ['TNDL VCS IncDecSymbol'] = {14, 1, 0, false, nil},
    ['TNDL CallSign Number'] = {16, 2, 0, false, nil},
    ['TNDL Asterisks on CS Number_both'] = {15, 1, 18, true, nil},
    ['TNDL   STN STN id lbl_1'] = {0, 1, 0, false, nil},
    ['TNDL   STN STN TDOA value_1'] = {2, 1, 0, false, nil},
    ['TNDL   STN STN value_1'] = {4, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_1_both'] = {1, 1, 3, true, nil},
    ['TNDL   STN Asterisks on STN_1_both'] = {3, 1, 9, true, nil},
    ['TNDL   STN STN id lbl_5'] = {10, 2, 0, false, nil},
    ['TNDL   STN STN TDOA value_5'] = {12, 1, 0, false, nil},
    ['TNDL   STN STN value_5'] = {14, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_5_both'] = {11, 1, 13, true, nil},
    ['TNDL   STN Asterisks on STN_5_both'] = {13, 1, 19, true, nil},
    ['TNDL   STN OWN lbl'] = {20, 3, 0, false, nil},
    ['NET STATUS GPS TIME lbl'] = {0, 8, 0, false, nil},
    ['NET STATUS GPS TIME status'] = {9, 3, 0, false, nil},
    ['NET STATUS Asterisks on ETR_both'] = {8, 1, 12, true, nil},
    ['IPF Reset lbl'] = {14, 9, 0, false, nil},
    ['Asterisks on IPF_both'] = {13, 1, 23, true, nil},
    ['A-G DL XMT lbl'] = {3, 3, 0, false, nil},
    ['A-G DL XMT value'] = {7, 2, 0, false, nil},
    ['A-G DL COMM lbl'] = {12, 4, 0, false, nil},
    ['A-G DL COMM status'] = {17, 3, 0, false, nil},
    ['INTRAFLIGHT STN id lbl1'] = {1, 2, 0, false, nil},
    ['INTRAFLIGHT STN value1'] = {4, 5, 0, false, nil},
    ['INTRAFLIGHT STN id lbl5'] = {7, 2, 0, false, nil},
    ['INTRAFLIGHT STN value5'] = {10, 5, 0, false, nil},
    ['INTRAFLIGHT COMM lbl'] = {13, 4, 0, false, nil},
    ['INTRAFLIGHT COMM status'] = {18, 3, 0, false, nil},

    --Misc
    ['MISC Misc Item 1 Number'] = {0, 1, 0, true, nil},
    ['MISC Misc Item 1 Name'] = {1, 4, 0, false, nil},
    ['MISC Misc Item 2 Number'] = {6, 1, 0, true, nil},
    ['MISC Misc Item 2 Name'] = {7, 4, 0, false, nil},
    ['MISC Misc Item 3 Number'] = {12, 1, 0, true, nil},
    ['MISC Misc Item 3 Name'] = {13, 4, 0, false, nil},
    ['MISC Misc Item R Number'] = {18, 1, 0, true, nil},
    ['MISC Misc Item R Name'] = {19, 4, 0, false, nil},

    --LASER
    ['LASR TGP CODE LABEL'] = {1, 8, 0, false, nil},
    ['LASR TGP CODE VALUE'] = {13, 4, 0, false, nil},
    ['LASR TGP CODE Asteriscs_both'] = {12, 1, 17, true, nil},

    --HARM
    ['HARM T2'] = {14, 2, 0, false, nil},
    ['HARM T2_code'] = {18, 3, 0, false, nil},
    ['HARM Asterisks_T2_both'] = {17, 1, 21, true, nil},

    --VIP
    ['VIP-TO-TGT Visual initial point number'] = {5, 3, 0, false, nil},
    ['VIP-TO-TGT VIP number value'] = {10, 3, 0, false, nil},
    ['VIP-TO-TGT VIP number up down arrows'] = {14, 1, 0, false, nil},
    ['VIP-TO-TGT VIP number Asteriscs_both'] = {9, 1, 13, true, nil},

    --VIP PUP
    ['VIP-TO-PUP Visual initial point number'] = {5, 3, 0, false, nil},
    ['VIP-TO-PUP VIP number value'] = {10, 3, 0, false, nil},
    ['VIP-TO-PUP VIP number up down arrows'] = {14, 1, 0, false, nil},
    ['VIP-TO-PUP VIP number Asteriscs_both'] = {9, 1, 13, true, nil},

    --VRP
    ['TGT-TO-VRP Target number'] = {5, 3, 0, false, nil},
    ['TGT-TO-VRP Target number value'] = {10, 3, 0, false, nil},
    ['TGT-TO-VRP Target number up down arrows'] = {14, 1, 0, false, nil},
    ['TGT-TO-VRP Target number Asteriscs_both'] = {9, 1, 13, true, nil},

    --VRP PUP
    ['TGT-TO-PUP Target number'] = {5, 3, 0, false, nil},
    ['TGT-TO-PUP Target number value'] = {10, 3, 0, false, nil},
    ['TGT-TO-PUP Target number up down arrows'] = {14, 1, 0, false, nil},
    ['TGT-TO-PUP Target number Asteriscs_both'] = {9, 1, 13, true, nil},

    --HMCS
    ['HMCS DISPLAY HMCS_HUD_BLANK'] = {3, 8, 0, false, nil},
    ['HMCS DISPLAY Asterisks_HUD_BLANK_both'] = {2, 1, 11, true, nil},
    ['HMCS ALIGN HMCS_COARSE'] = {2, 6, 0, false, nil},
    ['HMCS ALIGN Asterisks_COARSE_both'] = {1, 1, 8, true, nil},

    --BULL
    ['BULL POINT LABEL'] = {6, 4, 0, false, nil},
    ['BULLSEYE NUMBER'] = {12, 4, 0, false, nil},
    ['BULLSEYE IncDecSymbol'] = {16, 1, 0, false, nil},
    ['BULLSEYE SEQUENCE Asteriscs_both'] = {11, 1, 15, true, nil},

    --MARK
    ['MARK Latitude'] = {2, 3, 0, false, nil},
    ['MARK Latitude Value'] = {6, 12, 0, false, nil},
    ['MARK Latitude Asteriscs_both'] = {5, 1, 18, true, nil},

    --DEST_DIR
    ['DEST DIR DEST_LAT'] = {3, 3, 0, false, nil},
    ['DEST DIR LAT'] = {8, 12, 0, false, nil},
    ['DEST DIR Asterisks_LAT_both'] = {7, 1, 20, true, nil},

    --CRUS TOS
    ['TOS_SYSTEM_TIME_label'] = {7, 4, 0, false, nil},
    ['TOS_SYSTEM_TIME_value'] = {13, 8, 0, false, nil},

    --CRUS EDR
    ['EDR_STPT_NUM'] = {7, 4, 0, false, nil},
    ['EDR_INS_SelectedSteerpoint'] = {12, 3, 0, false, nil},
    ['EDR_INS_STPT_IncDecSymbol'] = {16, 1, 0, false, nil},

    --CRUS HOME
    ['HOME HOME_STPT_NUM'] = {7, 4, 0, false, nil},
    ['HOME Asterisks_HOME_STPT_NUM_both'] = {11, 1, 17, true, nil},
    ['HOME HOME_INS_SelectedSteerpoint'] = {12, 3, 0, false, nil},
    ['HOME HOME_INS_STPT_IncDecSymbol'] = {16, 1, 0, false, nil},

    --CRUS RNG
    ['RNG_STPT_NUM'] = {7, 4, 0, false, nil},
    ['RNG_INS_SelectedSteerpoint'] = {12, 3, 0, false, nil},
    ['RNG_INS_STPT_IncDecSymbol'] = {16, 1, 0, false, nil},

    --FIX
    ['FIX FIX_STPT'] = {4, 4, 0, false, nil},
    ['FIX INS_SelectedSteerpoint'] = {10, 3, 0, false, nil},
    ['FIX Asterisks_STPT_NUMBER_both'] = {9, 1, 13, true, nil},
    ['FIX INS_STPT_IncDecSymbol'] = {14, 1, 0, false, nil},

    --A CAL MAN
    ['ACAL ACAL_MODE'] = {8, 4, 0, false, nil},
    ['ACAL Asterisks_ACAL_SelectedMode_both'] = {7, 1, 12, true, nil},

    --A CAL AUTO
    ['NAV_FILTER_label'] = {2, 10, 0, false, nil},
    ['NAV_FILTER_mode'] = {14, 4, 0, false, nil},

    --HTS MAN
    ['HTS MAN T1'] = {1, 1, 0, false, nil},
    ['HTS MAN T1_code'] = {3, 4, 0, false, nil},
    ['HTS MAN Asterisks_T1_both'] = {2, 1, 7, true, nil},
    ['HTS MAN T5'] = {10, 1, 0, false, nil},
    ['HTS MAN T5_code'] = {12, 4, 0, false, nil},
    ['HTS MAN Asterisks_T5_both'] = {11, 1, 16, true, nil},

    --HTS SEAD
    ['HTS_LAT_lbl'] = {2, 3, 0, false, nil},
    ['HTS_LAT'] = {7, 10, 0, false, nil},

    --TODO
    ['TODO remove lbl'] = {4, 20, 0, false, nil},

    --UTM DEST
    ['UTM DEST UTM_DEST_GRID'] = {6, 4, 0, false, nil},
    ['UTM DEST GRID_DIGIT'] = {12, 2, 0, false, nil},
    ['UTM DEST GRID_SYMBOL'] = {14, 1, 0, false, nil},
    ['UTM DEST Asterisks_GRID_DIGIT_both'] = {11, 1, 15, true, nil},
    ['UTM DEST Asterisks_GRID_SYMBOL_both'] = {11, 1, 15, true, nil},
    ['UTM DEST UTM_DEST_CNVRT'] = {18, 5, 0, false, nil},
    ['UTM DEST Asterisks_CNVRT_both'] = {17, 1, 23, true, nil},
}

layout_defs[3] = {
    --CNI
    ['VHF Label'] = {1, 3, 0, false, nil},
    ['VHF IncDecSymbol'] = {5, 1, 0, false, nil},
    ['Selected VHF Frequency'] = {6, 6, 0, false, nil},
    ['System Time'] = {15, 8, 0, false, nil},

    --COM
    ['Scratchpad'] = {14, 6, 0, false, nil},
    ['Asterisks on Scratchpad_both'] = {13, 1, 20, true, nil},
    ['Guard or Backup Status'] = {9, 5, 0, false, nil},
    ['GUARD COM 2 Receiver Band'] = {8, 2, 0, false, nil},
    ['GUARD Guard Label'] = {12, 5, 0, false, nil},

    --IFF
    ['STAT M1 Mode'] = {0, 2, 0, false, nil},
    ['STAT M1 Lockout Status'] = {3, 1, 0, false, nil},
    ['STAT M1 Code'] = {4, 2, 0, false, nil},
    ['STAT M4 Mode'] = {8, 2, 0, false, nil},
    ['STAT M4 Code'] = {12, 1, 0, false, nil},
    ['STAT M4 Key'] = {14, 3, 0, false, nil},
    ['STAT POS EVENT - Side'] = {19, 1, 0, false, nil},
    ['STAT POS EVENT - OF'] = {20, 2, 0, false, nil},
    ['STAT POS EVENT - Number'] = {22, 1, 0, false, nil},
    ['POS M1 Mode'] = {1, 2, 0, false, nil},
    ['POS M1 Lockout Status'] = {3, 1, 0, false, nil},
    ['POS M1 Code'] = {4, 5, 0, false, nil},
    ['POS M4 Mode'] = {9, 2, 0, false, nil},
    ['POS M4 Code'] = {13, 1, 0, false, nil},
    ['POS M4 Key'] = {14, 2, 0, false, nil},
    ['POS Mode Asterisks_both'] = {18, 1, 23, true, nil},
    ['POS Mode Scratchpad'] = {14, 5, 0, false, nil},
    ['TIM M1 Mode'] = {1, 2, 0, false, nil},
    ['TIM M1 Lockout Status'] = {3, 1, 0, false, nil},
    ['TIM M1 Code'] = {4, 5, 0, false, nil},
    ['TIM M4 Mode'] = {9, 2, 0, false, nil},
    ['TIM M4 Code'] = {13, 1, 0, false, nil},
    ['TIM M4 Key'] = {14, 2, 0, false, nil},
    ['TIM Mode Asterisks_both'] = {18, 1, 23, true, nil},
    ['TIM Mode Scratchpad'] = {14, 5, 0, false, nil},
    ['BACKUP label'] = {9, 6, 0, false, nil},

    --List
    ['LIST List Item 4 Number'] = {0, 1, 0, true, nil},
    ['LIST List Item 4 Name'] = {1, 4, 0, false, nil},
    ['LIST List Item 5 Number'] = {6, 1, 0, true, nil},
    ['LIST List Item 5 Name'] = {7, 4, 0, false, nil},
    ['LIST List Item 6 Number'] = {12, 1, 0, true, nil},
    ['LIST List Item 6 Name'] = {13, 4, 0, false, nil},
    ['LIST List Item E Number'] = {18, 1, 0, true, nil},
    ['LIST List Item E Name'] = {19, 4, 0, false, nil},

    --T-ILS
    ['TILS Scratchpad'] = {8, 6, 0, false, nil},
    ['TILS Asterisks_both'] = {7, 1, 14, true, nil},
    ['ILS CMD STRG'] = {15, 8, 0, false, nil},
    ['TCN BCN Label'] = {0, 3, 0, false, nil},
    ['TCN BCN ID'] = {4, 3, 0, false, nil},

    --ALOW
    ['ALOW CARA ALOW label'] = {3, 9, 0, false, nil},
    ['ALOW CARA ALOW Scratchpad'] = {15, 7, 0, false, nil},
    ['ALOW CARA ALOW Asterisks_both'] = {14, 1, 22, true, nil},

    --STPT
    ['STEERPOINT Longitude'] = {3, 3, 0, false, nil},
    ['STEERPOINT Longitude Value'] = {8, 12, 0, false, nil},
    ['STEERPOINT Longitude Asteriscs_both'] = {7, 1, 20, true, nil},

    --STPT MGRS
    ['STEERPOINT SQUARE'] = {4, 6, 0, false, nil},
    ['STEERPOINT SQUARE Value1'] = {12, 1, 0, false, nil},
    ['STEERPOINT SQUARE Value2'] = {13, 1, 0, false, nil},
    ['STEERPOINT SQUARE Asteriscs_both'] = {11, 1, 14, true, nil},
    ['STEERPOINT SQUARE2 Asteriscs_both'] = {11, 1, 14, true, nil},

    --TIME
    ['HACK_label'] = {6, 4, 0, false, nil},
    ['HACK_value'] = {13, 8, 0, false, nil},
    ['Asterisks_on_HACK_both'] = {12, 1, 21, true, nil},
    ['HACK_IncDecSymbol'] = {23, 1, 0, false, nil},

    --BINGO
    ['SET label'] = {6, 3, 0, false, nil},
    ['BINGO Asterisks_both'] = {10, 1, 19, true, nil},
    ['BINGO Scratchpad'] = {11, 8, 0, false, nil},

    --NAV
    ['NAV STATUS GPS ACCURACY label'] = {3, 9, 0, false, nil},
    ['NAV STATUS GPS ACCURACY value'] = {14, 5, 0, false, nil},
    ['NAV COMMANDS FILTER MODE label'] = {3, 11, 0, false, nil},
    ['NAV COMMANDS FILTER MODE value'] = {16, 4, 0, false, nil},
    ['NAV COMMANDS Asterisks_both'] = {15, 1, 20, true, nil},

    --MAN
    ['MBAL Label'] = {10, 4, 0, false, nil},

    --INS
    ['INS_LNG_lbl'] = {2, 3, 0, false, nil},
    ['INS_LNG_Scratchpad'] = {7, 10, 0, false, nil},
    ['Asterisks_on_LNG_Scratchpad_both'] = {6, 1, 17, true, nil},
    ['INFLT ALGN INS_COMPASS_HDG_lbl'] = {3, 11, 0, false, nil},
    ['INFLT ALGN INS_CompassHdgScratchpad'] = {16, 4, 0, false, nil},
    ['INFLT ALGN Asterisks on Scratchpad_both'] = {15, 1, 20, true, nil},

    --CMDS
    ['CMDS_BI_lbl'] = {6, 2, 0, false, nil},
    ['CMDS_BI_Scratchpad'] = {10, 6, 0, false, nil},
    ['CMDS_BI_Asterisks_both'] = {9, 1, 16, true, nil},
    ['CMDS  BINGO CMDS_FL_lbl'] = {2, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_FL_Scratchpad'] = {7, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_FL_Asterisks_both'] = {6, 1, 9, true, nil},
    ['CMDS  BINGO CMDS_FDBK_lbl'] = {11, 4, 0, false, nil},
    ['CMDS  BINGO CMDS_FDBK_value'] = {19, 3, 0, false, nil},
    ['CMDS  BINGO CMDS_FDBK_Asterisks_both'] = {18, 1, 22, true, nil},

    --DLNK
    ['TNDL MC lbl'] = {3, 2, 0, false, nil},
    ['TNDL MC value'] = {6, 3, 0, false, nil},
    ['TNDL Asterisks on MC_both'] = {5, 1, 9, true, nil},
    ['TNDL FL lbl'] = {12, 2, 0, false, nil},
    ['TNDL FL status'] = {16, 3, 0, false, nil},
    ['TNDL Asterisks on FL_both'] = {15, 1, 19, true, nil},
    ['TNDL   STN NUM lbl'] = {20, 1, 0, false, nil},
    ['TNDL   STN Own num value'] = {22, 1, 0, false, nil},
    ['TNDL   STN Asterisks on Own_both'] = {21, 1, 23, true, nil},
    ['NET STATUS TIME lbl'] = {4, 4, 0, false, nil},
    ['NET STATUS TIME value'] = {9, 8, 0, false, nil},
    ['NET STATUS Asterisks on TIME_both'] = {8, 1, 17, true, nil},
    ['TNDL   STN STN id lbl_2'] = {0, 1, 0, false, nil},
    ['TNDL   STN STN TDOA value_2'] = {2, 1, 0, false, nil},
    ['TNDL   STN STN value_2'] = {4, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_2_both'] = {1, 1, 3, true, nil},
    ['TNDL   STN Asterisks on STN_2_both'] = {3, 1, 9, true, nil},
    ['TNDL   STN STN id lbl_6'] = {10, 2, 0, false, nil},
    ['TNDL   STN STN TDOA value_6'] = {12, 1, 0, false, nil},
    ['TNDL   STN STN value_6'] = {14, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_6_both'] = {11, 1, 13, true, nil},
    ['TNDL   STN Asterisks on STN_6_both'] = {13, 1, 19, true, nil},
    ['OWN value'] = {7, 2, 0, false, nil},
    ['DATA lbl'] = {12, 4, 0, false, nil},
    ['DATA value'] = {7, 3, 0, false, nil},
    ['INTRAFLIGHT STN id lbl2'] = {1, 2, 0, false, nil},
    ['INTRAFLIGHT STN value2'] = {4, 5, 0, false, nil},
    ['INTRAFLIGHT STN id lbl6'] = {7, 2, 0, false, nil},
    ['INTRAFLIGHT STN value6'] = {10, 5, 0, false, nil},
    ['INTRAFLIGHT DATA lbl'] = {13, 4, 0, false, nil},
    ['INTRAFLIGHT DATA value'] = {18, 3, 0, false, nil},

    --Misc
    ['MISC Misc Item 4 Number'] = {0, 1, 0, true, nil},
    ['MISC Misc Item 4 Name'] = {1, 4, 0, false, nil},
    ['MISC Misc Item 5 Number'] = {6, 1, 0, true, nil},
    ['MISC Misc Item 5 Name'] = {7, 4, 0, false, nil},
    ['MISC Misc Item 6 Number'] = {12, 1, 0, true, nil},
    ['MISC Misc Item 6 Name'] = {13, 4, 0, false, nil},
    ['MISC Misc Item E Number'] = {18, 1, 0, true, nil},
    ['MISC Misc Item E Name'] = {19, 4, 0, false, nil},

    --MAGV
    ['INS_MAGV_Scratchpad'] = {9, 6, 0, false, nil},
    ['Asterisks_on_MAGV_Scratchpad_both'] = {8, 1, 15, true, nil},

    --LASER
    ['LASR LST CODE LABEL'] = {1, 8, 0, false, nil},
    ['LASR LST CODE VALUE'] = {13, 4, 0, false, nil},
    ['LASR LST CODE Asteriscs_both'] = {12, 1, 17, true, nil},

    --INTG
    ['INTG M1 Mode'] = {0, 2, 0, false, nil},
    ['INTG M1 Decoupled Status'] = {3, 1, 0, false, nil},
    ['INTG M1 Code'] = {4, 2, 0, false, nil},
    ['INTG M4 Mode'] = {16, 2, 0, false, nil},
    ['INTG M4 Decoupled Status'] = {19, 1, 0, false, nil},
    ['INTG M4 Code'] = {20, 1, 0, false, nil},
    ['INTG M4 Key'] = {21, 3, 0, false, nil},

    --HARM
    ['HARM T3'] = {14, 2, 0, false, nil},
    ['HARM T3_code'] = {18, 3, 0, false, nil},
    ['HARM Asterisks_T3_both'] = {17, 1, 21, true, nil},

    --VIP
    ['VIP-TO-TGT VIP bearing'] = {4, 4, 0, false, nil},
    ['VIP-TO-TGT VIP bearing value'] = {10, 6, 0, false, nil},
    ['VIP-TO-TGT VIP bearing Asteriscs_both'] = {9, 1, 16, true, nil},

    --VIP PUP
    ['VIP-TO-PUP VIP bearing'] = {4, 4, 0, false, nil},
    ['VIP-TO-PUP VIP bearing value'] = {10, 6, 0, false, nil},
    ['VIP-TO-PUP VIP bearing Asteriscs_both'] = {9, 1, 16, true, nil},

    --VRP
    ['TGT-TO-VRP Target bearing'] = {4, 4, 0, false, nil},
    ['TGT-TO-VRP Target bearing value'] = {10, 6, 0, false, nil},
    ['TGT-TO-VRP Target bearing Asteriscs_both'] = {9, 1, 16, true, nil},

    --VRP PUP
    ['TGT-TO-PUP Target bearing'] = {4, 4, 0, false, nil},
    ['TGT-TO-PUP Target bearing value'] = {10, 6, 0, false, nil},
    ['TGT-TO-PUP Target bearing Asteriscs_both'] = {9, 1, 16, true, nil},

    --HMCS
    ['HMCS DISPLAY HMCS_CKPT_BLANK'] = {3, 9, 0, false, nil},
    ['HMCS DISPLAY Asterisks_CKPT_BLANK_both'] = {2, 1, 12, true, nil},
    ['HMCS ALIGN HMCS_AZ_EL'] = {2, 5, 0, false, nil},
    ['HMCS ALIGN Asterisks_AZ_ELAZ_EL_both'] = {1, 1, 7, true, nil},

    --MARK
    ['MARK Longitude'] = {2, 3, 0, false, nil},
    ['MARK Longitude Value'] = {6, 12, 0, false, nil},
    ['MARK Longitude Asteriscs_both'] = {5, 1, 18, true, nil},

    --CRUS TOS
    ['TOS_DES_TOS_label'] = {4, 7, 0, false, nil},
    ['TOS_DES_TOS_value'] = {13, 8, 0, false, nil},
    ['Asterisks_DES_TOS_both'] = {12, 1, 21, true, nil},

    --CRUS EDR
    ['EDR_TO_BINGO_label'] = {4, 7, 0, false, nil},
    ['EDR_TO_BINGO_value'] = {13, 8, 0, false, nil},

    --CRUS HOME
    ['HOME HOME_FUEL_REMANING'] = {7, 4, 0, false, nil},
    ['HOME HOME_FUEL_REMANING_Value'] = {12, 8, 0, false, nil},

    --CRUS RNG
    ['RNG_FUEL_REMANING'] = {7, 4, 0, false, nil},
    ['RNG_FUEL_REMANING_Value'] = {12, 8, 0, false, nil},

    --FIX
    ['FIX FIX_DELTA'] = {3, 5, 0, false, nil},
    ['FIX DELTA'] = {13, 7, 0, false, nil},

    --A CAL MAN
    ['ACAL ACAL_ALEV'] = {8, 4, 0, false, nil},
    ['ACAL ELEV'] = {16, 7, 0, false, nil},
    ['ACAL Asterisks_ELEV_both'] = {15, 1, 23, true, nil},

    --A CAL AUTO
    ['GPS_ACCURACY_label'] = {3, 9, 0, false, nil},
    ['GPS_ACCURACY_value'] = {14, 4, 0, false, nil},

    --HTS MAN
    ['HTS MAN T2'] = {1, 1, 0, false, nil},
    ['HTS MAN T2_code'] = {3, 4, 0, false, nil},
    ['HTS MAN Asterisks_T2_both'] = {2, 1, 7, true, nil},
    ['HTS MAN T6'] = {10, 1, 0, false, nil},
    ['HTS MAN T6_code'] = {12, 4, 0, false, nil},
    ['HTS MAN Asterisks_T6_both'] = {11, 1, 16, true, nil},

    --HTS SEAD
    ['HTS_LNG_lbl'] = {2, 3, 0, false, nil},
    ['HTS_LNG'] = {7, 10, 0, false, nil},

    --DEST_DIR
    ['DEST DIR DEST_LON'] = {3, 3, 0, false, nil},
    ['DEST DIR LON'] = {8, 12, 0, false, nil},
    ['DEST DIR Asterisks_LON_both'] = {7, 1, 20, true, nil},

    --UTM DEST
    ['UTM DEST UTM_DEST_SQUARE'] = {4, 6, 0, false, nil},
    ['UTM DEST SQUARE'] = {12, 1, 0, false, nil},
    ['UTM DEST SQUARE2'] = {13, 1, 0, false, nil},
    ['UTM DEST Asterisks_SQUARE_both'] = {11, 1, 14, true, nil},
    ['UTM DEST Asterisks_SQUARE2_both'] = {11, 1, 14, true, nil},

    --DEST_OA1
    ['DEST OA1 DEST_OA1_RNG'] = {3, 3, 0, false, nil},
    ['DEST OA1 RNG'] = {8, 8, 0, false, nil},
    ['DEST OA1 Asterisks_RNG_both'] = {7, 1, 16, true, nil},

    --DEST_OA2
    ['DEST OA2 DEST_OA2_RNG'] = {3, 3, 0, false, nil},
    ['DEST OA2 RNG'] = {8, 8, 0, false, nil},
    ['DEST OA2 Asterisks_RNG_both'] = {7, 1, 16, true, nil},
}

layout_defs[4] = {
    --CNI
    ['VHF Status'] = {1, 1, 0, false, nil},
    ['Hack Time'] = {15, 8, 0, false, nil},

    --COM
    ['Preset Label'] = {2, 9, 0, false, nil},
    ['Preset Number'] = {7, 2, 0, false, nil},
    ['Asterisks on PresetChannel_both'] = {6, 1, 9, true, nil},
    ['TOD Label'] = {17, 3, 0, false, nil},

    --IFF
    ['STAT M2 Mode'] = {0, 2, 0, false, nil},
    ['STAT M2 Lockout Status'] = {3, 1, 0, false, nil},
    ['STAT M2 Code'] = {4, 4, 0, false, nil},
    ['STAT MC Mode'] = {9, 2, 0, false, nil},
    ['STAT MC Code'] = {12, 1, 0, false, nil},
    ['STAT MC Key'] = {14, 3, 0, false, nil},
    ['STAT M2 Mode'] = {0, 2, 0, false, nil},
    ['STAT M2 Lockout Status'] = {3, 1, 0, false, nil},
    ['STAT M2 Code'] = {4, 4, 0, false, nil},
    ['STAT MC Mode'] = {9, 2, 0, false, nil},
    ['STAT MC Code'] = {12, 1, 0, false, nil},
    ['STAT MC Key'] = {14, 3, 0, false, nil},
    ['STAT TIM EVENT - Time'] = {18, 5, 0, false, nil},
    ['POS M2 Mode'] = {1, 2, 0, false, nil},
    ['POS M2 Lockout Status'] = {3, 1, 0, false, nil},
    ['POS M2 Code'] = {4, 4, 0, false, nil},
    ['POS MC Mode'] = {9, 2, 0, false, nil},
    ['POS MC Code'] = {12, 1, 0, false, nil},
    ['POS MC Key'] = {14, 3, 0, false, nil},
    ['POS POS EVENT - Side'] = {19, 1, 0, false, nil},
    ['POS POS EVENT - OF'] = {20, 2, 0, false, nil},
    ['POS POS EVENT - Number'] = {22, 1, 0, false, nil},
    ['TIM M2 Mode'] = {1, 2, 0, false, nil},
    ['TIM M2 Lockout Status'] = {3, 1, 0, false, nil},
    ['TIM M2 Lockout Status'] = {4, 4, 0, false, nil},
    ['TIM MC Mode'] = {9, 2, 0, false, nil},
    ['TIM MC Code'] = {12, 1, 0, false, nil},
    ['TIM MC Key'] = {14, 3, 0, false, nil},
    ['TIM EVENT - Time'] = {18, 5, 0, false, nil},

    --List
    ['LIST List Item 7 Number'] = {0, 1, 0, true, nil},
    ['LIST List Item 7 Name'] = {1, 4, 0, false, nil},
    ['LIST List Item 8 Number'] = {6, 1, 0, true, nil},
    ['LIST List Item 8 Name'] = {7, 4, 0, false, nil},
    ['LIST List Item 9 Number'] = {12, 1, 0, true, nil},
    ['LIST List Item 9 Name'] = {13, 4, 0, false, nil},
    ['LIST List Item 0 Number'] = {18, 1, 0, true, nil},
    ['LIST List Item 0 Name'] = {19, 4, 0, false, nil},

    --T-ILS
    ['ILS FRQ Label'] = {12, 3, 0, false, nil},
    ['ILS FRQ Scratchpad'] = {17, 6, 0, false, nil},
    ['ILS FRQ Asterisks_both'] = {16, 1, 23, true, nil},
    ['TCN CHAN Label'] = {0, 4, 0, false, nil},
    ['TCN CHAN Scratchpad'] = {5, 3, 0, false, nil},
    ['TCN CHAN Asterisks_both'] = {4, 1, 8, true, nil},
    ['BACKUP lbl'] = {2, 6, 0, false, nil},

    --ALOW
    ['ALOW MSL FLOOR label'] = {3, 9, 0, false, nil},
    ['ALOW MSL FLOOR Scratchpad'] = {15, 7, 0, false, nil},
    ['ALOW MSL FLOOR Asterisks_both'] = {14, 1, 22, true, nil},

    --STPT
    ['STEERPOINT Elevation'] = {2, 3, 0, false, nil},
    ['STEERPOINT Elevation Value'] = {8, 8, 0, false, nil},
    ['STEERPOINT Elevation Asteriscs_both'] = {7, 1, 16, true, nil},

    --STPT MGRS
    ['STEERPOINT EAST NORTH'] = {0, 10, 0, false, nil},
    ['STEERPOINT EAST NORTH Value'] = {12, 11, 0, false, nil},
    ['STEERPOINT EAST NORTH Asteriscs_both'] = {11, 1, 23, true, nil},

    --TIME
    ['DELTA_TOS_label'] = {1, 9, 0, false, nil},
    ['DELTA_TOS_value'] = {12, 9, 0, false, nil},
    ['Asterisks_on_DELTA_TOS_both'] = {11, 1, 21, true, nil},

    --BINGO
    ['TOTAL label'] = {4, 5, 0, false, nil},
    ['TOTAL value'] = {11, 5, 0, false, nil},
    ['TOTAL LBS label'] = {16, 3, 0, false, nil},

    --NAV
    ['NAV STATUS MSN DUR label'] = {3, 7, 0, false, nil},
    ['NAV STATUS DAYS label'] = {16, 4, 0, false, nil},
    ['NAV STATUS Scratchpad'] = {12, 2, 0, false, nil},
    ['NAV STATUS Asterisks on Scratchpad_both'] = {11, 1, 14, true, nil},
    ['NAV COMMANDS RESET GPS label'] = {6, 11, 0, false, nil},
    ['NAV COMMANDS Asterisks on RESET_both'] = {5, 1, 17, true, nil},

    --MAN
    ['RNG Label'] = {8, 3, 0, false, nil},
    ['RNG Data'] = {11, 7, 0, false, nil},
    ['RNG FT'] = {18, 2, 0, false, nil},

    --INS
    ['INS_SALT_lbl'] = {1, 4, 0, false, nil},
    ['INS_SALT_Scratchpad'] = {8, 7, 0, false, nil},
    ['Asterisks_on_SALT_Scratchpad_both'] = {7, 1, 15, true, nil},
    ['INS_FIX_NECESSARY_lbl'] = {3, 17, 0, false, nil},

    --CMDS
    ['CMDS_SQ_lbl'] = {6, 2, 0, false, nil},
    ['CMDS_SQ_Scratchpad'] = {10, 2, 0, false, nil},
    ['CMDS_SQ_Asterisks_both'] = {9, 1, 12, true, nil},
    ['CMDS  BINGO CMDS_O1_lbl'] = {2, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_O1_Scratchpad'] = {7, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_O1_Asterisks_both'] = {6, 1, 9, true, nil},
    ['CMDS  BINGO CMDS_REQCTR_lbl'] = {11, 6, 0, false, nil},
    ['CMDS  BINGO CMDS_REQCTR_value'] = {19, 3, 0, false, nil},
    ['CMDS  BINGO CMDS_REQCTR_Asterisks_both'] = {18, 1, 22, true, nil},

    --DLNK
    ['TNDL SC lbl'] = {3, 2, 0, false, nil},
    ['TNDL SC value'] = {6, 3, 0, false, nil},
    ['TNDL Asterisks on SC_both'] = {5, 1, 9, true, nil},
    ['TNDL XMT lbl'] = {11, 3, 0, false, nil},
    ['TNDL XMT status'] = {16, 2, 0, false, nil},
    ['TNDL Asterisks on XMT_both'] = {15, 1, 20, true, nil},
    ['NET STATUS NTR lbl'] = {5, 3, 0, false, nil},
    ['NET STATUS NTR status'] = {9, 3, 0, false, nil},
    ['NET STATUS Asterisks on NTR_both'] = {8, 1, 12, true, nil},
    ['TNDL   STN STN id lbl_3'] = {0, 1, 0, false, nil},
    ['TNDL   STN STN TDOA value_3'] = {2, 1, 0, false, nil},
    ['TNDL   STN STN value_3'] = {4, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_3_both'] = {1, 1, 3, true, nil},
    ['TNDL   STN Asterisks on STN_3_both'] = {3, 1, 9, true, nil},
    ['TNDL   STN STN id lbl_7'] = {10, 2, 0, false, nil},
    ['TNDL   STN STN TDOA value_7'] = {12, 1, 0, false, nil},
    ['TNDL   STN STN value_7'] = {14, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_7_both'] = {11, 1, 13, true, nil},
    ['TNDL   STN Asterisks on STN_7_both'] = {13, 1, 19, true, nil},
    ['FILL lbl'] = {2, 4, 0, false, nil},
    ['FILL status'] = {7, 3, 0, false, nil},
    ['PRTL lbl'] = {12, 4, 0, false, nil},
    ['PRTL status'] = {17, 5, 0, false, nil},
    ['INTRAFLIGHT STN id lbl3'] = {1, 2, 0, false, nil},
    ['INTRAFLIGHT STN value3'] = {4, 5, 0, false, nil},
    ['INTRAFLIGHT STN id lbl7'] = {7, 2, 0, false, nil},
    ['INTRAFLIGHT STN value7'] = {10, 5, 0, false, nil},
    ['INTRAFLIGHT OWN lbl'] = {14, 4, 0, false, nil},
    ['INTRAFLIGHT Own value'] = {18, 2, 0, false, nil},

    --Misc
    ['MISC Misc Item 7 Number'] = {0, 1, 0, true, nil},
    ['MISC Misc Item 7 Name'] = {1, 4, 0, false, nil},
    ['MISC Misc Item 8 Number'] = {6, 1, 0, true, nil},
    ['MISC Misc Item 8 Name'] = {7, 4, 0, false, nil},
    ['MISC Misc Item 9 Number'] = {12, 1, 0, true, nil},
    ['MISC Misc Item 9 Name'] = {13, 4, 0, false, nil},
    ['MISC Misc Item 0 Number'] = {18, 1, 0, true, nil},
    ['MISC Misc Item 0 Name'] = {19, 4, 0, false, nil},

    --INTG
    ['INTG M2 Mode'] = {0, 2, 0, false, nil},
    ['INTG M2 Decoupled Status'] = {3, 1, 0, false, nil},
    ['INTG M2 Code'] = {4, 4, 0, false, nil},
    ['INTG IJAM Mode'] = {15, 4, 0, false, nil},
    ['INTG IJAM Key'] = {20, 3, 0, false, nil},

    --HARM
    ['HARM T4'] = {14, 2, 0, false, nil},
    ['HARM T4_code'] = {18, 3, 0, false, nil},
    ['HARM Asterisks_T4_both'] = {17, 1, 21, true, nil},

    --VIP
    ['VIP-TO-TGT Range'] = {5, 3, 0, false, nil},
    ['VIP-TO-TGT Range value'] = {12, 4, 0, false, nil},
    ['VIP-TO-TGT Range Asteriscs_both'] = {11, 1, 16, true, nil},
    ['VIP-TO-TGT Range NM'] = {17, 2, 0, false, nil},

    --VIP PUP
    ['VIP-TO-PUP Range'] = {5, 3, 0, false, nil},
    ['VIP-TO-PUP Range value'] = {12, 4, 0, false, nil},
    ['VIP-TO-PUP Range Asteriscs_both'] = {11, 1, 16, true, nil},
    ['VIP-TO-PUP Range NM'] = {17, 2, 0, false, nil},

    --VRP
    ['TGT-TO-VRP Range'] = {5, 3, 0, false, nil},
    ['TGT-TO-VRP Range value'] = {10, 8, 0, false, nil},
    ['TGT-TO-VRP Range Asteriscs_both'] = {9, 1, 18, true, nil},
    ['TGT-TO-VRP Range NM'] = {17, 2, 0, false, nil},

    --VRP PUP
    ['TGT-TO-PUP Range'] = {5, 3, 0, false, nil},
    ['TGT-TO-PUP Range value'] = {10, 8, 0, false, nil},
    ['TGT-TO-PUP Range Asteriscs_both'] = {9, 1, 18, true, nil},
    ['TGT-TO-PUP Range NM'] = {17, 2, 0, false, nil},

    --HMCS
    ['HMCS DISPLAY HMCS_DECLUTTER'] = {3, 14, 0, false, nil},
    ['HMCS DISPLAY HMCS_DECLUTTER_STATUS'] = {17, 1, 0, false, nil},
    ['HMCS DISPLAY Asterisks_DECLUTTER_both'] = {12, 1, 18, true, nil},
    ['HMCS ALIGN HMCS_ROLL'] = {2, 4, 0, false, nil},
    ['HMCS ALIGN Asterisks_ROLL_both'] = {1, 1, 6, true, nil},

    --MARK
    ['MARK Elevation'] = {1, 4, 0, false, nil},
    ['MARK Elevation Value'] = {6, 8, 0, false, nil},
    ['MARK Elevation Asteriscs_both'] = {5, 1, 14, true, nil},

    --CRUS TOS
    ['TOS_ETA_label'] = {8, 3, 0, false, nil},
    ['TOS_ETA_value'] = {13, 8, 0, false, nil},

    --CRUS EDR
    ['EDR_OPT_MACH_label'] = {3, 8, 0, false, nil},
    ['EDR_OPT_MACH_value'] = {13, 8, 0, false, nil},

    --CRUS HOME
    ['HOME HOME_OPT_ALT_label'] = {4, 7, 0, false, nil},
    ['HOME HOME_OPT_ALT_value'] = {13, 8, 0, false, nil},

    --FIX
    ['FIX SYS ACCURACY label'] = {4, 9, 0, false, nil},
    ['FIX SYS ACCURACY value'] = {14, 4, 0, false, nil},

    --A CAL MAN
    ['ACAL ACAL_ALT_DELTA'] = {8, 5, 0, false, nil},
    ['ACAL ACAL_ALT_DELTA_label'] = {2, 8, 0, false, nil},
    ['ACAL DELTA_ALT'] = {16, 7, 0, false, nil},

    --A CAL AUTO
    ['DTS_STATUS_label'] = {9, 3, 0, false, nil},
    ['DTS_STATUS_value'] = {14, 3, 0, false, nil},
    ['DTS_ACCURACY_HPU_label'] = {21, 2, 0, false, nil},
    ['DTS_ACCURACY_HPU_value'] = {23, 1, 0, false, nil},

    --HTS MAN
    ['HTS MAN T3'] = {1, 1, 0, false, nil},
    ['HTS MAN T3_code'] = {3, 4, 0, false, nil},
    ['HTS MAN Asterisks_T3_both'] = {2, 1, 7, true, nil},
    ['HTS MAN T7'] = {10, 1, 0, false, nil},
    ['HTS MAN T7_code'] = {12, 4, 0, false, nil},
    ['HTS MAN Asterisks_T7_both'] = {11, 1, 16, true, nil},

    --HTS SEAD
    ['HTS_ELEV_lbl'] = {2, 3, 0, false, nil},
    ['HTS_ELEV'] = {7, 10, 0, false, nil},

    --TODO
    ['TODO remove label'] = {4, 20, 0, false, nil},

    --UTM DEST
    ['UTM DEST UTM_DEST_EAST/NORTH'] = {0, 10, 0, false, nil},
    ['UTM DEST EAST/NORTH'] = {12, 11, 0, false, nil},
    ['UTM DEST Asterisks_EAST/NORTH_both'] = {11, 1, 23, true, nil},

    --DEST_DIR
    ['DEST DIR DEST_ELEV'] = {2, 4, 0, false, nil},
    ['DEST DIR ELEV'] = {8, 7, 0, false, nil},
    ['DEST DIR Asterisks_ELEV_both'] = {7, 1, 15, true, nil},

    --DEST_OA1
    ['DEST OA1 DEST_OA1_BRG'] = {3, 3, 0, false, nil},
    ['DEST OA1 BRG'] = {8, 6, 0, false, nil},
    ['DEST OA1 Asterisks_BRG_both'] = {7, 1, 14, true, nil},

    --DEST_OA2
    ['DEST OA2 DEST_OA2_BRG'] = {3, 3, 0, false, nil},
    ['DEST OA2 BRG'] = {8, 6, 0, false, nil},
    ['DEST OA2 Asterisks_BRG_both'] = {7, 1, 14, true, nil},
}

layout_defs[5] = {
    --CNI
    ['IFF Modes Label'] = {1, 1, 0, false, nil},
    ['IFF Modes Enabled'] = {2, 6, 0, false, nil},
    ['Active Mode 3 Code'] = {9, 4, 0, false, nil},
    ['IFF Switching'] = {14, 1, 0, false, nil},
    ['TACAN Label'] = {19, 1, 0, false, nil},
    ['TACAN Channel'] = {20, 3, 0, false, nil},
    ['TACAN Band'] = {23, 1, 0, false, nil},
    ['TACAN A-A Distance'] = {19, 5, 0, false, nil},

    --COM
    ['Preset Frequency'] = {5, 6, 0, false, nil},
    ['Asterisks on PresetFrequency_both'] = {4, 1, 11, true, nil},
    ['Bandwidth'] = {18, 2, 0, false, nil},
    ['Asterisks on Band_both'] = {17, 1, 20, true, nil},
    ['Preset Channel Number'] = {20, 2, 0, false, nil},
    ['Guard or Backup Frequency'] = {10, 6, 0, false, nil},

    --IFF
    ['STAT M3 Mode'] = {0, 2, 0, false, nil},
    ['STAT M3 Lockout Status'] = {3, 1, 0, false, nil},
    ['STAT M3 Code'] = {4, 4, 0, false, nil},
    ['STAT M4 Monitoring'] = {9, 3, 0, false, nil},
    ['STAT M4 Monitoring Key'] = {14, 3, 0, false, nil},
    ['STAT MS Mode'] = {18, 2, 0, false, nil},
    ['STAT MS Code'] = {20, 1, 0, false, nil},
    ['STAT MS Key'] = {21, 3, 0, false, nil},
    ['POS M3 Mode'] = {1, 2, 0, false, nil},
    ['POS M3 Lockout Status'] = {3, 1, 0, false, nil},
    ['POS M3 Code'] = {4, 4, 0, false, nil},
    ['POS M4 Monitoring'] = {9, 3, 0, false, nil},
    ['POS M4 Monitoring Key'] = {14, 3, 0, false, nil},
    ['POS MS Mode'] = {18, 2, 0, false, nil},
    ['POS MS Code'] = {20, 1, 0, false, nil},
    ['POS MS Key'] = {21, 3, 0, false, nil},
    ['TIM M3 Mode'] = {1, 2, 0, false, nil},
    ['TIM M3 Lockout Status'] = {3, 1, 0, false, nil},
    ['TIM M3 Code'] = {4, 4, 0, false, nil},
    ['TIM M4 Monitoring'] = {9, 3, 0, false, nil},
    ['TIM M4 Monitoring Key'] = {14, 3, 0, false, nil},
    ['TIM MS Mode'] = {18, 2, 0, false, nil},
    ['TIM MS Code'] = {20, 1, 0, false, nil},
    ['TIM MS Key'] = {21, 3, 0, false, nil},

    --T-ILS
    ['ILS CRS Label'] = {12, 3, 0, false, nil},
    ['ILS CRS Scratchpad'] = {17, 4, 0, false, nil},
    ['ILS CRS Asterisks_both'] = {16, 1, 21, true, nil},
    ['TCN BAND Label'] = {0, 4, 0, false, nil},
    ['TCN BAND XY'] = {5, 1, 0, false, nil},
    ['TCN BAND Key'] = {6, 3, 0, false, nil},

    --STPT
    ['STEERPOINT Time over current STP'] = {3, 3, 0, false, nil},
    ['STEERPOINT TOS Value'] = {8, 8, 0, false, nil},
    ['STEERPOINT TOS Asteriscs_both'] = {7, 1, 16, true, nil},

    --STPT MGRS
    ['STEERPOINT ElevationMGRS'] = {6, 4, 0, false, nil},
    ['STEERPOINT ElevationMGRS Value'] = {11, 8, 0, false, nil},
    ['STEERPOINT ElevationMGRS Asteriscs_both'] = {11, 1, 20, true, nil},

    --TIME
    ['DATE_FORMAT_label'] = {2, 8, 0, false, nil},
    ['DATE_value'] = {13, 8, 0, false, nil},
    ['Asterisks_on_DATE_both'] = {12, 1, 21, true, nil},

    --NAV
    ['NAV STATUS Keys Msg'] = {3, 18, 0, false, nil},
    ['NAV COMMANDS ZEROIZE GPS label'] = {6, 11, 0, false, nil},
    ['NAV COMMANDS Asterisks on ZEROIZE_both'] = {5, 1, 17, true, nil},

    --MAN
    ['TOF Label'] = {8, 3, 0, false, nil},
    ['TOF Data'] = {11, 6, 0, false, nil},
    ['TOF SEC'] = {17, 3, 0, false, nil},

    --INS
    ['INS_THDG_lbl'] = {1, 4, 0, false, nil},
    ['INS_THDG_Scratchpad'] = {7, 6, 0, false, nil},
    ['Asterisks_on_THDG_Scratchpad'] = {6, 1, 13, true, nil},
    ['INS_GS_lbl'] = {16, 3, 0, false, nil},
    ['INS_GS_value'] = {20, 3, 0, false, nil},

    --CMDS
    ['CMDS_SI_lbl'] = {6, 2, 0, false, nil},
    ['CMDS_SI_Scratchpad'] = {10, 6, 0, false, nil},
    ['CMDS_SI_Asterisks_both'] = {9, 1, 16, true, nil},
    ['CMDS  BINGO CMDS_O2_lbl'] = {2, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_O2_Scratchpad'] = {7, 2, 0, false, nil},
    ['CMDS  BINGO CMDS_O2_Asterisks_both'] = {6, 1, 9, true, nil},
    ['CMDS  BINGO CMDS_BINGO_lbl'] = {11, 5, 0, false, nil},
    ['CMDS  BINGO CMDS_BINGO_value'] = {19, 3, 0, false, nil},
    ['CMDS  BINGO CMDS_BINGO_Asterisks_both'] = {18, 1, 22, true, nil},

    --DLNK
    ['TNDL P2 lbl'] = {21, 3, 0, false, nil},
    ['NET STATUS SYNC lbl'] = {4, 4, 0, false, nil},
    ['NET STATUS SYNC status'] = {9, 4, 0, false, nil},
    ['NET STATUS Asterisks on SYNC_both'] = {8, 1, 15, true, nil},
    ['NET STATUS P1 lbl'] = {21, 3, 0, false, nil},
    ['TNDL   STN STN id lbl_4'] = {0, 1, 0, false, nil},
    ['TNDL   STN STN TDOA value_4'] = {2, 1, 0, false, nil},
    ['TNDL   STN STN value_4'] = {4, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_4_both'] = {1, 1, 3, true, nil},
    ['TNDL   STN Asterisks on STN_4_both'] = {3, 1, 9, true, nil},
    ['TNDL   STN STN id lbl_8'] = {10, 2, 0, false, nil},
    ['TNDL   STN STN TDOA value_8'] = {12, 1, 0, false, nil},
    ['TNDL   STN STN value_8'] = {14, 5, 0, false, nil},
    ['TNDL   STN Asterisks on STN TDOA_8_both'] = {11, 1, 13, true, nil},
    ['TNDL   STN Asterisks on STN_8_both'] = {13, 1, 19, true, nil},
    ['TNDL   STN P3 lbl'] = {21, 3, 0, false, nil},
    ['P5 lbl'] = {21, 3, 0, false, nil},
    ['INTRAFLIGHT STN id lbl4'] = {1, 2, 0, false, nil},
    ['INTRAFLIGHT STN value4'] = {4, 5, 0, false, nil},
    ['INTRAFLIGHT STN id lbl8'] = {7, 2, 0, false, nil},
    ['INTRAFLIGHT STN value8'] = {10, 5, 0, false, nil},
    ['INTRAFLIGHT LAST lbl'] = {13, 4, 0, false, nil},
    ['INTRAFLIGHT LAST value'] = {18, 2, 0, false, nil},
    ['INTRAFLIGHT P6 lbl'] = {21, 3, 0, false, nil},

    --LASER
    ['LASR Laser ST Time LABEL'] = {1, 13, 0, false, nil},
    ['LASR Laser ST Time VALUE'] = {16, 3, 0, false, nil},
    ['LASR Laser ST Time Asteriscs_both'] = {15, 1, 19, true, nil},

    --INTG
    ['INTG M3 Mode'] = {0, 2, 0, false, nil},
    ['INTG M3 Decoupled Status'] = {3, 1, 0, false, nil},
    ['INTG M3 Code'] = {4, 4, 0, false, nil},
    ['INTG Asterisks_both'] = {9, 1, 15, true, nil},
    ['INTG Scratchpad'] = {10, 5, 0, false, nil},
    ['INTG COUPLE Mode'] = {16, 4, 0, false, nil},
    ['INTG COUPLE Key'] = {20, 3, 0, false, nil},

    --HARM
    ['HARM T5'] = {14, 2, 0, false, nil},
    ['HARM T5_code'] = {18, 3, 0, false, nil},
    ['HARM Asterisks_T5_both'] = {17, 1, 21, true, nil},

    --HMCS
    ['HMCS DISPLAY HMCS_RWR_DISPLAY'] = {3, 9, 0, false, nil},
    ['HMCS DISPLAY HMCS_RWR_DISPLAY_STATUS'] = {13, 3, 0, false, nil},
    ['HMCS DISPLAY Asterisks_RWR_DISPLAY_both'] = {12, 1, 16, true, nil},

    --MARK
    ['MARK MGRS'] = {1, 4, 0, false, nil},
    ['MARK GRID DIGIT Value'] = {6, 2, 0, false, nil},
    ['MARK GRID SYMBOL Value'] = {8, 1, 0, false, nil},
    ['MARK SQUARE Value1'] = {9, 1, 0, false, nil},
    ['MARK SQUARE Value2'] = {10, 1, 0, false, nil},
    ['MARK EAST Value'] = {12, 5, 0, false, nil},
    ['MARK Slash'] = {17, 1, 0, false, nil},
    ['MARK NORTH Value'] = {18, 5, 0, false, nil},
    ['MARK MGRS Asteriscs_both'] = {5, 1, 23, true, nil},

    --CRUS RNG
    ['RNG_WIND_AT_ALTITUDE'] = {7, 4, 0, false, nil},
    ['RNG_WIND_AT_ALTITUDE_Value'] = {13, 10, 0, false, nil},

    --CRUS TOS
    ['TOS_REQ_GS_label'] = {4, 7, 0, false, nil},
    ['TOS_REQ_GS_value'] = {13, 7, 0, false, nil},

    --CRUS EDR
    ['EDR_WIND_AT_ALTITUDE'] = {7, 4, 0, false, nil},
    ['EDR_WIND_AT_ALTITUDE_Value'] = {13, 10, 0, false, nil},

    --CRUS HOME
    ['HOME HOME_WIND_AT_ALTITUDE'] = {7, 4, 0, false, nil},
    ['HOME HOME_WIND_AT_ALTITUDE_Value'] = {13, 10, 0, false, nil},

    --FIX
    ['FIX GPS ACCURACY label'] = {4, 9, 0, false, nil},
    ['FIX GPS ACCURACY value'] = {14, 4, 0, false, nil},

    --A CAL MAN
    ['ACAL ACAL_POS_DELTA'] = {8, 5, 0, false, nil},
    ['ACAL ACAL_POS_DELTA_label'] = {2, 3, 0, false, nil},
    ['ACAL DELTA_POS'] = {16, 7, 0, false, nil},

    --A CAL AUTO
    ['DTS_ACCURACY_VPU_label'] = {21, 2, 0, false, nil},
    ['DTS_ACCURACY_VPU_value'] = {23, 1, 0, false, nil},

    --HTS MAN
    ['HTS MAN T4'] = {1, 1, 0, false, nil},
    ['HTS MAN T4_code'] = {3, 4, 0, false, nil},
    ['HTS MAN Asterisks_T4_both'] = {2, 1, 7, true, nil},
    ['HTS MAN T8'] = {10, 1, 0, false, nil},
    ['HTS MAN T8_code'] = {12, 4, 0, false, nil},
    ['HTS MAN Asterisks_T8_both'] = {11, 1, 16, true, nil},

    --HTS SEAD
    ['HTS_TOT_lbl'] = {2, 3, 0, false, nil},
    ['HTS_TOT'] = {7, 10, 0, false, nil},

    --UTM DEST
    ['UTM DEST UTM_DEST_ELEV'] = {6, 4, 0, false, nil},
    ['UTM DEST ELEV'] = {12, 7, 0, false, nil},
    ['UTM DEST Asterisks_ELEV_both'] = {11, 1, 19, true, nil},
    ['UTM DEST P1 lbl'] = {21, 3, 0, false, nil},

    --DEST_DIR
    ['DEST DIR DEST_TOS'] = {3, 3, 0, false, nil},
    ['DEST DIR TOS'] = {8, 8, 0, false, nil},
    ['DEST DIR Asterisks_TOS_both'] = {7, 1, 16, true, nil},
    ['DEST DIR P2lbl'] = {21, 3, 0, false, nil},

    --DEST_OA1
    ['DEST OA1 DEST_OA1_ELEV'] = {2, 3, 0, false, nil},
    ['DEST OA1 ELEV'] = {8, 8, 0, false, nil},
    ['DEST OA1 Asterisks_ELEV_both'] = {7, 1, 16, true, nil},
    ['DEST OA1 P3lbl'] = {21, 3, 0, false, nil},

    --DEST_OA2
    ['DEST OA2 DEST_OA2_ELEV'] = {2, 3, 0, false, nil},
    ['DEST OA2 ELEV'] = {8, 8, 0, false, nil},
    ['DEST OA2 Asterisks_ELEV_both'] = {7, 1, 16, true, nil},
    ['DEST OA2 P4lbl'] = {21, 3, 0, false, nil},

    --VIP
    ['VIP-TO-TGT Elevation'] = {4, 4, 0, false, nil},
    ['VIP-TO-TGT Elevation value'] = {10, 8, 0, false, nil},
    ['VIP-TO-TGT Elevation Asteriscs_both'] = {9, 1, 18, true, nil},

    --VIP PUP
    ['VIP-TO-PUP Elevation'] = {4, 4, 0, false, nil},
    ['VIP-TO-PUP Elevation value'] = {10, 8, 0, false, nil},
    ['VIP-TO-PUP Elevation Asteriscs_both'] = {9, 1, 18, true, nil},

    --VRP
    ['TGT-TO-VRP Elevation'] = {4, 4, 0, false, nil},
    ['TGT-TO-VRP Elevation value'] = {10, 8, 0, false, nil},
    ['TGT-TO-VRP Elevation Asteriscs_both'] = {9, 1, 18, true, nil},

    --VRP PUP
    ['TGT-TO-PUP Elevation'] = {4, 4, 0, false, nil},
    ['TGT-TO-PUP Elevation value'] = {10, 8, 0, false, nil},
    ['TGT-TO-PUP Elevation Asteriscs_both'] = {9, 1, 18, true, nil},
}

local function parse_indication(indication_text)
    local parsed_data = {}
    for key, value in indication_text:gmatch('-+\n([^\n]+)\n([^\n]*)\n') do
        parsed_data[key] = value
    end
    return parsed_data
end

local function inverse_text(text)
    local new_text = {}
    for i, code in ipairs({text:byte(1, text:len())}) do
        new_text[i] = code + 128
    end
    return string.char(table.unpack(new_text))
end

local function merge_string(original_string, new_string, location)
	local new_string_length = new_string:len()
	local before = original_string:sub(1, location)
	local after = original_string:sub(location + new_string_length + 1)
    local merged = {}

	for i = 1, new_string_length do
		local current = original_string:sub(location + i, location + i)
		if current ~= ' ' then
			merged[i] = current
		else
			merged[i] = new_string:sub(i, i)
		end
	end
	return before .. table.concat(merged) .. after
end

local blank_line = "                        "

local function format_ded_line(ded_data, line)
    local text = blank_line

    -- Check for present of Objects that indicate Duplicate Key Names that need resolving
	local key_prefix =  ded_data["Guard Label"] or
	                    ded_data["Mode label"] or
	                    ded_data["Event Occured"] or
	                    ded_data["ALOW label"] or
	                    ded_data["CMDS_BINGO_label"] or
	                    ded_data["INS_INFLT_ALGN_lbl"] or
	                    ded_data["INTRAFLIGHT lbl"] or
	                    ded_data["A-G DL lbl"] or -- DLNK A-G page: further action might be necessary
	                    ded_data["NAV Status lbl"] or
	                    ded_data["HMCS_DISPLAY_label"] or
	                    ded_data["HMCS_ALIGN_label"] or
	                    ded_data["UTM_DEST"] or
	                    ded_data["DEST_DIR"] or
	                    ded_data["DEST_OA1"] or
	                    ded_data["DEST_OA2"] or
	                    ded_data["Target to VRP Label"] or ded_data["Target to VRP Label_inv"] or
	                    ded_data["Visual initial point to TGT Label"] or ded_data["Visual initial point to TGT Label_inv"] or
	                    ded_data["HOME_MODE"] or ded_data["HOME_MODE_inv"] or
	                    ded_data["FIX_SENSORS"] or
	                    ded_data["ACAL_SENSORS"] or
	                    ded_data["HARM"] or
	                    (ded_data["HTS"] == "HTS MAN" and "HTS MAN") or
	                    ded_data["Master_mode_label"] or
	                    ded_data["NET STATUS lbl"] or
	                    ded_data["LINK16 STN lbl"] or
	                    ded_data["LINK16 lbl"] or
	                    ded_data["MISC Label"] or
	                    ded_data["LIST Label"] or
	                    ded_data["LASR LABEL"]

    for k, v in pairs(ded_data) do
		local label = key_prefix and key_prefix .. ' ' .. k or k
        local layout = layout_defs[line][label:gsub('_inv', '', 1):gsub('_lhs', '_both', 1)]
        if layout then
            v = layout[5] or v
            if layout[4] or label:find('_inv') then
                if v:len() < layout[2] then
                    v = v .. blank_line:sub(1, layout[2] - v:len())
                end
                v = inverse_text(v)
            end
            text = merge_string(text, v, layout[1])
            if layout[3] > 0 then
                text = merge_string(text, v, layout[3])
            end
        end
    end

    return text
end

local ded_formatter = {}

function ded_formatter.format_ded_lines(indication_text)
    local lines = {}
    local ded_data = parse_indication(indication_text)

    for line = 1, 5 do
        lines[line] = format_ded_line(ded_data, line)
    end

    return lines
end

return ded_formatter
