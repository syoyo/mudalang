{-# OPTIONS -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module ParMUDA where
import AbsMUDA
import LexMUDA
import ErrM

-- parser produced by Happy Version 1.16

data HappyAbsSyn 
	= HappyTerminal Token
	| HappyErrorToken Int
	| HappyAbsSyn4 (Ident)
	| HappyAbsSyn5 (Integer)
	| HappyAbsSyn6 (Double)
	| HappyAbsSyn7 (CFloat)
	| HappyAbsSyn8 (CDouble)
	| HappyAbsSyn9 (Hexadecimal)
	| HappyAbsSyn10 (Prog)
	| HappyAbsSyn11 ([Struc])
	| HappyAbsSyn12 (Struc)
	| HappyAbsSyn13 ([MDec])
	| HappyAbsSyn14 (MDec)
	| HappyAbsSyn15 ([Func])
	| HappyAbsSyn16 (Func)
	| HappyAbsSyn17 ([FuncSpec])
	| HappyAbsSyn18 (FuncSpec)
	| HappyAbsSyn19 (FormalDec)
	| HappyAbsSyn20 ([FormalDec])
	| HappyAbsSyn21 ([DecInit])
	| HappyAbsSyn22 (DecInit)
	| HappyAbsSyn23 ([DecInitExp])
	| HappyAbsSyn24 (DecInitExp)
	| HappyAbsSyn25 (Qual)
	| HappyAbsSyn26 ([Qual])
	| HappyAbsSyn27 (Stm)
	| HappyAbsSyn28 ([Stm])
	| HappyAbsSyn29 ([Exp])
	| HappyAbsSyn30 (Exp)
	| HappyAbsSyn40 ([FuncArgs])
	| HappyAbsSyn41 (FuncArgs)
	| HappyAbsSyn42 ([Field])
	| HappyAbsSyn43 (Field)
	| HappyAbsSyn44 (Typ)

type HappyReduction m = 
	   Int 
	-> (Token)
	-> HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)
	-> [HappyState (Token) (HappyStk HappyAbsSyn -> [(Token)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Token)] -> m HappyAbsSyn

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186 :: () => Int -> HappyReduction (Err)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104 :: () => HappyReduction (Err)

action_0 (10) = happyGoto action_3
action_0 (11) = happyGoto action_4
action_0 _ = happyReduce_8

action_1 (92) = happyShift action_2
action_1 _ = happyFail

action_2 _ = happyReduce_1

action_3 (99) = happyAccept
action_3 _ = happyFail

action_4 (90) = happyShift action_7
action_4 (12) = happyGoto action_5
action_4 (15) = happyGoto action_6
action_4 _ = happyReduce_14

action_5 _ = happyReduce_9

action_6 (99) = happyReduce_7
action_6 (16) = happyGoto action_9
action_6 (17) = happyGoto action_10
action_6 _ = happyReduce_17

action_7 (92) = happyShift action_2
action_7 (4) = happyGoto action_8
action_7 _ = happyFail

action_8 (45) = happyShift action_18
action_8 _ = happyFail

action_9 _ = happyReduce_15

action_10 (78) = happyShift action_14
action_10 (81) = happyShift action_15
action_10 (84) = happyShift action_16
action_10 (89) = happyShift action_17
action_10 (92) = happyShift action_2
action_10 (4) = happyGoto action_11
action_10 (18) = happyGoto action_12
action_10 (44) = happyGoto action_13
action_10 _ = happyFail

action_11 _ = happyReduce_104

action_12 _ = happyReduce_18

action_13 (92) = happyShift action_2
action_13 (4) = happyGoto action_22
action_13 _ = happyFail

action_14 _ = happyReduce_21

action_15 _ = happyReduce_20

action_16 _ = happyReduce_19

action_17 _ = happyReduce_22

action_18 (92) = happyShift action_2
action_18 (4) = happyGoto action_11
action_18 (13) = happyGoto action_19
action_18 (14) = happyGoto action_20
action_18 (44) = happyGoto action_21
action_18 _ = happyFail

action_19 (46) = happyShift action_26
action_19 _ = happyFail

action_20 (92) = happyShift action_2
action_20 (4) = happyGoto action_11
action_20 (13) = happyGoto action_25
action_20 (14) = happyGoto action_20
action_20 (44) = happyGoto action_21
action_20 _ = happyReduce_11

action_21 (92) = happyShift action_2
action_21 (4) = happyGoto action_24
action_21 _ = happyFail

action_22 (48) = happyShift action_23
action_22 _ = happyFail

action_23 (79) = happyReduce_37
action_23 (83) = happyReduce_37
action_23 (85) = happyReduce_37
action_23 (87) = happyReduce_37
action_23 (92) = happyReduce_37
action_23 (19) = happyGoto action_29
action_23 (20) = happyGoto action_30
action_23 (26) = happyGoto action_31
action_23 _ = happyReduce_24

action_24 (47) = happyShift action_28
action_24 _ = happyFail

action_25 _ = happyReduce_12

action_26 (47) = happyShift action_27
action_26 _ = happyFail

action_27 _ = happyReduce_10

action_28 _ = happyReduce_13

action_29 (50) = happyShift action_39
action_29 _ = happyReduce_25

action_30 (49) = happyShift action_38
action_30 _ = happyFail

action_31 (79) = happyShift action_34
action_31 (83) = happyShift action_35
action_31 (85) = happyShift action_36
action_31 (87) = happyShift action_37
action_31 (92) = happyShift action_2
action_31 (4) = happyGoto action_11
action_31 (25) = happyGoto action_32
action_31 (44) = happyGoto action_33
action_31 _ = happyFail

action_32 _ = happyReduce_38

action_33 (92) = happyShift action_2
action_33 (4) = happyGoto action_42
action_33 _ = happyFail

action_34 _ = happyReduce_36

action_35 _ = happyReduce_33

action_36 _ = happyReduce_35

action_37 _ = happyReduce_34

action_38 (45) = happyShift action_41
action_38 _ = happyFail

action_39 (79) = happyReduce_37
action_39 (83) = happyReduce_37
action_39 (85) = happyReduce_37
action_39 (87) = happyReduce_37
action_39 (92) = happyReduce_37
action_39 (19) = happyGoto action_29
action_39 (20) = happyGoto action_40
action_39 (26) = happyGoto action_31
action_39 _ = happyReduce_24

action_40 _ = happyReduce_26

action_41 (28) = happyGoto action_43
action_41 _ = happyReduce_51

action_42 _ = happyReduce_23

action_43 (45) = happyShift action_61
action_43 (46) = happyShift action_62
action_43 (48) = happyShift action_63
action_43 (74) = happyShift action_64
action_43 (82) = happyShift action_65
action_43 (88) = happyShift action_66
action_43 (91) = happyShift action_67
action_43 (92) = happyShift action_2
action_43 (93) = happyShift action_68
action_43 (94) = happyShift action_69
action_43 (95) = happyShift action_70
action_43 (97) = happyShift action_71
action_43 (4) = happyGoto action_44
action_43 (5) = happyGoto action_45
action_43 (6) = happyGoto action_46
action_43 (7) = happyGoto action_47
action_43 (9) = happyGoto action_48
action_43 (27) = happyGoto action_49
action_43 (30) = happyGoto action_50
action_43 (31) = happyGoto action_51
action_43 (32) = happyGoto action_52
action_43 (33) = happyGoto action_53
action_43 (34) = happyGoto action_54
action_43 (35) = happyGoto action_55
action_43 (36) = happyGoto action_56
action_43 (37) = happyGoto action_57
action_43 (38) = happyGoto action_58
action_43 (39) = happyGoto action_59
action_43 (44) = happyGoto action_60
action_43 _ = happyFail

action_44 (48) = happyShift action_111
action_44 (51) = happyShift action_112
action_44 (52) = happyShift action_113
action_44 (53) = happyShift action_114
action_44 (92) = happyReduce_104
action_44 _ = happyReduce_91

action_45 _ = happyReduce_92

action_46 _ = happyReduce_93

action_47 _ = happyReduce_94

action_48 _ = happyReduce_95

action_49 (47) = happyShift action_110
action_49 _ = happyReduce_52

action_50 (47) = happyShift action_105
action_50 (55) = happyShift action_106
action_50 (56) = happyShift action_107
action_50 (57) = happyShift action_108
action_50 (58) = happyShift action_109
action_50 _ = happyFail

action_51 (59) = happyShift action_103
action_51 (60) = happyShift action_104
action_51 _ = happyReduce_59

action_52 (61) = happyShift action_99
action_52 (62) = happyShift action_100
action_52 (63) = happyShift action_101
action_52 (64) = happyShift action_102
action_52 _ = happyReduce_62

action_53 (65) = happyShift action_91
action_53 (66) = happyShift action_92
action_53 (67) = happyShift action_93
action_53 (68) = happyShift action_94
action_53 (69) = happyShift action_95
action_53 (70) = happyShift action_96
action_53 (71) = happyShift action_97
action_53 (72) = happyShift action_98
action_53 _ = happyReduce_67

action_54 (73) = happyShift action_89
action_54 (74) = happyShift action_90
action_54 _ = happyReduce_76

action_55 (75) = happyShift action_86
action_55 (76) = happyShift action_87
action_55 (77) = happyShift action_88
action_55 _ = happyReduce_79

action_56 (52) = happyShift action_85
action_56 _ = happyReduce_83

action_57 _ = happyReduce_85

action_58 (53) = happyShift action_84
action_58 _ = happyReduce_87

action_59 _ = happyReduce_90

action_60 (92) = happyShift action_2
action_60 (4) = happyGoto action_81
action_60 (21) = happyGoto action_82
action_60 (22) = happyGoto action_83
action_60 _ = happyFail

action_61 (28) = happyGoto action_80
action_61 _ = happyReduce_51

action_62 _ = happyReduce_16

action_63 (48) = happyShift action_63
action_63 (74) = happyShift action_64
action_63 (92) = happyShift action_2
action_63 (93) = happyShift action_68
action_63 (94) = happyShift action_69
action_63 (95) = happyShift action_70
action_63 (97) = happyShift action_71
action_63 (4) = happyGoto action_73
action_63 (5) = happyGoto action_45
action_63 (6) = happyGoto action_46
action_63 (7) = happyGoto action_47
action_63 (9) = happyGoto action_48
action_63 (30) = happyGoto action_79
action_63 (31) = happyGoto action_51
action_63 (32) = happyGoto action_52
action_63 (33) = happyGoto action_53
action_63 (34) = happyGoto action_54
action_63 (35) = happyGoto action_55
action_63 (36) = happyGoto action_56
action_63 (37) = happyGoto action_57
action_63 (38) = happyGoto action_58
action_63 (39) = happyGoto action_59
action_63 _ = happyFail

action_64 (48) = happyShift action_63
action_64 (74) = happyShift action_64
action_64 (92) = happyShift action_2
action_64 (93) = happyShift action_68
action_64 (94) = happyShift action_69
action_64 (95) = happyShift action_70
action_64 (97) = happyShift action_71
action_64 (4) = happyGoto action_73
action_64 (5) = happyGoto action_45
action_64 (6) = happyGoto action_46
action_64 (7) = happyGoto action_47
action_64 (9) = happyGoto action_48
action_64 (36) = happyGoto action_77
action_64 (37) = happyGoto action_78
action_64 (38) = happyGoto action_58
action_64 (39) = happyGoto action_59
action_64 _ = happyFail

action_65 (48) = happyShift action_76
action_65 _ = happyFail

action_66 (47) = happyShift action_75
action_66 (48) = happyShift action_63
action_66 (74) = happyShift action_64
action_66 (92) = happyShift action_2
action_66 (93) = happyShift action_68
action_66 (94) = happyShift action_69
action_66 (95) = happyShift action_70
action_66 (97) = happyShift action_71
action_66 (4) = happyGoto action_73
action_66 (5) = happyGoto action_45
action_66 (6) = happyGoto action_46
action_66 (7) = happyGoto action_47
action_66 (9) = happyGoto action_48
action_66 (30) = happyGoto action_74
action_66 (31) = happyGoto action_51
action_66 (32) = happyGoto action_52
action_66 (33) = happyGoto action_53
action_66 (34) = happyGoto action_54
action_66 (35) = happyGoto action_55
action_66 (36) = happyGoto action_56
action_66 (37) = happyGoto action_57
action_66 (38) = happyGoto action_58
action_66 (39) = happyGoto action_59
action_66 _ = happyFail

action_67 (48) = happyShift action_72
action_67 _ = happyFail

action_68 _ = happyReduce_2

action_69 _ = happyReduce_3

action_70 _ = happyReduce_4

action_71 _ = happyReduce_6

action_72 (48) = happyShift action_63
action_72 (74) = happyShift action_64
action_72 (92) = happyShift action_2
action_72 (93) = happyShift action_68
action_72 (94) = happyShift action_69
action_72 (95) = happyShift action_70
action_72 (97) = happyShift action_71
action_72 (4) = happyGoto action_73
action_72 (5) = happyGoto action_45
action_72 (6) = happyGoto action_46
action_72 (7) = happyGoto action_47
action_72 (9) = happyGoto action_48
action_72 (30) = happyGoto action_158
action_72 (31) = happyGoto action_51
action_72 (32) = happyGoto action_52
action_72 (33) = happyGoto action_53
action_72 (34) = happyGoto action_54
action_72 (35) = happyGoto action_55
action_72 (36) = happyGoto action_56
action_72 (37) = happyGoto action_57
action_72 (38) = happyGoto action_58
action_72 (39) = happyGoto action_59
action_72 _ = happyFail

action_73 (48) = happyShift action_111
action_73 _ = happyReduce_91

action_74 (47) = happyShift action_157
action_74 (55) = happyShift action_106
action_74 (56) = happyShift action_107
action_74 (57) = happyShift action_108
action_74 (58) = happyShift action_109
action_74 _ = happyFail

action_75 _ = happyReduce_48

action_76 (48) = happyShift action_63
action_76 (74) = happyShift action_64
action_76 (92) = happyShift action_2
action_76 (93) = happyShift action_68
action_76 (94) = happyShift action_69
action_76 (95) = happyShift action_70
action_76 (97) = happyShift action_71
action_76 (4) = happyGoto action_73
action_76 (5) = happyGoto action_45
action_76 (6) = happyGoto action_46
action_76 (7) = happyGoto action_47
action_76 (9) = happyGoto action_48
action_76 (30) = happyGoto action_156
action_76 (31) = happyGoto action_51
action_76 (32) = happyGoto action_52
action_76 (33) = happyGoto action_53
action_76 (34) = happyGoto action_54
action_76 (35) = happyGoto action_55
action_76 (36) = happyGoto action_56
action_76 (37) = happyGoto action_57
action_76 (38) = happyGoto action_58
action_76 (39) = happyGoto action_59
action_76 _ = happyFail

action_77 (52) = happyShift action_85
action_77 _ = happyFail

action_78 (52) = happyReduce_85
action_78 _ = happyReduce_84

action_79 (49) = happyShift action_155
action_79 (55) = happyShift action_106
action_79 (56) = happyShift action_107
action_79 (57) = happyShift action_108
action_79 (58) = happyShift action_109
action_79 _ = happyFail

action_80 (45) = happyShift action_61
action_80 (46) = happyShift action_154
action_80 (48) = happyShift action_63
action_80 (74) = happyShift action_64
action_80 (82) = happyShift action_65
action_80 (88) = happyShift action_66
action_80 (91) = happyShift action_67
action_80 (92) = happyShift action_2
action_80 (93) = happyShift action_68
action_80 (94) = happyShift action_69
action_80 (95) = happyShift action_70
action_80 (97) = happyShift action_71
action_80 (4) = happyGoto action_44
action_80 (5) = happyGoto action_45
action_80 (6) = happyGoto action_46
action_80 (7) = happyGoto action_47
action_80 (9) = happyGoto action_48
action_80 (27) = happyGoto action_49
action_80 (30) = happyGoto action_50
action_80 (31) = happyGoto action_51
action_80 (32) = happyGoto action_52
action_80 (33) = happyGoto action_53
action_80 (34) = happyGoto action_54
action_80 (35) = happyGoto action_55
action_80 (36) = happyGoto action_56
action_80 (37) = happyGoto action_57
action_80 (38) = happyGoto action_58
action_80 (39) = happyGoto action_59
action_80 (44) = happyGoto action_60
action_80 _ = happyFail

action_81 (51) = happyShift action_153
action_81 (23) = happyGoto action_151
action_81 (24) = happyGoto action_152
action_81 _ = happyReduce_30

action_82 (47) = happyShift action_150
action_82 _ = happyFail

action_83 (50) = happyShift action_149
action_83 _ = happyReduce_27

action_84 (48) = happyShift action_63
action_84 (74) = happyShift action_64
action_84 (92) = happyShift action_2
action_84 (93) = happyShift action_68
action_84 (94) = happyShift action_69
action_84 (95) = happyShift action_70
action_84 (97) = happyShift action_71
action_84 (4) = happyGoto action_73
action_84 (5) = happyGoto action_45
action_84 (6) = happyGoto action_46
action_84 (7) = happyGoto action_47
action_84 (9) = happyGoto action_48
action_84 (30) = happyGoto action_148
action_84 (31) = happyGoto action_51
action_84 (32) = happyGoto action_52
action_84 (33) = happyGoto action_53
action_84 (34) = happyGoto action_54
action_84 (35) = happyGoto action_55
action_84 (36) = happyGoto action_56
action_84 (37) = happyGoto action_57
action_84 (38) = happyGoto action_58
action_84 (39) = happyGoto action_59
action_84 _ = happyFail

action_85 (92) = happyShift action_2
action_85 (4) = happyGoto action_116
action_85 (42) = happyGoto action_147
action_85 (43) = happyGoto action_118
action_85 _ = happyFail

action_86 (48) = happyShift action_63
action_86 (74) = happyShift action_64
action_86 (92) = happyShift action_2
action_86 (93) = happyShift action_68
action_86 (94) = happyShift action_69
action_86 (95) = happyShift action_70
action_86 (97) = happyShift action_71
action_86 (4) = happyGoto action_73
action_86 (5) = happyGoto action_45
action_86 (6) = happyGoto action_46
action_86 (7) = happyGoto action_47
action_86 (9) = happyGoto action_48
action_86 (36) = happyGoto action_146
action_86 (37) = happyGoto action_57
action_86 (38) = happyGoto action_58
action_86 (39) = happyGoto action_59
action_86 _ = happyFail

action_87 (48) = happyShift action_63
action_87 (74) = happyShift action_64
action_87 (92) = happyShift action_2
action_87 (93) = happyShift action_68
action_87 (94) = happyShift action_69
action_87 (95) = happyShift action_70
action_87 (97) = happyShift action_71
action_87 (4) = happyGoto action_73
action_87 (5) = happyGoto action_45
action_87 (6) = happyGoto action_46
action_87 (7) = happyGoto action_47
action_87 (9) = happyGoto action_48
action_87 (36) = happyGoto action_145
action_87 (37) = happyGoto action_57
action_87 (38) = happyGoto action_58
action_87 (39) = happyGoto action_59
action_87 _ = happyFail

action_88 (48) = happyShift action_63
action_88 (74) = happyShift action_64
action_88 (92) = happyShift action_2
action_88 (93) = happyShift action_68
action_88 (94) = happyShift action_69
action_88 (95) = happyShift action_70
action_88 (97) = happyShift action_71
action_88 (4) = happyGoto action_73
action_88 (5) = happyGoto action_45
action_88 (6) = happyGoto action_46
action_88 (7) = happyGoto action_47
action_88 (9) = happyGoto action_48
action_88 (36) = happyGoto action_144
action_88 (37) = happyGoto action_57
action_88 (38) = happyGoto action_58
action_88 (39) = happyGoto action_59
action_88 _ = happyFail

action_89 (48) = happyShift action_63
action_89 (74) = happyShift action_64
action_89 (92) = happyShift action_2
action_89 (93) = happyShift action_68
action_89 (94) = happyShift action_69
action_89 (95) = happyShift action_70
action_89 (97) = happyShift action_71
action_89 (4) = happyGoto action_73
action_89 (5) = happyGoto action_45
action_89 (6) = happyGoto action_46
action_89 (7) = happyGoto action_47
action_89 (9) = happyGoto action_48
action_89 (35) = happyGoto action_143
action_89 (36) = happyGoto action_56
action_89 (37) = happyGoto action_57
action_89 (38) = happyGoto action_58
action_89 (39) = happyGoto action_59
action_89 _ = happyFail

action_90 (48) = happyShift action_63
action_90 (74) = happyShift action_64
action_90 (92) = happyShift action_2
action_90 (93) = happyShift action_68
action_90 (94) = happyShift action_69
action_90 (95) = happyShift action_70
action_90 (97) = happyShift action_71
action_90 (4) = happyGoto action_73
action_90 (5) = happyGoto action_45
action_90 (6) = happyGoto action_46
action_90 (7) = happyGoto action_47
action_90 (9) = happyGoto action_48
action_90 (35) = happyGoto action_142
action_90 (36) = happyGoto action_56
action_90 (37) = happyGoto action_57
action_90 (38) = happyGoto action_58
action_90 (39) = happyGoto action_59
action_90 _ = happyFail

action_91 (48) = happyShift action_63
action_91 (74) = happyShift action_64
action_91 (92) = happyShift action_2
action_91 (93) = happyShift action_68
action_91 (94) = happyShift action_69
action_91 (95) = happyShift action_70
action_91 (97) = happyShift action_71
action_91 (4) = happyGoto action_73
action_91 (5) = happyGoto action_45
action_91 (6) = happyGoto action_46
action_91 (7) = happyGoto action_47
action_91 (9) = happyGoto action_48
action_91 (34) = happyGoto action_141
action_91 (35) = happyGoto action_55
action_91 (36) = happyGoto action_56
action_91 (37) = happyGoto action_57
action_91 (38) = happyGoto action_58
action_91 (39) = happyGoto action_59
action_91 _ = happyFail

action_92 (48) = happyShift action_63
action_92 (74) = happyShift action_64
action_92 (92) = happyShift action_2
action_92 (93) = happyShift action_68
action_92 (94) = happyShift action_69
action_92 (95) = happyShift action_70
action_92 (97) = happyShift action_71
action_92 (4) = happyGoto action_73
action_92 (5) = happyGoto action_45
action_92 (6) = happyGoto action_46
action_92 (7) = happyGoto action_47
action_92 (9) = happyGoto action_48
action_92 (34) = happyGoto action_140
action_92 (35) = happyGoto action_55
action_92 (36) = happyGoto action_56
action_92 (37) = happyGoto action_57
action_92 (38) = happyGoto action_58
action_92 (39) = happyGoto action_59
action_92 _ = happyFail

action_93 (48) = happyShift action_63
action_93 (74) = happyShift action_64
action_93 (92) = happyShift action_2
action_93 (93) = happyShift action_68
action_93 (94) = happyShift action_69
action_93 (95) = happyShift action_70
action_93 (97) = happyShift action_71
action_93 (4) = happyGoto action_73
action_93 (5) = happyGoto action_45
action_93 (6) = happyGoto action_46
action_93 (7) = happyGoto action_47
action_93 (9) = happyGoto action_48
action_93 (34) = happyGoto action_139
action_93 (35) = happyGoto action_55
action_93 (36) = happyGoto action_56
action_93 (37) = happyGoto action_57
action_93 (38) = happyGoto action_58
action_93 (39) = happyGoto action_59
action_93 _ = happyFail

action_94 (48) = happyShift action_63
action_94 (74) = happyShift action_64
action_94 (92) = happyShift action_2
action_94 (93) = happyShift action_68
action_94 (94) = happyShift action_69
action_94 (95) = happyShift action_70
action_94 (97) = happyShift action_71
action_94 (4) = happyGoto action_73
action_94 (5) = happyGoto action_45
action_94 (6) = happyGoto action_46
action_94 (7) = happyGoto action_47
action_94 (9) = happyGoto action_48
action_94 (34) = happyGoto action_138
action_94 (35) = happyGoto action_55
action_94 (36) = happyGoto action_56
action_94 (37) = happyGoto action_57
action_94 (38) = happyGoto action_58
action_94 (39) = happyGoto action_59
action_94 _ = happyFail

action_95 (48) = happyShift action_63
action_95 (74) = happyShift action_64
action_95 (92) = happyShift action_2
action_95 (93) = happyShift action_68
action_95 (94) = happyShift action_69
action_95 (95) = happyShift action_70
action_95 (97) = happyShift action_71
action_95 (4) = happyGoto action_73
action_95 (5) = happyGoto action_45
action_95 (6) = happyGoto action_46
action_95 (7) = happyGoto action_47
action_95 (9) = happyGoto action_48
action_95 (34) = happyGoto action_137
action_95 (35) = happyGoto action_55
action_95 (36) = happyGoto action_56
action_95 (37) = happyGoto action_57
action_95 (38) = happyGoto action_58
action_95 (39) = happyGoto action_59
action_95 _ = happyFail

action_96 (48) = happyShift action_63
action_96 (74) = happyShift action_64
action_96 (92) = happyShift action_2
action_96 (93) = happyShift action_68
action_96 (94) = happyShift action_69
action_96 (95) = happyShift action_70
action_96 (97) = happyShift action_71
action_96 (4) = happyGoto action_73
action_96 (5) = happyGoto action_45
action_96 (6) = happyGoto action_46
action_96 (7) = happyGoto action_47
action_96 (9) = happyGoto action_48
action_96 (34) = happyGoto action_136
action_96 (35) = happyGoto action_55
action_96 (36) = happyGoto action_56
action_96 (37) = happyGoto action_57
action_96 (38) = happyGoto action_58
action_96 (39) = happyGoto action_59
action_96 _ = happyFail

action_97 (48) = happyShift action_63
action_97 (74) = happyShift action_64
action_97 (92) = happyShift action_2
action_97 (93) = happyShift action_68
action_97 (94) = happyShift action_69
action_97 (95) = happyShift action_70
action_97 (97) = happyShift action_71
action_97 (4) = happyGoto action_73
action_97 (5) = happyGoto action_45
action_97 (6) = happyGoto action_46
action_97 (7) = happyGoto action_47
action_97 (9) = happyGoto action_48
action_97 (34) = happyGoto action_135
action_97 (35) = happyGoto action_55
action_97 (36) = happyGoto action_56
action_97 (37) = happyGoto action_57
action_97 (38) = happyGoto action_58
action_97 (39) = happyGoto action_59
action_97 _ = happyFail

action_98 (48) = happyShift action_63
action_98 (74) = happyShift action_64
action_98 (92) = happyShift action_2
action_98 (93) = happyShift action_68
action_98 (94) = happyShift action_69
action_98 (95) = happyShift action_70
action_98 (97) = happyShift action_71
action_98 (4) = happyGoto action_73
action_98 (5) = happyGoto action_45
action_98 (6) = happyGoto action_46
action_98 (7) = happyGoto action_47
action_98 (9) = happyGoto action_48
action_98 (34) = happyGoto action_134
action_98 (35) = happyGoto action_55
action_98 (36) = happyGoto action_56
action_98 (37) = happyGoto action_57
action_98 (38) = happyGoto action_58
action_98 (39) = happyGoto action_59
action_98 _ = happyFail

action_99 (48) = happyShift action_63
action_99 (74) = happyShift action_64
action_99 (92) = happyShift action_2
action_99 (93) = happyShift action_68
action_99 (94) = happyShift action_69
action_99 (95) = happyShift action_70
action_99 (97) = happyShift action_71
action_99 (4) = happyGoto action_73
action_99 (5) = happyGoto action_45
action_99 (6) = happyGoto action_46
action_99 (7) = happyGoto action_47
action_99 (9) = happyGoto action_48
action_99 (33) = happyGoto action_133
action_99 (34) = happyGoto action_54
action_99 (35) = happyGoto action_55
action_99 (36) = happyGoto action_56
action_99 (37) = happyGoto action_57
action_99 (38) = happyGoto action_58
action_99 (39) = happyGoto action_59
action_99 _ = happyFail

action_100 (48) = happyShift action_63
action_100 (74) = happyShift action_64
action_100 (92) = happyShift action_2
action_100 (93) = happyShift action_68
action_100 (94) = happyShift action_69
action_100 (95) = happyShift action_70
action_100 (97) = happyShift action_71
action_100 (4) = happyGoto action_73
action_100 (5) = happyGoto action_45
action_100 (6) = happyGoto action_46
action_100 (7) = happyGoto action_47
action_100 (9) = happyGoto action_48
action_100 (33) = happyGoto action_132
action_100 (34) = happyGoto action_54
action_100 (35) = happyGoto action_55
action_100 (36) = happyGoto action_56
action_100 (37) = happyGoto action_57
action_100 (38) = happyGoto action_58
action_100 (39) = happyGoto action_59
action_100 _ = happyFail

action_101 (48) = happyShift action_63
action_101 (74) = happyShift action_64
action_101 (92) = happyShift action_2
action_101 (93) = happyShift action_68
action_101 (94) = happyShift action_69
action_101 (95) = happyShift action_70
action_101 (97) = happyShift action_71
action_101 (4) = happyGoto action_73
action_101 (5) = happyGoto action_45
action_101 (6) = happyGoto action_46
action_101 (7) = happyGoto action_47
action_101 (9) = happyGoto action_48
action_101 (33) = happyGoto action_131
action_101 (34) = happyGoto action_54
action_101 (35) = happyGoto action_55
action_101 (36) = happyGoto action_56
action_101 (37) = happyGoto action_57
action_101 (38) = happyGoto action_58
action_101 (39) = happyGoto action_59
action_101 _ = happyFail

action_102 (48) = happyShift action_63
action_102 (74) = happyShift action_64
action_102 (92) = happyShift action_2
action_102 (93) = happyShift action_68
action_102 (94) = happyShift action_69
action_102 (95) = happyShift action_70
action_102 (97) = happyShift action_71
action_102 (4) = happyGoto action_73
action_102 (5) = happyGoto action_45
action_102 (6) = happyGoto action_46
action_102 (7) = happyGoto action_47
action_102 (9) = happyGoto action_48
action_102 (33) = happyGoto action_130
action_102 (34) = happyGoto action_54
action_102 (35) = happyGoto action_55
action_102 (36) = happyGoto action_56
action_102 (37) = happyGoto action_57
action_102 (38) = happyGoto action_58
action_102 (39) = happyGoto action_59
action_102 _ = happyFail

action_103 (48) = happyShift action_63
action_103 (74) = happyShift action_64
action_103 (92) = happyShift action_2
action_103 (93) = happyShift action_68
action_103 (94) = happyShift action_69
action_103 (95) = happyShift action_70
action_103 (97) = happyShift action_71
action_103 (4) = happyGoto action_73
action_103 (5) = happyGoto action_45
action_103 (6) = happyGoto action_46
action_103 (7) = happyGoto action_47
action_103 (9) = happyGoto action_48
action_103 (32) = happyGoto action_129
action_103 (33) = happyGoto action_53
action_103 (34) = happyGoto action_54
action_103 (35) = happyGoto action_55
action_103 (36) = happyGoto action_56
action_103 (37) = happyGoto action_57
action_103 (38) = happyGoto action_58
action_103 (39) = happyGoto action_59
action_103 _ = happyFail

action_104 (48) = happyShift action_63
action_104 (74) = happyShift action_64
action_104 (92) = happyShift action_2
action_104 (93) = happyShift action_68
action_104 (94) = happyShift action_69
action_104 (95) = happyShift action_70
action_104 (97) = happyShift action_71
action_104 (4) = happyGoto action_73
action_104 (5) = happyGoto action_45
action_104 (6) = happyGoto action_46
action_104 (7) = happyGoto action_47
action_104 (9) = happyGoto action_48
action_104 (32) = happyGoto action_128
action_104 (33) = happyGoto action_53
action_104 (34) = happyGoto action_54
action_104 (35) = happyGoto action_55
action_104 (36) = happyGoto action_56
action_104 (37) = happyGoto action_57
action_104 (38) = happyGoto action_58
action_104 (39) = happyGoto action_59
action_104 _ = happyFail

action_105 _ = happyReduce_43

action_106 (48) = happyShift action_63
action_106 (74) = happyShift action_64
action_106 (92) = happyShift action_2
action_106 (93) = happyShift action_68
action_106 (94) = happyShift action_69
action_106 (95) = happyShift action_70
action_106 (97) = happyShift action_71
action_106 (4) = happyGoto action_73
action_106 (5) = happyGoto action_45
action_106 (6) = happyGoto action_46
action_106 (7) = happyGoto action_47
action_106 (9) = happyGoto action_48
action_106 (31) = happyGoto action_127
action_106 (32) = happyGoto action_52
action_106 (33) = happyGoto action_53
action_106 (34) = happyGoto action_54
action_106 (35) = happyGoto action_55
action_106 (36) = happyGoto action_56
action_106 (37) = happyGoto action_57
action_106 (38) = happyGoto action_58
action_106 (39) = happyGoto action_59
action_106 _ = happyFail

action_107 (48) = happyShift action_63
action_107 (74) = happyShift action_64
action_107 (92) = happyShift action_2
action_107 (93) = happyShift action_68
action_107 (94) = happyShift action_69
action_107 (95) = happyShift action_70
action_107 (97) = happyShift action_71
action_107 (4) = happyGoto action_73
action_107 (5) = happyGoto action_45
action_107 (6) = happyGoto action_46
action_107 (7) = happyGoto action_47
action_107 (9) = happyGoto action_48
action_107 (31) = happyGoto action_126
action_107 (32) = happyGoto action_52
action_107 (33) = happyGoto action_53
action_107 (34) = happyGoto action_54
action_107 (35) = happyGoto action_55
action_107 (36) = happyGoto action_56
action_107 (37) = happyGoto action_57
action_107 (38) = happyGoto action_58
action_107 (39) = happyGoto action_59
action_107 _ = happyFail

action_108 (48) = happyShift action_63
action_108 (74) = happyShift action_64
action_108 (92) = happyShift action_2
action_108 (93) = happyShift action_68
action_108 (94) = happyShift action_69
action_108 (95) = happyShift action_70
action_108 (97) = happyShift action_71
action_108 (4) = happyGoto action_73
action_108 (5) = happyGoto action_45
action_108 (6) = happyGoto action_46
action_108 (7) = happyGoto action_47
action_108 (9) = happyGoto action_48
action_108 (31) = happyGoto action_125
action_108 (32) = happyGoto action_52
action_108 (33) = happyGoto action_53
action_108 (34) = happyGoto action_54
action_108 (35) = happyGoto action_55
action_108 (36) = happyGoto action_56
action_108 (37) = happyGoto action_57
action_108 (38) = happyGoto action_58
action_108 (39) = happyGoto action_59
action_108 _ = happyFail

action_109 (48) = happyShift action_63
action_109 (74) = happyShift action_64
action_109 (92) = happyShift action_2
action_109 (93) = happyShift action_68
action_109 (94) = happyShift action_69
action_109 (95) = happyShift action_70
action_109 (97) = happyShift action_71
action_109 (4) = happyGoto action_73
action_109 (5) = happyGoto action_45
action_109 (6) = happyGoto action_46
action_109 (7) = happyGoto action_47
action_109 (9) = happyGoto action_48
action_109 (31) = happyGoto action_124
action_109 (32) = happyGoto action_52
action_109 (33) = happyGoto action_53
action_109 (34) = happyGoto action_54
action_109 (35) = happyGoto action_55
action_109 (36) = happyGoto action_56
action_109 (37) = happyGoto action_57
action_109 (38) = happyGoto action_58
action_109 (39) = happyGoto action_59
action_109 _ = happyFail

action_110 _ = happyReduce_50

action_111 (48) = happyShift action_63
action_111 (74) = happyShift action_64
action_111 (92) = happyShift action_2
action_111 (93) = happyShift action_68
action_111 (94) = happyShift action_69
action_111 (95) = happyShift action_70
action_111 (97) = happyShift action_71
action_111 (4) = happyGoto action_73
action_111 (5) = happyGoto action_45
action_111 (6) = happyGoto action_46
action_111 (7) = happyGoto action_47
action_111 (9) = happyGoto action_48
action_111 (31) = happyGoto action_121
action_111 (32) = happyGoto action_52
action_111 (33) = happyGoto action_53
action_111 (34) = happyGoto action_54
action_111 (35) = happyGoto action_55
action_111 (36) = happyGoto action_56
action_111 (37) = happyGoto action_57
action_111 (38) = happyGoto action_58
action_111 (39) = happyGoto action_59
action_111 (40) = happyGoto action_122
action_111 (41) = happyGoto action_123
action_111 _ = happyReduce_97

action_112 (48) = happyShift action_63
action_112 (74) = happyShift action_64
action_112 (86) = happyShift action_120
action_112 (92) = happyShift action_2
action_112 (93) = happyShift action_68
action_112 (94) = happyShift action_69
action_112 (95) = happyShift action_70
action_112 (97) = happyShift action_71
action_112 (4) = happyGoto action_73
action_112 (5) = happyGoto action_45
action_112 (6) = happyGoto action_46
action_112 (7) = happyGoto action_47
action_112 (9) = happyGoto action_48
action_112 (30) = happyGoto action_119
action_112 (31) = happyGoto action_51
action_112 (32) = happyGoto action_52
action_112 (33) = happyGoto action_53
action_112 (34) = happyGoto action_54
action_112 (35) = happyGoto action_55
action_112 (36) = happyGoto action_56
action_112 (37) = happyGoto action_57
action_112 (38) = happyGoto action_58
action_112 (39) = happyGoto action_59
action_112 _ = happyFail

action_113 (92) = happyShift action_2
action_113 (4) = happyGoto action_116
action_113 (42) = happyGoto action_117
action_113 (43) = happyGoto action_118
action_113 _ = happyFail

action_114 (48) = happyShift action_63
action_114 (74) = happyShift action_64
action_114 (92) = happyShift action_2
action_114 (93) = happyShift action_68
action_114 (94) = happyShift action_69
action_114 (95) = happyShift action_70
action_114 (97) = happyShift action_71
action_114 (4) = happyGoto action_73
action_114 (5) = happyGoto action_45
action_114 (6) = happyGoto action_46
action_114 (7) = happyGoto action_47
action_114 (9) = happyGoto action_48
action_114 (30) = happyGoto action_115
action_114 (31) = happyGoto action_51
action_114 (32) = happyGoto action_52
action_114 (33) = happyGoto action_53
action_114 (34) = happyGoto action_54
action_114 (35) = happyGoto action_55
action_114 (36) = happyGoto action_56
action_114 (37) = happyGoto action_57
action_114 (38) = happyGoto action_58
action_114 (39) = happyGoto action_59
action_114 _ = happyFail

action_115 (54) = happyShift action_170
action_115 (55) = happyShift action_106
action_115 (56) = happyShift action_107
action_115 (57) = happyShift action_108
action_115 (58) = happyShift action_109
action_115 _ = happyFail

action_116 _ = happyReduce_103

action_117 (51) = happyShift action_169
action_117 _ = happyFail

action_118 (52) = happyShift action_168
action_118 _ = happyReduce_101

action_119 (47) = happyShift action_167
action_119 (55) = happyShift action_106
action_119 (56) = happyShift action_107
action_119 (57) = happyShift action_108
action_119 (58) = happyShift action_109
action_119 _ = happyFail

action_120 (93) = happyShift action_68
action_120 (5) = happyGoto action_166
action_120 _ = happyFail

action_121 (59) = happyShift action_103
action_121 (60) = happyShift action_104
action_121 _ = happyReduce_100

action_122 (49) = happyShift action_165
action_122 _ = happyFail

action_123 (50) = happyShift action_164
action_123 _ = happyReduce_98

action_124 (59) = happyShift action_103
action_124 (60) = happyShift action_104
action_124 _ = happyReduce_58

action_125 (59) = happyShift action_103
action_125 (60) = happyShift action_104
action_125 _ = happyReduce_57

action_126 (59) = happyShift action_103
action_126 (60) = happyShift action_104
action_126 _ = happyReduce_56

action_127 (59) = happyShift action_103
action_127 (60) = happyShift action_104
action_127 _ = happyReduce_55

action_128 (61) = happyShift action_99
action_128 (62) = happyShift action_100
action_128 (63) = happyShift action_101
action_128 (64) = happyShift action_102
action_128 _ = happyReduce_61

action_129 (61) = happyShift action_99
action_129 (62) = happyShift action_100
action_129 (63) = happyShift action_101
action_129 (64) = happyShift action_102
action_129 _ = happyReduce_60

action_130 (65) = happyShift action_91
action_130 (66) = happyShift action_92
action_130 (67) = happyShift action_93
action_130 (68) = happyShift action_94
action_130 (69) = happyShift action_95
action_130 (70) = happyShift action_96
action_130 (71) = happyShift action_97
action_130 (72) = happyShift action_98
action_130 _ = happyReduce_66

action_131 (65) = happyShift action_91
action_131 (66) = happyShift action_92
action_131 (67) = happyShift action_93
action_131 (68) = happyShift action_94
action_131 (69) = happyShift action_95
action_131 (70) = happyShift action_96
action_131 (71) = happyShift action_97
action_131 (72) = happyShift action_98
action_131 _ = happyReduce_65

action_132 (65) = happyShift action_91
action_132 (66) = happyShift action_92
action_132 (67) = happyShift action_93
action_132 (68) = happyShift action_94
action_132 (69) = happyShift action_95
action_132 (70) = happyShift action_96
action_132 (71) = happyShift action_97
action_132 (72) = happyShift action_98
action_132 _ = happyReduce_64

action_133 (65) = happyShift action_91
action_133 (66) = happyShift action_92
action_133 (67) = happyShift action_93
action_133 (68) = happyShift action_94
action_133 (69) = happyShift action_95
action_133 (70) = happyShift action_96
action_133 (71) = happyShift action_97
action_133 (72) = happyShift action_98
action_133 _ = happyReduce_63

action_134 (73) = happyShift action_89
action_134 (74) = happyShift action_90
action_134 _ = happyReduce_75

action_135 (73) = happyShift action_89
action_135 (74) = happyShift action_90
action_135 _ = happyReduce_74

action_136 (73) = happyShift action_89
action_136 (74) = happyShift action_90
action_136 _ = happyReduce_73

action_137 (73) = happyShift action_89
action_137 (74) = happyShift action_90
action_137 _ = happyReduce_72

action_138 (73) = happyShift action_89
action_138 (74) = happyShift action_90
action_138 _ = happyReduce_71

action_139 (73) = happyShift action_89
action_139 (74) = happyShift action_90
action_139 _ = happyReduce_70

action_140 (73) = happyShift action_89
action_140 (74) = happyShift action_90
action_140 _ = happyReduce_69

action_141 (73) = happyShift action_89
action_141 (74) = happyShift action_90
action_141 _ = happyReduce_68

action_142 (75) = happyShift action_86
action_142 (76) = happyShift action_87
action_142 (77) = happyShift action_88
action_142 _ = happyReduce_78

action_143 (75) = happyShift action_86
action_143 (76) = happyShift action_87
action_143 (77) = happyShift action_88
action_143 _ = happyReduce_77

action_144 (52) = happyShift action_85
action_144 _ = happyReduce_82

action_145 (52) = happyShift action_85
action_145 _ = happyReduce_81

action_146 (52) = happyShift action_85
action_146 _ = happyReduce_80

action_147 _ = happyReduce_86

action_148 (54) = happyShift action_163
action_148 (55) = happyShift action_106
action_148 (56) = happyShift action_107
action_148 (57) = happyShift action_108
action_148 (58) = happyShift action_109
action_148 _ = happyFail

action_149 (92) = happyShift action_2
action_149 (4) = happyGoto action_81
action_149 (21) = happyGoto action_162
action_149 (22) = happyGoto action_83
action_149 _ = happyFail

action_150 _ = happyReduce_39

action_151 _ = happyReduce_29

action_152 _ = happyReduce_31

action_153 (48) = happyShift action_63
action_153 (74) = happyShift action_64
action_153 (92) = happyShift action_2
action_153 (93) = happyShift action_68
action_153 (94) = happyShift action_69
action_153 (95) = happyShift action_70
action_153 (97) = happyShift action_71
action_153 (4) = happyGoto action_73
action_153 (5) = happyGoto action_45
action_153 (6) = happyGoto action_46
action_153 (7) = happyGoto action_47
action_153 (9) = happyGoto action_48
action_153 (30) = happyGoto action_161
action_153 (31) = happyGoto action_51
action_153 (32) = happyGoto action_52
action_153 (33) = happyGoto action_53
action_153 (34) = happyGoto action_54
action_153 (35) = happyGoto action_55
action_153 (36) = happyGoto action_56
action_153 (37) = happyGoto action_57
action_153 (38) = happyGoto action_58
action_153 (39) = happyGoto action_59
action_153 _ = happyFail

action_154 _ = happyReduce_44

action_155 _ = happyReduce_96

action_156 (49) = happyShift action_160
action_156 (55) = happyShift action_106
action_156 (56) = happyShift action_107
action_156 (57) = happyShift action_108
action_156 (58) = happyShift action_109
action_156 _ = happyFail

action_157 _ = happyReduce_47

action_158 (49) = happyShift action_159
action_158 (55) = happyShift action_106
action_158 (56) = happyShift action_107
action_158 (57) = happyShift action_108
action_158 (58) = happyShift action_109
action_158 _ = happyFail

action_159 (45) = happyShift action_61
action_159 (48) = happyShift action_63
action_159 (74) = happyShift action_64
action_159 (82) = happyShift action_65
action_159 (88) = happyShift action_66
action_159 (91) = happyShift action_67
action_159 (92) = happyShift action_2
action_159 (93) = happyShift action_68
action_159 (94) = happyShift action_69
action_159 (95) = happyShift action_70
action_159 (97) = happyShift action_71
action_159 (4) = happyGoto action_44
action_159 (5) = happyGoto action_45
action_159 (6) = happyGoto action_46
action_159 (7) = happyGoto action_47
action_159 (9) = happyGoto action_48
action_159 (27) = happyGoto action_177
action_159 (30) = happyGoto action_50
action_159 (31) = happyGoto action_51
action_159 (32) = happyGoto action_52
action_159 (33) = happyGoto action_53
action_159 (34) = happyGoto action_54
action_159 (35) = happyGoto action_55
action_159 (36) = happyGoto action_56
action_159 (37) = happyGoto action_57
action_159 (38) = happyGoto action_58
action_159 (39) = happyGoto action_59
action_159 (44) = happyGoto action_60
action_159 _ = happyFail

action_160 (45) = happyShift action_176
action_160 _ = happyFail

action_161 (55) = happyShift action_106
action_161 (56) = happyShift action_107
action_161 (57) = happyShift action_108
action_161 (58) = happyShift action_109
action_161 _ = happyReduce_32

action_162 _ = happyReduce_28

action_163 _ = happyReduce_88

action_164 (48) = happyShift action_63
action_164 (74) = happyShift action_64
action_164 (92) = happyShift action_2
action_164 (93) = happyShift action_68
action_164 (94) = happyShift action_69
action_164 (95) = happyShift action_70
action_164 (97) = happyShift action_71
action_164 (4) = happyGoto action_73
action_164 (5) = happyGoto action_45
action_164 (6) = happyGoto action_46
action_164 (7) = happyGoto action_47
action_164 (9) = happyGoto action_48
action_164 (31) = happyGoto action_121
action_164 (32) = happyGoto action_52
action_164 (33) = happyGoto action_53
action_164 (34) = happyGoto action_54
action_164 (35) = happyGoto action_55
action_164 (36) = happyGoto action_56
action_164 (37) = happyGoto action_57
action_164 (38) = happyGoto action_58
action_164 (39) = happyGoto action_59
action_164 (40) = happyGoto action_175
action_164 (41) = happyGoto action_123
action_164 _ = happyReduce_97

action_165 _ = happyReduce_89

action_166 (47) = happyShift action_174
action_166 _ = happyFail

action_167 _ = happyReduce_40

action_168 (92) = happyShift action_2
action_168 (4) = happyGoto action_116
action_168 (42) = happyGoto action_173
action_168 (43) = happyGoto action_118
action_168 _ = happyFail

action_169 (48) = happyShift action_63
action_169 (74) = happyShift action_64
action_169 (92) = happyShift action_2
action_169 (93) = happyShift action_68
action_169 (94) = happyShift action_69
action_169 (95) = happyShift action_70
action_169 (97) = happyShift action_71
action_169 (4) = happyGoto action_73
action_169 (5) = happyGoto action_45
action_169 (6) = happyGoto action_46
action_169 (7) = happyGoto action_47
action_169 (9) = happyGoto action_48
action_169 (30) = happyGoto action_172
action_169 (31) = happyGoto action_51
action_169 (32) = happyGoto action_52
action_169 (33) = happyGoto action_53
action_169 (34) = happyGoto action_54
action_169 (35) = happyGoto action_55
action_169 (36) = happyGoto action_56
action_169 (37) = happyGoto action_57
action_169 (38) = happyGoto action_58
action_169 (39) = happyGoto action_59
action_169 _ = happyFail

action_170 (51) = happyShift action_171
action_170 _ = happyFail

action_171 (48) = happyShift action_63
action_171 (74) = happyShift action_64
action_171 (92) = happyShift action_2
action_171 (93) = happyShift action_68
action_171 (94) = happyShift action_69
action_171 (95) = happyShift action_70
action_171 (97) = happyShift action_71
action_171 (4) = happyGoto action_73
action_171 (5) = happyGoto action_45
action_171 (6) = happyGoto action_46
action_171 (7) = happyGoto action_47
action_171 (9) = happyGoto action_48
action_171 (30) = happyGoto action_180
action_171 (31) = happyGoto action_51
action_171 (32) = happyGoto action_52
action_171 (33) = happyGoto action_53
action_171 (34) = happyGoto action_54
action_171 (35) = happyGoto action_55
action_171 (36) = happyGoto action_56
action_171 (37) = happyGoto action_57
action_171 (38) = happyGoto action_58
action_171 (39) = happyGoto action_59
action_171 _ = happyFail

action_172 (47) = happyShift action_179
action_172 (55) = happyShift action_106
action_172 (56) = happyShift action_107
action_172 (57) = happyShift action_108
action_172 (58) = happyShift action_109
action_172 _ = happyFail

action_173 _ = happyReduce_102

action_174 _ = happyReduce_49

action_175 _ = happyReduce_99

action_176 (28) = happyGoto action_178
action_176 _ = happyReduce_51

action_177 (47) = happyShift action_110
action_177 _ = happyReduce_45

action_178 (45) = happyShift action_61
action_178 (46) = happyShift action_182
action_178 (48) = happyShift action_63
action_178 (74) = happyShift action_64
action_178 (82) = happyShift action_65
action_178 (88) = happyShift action_66
action_178 (91) = happyShift action_67
action_178 (92) = happyShift action_2
action_178 (93) = happyShift action_68
action_178 (94) = happyShift action_69
action_178 (95) = happyShift action_70
action_178 (97) = happyShift action_71
action_178 (4) = happyGoto action_44
action_178 (5) = happyGoto action_45
action_178 (6) = happyGoto action_46
action_178 (7) = happyGoto action_47
action_178 (9) = happyGoto action_48
action_178 (27) = happyGoto action_49
action_178 (30) = happyGoto action_50
action_178 (31) = happyGoto action_51
action_178 (32) = happyGoto action_52
action_178 (33) = happyGoto action_53
action_178 (34) = happyGoto action_54
action_178 (35) = happyGoto action_55
action_178 (36) = happyGoto action_56
action_178 (37) = happyGoto action_57
action_178 (38) = happyGoto action_58
action_178 (39) = happyGoto action_59
action_178 (44) = happyGoto action_60
action_178 _ = happyFail

action_179 _ = happyReduce_41

action_180 (47) = happyShift action_181
action_180 (55) = happyShift action_106
action_180 (56) = happyShift action_107
action_180 (57) = happyShift action_108
action_180 (58) = happyShift action_109
action_180 _ = happyFail

action_181 _ = happyReduce_42

action_182 (80) = happyShift action_183
action_182 _ = happyFail

action_183 (45) = happyShift action_184
action_183 _ = happyFail

action_184 (28) = happyGoto action_185
action_184 _ = happyReduce_51

action_185 (45) = happyShift action_61
action_185 (46) = happyShift action_186
action_185 (48) = happyShift action_63
action_185 (74) = happyShift action_64
action_185 (82) = happyShift action_65
action_185 (88) = happyShift action_66
action_185 (91) = happyShift action_67
action_185 (92) = happyShift action_2
action_185 (93) = happyShift action_68
action_185 (94) = happyShift action_69
action_185 (95) = happyShift action_70
action_185 (97) = happyShift action_71
action_185 (4) = happyGoto action_44
action_185 (5) = happyGoto action_45
action_185 (6) = happyGoto action_46
action_185 (7) = happyGoto action_47
action_185 (9) = happyGoto action_48
action_185 (27) = happyGoto action_49
action_185 (30) = happyGoto action_50
action_185 (31) = happyGoto action_51
action_185 (32) = happyGoto action_52
action_185 (33) = happyGoto action_53
action_185 (34) = happyGoto action_54
action_185 (35) = happyGoto action_55
action_185 (36) = happyGoto action_56
action_185 (37) = happyGoto action_57
action_185 (38) = happyGoto action_58
action_185 (39) = happyGoto action_59
action_185 (44) = happyGoto action_60
action_185 _ = happyFail

action_186 _ = happyReduce_46

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyTerminal (PT _ (TV happy_var_1)))
	 =  HappyAbsSyn4
		 (Ident happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 (HappyTerminal (PT _ (TI happy_var_1)))
	 =  HappyAbsSyn5
		 ((read happy_var_1) :: Integer
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  6 happyReduction_3
happyReduction_3 (HappyTerminal (PT _ (TD happy_var_1)))
	 =  HappyAbsSyn6
		 ((read happy_var_1) :: Double
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  7 happyReduction_4
happyReduction_4 (HappyTerminal (PT _ (T_CFloat happy_var_1)))
	 =  HappyAbsSyn7
		 (CFloat (happy_var_1)
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  8 happyReduction_5
happyReduction_5 (HappyTerminal (PT _ (T_CDouble happy_var_1)))
	 =  HappyAbsSyn8
		 (CDouble (happy_var_1)
	)
happyReduction_5 _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  9 happyReduction_6
happyReduction_6 (HappyTerminal (PT _ (T_Hexadecimal happy_var_1)))
	 =  HappyAbsSyn9
		 (Hexadecimal (happy_var_1)
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  10 happyReduction_7
happyReduction_7 (HappyAbsSyn15  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn10
		 (Program (reverse happy_var_1) (reverse happy_var_2)
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_0  11 happyReduction_8
happyReduction_8  =  HappyAbsSyn11
		 ([]
	)

happyReduce_9 = happySpecReduce_2  11 happyReduction_9
happyReduction_9 (HappyAbsSyn12  happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happyReduce 6 12 happyReduction_10
happyReduction_10 (_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn13  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (Struct happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_11 = happySpecReduce_1  13 happyReduction_11
happyReduction_11 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ((:[]) happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  13 happyReduction_12
happyReduction_12 (HappyAbsSyn13  happy_var_2)
	(HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ((:) happy_var_1 happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_3  14 happyReduction_13
happyReduction_13 _
	(HappyAbsSyn4  happy_var_2)
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn14
		 (MDecl happy_var_1 happy_var_2
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_0  15 happyReduction_14
happyReduction_14  =  HappyAbsSyn15
		 ([]
	)

happyReduce_15 = happySpecReduce_2  15 happyReduction_15
happyReduction_15 (HappyAbsSyn16  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn15
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_15 _ _  = notHappyAtAll 

happyReduce_16 = happyReduce 9 16 happyReduction_16
happyReduction_16 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_8) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn20  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_3) `HappyStk`
	(HappyAbsSyn44  happy_var_2) `HappyStk`
	(HappyAbsSyn17  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn16
		 (Fun (reverse happy_var_1) happy_var_2 happy_var_3 happy_var_5 (reverse happy_var_8)
	) `HappyStk` happyRest

happyReduce_17 = happySpecReduce_0  17 happyReduction_17
happyReduction_17  =  HappyAbsSyn17
		 ([]
	)

happyReduce_18 = happySpecReduce_2  17 happyReduction_18
happyReduction_18 (HappyAbsSyn18  happy_var_2)
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  18 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn18
		 (InlineFuncSpec
	)

happyReduce_20 = happySpecReduce_1  18 happyReduction_20
happyReduction_20 _
	 =  HappyAbsSyn18
		 (ForceInlineFuncSpec
	)

happyReduce_21 = happySpecReduce_1  18 happyReduction_21
happyReduction_21 _
	 =  HappyAbsSyn18
		 (AlwaysInlineFuncSpec
	)

happyReduce_22 = happySpecReduce_1  18 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn18
		 (StaticFuncSpec
	)

happyReduce_23 = happySpecReduce_3  19 happyReduction_23
happyReduction_23 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn44  happy_var_2)
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn19
		 (FormalDecl (reverse happy_var_1) happy_var_2 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_0  20 happyReduction_24
happyReduction_24  =  HappyAbsSyn20
		 ([]
	)

happyReduce_25 = happySpecReduce_1  20 happyReduction_25
happyReduction_25 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 ((:[]) happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  20 happyReduction_26
happyReduction_26 (HappyAbsSyn20  happy_var_3)
	_
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn20
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  21 happyReduction_27
happyReduction_27 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 ((:[]) happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  21 happyReduction_28
happyReduction_28 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_2  22 happyReduction_29
happyReduction_29 (HappyAbsSyn23  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn22
		 (DeclInit happy_var_1 happy_var_2
	)
happyReduction_29 _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_0  23 happyReduction_30
happyReduction_30  =  HappyAbsSyn23
		 ([]
	)

happyReduce_31 = happySpecReduce_1  23 happyReduction_31
happyReduction_31 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ((:[]) happy_var_1
	)
happyReduction_31 _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  24 happyReduction_32
happyReduction_32 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (DExp happy_var_2
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_1  25 happyReduction_33
happyReduction_33 _
	 =  HappyAbsSyn25
		 (InputQual
	)

happyReduce_34 = happySpecReduce_1  25 happyReduction_34
happyReduction_34 _
	 =  HappyAbsSyn25
		 (OutputQual
	)

happyReduce_35 = happySpecReduce_1  25 happyReduction_35
happyReduction_35 _
	 =  HappyAbsSyn25
		 (InOutQual
	)

happyReduce_36 = happySpecReduce_1  25 happyReduction_36
happyReduction_36 _
	 =  HappyAbsSyn25
		 (ArrayQual
	)

happyReduce_37 = happySpecReduce_0  26 happyReduction_37
happyReduction_37  =  HappyAbsSyn26
		 ([]
	)

happyReduce_38 = happySpecReduce_2  26 happyReduction_38
happyReduction_38 (HappyAbsSyn25  happy_var_2)
	(HappyAbsSyn26  happy_var_1)
	 =  HappyAbsSyn26
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  27 happyReduction_39
happyReduction_39 _
	(HappyAbsSyn21  happy_var_2)
	(HappyAbsSyn44  happy_var_1)
	 =  HappyAbsSyn27
		 (SDecl happy_var_1 happy_var_2
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happyReduce 4 27 happyReduction_40
happyReduction_40 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SAssign happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_41 = happyReduce 6 27 happyReduction_41
happyReduction_41 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn42  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SAssignWithField happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_42 = happyReduce 7 27 happyReduction_42
happyReduction_42 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SAssignWithArray happy_var_1 happy_var_3 happy_var_6
	) `HappyStk` happyRest

happyReduce_43 = happySpecReduce_2  27 happyReduction_43
happyReduction_43 _
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn27
		 (SExp happy_var_1
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  27 happyReduction_44
happyReduction_44 _
	(HappyAbsSyn28  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (SBlock (reverse happy_var_2)
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happyReduce 5 27 happyReduction_45
happyReduction_45 ((HappyAbsSyn27  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SWhile happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_46 = happyReduce 11 27 happyReduction_46
happyReduction_46 (_ `HappyStk`
	(HappyAbsSyn28  happy_var_10) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn28  happy_var_6) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SIf happy_var_3 (reverse happy_var_6) (reverse happy_var_10)
	) `HappyStk` happyRest

happyReduce_47 = happySpecReduce_3  27 happyReduction_47
happyReduction_47 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (SReturn happy_var_2
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  27 happyReduction_48
happyReduction_48 _
	_
	 =  HappyAbsSyn27
		 (SReturnVoid
	)

happyReduce_49 = happyReduce 5 27 happyReduction_49
happyReduction_49 (_ `HappyStk`
	(HappyAbsSyn5  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn27
		 (SNew happy_var_1 happy_var_4
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_2  27 happyReduction_50
happyReduction_50 _
	(HappyAbsSyn27  happy_var_1)
	 =  HappyAbsSyn27
		 (happy_var_1
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_0  28 happyReduction_51
happyReduction_51  =  HappyAbsSyn28
		 ([]
	)

happyReduce_52 = happySpecReduce_2  28 happyReduction_52
happyReduction_52 (HappyAbsSyn27  happy_var_2)
	(HappyAbsSyn28  happy_var_1)
	 =  HappyAbsSyn28
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_52 _ _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_0  29 happyReduction_53
happyReduction_53  =  HappyAbsSyn29
		 ([]
	)

happyReduce_54 = happySpecReduce_2  29 happyReduction_54
happyReduction_54 (HappyAbsSyn30  happy_var_2)
	(HappyAbsSyn29  happy_var_1)
	 =  HappyAbsSyn29
		 (flip (:) happy_var_1 happy_var_2
	)
happyReduction_54 _ _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  30 happyReduction_55
happyReduction_55 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EAnd happy_var_1 happy_var_3
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_3  30 happyReduction_56
happyReduction_56 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EOr happy_var_1 happy_var_3
	)
happyReduction_56 _ _ _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_3  30 happyReduction_57
happyReduction_57 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EXor happy_var_1 happy_var_3
	)
happyReduction_57 _ _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_3  30 happyReduction_58
happyReduction_58 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ENot happy_var_1 happy_var_3
	)
happyReduction_58 _ _ _  = notHappyAtAll 

happyReduce_59 = happySpecReduce_1  30 happyReduction_59
happyReduction_59 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  31 happyReduction_60
happyReduction_60 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EEq happy_var_1 happy_var_3
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_3  31 happyReduction_61
happyReduction_61 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ENeq happy_var_1 happy_var_3
	)
happyReduction_61 _ _ _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  31 happyReduction_62
happyReduction_62 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  32 happyReduction_63
happyReduction_63 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EGt happy_var_1 happy_var_3
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  32 happyReduction_64
happyReduction_64 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EGte happy_var_1 happy_var_3
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_3  32 happyReduction_65
happyReduction_65 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ELt happy_var_1 happy_var_3
	)
happyReduction_65 _ _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_3  32 happyReduction_66
happyReduction_66 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ELte happy_var_1 happy_var_3
	)
happyReduction_66 _ _ _  = notHappyAtAll 

happyReduce_67 = happySpecReduce_1  32 happyReduction_67
happyReduction_67 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_67 _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  33 happyReduction_68
happyReduction_68 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESlElemWise happy_var_1 happy_var_3
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_3  33 happyReduction_69
happyReduction_69 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESrElemWise happy_var_1 happy_var_3
	)
happyReduction_69 _ _ _  = notHappyAtAll 

happyReduce_70 = happySpecReduce_3  33 happyReduction_70
happyReduction_70 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESlaElemWise happy_var_1 happy_var_3
	)
happyReduction_70 _ _ _  = notHappyAtAll 

happyReduce_71 = happySpecReduce_3  33 happyReduction_71
happyReduction_71 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESraElemWise happy_var_1 happy_var_3
	)
happyReduction_71 _ _ _  = notHappyAtAll 

happyReduce_72 = happySpecReduce_3  33 happyReduction_72
happyReduction_72 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESlQWord happy_var_1 happy_var_3
	)
happyReduction_72 _ _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_3  33 happyReduction_73
happyReduction_73 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESrQWord happy_var_1 happy_var_3
	)
happyReduction_73 _ _ _  = notHappyAtAll 

happyReduce_74 = happySpecReduce_3  33 happyReduction_74
happyReduction_74 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESlaQWord happy_var_1 happy_var_3
	)
happyReduction_74 _ _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_3  33 happyReduction_75
happyReduction_75 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESraQWord happy_var_1 happy_var_3
	)
happyReduction_75 _ _ _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  33 happyReduction_76
happyReduction_76 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_3  34 happyReduction_77
happyReduction_77 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EAdd happy_var_1 happy_var_3
	)
happyReduction_77 _ _ _  = notHappyAtAll 

happyReduce_78 = happySpecReduce_3  34 happyReduction_78
happyReduction_78 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (ESub happy_var_1 happy_var_3
	)
happyReduction_78 _ _ _  = notHappyAtAll 

happyReduce_79 = happySpecReduce_1  34 happyReduction_79
happyReduction_79 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_3  35 happyReduction_80
happyReduction_80 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EMul happy_var_1 happy_var_3
	)
happyReduction_80 _ _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_3  35 happyReduction_81
happyReduction_81 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EDiv happy_var_1 happy_var_3
	)
happyReduction_81 _ _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_3  35 happyReduction_82
happyReduction_82 (HappyAbsSyn30  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EDivApprox happy_var_1 happy_var_3
	)
happyReduction_82 _ _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_1  35 happyReduction_83
happyReduction_83 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_2  36 happyReduction_84
happyReduction_84 (HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (ENeg happy_var_2
	)
happyReduction_84 _ _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_1  36 happyReduction_85
happyReduction_85 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_85 _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_3  37 happyReduction_86
happyReduction_86 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (EFieldSelect happy_var_1 happy_var_3
	)
happyReduction_86 _ _ _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  37 happyReduction_87
happyReduction_87 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happyReduce 4 38 happyReduction_88
happyReduction_88 (_ `HappyStk`
	(HappyAbsSyn30  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn30  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (EArray happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_89 = happyReduce 4 38 happyReduction_89
happyReduction_89 (_ `HappyStk`
	(HappyAbsSyn40  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn4  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn30
		 (EFunc happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_90 = happySpecReduce_1  38 happyReduction_90
happyReduction_90 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn30
		 (happy_var_1
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_1  39 happyReduction_91
happyReduction_91 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn30
		 (EIdent happy_var_1
	)
happyReduction_91 _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_1  39 happyReduction_92
happyReduction_92 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn30
		 (EInt happy_var_1
	)
happyReduction_92 _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_1  39 happyReduction_93
happyReduction_93 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn30
		 (EDouble happy_var_1
	)
happyReduction_93 _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  39 happyReduction_94
happyReduction_94 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn30
		 (ECFloat happy_var_1
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_1  39 happyReduction_95
happyReduction_95 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn30
		 (EHexadec happy_var_1
	)
happyReduction_95 _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  39 happyReduction_96
happyReduction_96 _
	(HappyAbsSyn30  happy_var_2)
	_
	 =  HappyAbsSyn30
		 (happy_var_2
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_0  40 happyReduction_97
happyReduction_97  =  HappyAbsSyn40
		 ([]
	)

happyReduce_98 = happySpecReduce_1  40 happyReduction_98
happyReduction_98 (HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn40
		 ((:[]) happy_var_1
	)
happyReduction_98 _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_3  40 happyReduction_99
happyReduction_99 (HappyAbsSyn40  happy_var_3)
	_
	(HappyAbsSyn41  happy_var_1)
	 =  HappyAbsSyn40
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_1  41 happyReduction_100
happyReduction_100 (HappyAbsSyn30  happy_var_1)
	 =  HappyAbsSyn41
		 (EArg happy_var_1
	)
happyReduction_100 _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_1  42 happyReduction_101
happyReduction_101 (HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn42
		 ((:[]) happy_var_1
	)
happyReduction_101 _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_3  42 happyReduction_102
happyReduction_102 (HappyAbsSyn42  happy_var_3)
	_
	(HappyAbsSyn43  happy_var_1)
	 =  HappyAbsSyn42
		 ((:) happy_var_1 happy_var_3
	)
happyReduction_102 _ _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_1  43 happyReduction_103
happyReduction_103 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn43
		 (EField happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  44 happyReduction_104
happyReduction_104 (HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn44
		 (TName happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 99 99 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	PT _ (TS "{") -> cont 45;
	PT _ (TS "}") -> cont 46;
	PT _ (TS ";") -> cont 47;
	PT _ (TS "(") -> cont 48;
	PT _ (TS ")") -> cont 49;
	PT _ (TS ",") -> cont 50;
	PT _ (TS "=") -> cont 51;
	PT _ (TS ".") -> cont 52;
	PT _ (TS "[") -> cont 53;
	PT _ (TS "]") -> cont 54;
	PT _ (TS "&") -> cont 55;
	PT _ (TS "|") -> cont 56;
	PT _ (TS "^") -> cont 57;
	PT _ (TS "~") -> cont 58;
	PT _ (TS "==") -> cont 59;
	PT _ (TS "!=") -> cont 60;
	PT _ (TS ">") -> cont 61;
	PT _ (TS ">=") -> cont 62;
	PT _ (TS "<") -> cont 63;
	PT _ (TS "<=") -> cont 64;
	PT _ (TS "<<") -> cont 65;
	PT _ (TS ">>") -> cont 66;
	PT _ (TS "<<<") -> cont 67;
	PT _ (TS ">>>") -> cont 68;
	PT _ (TS "<<|") -> cont 69;
	PT _ (TS ">>|") -> cont 70;
	PT _ (TS "<<<|") -> cont 71;
	PT _ (TS ">>>|") -> cont 72;
	PT _ (TS "+") -> cont 73;
	PT _ (TS "-") -> cont 74;
	PT _ (TS "*") -> cont 75;
	PT _ (TS "/") -> cont 76;
	PT _ (TS "/.") -> cont 77;
	PT _ (TS "always_inline") -> cont 78;
	PT _ (TS "array") -> cont 79;
	PT _ (TS "else") -> cont 80;
	PT _ (TS "force_inline") -> cont 81;
	PT _ (TS "if") -> cont 82;
	PT _ (TS "in") -> cont 83;
	PT _ (TS "inline") -> cont 84;
	PT _ (TS "inout") -> cont 85;
	PT _ (TS "new") -> cont 86;
	PT _ (TS "out") -> cont 87;
	PT _ (TS "return") -> cont 88;
	PT _ (TS "static") -> cont 89;
	PT _ (TS "struct") -> cont 90;
	PT _ (TS "while") -> cont 91;
	PT _ (TV happy_dollar_dollar) -> cont 92;
	PT _ (TI happy_dollar_dollar) -> cont 93;
	PT _ (TD happy_dollar_dollar) -> cont 94;
	PT _ (T_CFloat happy_dollar_dollar) -> cont 95;
	PT _ (T_CDouble happy_dollar_dollar) -> cont 96;
	PT _ (T_Hexadecimal happy_dollar_dollar) -> cont 97;
	_ -> cont 98;
	_ -> happyError' (tk:tks)
	}

happyError_ tk tks = happyError' (tk:tks)

happyThen :: () => Err a -> (a -> Err b) -> Err b
happyThen = (thenM)
happyReturn :: () => a -> Err a
happyReturn = (returnM)
happyThen1 m k tks = (thenM) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> Err a
happyReturn1 = \a tks -> (returnM) a
happyError' :: () => [Token] -> Err a
happyError' = happyError

pProg tks = happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn10 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    _ -> " before " ++ unwords (map prToken (take 4 ts))

myLexer = tokens
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command line>" #-}
{-# LINE 1 "GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 28 "GenericTemplate.hs" #-}








{-# LINE 49 "GenericTemplate.hs" #-}

{-# LINE 59 "GenericTemplate.hs" #-}

{-# LINE 68 "GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
	happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
	 (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
	 sts1@(((st1@(HappyState (action))):(_))) ->
        	let r = fn stk in  -- it doesn't hurt to always seq here...
       		happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
        happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
       happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))
       where sts1@(((st1@(HappyState (action))):(_))) = happyDrop k ((st):(sts))
             drop_stk = happyDropStk k stk





             new_state = action


happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 253 "GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail  (1) tk old_st _ stk =
--	trace "failing" $ 
    	happyError_ tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
						(saved_tok `HappyStk` _ `HappyStk` stk) =
--	trace ("discarding state, depth " ++ show (length stk))  $
	action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
	action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--	happySeq = happyDoSeq
-- otherwise it emits
-- 	happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 317 "GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
