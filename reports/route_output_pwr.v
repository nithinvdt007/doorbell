module doorbell_chip (btn_in,
    clk,
    led_blink,
    rst_n,
    sleep_led,
    seg_out);
 input btn_in;
 input clk;
 output led_blink;
 input rst_n;
 output sleep_led;
 output [6:0] seg_out;

 wire GROUND;
 wire VDD;
 wire _000_;
 wire _001_;
 wire _002_;
 wire _003_;
 wire _004_;
 wire _005_;
 wire _006_;
 wire _007_;
 wire _008_;
 wire _009_;
 wire _010_;
 wire _011_;
 wire _012_;
 wire _013_;
 wire _014_;
 wire _015_;
 wire _016_;
 wire _017_;
 wire _018_;
 wire _019_;
 wire _020_;
 wire _021_;
 wire _022_;
 wire _023_;
 wire _024_;
 wire _025_;
 wire _026_;
 wire _027_;
 wire _028_;
 wire _029_;
 wire _030_;
 wire _031_;
 wire _032_;
 wire _033_;
 wire _034_;
 wire _035_;
 wire _036_;
 wire _037_;
 wire _038_;
 wire _039_;
 wire _040_;
 wire _041_;
 wire _042_;
 wire _043_;
 wire _044_;
 wire _045_;
 wire _046_;
 wire _047_;
 wire _048_;
 wire _049_;
 wire _050_;
 wire _051_;
 wire _052_;
 wire _053_;
 wire _054_;
 wire _055_;
 wire _056_;
 wire _057_;
 wire _058_;
 wire _059_;
 wire _060_;
 wire _061_;
 wire _062_;
 wire _063_;
 wire _064_;
 wire _065_;
 wire _066_;
 wire _067_;
 wire _068_;
 wire _069_;
 wire _070_;
 wire _071_;
 wire _072_;
 wire _073_;
 wire _074_;
 wire _075_;
 wire _076_;
 wire _077_;
 wire _078_;
 wire _079_;
 wire _080_;
 wire _081_;
 wire _082_;
 wire _083_;
 wire _084_;
 wire _085_;
 wire _086_;
 wire _087_;
 wire _088_;
 wire _089_;
 wire _090_;
 wire _091_;
 wire _092_;
 wire _093_;
 wire _094_;
 wire _095_;
 wire _096_;
 wire _097_;
 wire _098_;
 wire _099_;
 wire _100_;
 wire _101_;
 wire _102_;
 wire _103_;
 wire _104_;
 wire _105_;
 wire _106_;
 wire _107_;
 wire _108_;
 wire _109_;
 wire _110_;
 wire _111_;
 wire _112_;
 wire _113_;
 wire _114_;
 wire _115_;
 wire _116_;
 wire _117_;
 wire _118_;
 wire _119_;
 wire _120_;
 wire _121_;
 wire _122_;
 wire _123_;
 wire _124_;
 wire _125_;
 wire _126_;
 wire _127_;
 wire _128_;
 wire _129_;
 wire _130_;
 wire _131_;
 wire _132_;
 wire _133_;
 wire _134_;
 wire _135_;
 wire _136_;
 wire _137_;
 wire _138_;
 wire _139_;
 wire _140_;
 wire _141_;
 wire _142_;
 wire _143_;
 wire _144_;
 wire _145_;
 wire _146_;
 wire _147_;
 wire _148_;
 wire _149_;
 wire _150_;
 wire _151_;
 wire _152_;
 wire _153_;
 wire _154_;
 wire _155_;
 wire _156_;
 wire _157_;
 wire _158_;
 wire _159_;
 wire _160_;
 wire _161_;
 wire _162_;
 wire _163_;
 wire _164_;
 wire _165_;
 wire _166_;
 wire _167_;
 wire _168_;
 wire _169_;
 wire _170_;
 wire _171_;
 wire _172_;
 wire _173_;
 wire _174_;
 wire _175_;
 wire _176_;
 wire _177_;
 wire _178_;
 wire _179_;
 wire _180_;
 wire _181_;
 wire _182_;
 wire _183_;
 wire _184_;
 wire _185_;
 wire _186_;
 wire _187_;
 wire _188_;
 wire _189_;
 wire _190_;
 wire _191_;
 wire _192_;
 wire _193_;
 wire _194_;
 wire _195_;
 wire _196_;
 wire _197_;
 wire _198_;
 wire _199_;
 wire _200_;
 wire _201_;
 wire _202_;
 wire _203_;
 wire _204_;
 wire _205_;
 wire _206_;
 wire _207_;
 wire _208_;
 wire _209_;
 wire _210_;
 wire _211_;
 wire _212_;
 wire _213_;
 wire _214_;
 wire _215_;
 wire _216_;
 wire _217_;
 wire _218_;
 wire _219_;
 wire _220_;
 wire _221_;
 wire _222_;
 wire _223_;
 wire _224_;
 wire _225_;
 wire _226_;
 wire _227_;
 wire _228_;
 wire _229_;
 wire _230_;
 wire _231_;
 wire _232_;
 wire _233_;
 wire _234_;
 wire _235_;
 wire _236_;
 wire _237_;
 wire _238_;
 wire _239_;
 wire _240_;
 wire _241_;
 wire _242_;
 wire _243_;
 wire _244_;
 wire _245_;
 wire _246_;
 wire _247_;
 wire _248_;
 wire _249_;
 wire _250_;
 wire _251_;
 wire _252_;
 wire _253_;
 wire _254_;
 wire _255_;
 wire _256_;
 wire _257_;
 wire _258_;
 wire _259_;
 wire _260_;
 wire _261_;
 wire _262_;
 wire _263_;
 wire _264_;
 wire _265_;
 wire _266_;
 wire _267_;
 wire _268_;
 wire _269_;
 wire _270_;
 wire _271_;
 wire _272_;
 wire _273_;
 wire _274_;
 wire _275_;
 wire _276_;
 wire _277_;
 wire _278_;
 wire _279_;
 wire _280_;
 wire _281_;
 wire _282_;
 wire _283_;
 wire _284_;
 wire _285_;
 wire _286_;
 wire _287_;
 wire _288_;
 wire _289_;
 wire _290_;
 wire _291_;
 wire _292_;
 wire _293_;
 wire _294_;
 wire _295_;
 wire _296_;
 wire _297_;
 wire _298_;
 wire _299_;
 wire _300_;
 wire _301_;
 wire _302_;
 wire _303_;
 wire _304_;
 wire _305_;
 wire _306_;
 wire _307_;
 wire _308_;
 wire _309_;
 wire _310_;
 wire _311_;
 wire _312_;
 wire _313_;
 wire _314_;
 wire _315_;
 wire _316_;
 wire _317_;
 wire _318_;
 wire _319_;
 wire _320_;
 wire _321_;
 wire _322_;
 wire _323_;
 wire _324_;
 wire _325_;
 wire _326_;
 wire _327_;
 wire _328_;
 wire _329_;
 wire _330_;
 wire _331_;
 wire _332_;
 wire _333_;
 wire _334_;
 wire _335_;
 wire _336_;
 wire _337_;
 wire _338_;
 wire _339_;
 wire _340_;
 wire _341_;
 wire _342_;
 wire _343_;
 wire _344_;
 wire _345_;
 wire _346_;
 wire _347_;
 wire _348_;
 wire _349_;
 wire _350_;
 wire _351_;
 wire _352_;
 wire _353_;
 wire _354_;
 wire _355_;
 wire _356_;
 wire _357_;
 wire _358_;
 wire _359_;
 wire _360_;
 wire _361_;
 wire _362_;
 wire _363_;
 wire _364_;
 wire _365_;
 wire btn_c;
 wire clk_c;
 wire clknet_0_clk_c;
 wire clknet_3_0_0_clk_c;
 wire clknet_3_1_0_clk_c;
 wire clknet_3_2_0_clk_c;
 wire clknet_3_3_0_clk_c;
 wire clknet_3_4_0_clk_c;
 wire clknet_3_5_0_clk_c;
 wire clknet_3_6_0_clk_c;
 wire clknet_3_7_0_clk_c;
 wire clknet_4_0_0_clk_c;
 wire clknet_4_10_0_clk_c;
 wire clknet_4_11_0_clk_c;
 wire clknet_4_12_0_clk_c;
 wire clknet_4_13_0_clk_c;
 wire clknet_4_14_0_clk_c;
 wire clknet_4_15_0_clk_c;
 wire clknet_4_1_0_clk_c;
 wire clknet_4_2_0_clk_c;
 wire clknet_4_3_0_clk_c;
 wire clknet_4_4_0_clk_c;
 wire clknet_4_5_0_clk_c;
 wire clknet_4_6_0_clk_c;
 wire clknet_4_7_0_clk_c;
 wire clknet_4_8_0_clk_c;
 wire clknet_4_9_0_clk_c;
 wire clknet_5_0_0_clk_c;
 wire clknet_5_10_0_clk_c;
 wire clknet_5_11_0_clk_c;
 wire clknet_5_12_0_clk_c;
 wire clknet_5_13_0_clk_c;
 wire clknet_5_14_0_clk_c;
 wire clknet_5_15_0_clk_c;
 wire clknet_5_16_0_clk_c;
 wire clknet_5_17_0_clk_c;
 wire clknet_5_18_0_clk_c;
 wire clknet_5_19_0_clk_c;
 wire clknet_5_1_0_clk_c;
 wire clknet_5_20_0_clk_c;
 wire clknet_5_21_0_clk_c;
 wire clknet_5_22_0_clk_c;
 wire clknet_5_23_0_clk_c;
 wire clknet_5_24_0_clk_c;
 wire clknet_5_25_0_clk_c;
 wire clknet_5_26_0_clk_c;
 wire clknet_5_27_0_clk_c;
 wire clknet_5_28_0_clk_c;
 wire clknet_5_29_0_clk_c;
 wire clknet_5_2_0_clk_c;
 wire clknet_5_30_0_clk_c;
 wire clknet_5_31_0_clk_c;
 wire clknet_5_3_0_clk_c;
 wire clknet_5_4_0_clk_c;
 wire clknet_5_5_0_clk_c;
 wire clknet_5_6_0_clk_c;
 wire clknet_5_7_0_clk_c;
 wire clknet_5_8_0_clk_c;
 wire clknet_5_9_0_clk_c;
 wire rst_n_c;
 wire rst_sync_0;
 wire rst_sync_1;
 wire rst_sync_d;
 wire \seg_c[0] ;
 wire \seg_c[1] ;
 wire \seg_c[2] ;
 wire \seg_c[3] ;
 wire \seg_c[4] ;
 wire \seg_c[5] ;
 wire \seg_c[6] ;
 wire \u_core.u_blink.cnt[0] ;
 wire \u_core.u_blink.cnt[10] ;
 wire \u_core.u_blink.cnt[11] ;
 wire \u_core.u_blink.cnt[12] ;
 wire \u_core.u_blink.cnt[13] ;
 wire \u_core.u_blink.cnt[14] ;
 wire \u_core.u_blink.cnt[15] ;
 wire \u_core.u_blink.cnt[16] ;
 wire \u_core.u_blink.cnt[17] ;
 wire \u_core.u_blink.cnt[18] ;
 wire \u_core.u_blink.cnt[19] ;
 wire \u_core.u_blink.cnt[1] ;
 wire \u_core.u_blink.cnt[2] ;
 wire \u_core.u_blink.cnt[3] ;
 wire \u_core.u_blink.cnt[4] ;
 wire \u_core.u_blink.cnt[5] ;
 wire \u_core.u_blink.cnt[6] ;
 wire \u_core.u_blink.cnt[7] ;
 wire \u_core.u_blink.cnt[8] ;
 wire \u_core.u_blink.cnt[9] ;
 wire \u_core.u_blink.pulse ;
 wire \u_core.u_blink.running ;
 wire \u_core.u_counter.count[0] ;
 wire \u_core.u_counter.count[1] ;
 wire \u_core.u_counter.count[2] ;
 wire \u_core.u_counter.count[3] ;
 wire \u_core.u_debounce.btn_out ;
 wire \u_core.u_debounce.btn_sync_0 ;
 wire \u_core.u_debounce.btn_sync_1 ;
 wire \u_core.u_debounce.stable_cnt[0] ;
 wire \u_core.u_debounce.stable_cnt[10] ;
 wire \u_core.u_debounce.stable_cnt[11] ;
 wire \u_core.u_debounce.stable_cnt[12] ;
 wire \u_core.u_debounce.stable_cnt[13] ;
 wire \u_core.u_debounce.stable_cnt[14] ;
 wire \u_core.u_debounce.stable_cnt[15] ;
 wire \u_core.u_debounce.stable_cnt[1] ;
 wire \u_core.u_debounce.stable_cnt[2] ;
 wire \u_core.u_debounce.stable_cnt[3] ;
 wire \u_core.u_debounce.stable_cnt[4] ;
 wire \u_core.u_debounce.stable_cnt[5] ;
 wire \u_core.u_debounce.stable_cnt[6] ;
 wire \u_core.u_debounce.stable_cnt[7] ;
 wire \u_core.u_debounce.stable_cnt[8] ;
 wire \u_core.u_debounce.stable_cnt[9] ;
 wire \u_core.u_edge.sig_prev ;
 wire \u_core.u_sleep.idle_cnt[0] ;
 wire \u_core.u_sleep.idle_cnt[10] ;
 wire \u_core.u_sleep.idle_cnt[11] ;
 wire \u_core.u_sleep.idle_cnt[12] ;
 wire \u_core.u_sleep.idle_cnt[13] ;
 wire \u_core.u_sleep.idle_cnt[14] ;
 wire \u_core.u_sleep.idle_cnt[15] ;
 wire \u_core.u_sleep.idle_cnt[16] ;
 wire \u_core.u_sleep.idle_cnt[17] ;
 wire \u_core.u_sleep.idle_cnt[18] ;
 wire \u_core.u_sleep.idle_cnt[19] ;
 wire \u_core.u_sleep.idle_cnt[1] ;
 wire \u_core.u_sleep.idle_cnt[20] ;
 wire \u_core.u_sleep.idle_cnt[21] ;
 wire \u_core.u_sleep.idle_cnt[22] ;
 wire \u_core.u_sleep.idle_cnt[23] ;
 wire \u_core.u_sleep.idle_cnt[2] ;
 wire \u_core.u_sleep.idle_cnt[3] ;
 wire \u_core.u_sleep.idle_cnt[4] ;
 wire \u_core.u_sleep.idle_cnt[5] ;
 wire \u_core.u_sleep.idle_cnt[6] ;
 wire \u_core.u_sleep.idle_cnt[7] ;
 wire \u_core.u_sleep.idle_cnt[8] ;
 wire \u_core.u_sleep.idle_cnt[9] ;
 wire \u_core.u_sleep.sleep_out ;
 wire \u_core.u_sleep.state ;

 CORNER IO_CORNER_NORTH_EAST_INST (.GROUND(GROUND),
    .VDD(VDD));
 CORNER IO_CORNER_NORTH_WEST_INST (.GROUND(GROUND),
    .VDD(VDD));
 CORNER IO_CORNER_SOUTH_EAST_INST (.GROUND(GROUND),
    .VDD(VDD));
 CORNER IO_CORNER_SOUTH_WEST_INST (.GROUND(GROUND),
    .VDD(VDD));
 INVR00 _366_ (.GROUND(GROUND),
    .OUT1(_128_),
    .IN1(\u_core.u_blink.cnt[14] ),
    .VDD(VDD));
 INVR00 _367_ (.GROUND(GROUND),
    .OUT1(_129_),
    .IN1(\u_core.u_blink.cnt[2] ),
    .VDD(VDD));
 INVR00 _368_ (.GROUND(GROUND),
    .OUT1(_130_),
    .IN1(\u_core.u_blink.cnt[4] ),
    .VDD(VDD));
 INVR00 _369_ (.GROUND(GROUND),
    .OUT1(_131_),
    .IN1(\u_core.u_blink.cnt[5] ),
    .VDD(VDD));
 INVR00 _370_ (.GROUND(GROUND),
    .OUT1(_132_),
    .IN1(\u_core.u_blink.cnt[3] ),
    .VDD(VDD));
 INVR00 _371_ (.GROUND(GROUND),
    .OUT1(_133_),
    .IN1(\u_core.u_blink.cnt[1] ),
    .VDD(VDD));
 INVR00 _372_ (.GROUND(GROUND),
    .OUT1(_134_),
    .IN1(\u_core.u_blink.cnt[0] ),
    .VDD(VDD));
 INVR00 _373_ (.GROUND(GROUND),
    .OUT1(_135_),
    .IN1(\u_core.u_counter.count[2] ),
    .VDD(VDD));
 INVR00 _374_ (.GROUND(GROUND),
    .OUT1(_136_),
    .IN1(\u_core.u_counter.count[1] ),
    .VDD(VDD));
 INVR00 _375_ (.GROUND(GROUND),
    .OUT1(_137_),
    .IN1(\u_core.u_sleep.idle_cnt[5] ),
    .VDD(VDD));
 INVR00 _376_ (.GROUND(GROUND),
    .OUT1(_138_),
    .IN1(_350_),
    .VDD(VDD));
 INVR00 _377_ (.GROUND(GROUND),
    .OUT1(_139_),
    .IN1(_058_),
    .VDD(VDD));
 INVR00 _378_ (.GROUND(GROUND),
    .OUT1(_140_),
    .IN1(\u_core.u_blink.pulse ),
    .VDD(VDD));
 INVR00 _379_ (.GROUND(GROUND),
    .OUT1(_141_),
    .IN1(\u_core.u_blink.running ),
    .VDD(VDD));
 AND200 _380_ (.GROUND(GROUND),
    .OUT1(_142_),
    .IN1(\u_core.u_debounce.stable_cnt[1] ),
    .IN2(\u_core.u_debounce.stable_cnt[0] ),
    .VDD(VDD));
 AND200 _381_ (.GROUND(GROUND),
    .OUT1(_143_),
    .IN1(\u_core.u_debounce.stable_cnt[2] ),
    .IN2(_142_),
    .VDD(VDD));
 AND200 _382_ (.GROUND(GROUND),
    .OUT1(_144_),
    .IN1(\u_core.u_debounce.stable_cnt[3] ),
    .IN2(_143_),
    .VDD(VDD));
 AND500 _383_ (.GROUND(GROUND),
    .OUT1(_145_),
    .IN1(\u_core.u_debounce.stable_cnt[1] ),
    .IN2(\u_core.u_debounce.stable_cnt[0] ),
    .IN3(\u_core.u_debounce.stable_cnt[3] ),
    .IN4(\u_core.u_debounce.stable_cnt[2] ),
    .IN5(\u_core.u_debounce.stable_cnt[4] ),
    .VDD(VDD));
 AND200 _384_ (.GROUND(GROUND),
    .OUT1(_146_),
    .IN1(\u_core.u_debounce.stable_cnt[5] ),
    .IN2(_145_),
    .VDD(VDD));
 AND200 _385_ (.GROUND(GROUND),
    .OUT1(_147_),
    .IN1(\u_core.u_debounce.stable_cnt[6] ),
    .IN2(_146_),
    .VDD(VDD));
 AND200 _386_ (.GROUND(GROUND),
    .OUT1(_148_),
    .IN1(\u_core.u_debounce.stable_cnt[7] ),
    .IN2(_147_),
    .VDD(VDD));
 AND500 _387_ (.GROUND(GROUND),
    .OUT1(_149_),
    .IN1(\u_core.u_debounce.stable_cnt[6] ),
    .IN2(\u_core.u_debounce.stable_cnt[5] ),
    .IN3(\u_core.u_debounce.stable_cnt[7] ),
    .IN4(\u_core.u_debounce.stable_cnt[8] ),
    .IN5(_145_),
    .VDD(VDD));
 AND300 _388_ (.GROUND(GROUND),
    .OUT1(_150_),
    .IN1(\u_core.u_debounce.stable_cnt[9] ),
    .IN2(\u_core.u_debounce.stable_cnt[10] ),
    .IN3(_149_),
    .VDD(VDD));
 AND400 _389_ (.GROUND(GROUND),
    .OUT1(_151_),
    .IN1(\u_core.u_debounce.stable_cnt[9] ),
    .IN2(\u_core.u_debounce.stable_cnt[10] ),
    .IN3(\u_core.u_debounce.stable_cnt[11] ),
    .IN4(_149_),
    .VDD(VDD));
 AND200 _390_ (.GROUND(GROUND),
    .OUT1(_152_),
    .IN1(\u_core.u_debounce.stable_cnt[12] ),
    .IN2(_151_),
    .VDD(VDD));
 AND200 _391_ (.GROUND(GROUND),
    .OUT1(_153_),
    .IN1(\u_core.u_debounce.stable_cnt[13] ),
    .IN2(_152_),
    .VDD(VDD));
 AND200 _392_ (.GROUND(GROUND),
    .OUT1(_154_),
    .IN1(\u_core.u_debounce.stable_cnt[14] ),
    .IN2(_153_),
    .VDD(VDD));
 NOR200 _393_ (.GROUND(GROUND),
    .OUT1(_155_),
    .IN1(\u_core.u_debounce.stable_cnt[14] ),
    .IN2(_153_),
    .VDD(VDD));
 OR4100 _394_ (.GROUND(GROUND),
    .OUT1(_156_),
    .IN1(_352_),
    .IN2(_045_),
    .IN3(_047_),
    .IN4(_046_),
    .VDD(VDD));
 NOR500 _395_ (.GROUND(GROUND),
    .OUT1(_157_),
    .IN1(_051_),
    .IN2(_050_),
    .IN3(_052_),
    .IN4(_056_),
    .IN5(_156_),
    .VDD(VDD));
 NOR400 _396_ (.GROUND(GROUND),
    .OUT1(_158_),
    .IN1(_043_),
    .IN2(_001_),
    .IN3(_044_),
    .IN4(_049_),
    .VDD(VDD));
 NOR400 _397_ (.GROUND(GROUND),
    .OUT1(_159_),
    .IN1(_048_),
    .IN2(_053_),
    .IN3(_055_),
    .IN4(_054_),
    .VDD(VDD));
 NND300 _398_ (.GROUND(GROUND),
    .OUT1(_160_),
    .IN1(_157_),
    .IN2(_158_),
    .IN3(_159_),
    .VDD(VDD));
 XOR200 _399_ (.GROUND(GROUND),
    .OUT1(_161_),
    .IN1(\u_core.u_debounce.btn_out ),
    .IN2(\u_core.u_debounce.btn_sync_1 ),
    .VDD(VDD));
 NND200 _400_ (.GROUND(GROUND),
    .OUT1(_162_),
    .IN1(_160_),
    .IN2(_161_),
    .VDD(VDD));
 NOR300 _401_ (.GROUND(GROUND),
    .OUT1(_117_),
    .IN1(_154_),
    .IN2(_155_),
    .IN3(_162_),
    .VDD(VDD));
 NOR200 _402_ (.GROUND(GROUND),
    .OUT1(_163_),
    .IN1(\u_core.u_debounce.stable_cnt[13] ),
    .IN2(_152_),
    .VDD(VDD));
 NOR300 _403_ (.GROUND(GROUND),
    .OUT1(_116_),
    .IN1(_153_),
    .IN2(_162_),
    .IN3(_163_),
    .VDD(VDD));
 NOR200 _404_ (.GROUND(GROUND),
    .OUT1(_164_),
    .IN1(\u_core.u_debounce.stable_cnt[12] ),
    .IN2(_151_),
    .VDD(VDD));
 NOR300 _405_ (.GROUND(GROUND),
    .OUT1(_115_),
    .IN1(_152_),
    .IN2(_162_),
    .IN3(_164_),
    .VDD(VDD));
 NOR200 _406_ (.GROUND(GROUND),
    .OUT1(_165_),
    .IN1(\u_core.u_debounce.stable_cnt[11] ),
    .IN2(_150_),
    .VDD(VDD));
 NOR300 _407_ (.GROUND(GROUND),
    .OUT1(_114_),
    .IN1(_151_),
    .IN2(_162_),
    .IN3(_165_),
    .VDD(VDD));
 ADNR00 _408_ (.GROUND(GROUND),
    .OUT1(_166_),
    .IN1(\u_core.u_debounce.stable_cnt[9] ),
    .IN2(_149_),
    .IN3(\u_core.u_debounce.stable_cnt[10] ),
    .VDD(VDD));
 NOR300 _409_ (.GROUND(GROUND),
    .OUT1(_113_),
    .IN1(_150_),
    .IN2(_162_),
    .IN3(_166_),
    .VDD(VDD));
 NOR200 _410_ (.GROUND(GROUND),
    .OUT1(_167_),
    .IN1(\u_core.u_debounce.stable_cnt[9] ),
    .IN2(_149_),
    .VDD(VDD));
 OR2100 _411_ (.GROUND(GROUND),
    .OUT1(_168_),
    .IN1(_162_),
    .IN2(_167_),
    .VDD(VDD));
 ADNR00 _412_ (.GROUND(GROUND),
    .OUT1(_127_),
    .IN1(\u_core.u_debounce.stable_cnt[9] ),
    .IN2(_149_),
    .IN3(_168_),
    .VDD(VDD));
 NOR200 _413_ (.GROUND(GROUND),
    .OUT1(_169_),
    .IN1(\u_core.u_debounce.stable_cnt[8] ),
    .IN2(_148_),
    .VDD(VDD));
 NOR300 _414_ (.GROUND(GROUND),
    .OUT1(_126_),
    .IN1(_149_),
    .IN2(_162_),
    .IN3(_169_),
    .VDD(VDD));
 NOR200 _415_ (.GROUND(GROUND),
    .OUT1(_170_),
    .IN1(\u_core.u_debounce.stable_cnt[7] ),
    .IN2(_147_),
    .VDD(VDD));
 NOR300 _416_ (.GROUND(GROUND),
    .OUT1(_125_),
    .IN1(_148_),
    .IN2(_162_),
    .IN3(_170_),
    .VDD(VDD));
 NOR200 _417_ (.GROUND(GROUND),
    .OUT1(_171_),
    .IN1(\u_core.u_debounce.stable_cnt[6] ),
    .IN2(_146_),
    .VDD(VDD));
 NOR300 _418_ (.GROUND(GROUND),
    .OUT1(_124_),
    .IN1(_147_),
    .IN2(_162_),
    .IN3(_171_),
    .VDD(VDD));
 NOR200 _419_ (.GROUND(GROUND),
    .OUT1(_172_),
    .IN1(\u_core.u_debounce.stable_cnt[5] ),
    .IN2(_145_),
    .VDD(VDD));
 NOR300 _420_ (.GROUND(GROUND),
    .OUT1(_123_),
    .IN1(_146_),
    .IN2(_162_),
    .IN3(_172_),
    .VDD(VDD));
 NOR200 _421_ (.GROUND(GROUND),
    .OUT1(_173_),
    .IN1(\u_core.u_debounce.stable_cnt[4] ),
    .IN2(_144_),
    .VDD(VDD));
 NOR300 _422_ (.GROUND(GROUND),
    .OUT1(_122_),
    .IN1(_145_),
    .IN2(_162_),
    .IN3(_173_),
    .VDD(VDD));
 NOR200 _423_ (.GROUND(GROUND),
    .OUT1(_174_),
    .IN1(\u_core.u_debounce.stable_cnt[3] ),
    .IN2(_143_),
    .VDD(VDD));
 NOR300 _424_ (.GROUND(GROUND),
    .OUT1(_121_),
    .IN1(_144_),
    .IN2(_162_),
    .IN3(_174_),
    .VDD(VDD));
 NOR200 _425_ (.GROUND(GROUND),
    .OUT1(_175_),
    .IN1(\u_core.u_debounce.stable_cnt[2] ),
    .IN2(_142_),
    .VDD(VDD));
 NOR300 _426_ (.GROUND(GROUND),
    .OUT1(_120_),
    .IN1(_143_),
    .IN2(_162_),
    .IN3(_175_),
    .VDD(VDD));
 NOR200 _427_ (.GROUND(GROUND),
    .OUT1(_176_),
    .IN1(\u_core.u_debounce.stable_cnt[1] ),
    .IN2(\u_core.u_debounce.stable_cnt[0] ),
    .VDD(VDD));
 NOR300 _428_ (.GROUND(GROUND),
    .OUT1(_119_),
    .IN1(_142_),
    .IN2(_162_),
    .IN3(_176_),
    .VDD(VDD));
 AND200 _429_ (.GROUND(GROUND),
    .OUT1(_112_),
    .IN1(_352_),
    .IN2(_161_),
    .VDD(VDD));
 NND200 _430_ (.GROUND(GROUND),
    .OUT1(_177_),
    .IN1(_136_),
    .IN2(_350_),
    .VDD(VDD));
 ADNR00 _431_ (.GROUND(GROUND),
    .OUT1(_178_),
    .IN1(\u_core.u_counter.count[1] ),
    .IN2(_138_),
    .IN3(_135_),
    .VDD(VDD));
 ADNR00 _432_ (.GROUND(GROUND),
    .OUT1(_179_),
    .IN1(_136_),
    .IN2(_350_),
    .IN3(_178_),
    .VDD(VDD));
 NND300 _433_ (.GROUND(GROUND),
    .OUT1(_180_),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_135_),
    .IN3(_002_),
    .VDD(VDD));
 ORND00 _434_ (.GROUND(GROUND),
    .OUT1(\seg_c[5] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_179_),
    .IN3(_180_),
    .VDD(VDD));
 NOR200 _435_ (.GROUND(GROUND),
    .OUT1(_181_),
    .IN1(\u_core.u_counter.count[2] ),
    .IN2(\u_core.u_counter.count[1] ),
    .VDD(VDD));
 NND200 _436_ (.GROUND(GROUND),
    .OUT1(_182_),
    .IN1(_350_),
    .IN2(_181_),
    .VDD(VDD));
 NND200 _437_ (.GROUND(GROUND),
    .OUT1(_183_),
    .IN1(\u_core.u_counter.count[1] ),
    .IN2(_350_),
    .VDD(VDD));
 ORND00 _438_ (.GROUND(GROUND),
    .OUT1(\seg_c[4] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_183_),
    .IN3(_182_),
    .VDD(VDD));
 OR2100 _439_ (.GROUND(GROUND),
    .OUT1(_184_),
    .IN1(\u_core.u_counter.count[1] ),
    .IN2(\u_core.u_counter.count[0] ),
    .VDD(VDD));
 NND200 _440_ (.GROUND(GROUND),
    .OUT1(_185_),
    .IN1(_135_),
    .IN2(\u_core.u_counter.count[1] ),
    .VDD(VDD));
 NND200 _441_ (.GROUND(GROUND),
    .OUT1(_186_),
    .IN1(_182_),
    .IN2(_185_),
    .VDD(VDD));
 ADNR00 _442_ (.GROUND(GROUND),
    .OUT1(_187_),
    .IN1(_178_),
    .IN2(_184_),
    .IN3(_186_),
    .VDD(VDD));
 ORND00 _443_ (.GROUND(GROUND),
    .OUT1(\seg_c[3] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_187_),
    .IN3(_180_),
    .VDD(VDD));
 NOR200 _444_ (.GROUND(GROUND),
    .OUT1(_188_),
    .IN1(\u_core.u_counter.count[0] ),
    .IN2(_185_),
    .VDD(VDD));
 ORND00 _445_ (.GROUND(GROUND),
    .OUT1(\seg_c[2] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_188_),
    .IN3(_180_),
    .VDD(VDD));
 NND200 _446_ (.GROUND(GROUND),
    .OUT1(_189_),
    .IN1(\u_core.u_counter.count[1] ),
    .IN2(\u_core.u_counter.count[0] ),
    .VDD(VDD));
 AND300 _447_ (.GROUND(GROUND),
    .OUT1(_190_),
    .IN1(\u_core.u_counter.count[2] ),
    .IN2(_177_),
    .IN3(_189_),
    .VDD(VDD));
 ORND00 _448_ (.GROUND(GROUND),
    .OUT1(\seg_c[1] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_190_),
    .IN3(_180_),
    .VDD(VDD));
 MX2100 _449_ (.GROUND(GROUND),
    .S(_181_),
    .D0(_184_),
    .OUT1(_191_),
    .D1(_350_),
    .VDD(VDD));
 ORND00 _450_ (.GROUND(GROUND),
    .OUT1(\seg_c[0] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_191_),
    .IN3(_180_),
    .VDD(VDD));
 AND200 _451_ (.GROUND(GROUND),
    .OUT1(_192_),
    .IN1(\u_core.u_debounce.btn_out ),
    .IN2(_059_),
    .VDD(VDD));
 NND200 _452_ (.GROUND(GROUND),
    .OUT1(_193_),
    .IN1(\u_core.u_debounce.btn_out ),
    .IN2(_059_),
    .VDD(VDD));
 NOR400 _453_ (.GROUND(GROUND),
    .OUT1(_194_),
    .IN1(_041_),
    .IN2(_036_),
    .IN3(_034_),
    .IN4(_023_),
    .VDD(VDD));
 NOR400 _454_ (.GROUND(GROUND),
    .OUT1(_195_),
    .IN1(_037_),
    .IN2(_031_),
    .IN3(_029_),
    .IN4(_024_),
    .VDD(VDD));
 NOR300 _455_ (.GROUND(GROUND),
    .OUT1(_196_),
    .IN1(_026_),
    .IN2(_025_),
    .IN3(_021_),
    .VDD(VDD));
 NOR200 _456_ (.GROUND(GROUND),
    .OUT1(_197_),
    .IN1(_353_),
    .IN2(_039_),
    .VDD(VDD));
 NND400 _457_ (.GROUND(GROUND),
    .OUT1(_198_),
    .IN1(_194_),
    .IN2(_195_),
    .IN3(_196_),
    .IN4(_197_),
    .VDD(VDD));
 NOR400 _458_ (.GROUND(GROUND),
    .OUT1(_199_),
    .IN1(_035_),
    .IN2(_033_),
    .IN3(_028_),
    .IN4(_022_),
    .VDD(VDD));
 NOR200 _459_ (.GROUND(GROUND),
    .OUT1(_200_),
    .IN1(_032_),
    .IN2(_030_),
    .VDD(VDD));
 NOR200 _460_ (.GROUND(GROUND),
    .OUT1(_201_),
    .IN1(_042_),
    .IN2(_027_),
    .VDD(VDD));
 NOR300 _461_ (.GROUND(GROUND),
    .OUT1(_202_),
    .IN1(_000_),
    .IN2(_040_),
    .IN3(_038_),
    .VDD(VDD));
 NND400 _462_ (.GROUND(GROUND),
    .OUT1(_203_),
    .IN1(_199_),
    .IN2(_200_),
    .IN3(_201_),
    .IN4(_202_),
    .VDD(VDD));
 NOR200 _463_ (.GROUND(GROUND),
    .OUT1(_204_),
    .IN1(_198_),
    .IN2(_203_),
    .VDD(VDD));
 NND200 _464_ (.GROUND(GROUND),
    .OUT1(_205_),
    .IN1(\u_core.u_sleep.state ),
    .IN2(_193_),
    .VDD(VDD));
 NND300 _465_ (.GROUND(GROUND),
    .OUT1(_206_),
    .IN1(_364_),
    .IN2(_193_),
    .IN3(_204_),
    .VDD(VDD));
 NND200 _466_ (.GROUND(GROUND),
    .OUT1(_365_),
    .IN1(_205_),
    .IN2(_206_),
    .VDD(VDD));
 NOR200 _467_ (.GROUND(GROUND),
    .OUT1(_207_),
    .IN1(_364_),
    .IN2(_192_),
    .VDD(VDD));
 NOR200 _468_ (.GROUND(GROUND),
    .OUT1(_208_),
    .IN1(_204_),
    .IN2(_207_),
    .VDD(VDD));
 NND200 _469_ (.GROUND(GROUND),
    .OUT1(_209_),
    .IN1(\u_core.u_sleep.state ),
    .IN2(_364_),
    .VDD(VDD));
 NOR200 _470_ (.GROUND(GROUND),
    .OUT1(_210_),
    .IN1(\u_core.u_sleep.state ),
    .IN2(_192_),
    .VDD(VDD));
 OR2100 _471_ (.GROUND(GROUND),
    .OUT1(_211_),
    .IN1(\u_core.u_sleep.state ),
    .IN2(_192_),
    .VDD(VDD));
 OR2100 _472_ (.GROUND(GROUND),
    .OUT1(_212_),
    .IN1(_207_),
    .IN2(_210_),
    .VDD(VDD));
 NND200 _473_ (.GROUND(GROUND),
    .OUT1(_213_),
    .IN1(_193_),
    .IN2(_209_),
    .VDD(VDD));
 NOR200 _474_ (.GROUND(GROUND),
    .OUT1(_214_),
    .IN1(_208_),
    .IN2(_213_),
    .VDD(VDD));
 ORND00 _475_ (.GROUND(GROUND),
    .OUT1(_215_),
    .IN1(_204_),
    .IN2(_207_),
    .IN3(_212_),
    .VDD(VDD));
 AND400 _476_ (.GROUND(GROUND),
    .OUT1(_216_),
    .IN1(\u_core.u_sleep.idle_cnt[0] ),
    .IN2(\u_core.u_sleep.idle_cnt[3] ),
    .IN3(\u_core.u_sleep.idle_cnt[5] ),
    .IN4(\u_core.u_sleep.idle_cnt[6] ),
    .VDD(VDD));
 AND400 _477_ (.GROUND(GROUND),
    .OUT1(_217_),
    .IN1(\u_core.u_sleep.idle_cnt[2] ),
    .IN2(\u_core.u_sleep.idle_cnt[7] ),
    .IN3(\u_core.u_sleep.idle_cnt[4] ),
    .IN4(\u_core.u_sleep.idle_cnt[1] ),
    .VDD(VDD));
 AND500 _478_ (.GROUND(GROUND),
    .OUT1(_218_),
    .IN1(\u_core.u_sleep.idle_cnt[2] ),
    .IN2(\u_core.u_sleep.idle_cnt[4] ),
    .IN3(\u_core.u_sleep.idle_cnt[1] ),
    .IN4(\u_core.u_sleep.idle_cnt[0] ),
    .IN5(\u_core.u_sleep.idle_cnt[3] ),
    .VDD(VDD));
 AND300 _479_ (.GROUND(GROUND),
    .OUT1(_219_),
    .IN1(\u_core.u_sleep.idle_cnt[5] ),
    .IN2(\u_core.u_sleep.idle_cnt[6] ),
    .IN3(_218_),
    .VDD(VDD));
 AND300 _480_ (.GROUND(GROUND),
    .OUT1(_220_),
    .IN1(\u_core.u_sleep.idle_cnt[8] ),
    .IN2(_216_),
    .IN3(_217_),
    .VDD(VDD));
 AND500 _481_ (.GROUND(GROUND),
    .OUT1(_221_),
    .IN1(\u_core.u_sleep.idle_cnt[8] ),
    .IN2(\u_core.u_sleep.idle_cnt[9] ),
    .IN3(\u_core.u_sleep.idle_cnt[10] ),
    .IN4(_216_),
    .IN5(_217_),
    .VDD(VDD));
 AND300 _482_ (.GROUND(GROUND),
    .OUT1(_222_),
    .IN1(\u_core.u_sleep.idle_cnt[12] ),
    .IN2(\u_core.u_sleep.idle_cnt[11] ),
    .IN3(_221_),
    .VDD(VDD));
 AND500 _483_ (.GROUND(GROUND),
    .OUT1(_223_),
    .IN1(\u_core.u_sleep.idle_cnt[13] ),
    .IN2(\u_core.u_sleep.idle_cnt[14] ),
    .IN3(\u_core.u_sleep.idle_cnt[12] ),
    .IN4(\u_core.u_sleep.idle_cnt[11] ),
    .IN5(_221_),
    .VDD(VDD));
 NND300 _484_ (.GROUND(GROUND),
    .OUT1(_224_),
    .IN1(\u_core.u_sleep.idle_cnt[15] ),
    .IN2(\u_core.u_sleep.idle_cnt[16] ),
    .IN3(_223_),
    .VDD(VDD));
 INVR00 _485_ (.GROUND(GROUND),
    .OUT1(_225_),
    .IN1(_224_),
    .VDD(VDD));
 AND500 _486_ (.GROUND(GROUND),
    .OUT1(_226_),
    .IN1(\u_core.u_sleep.idle_cnt[15] ),
    .IN2(\u_core.u_sleep.idle_cnt[17] ),
    .IN3(\u_core.u_sleep.idle_cnt[18] ),
    .IN4(\u_core.u_sleep.idle_cnt[16] ),
    .IN5(_223_),
    .VDD(VDD));
 INVR00 _487_ (.GROUND(GROUND),
    .OUT1(_227_),
    .IN1(_226_),
    .VDD(VDD));
 NND200 _488_ (.GROUND(GROUND),
    .OUT1(_228_),
    .IN1(\u_core.u_sleep.idle_cnt[19] ),
    .IN2(_226_),
    .VDD(VDD));
 NND300 _489_ (.GROUND(GROUND),
    .OUT1(_229_),
    .IN1(\u_core.u_sleep.idle_cnt[20] ),
    .IN2(\u_core.u_sleep.idle_cnt[19] ),
    .IN3(_226_),
    .VDD(VDD));
 AND400 _490_ (.GROUND(GROUND),
    .OUT1(_230_),
    .IN1(\u_core.u_sleep.idle_cnt[21] ),
    .IN2(\u_core.u_sleep.idle_cnt[20] ),
    .IN3(\u_core.u_sleep.idle_cnt[19] ),
    .IN4(_226_),
    .VDD(VDD));
 NND200 _491_ (.GROUND(GROUND),
    .OUT1(_231_),
    .IN1(\u_core.u_sleep.idle_cnt[22] ),
    .IN2(_230_),
    .VDD(VDD));
 NOR200 _492_ (.GROUND(GROUND),
    .OUT1(_232_),
    .IN1(_211_),
    .IN2(_214_),
    .VDD(VDD));
 ADNR00 _493_ (.GROUND(GROUND),
    .OUT1(_233_),
    .IN1(_231_),
    .IN2(_232_),
    .IN3(_214_),
    .VDD(VDD));
 ADNR00 _494_ (.GROUND(GROUND),
    .OUT1(_234_),
    .IN1(_230_),
    .IN2(_232_),
    .IN3(\u_core.u_sleep.idle_cnt[22] ),
    .VDD(VDD));
 NOR200 _495_ (.GROUND(GROUND),
    .OUT1(_060_),
    .IN1(_233_),
    .IN2(_234_),
    .VDD(VDD));
 XNR200 _496_ (.GROUND(GROUND),
    .OUT1(_235_),
    .IN1(\u_core.u_sleep.idle_cnt[21] ),
    .IN2(_229_),
    .VDD(VDD));
 AOI400 _497_ (.GROUND(GROUND),
    .OUT1(_236_),
    .IN1(\u_core.u_sleep.idle_cnt[21] ),
    .IN2(_214_),
    .IN3(_232_),
    .IN4(_235_),
    .VDD(VDD));
 INVR00 _498_ (.GROUND(GROUND),
    .OUT1(_061_),
    .IN1(_236_),
    .VDD(VDD));
 XNR200 _499_ (.GROUND(GROUND),
    .OUT1(_237_),
    .IN1(\u_core.u_sleep.idle_cnt[20] ),
    .IN2(_228_),
    .VDD(VDD));
 AOI400 _500_ (.GROUND(GROUND),
    .OUT1(_238_),
    .IN1(\u_core.u_sleep.idle_cnt[20] ),
    .IN2(_214_),
    .IN3(_232_),
    .IN4(_237_),
    .VDD(VDD));
 INVR00 _501_ (.GROUND(GROUND),
    .OUT1(_062_),
    .IN1(_238_),
    .VDD(VDD));
 XOR200 _502_ (.GROUND(GROUND),
    .OUT1(_239_),
    .IN1(\u_core.u_sleep.idle_cnt[19] ),
    .IN2(_226_),
    .VDD(VDD));
 AOI400 _503_ (.GROUND(GROUND),
    .OUT1(_240_),
    .IN1(\u_core.u_sleep.idle_cnt[19] ),
    .IN2(_214_),
    .IN3(_232_),
    .IN4(_239_),
    .VDD(VDD));
 INVR00 _504_ (.GROUND(GROUND),
    .OUT1(_063_),
    .IN1(_240_),
    .VDD(VDD));
 ADNR00 _505_ (.GROUND(GROUND),
    .OUT1(_241_),
    .IN1(\u_core.u_sleep.idle_cnt[17] ),
    .IN2(_225_),
    .IN3(\u_core.u_sleep.idle_cnt[18] ),
    .VDD(VDD));
 AOI400 _506_ (.GROUND(GROUND),
    .OUT1(_242_),
    .IN1(\u_core.u_sleep.idle_cnt[18] ),
    .IN2(_214_),
    .IN3(_227_),
    .IN4(_232_),
    .VDD(VDD));
 NOR200 _507_ (.GROUND(GROUND),
    .OUT1(_064_),
    .IN1(_241_),
    .IN2(_242_),
    .VDD(VDD));
 ADNR00 _508_ (.GROUND(GROUND),
    .OUT1(_243_),
    .IN1(_225_),
    .IN2(_232_),
    .IN3(\u_core.u_sleep.idle_cnt[17] ),
    .VDD(VDD));
 ORND00 _509_ (.GROUND(GROUND),
    .OUT1(_244_),
    .IN1(_214_),
    .IN2(_224_),
    .IN3(_212_),
    .VDD(VDD));
 ADNR00 _510_ (.GROUND(GROUND),
    .OUT1(_065_),
    .IN1(\u_core.u_sleep.idle_cnt[17] ),
    .IN2(_244_),
    .IN3(_243_),
    .VDD(VDD));
 AND300 _511_ (.GROUND(GROUND),
    .OUT1(_245_),
    .IN1(\u_core.u_sleep.idle_cnt[15] ),
    .IN2(_215_),
    .IN3(_223_),
    .VDD(VDD));
 NOR200 _512_ (.GROUND(GROUND),
    .OUT1(_246_),
    .IN1(\u_core.u_sleep.idle_cnt[16] ),
    .IN2(_245_),
    .VDD(VDD));
 NOR200 _513_ (.GROUND(GROUND),
    .OUT1(_066_),
    .IN1(_244_),
    .IN2(_246_),
    .VDD(VDD));
 NND200 _514_ (.GROUND(GROUND),
    .OUT1(_247_),
    .IN1(_223_),
    .IN2(_232_),
    .VDD(VDD));
 ORND00 _515_ (.GROUND(GROUND),
    .OUT1(_248_),
    .IN1(_211_),
    .IN2(_223_),
    .IN3(_215_),
    .VDD(VDD));
 NND200 _516_ (.GROUND(GROUND),
    .OUT1(_249_),
    .IN1(\u_core.u_sleep.idle_cnt[15] ),
    .IN2(_248_),
    .VDD(VDD));
 ORND00 _517_ (.GROUND(GROUND),
    .OUT1(_067_),
    .IN1(\u_core.u_sleep.idle_cnt[15] ),
    .IN2(_247_),
    .IN3(_249_),
    .VDD(VDD));
 AND300 _518_ (.GROUND(GROUND),
    .OUT1(_250_),
    .IN1(\u_core.u_sleep.idle_cnt[13] ),
    .IN2(_215_),
    .IN3(_222_),
    .VDD(VDD));
 ORND00 _519_ (.GROUND(GROUND),
    .OUT1(_251_),
    .IN1(\u_core.u_sleep.idle_cnt[14] ),
    .IN2(_250_),
    .IN3(_248_),
    .VDD(VDD));
 INVR00 _520_ (.GROUND(GROUND),
    .OUT1(_068_),
    .IN1(_251_),
    .VDD(VDD));
 NND200 _521_ (.GROUND(GROUND),
    .OUT1(_252_),
    .IN1(_222_),
    .IN2(_232_),
    .VDD(VDD));
 NOR200 _522_ (.GROUND(GROUND),
    .OUT1(_253_),
    .IN1(_211_),
    .IN2(_222_),
    .VDD(VDD));
 NOR200 _523_ (.GROUND(GROUND),
    .OUT1(_254_),
    .IN1(_214_),
    .IN2(_253_),
    .VDD(VDD));
 MX2100 _524_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[13] ),
    .D0(_252_),
    .OUT1(_069_),
    .D1(_254_),
    .VDD(VDD));
 AND300 _525_ (.GROUND(GROUND),
    .OUT1(_255_),
    .IN1(\u_core.u_sleep.idle_cnt[11] ),
    .IN2(_215_),
    .IN3(_221_),
    .VDD(VDD));
 NOR200 _526_ (.GROUND(GROUND),
    .OUT1(_256_),
    .IN1(\u_core.u_sleep.idle_cnt[12] ),
    .IN2(_255_),
    .VDD(VDD));
 NOR200 _527_ (.GROUND(GROUND),
    .OUT1(_070_),
    .IN1(_254_),
    .IN2(_256_),
    .VDD(VDD));
 NND200 _528_ (.GROUND(GROUND),
    .OUT1(_257_),
    .IN1(_221_),
    .IN2(_232_),
    .VDD(VDD));
 NOR200 _529_ (.GROUND(GROUND),
    .OUT1(_258_),
    .IN1(_211_),
    .IN2(_221_),
    .VDD(VDD));
 NOR200 _530_ (.GROUND(GROUND),
    .OUT1(_259_),
    .IN1(_214_),
    .IN2(_258_),
    .VDD(VDD));
 MX2100 _531_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[11] ),
    .D0(_257_),
    .OUT1(_071_),
    .D1(_259_),
    .VDD(VDD));
 AND300 _532_ (.GROUND(GROUND),
    .OUT1(_260_),
    .IN1(\u_core.u_sleep.idle_cnt[9] ),
    .IN2(_215_),
    .IN3(_220_),
    .VDD(VDD));
 NOR200 _533_ (.GROUND(GROUND),
    .OUT1(_261_),
    .IN1(\u_core.u_sleep.idle_cnt[10] ),
    .IN2(_260_),
    .VDD(VDD));
 NOR200 _534_ (.GROUND(GROUND),
    .OUT1(_072_),
    .IN1(_259_),
    .IN2(_261_),
    .VDD(VDD));
 NND200 _535_ (.GROUND(GROUND),
    .OUT1(_262_),
    .IN1(_220_),
    .IN2(_232_),
    .VDD(VDD));
 NOR200 _536_ (.GROUND(GROUND),
    .OUT1(_263_),
    .IN1(_211_),
    .IN2(_220_),
    .VDD(VDD));
 NOR200 _537_ (.GROUND(GROUND),
    .OUT1(_264_),
    .IN1(_214_),
    .IN2(_263_),
    .VDD(VDD));
 MX2100 _538_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[9] ),
    .D0(_262_),
    .OUT1(_073_),
    .D1(_264_),
    .VDD(VDD));
 AND300 _539_ (.GROUND(GROUND),
    .OUT1(_265_),
    .IN1(\u_core.u_sleep.idle_cnt[7] ),
    .IN2(_215_),
    .IN3(_219_),
    .VDD(VDD));
 NOR200 _540_ (.GROUND(GROUND),
    .OUT1(_266_),
    .IN1(\u_core.u_sleep.idle_cnt[8] ),
    .IN2(_265_),
    .VDD(VDD));
 NOR200 _541_ (.GROUND(GROUND),
    .OUT1(_074_),
    .IN1(_264_),
    .IN2(_266_),
    .VDD(VDD));
 AND300 _542_ (.GROUND(GROUND),
    .OUT1(_267_),
    .IN1(\u_core.u_sleep.idle_cnt[1] ),
    .IN2(\u_core.u_sleep.idle_cnt[0] ),
    .IN3(_215_),
    .VDD(VDD));
 AND200 _543_ (.GROUND(GROUND),
    .OUT1(_268_),
    .IN1(\u_core.u_sleep.idle_cnt[2] ),
    .IN2(_267_),
    .VDD(VDD));
 NND200 _544_ (.GROUND(GROUND),
    .OUT1(_269_),
    .IN1(_215_),
    .IN2(_218_),
    .VDD(VDD));
 NOR200 _545_ (.GROUND(GROUND),
    .OUT1(_270_),
    .IN1(_137_),
    .IN2(_269_),
    .VDD(VDD));
 NND200 _546_ (.GROUND(GROUND),
    .OUT1(_271_),
    .IN1(_215_),
    .IN2(_219_),
    .VDD(VDD));
 NND200 _547_ (.GROUND(GROUND),
    .OUT1(_272_),
    .IN1(_212_),
    .IN2(_271_),
    .VDD(VDD));
 OR2100 _548_ (.GROUND(GROUND),
    .OUT1(_273_),
    .IN1(_211_),
    .IN2(_271_),
    .VDD(VDD));
 MX2100 _549_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[7] ),
    .D0(_273_),
    .OUT1(_075_),
    .D1(_272_),
    .VDD(VDD));
 NOR200 _550_ (.GROUND(GROUND),
    .OUT1(_274_),
    .IN1(\u_core.u_sleep.idle_cnt[6] ),
    .IN2(_270_),
    .VDD(VDD));
 NOR200 _551_ (.GROUND(GROUND),
    .OUT1(_076_),
    .IN1(_272_),
    .IN2(_274_),
    .VDD(VDD));
 NND200 _552_ (.GROUND(GROUND),
    .OUT1(_275_),
    .IN1(_212_),
    .IN2(_269_),
    .VDD(VDD));
 NND300 _553_ (.GROUND(GROUND),
    .OUT1(_276_),
    .IN1(_137_),
    .IN2(_218_),
    .IN3(_232_),
    .VDD(VDD));
 ORND00 _554_ (.GROUND(GROUND),
    .OUT1(_077_),
    .IN1(_137_),
    .IN2(_275_),
    .IN3(_276_),
    .VDD(VDD));
 ADNR00 _555_ (.GROUND(GROUND),
    .OUT1(_277_),
    .IN1(\u_core.u_sleep.idle_cnt[3] ),
    .IN2(_268_),
    .IN3(\u_core.u_sleep.idle_cnt[4] ),
    .VDD(VDD));
 NOR200 _556_ (.GROUND(GROUND),
    .OUT1(_078_),
    .IN1(_275_),
    .IN2(_277_),
    .VDD(VDD));
 NND200 _557_ (.GROUND(GROUND),
    .OUT1(_278_),
    .IN1(_210_),
    .IN2(_268_),
    .VDD(VDD));
 OR2100 _558_ (.GROUND(GROUND),
    .OUT1(_279_),
    .IN1(_213_),
    .IN2(_268_),
    .VDD(VDD));
 MX2100 _559_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[3] ),
    .D0(_278_),
    .OUT1(_079_),
    .D1(_279_),
    .VDD(VDD));
 NOR200 _560_ (.GROUND(GROUND),
    .OUT1(_280_),
    .IN1(\u_core.u_sleep.idle_cnt[2] ),
    .IN2(_267_),
    .VDD(VDD));
 NOR200 _561_ (.GROUND(GROUND),
    .OUT1(_080_),
    .IN1(_279_),
    .IN2(_280_),
    .VDD(VDD));
 ADNR00 _562_ (.GROUND(GROUND),
    .OUT1(_281_),
    .IN1(\u_core.u_sleep.idle_cnt[0] ),
    .IN2(_215_),
    .IN3(\u_core.u_sleep.idle_cnt[1] ),
    .VDD(VDD));
 NOR300 _563_ (.GROUND(GROUND),
    .OUT1(_081_),
    .IN1(_213_),
    .IN2(_267_),
    .IN3(_281_),
    .VDD(VDD));
 AOI400 _564_ (.GROUND(GROUND),
    .OUT1(_282_),
    .IN1(\u_core.u_sleep.idle_cnt[0] ),
    .IN2(_214_),
    .IN3(_232_),
    .IN4(_353_),
    .VDD(VDD));
 INVR00 _565_ (.GROUND(GROUND),
    .OUT1(_082_),
    .IN1(_282_),
    .VDD(VDD));
 NOR400 _566_ (.GROUND(GROUND),
    .OUT1(_283_),
    .IN1(_019_),
    .IN2(_016_),
    .IN3(_017_),
    .IN4(_014_),
    .VDD(VDD));
 NOR400 _567_ (.GROUND(GROUND),
    .OUT1(_284_),
    .IN1(_351_),
    .IN2(_020_),
    .IN3(_057_),
    .IN4(_018_),
    .VDD(VDD));
 AND200 _568_ (.GROUND(GROUND),
    .OUT1(_285_),
    .IN1(_283_),
    .IN2(_284_),
    .VDD(VDD));
 NND200 _569_ (.GROUND(GROUND),
    .OUT1(_286_),
    .IN1(_283_),
    .IN2(_284_),
    .VDD(VDD));
 NOR400 _570_ (.GROUND(GROUND),
    .OUT1(_287_),
    .IN1(_007_),
    .IN2(_004_),
    .IN3(_005_),
    .IN4(_003_),
    .VDD(VDD));
 NOR400 _571_ (.GROUND(GROUND),
    .OUT1(_288_),
    .IN1(_011_),
    .IN2(_008_),
    .IN3(_009_),
    .IN4(_006_),
    .VDD(VDD));
 NOR400 _572_ (.GROUND(GROUND),
    .OUT1(_289_),
    .IN1(_015_),
    .IN2(_012_),
    .IN3(_013_),
    .IN4(_010_),
    .VDD(VDD));
 AND300 _573_ (.GROUND(GROUND),
    .OUT1(_290_),
    .IN1(_287_),
    .IN2(_288_),
    .IN3(_289_),
    .VDD(VDD));
 NND300 _574_ (.GROUND(GROUND),
    .OUT1(_291_),
    .IN1(_287_),
    .IN2(_288_),
    .IN3(_289_),
    .VDD(VDD));
 ADNR00 _575_ (.GROUND(GROUND),
    .OUT1(_292_),
    .IN1(_285_),
    .IN2(_290_),
    .IN3(_141_),
    .VDD(VDD));
 ORND00 _576_ (.GROUND(GROUND),
    .OUT1(_293_),
    .IN1(_286_),
    .IN2(_291_),
    .IN3(\u_core.u_blink.running ),
    .VDD(VDD));
 NND400 _577_ (.GROUND(GROUND),
    .OUT1(_294_),
    .IN1(\u_core.u_blink.cnt[6] ),
    .IN2(\u_core.u_blink.cnt[15] ),
    .IN3(\u_core.u_blink.cnt[13] ),
    .IN4(\u_core.u_blink.cnt[7] ),
    .VDD(VDD));
 NND400 _578_ (.GROUND(GROUND),
    .OUT1(_295_),
    .IN1(\u_core.u_blink.cnt[14] ),
    .IN2(\u_core.u_blink.cnt[2] ),
    .IN3(\u_core.u_blink.cnt[4] ),
    .IN4(\u_core.u_blink.cnt[12] ),
    .VDD(VDD));
 AND400 _579_ (.GROUND(GROUND),
    .OUT1(_296_),
    .IN1(\u_core.u_blink.cnt[8] ),
    .IN2(\u_core.u_blink.cnt[11] ),
    .IN3(\u_core.u_blink.cnt[10] ),
    .IN4(\u_core.u_blink.cnt[9] ),
    .VDD(VDD));
 NND500 _580_ (.GROUND(GROUND),
    .OUT1(_297_),
    .IN1(\u_core.u_blink.cnt[5] ),
    .IN2(\u_core.u_blink.cnt[3] ),
    .IN3(\u_core.u_blink.cnt[1] ),
    .IN4(\u_core.u_blink.cnt[0] ),
    .IN5(_296_),
    .VDD(VDD));
 NOR400 _581_ (.GROUND(GROUND),
    .OUT1(_298_),
    .IN1(_293_),
    .IN2(_294_),
    .IN3(_295_),
    .IN4(_297_),
    .VDD(VDD));
 AND200 _582_ (.GROUND(GROUND),
    .OUT1(_299_),
    .IN1(\u_core.u_blink.cnt[16] ),
    .IN2(_298_),
    .VDD(VDD));
 ADNR00 _583_ (.GROUND(GROUND),
    .OUT1(_300_),
    .IN1(\u_core.u_blink.cnt[17] ),
    .IN2(_299_),
    .IN3(\u_core.u_blink.cnt[18] ),
    .VDD(VDD));
 AND400 _584_ (.GROUND(GROUND),
    .OUT1(_301_),
    .IN1(\u_core.u_blink.cnt[18] ),
    .IN2(\u_core.u_blink.cnt[16] ),
    .IN3(\u_core.u_blink.cnt[17] ),
    .IN4(_298_),
    .VDD(VDD));
 NOR300 _585_ (.GROUND(GROUND),
    .OUT1(_083_),
    .IN1(_192_),
    .IN2(_300_),
    .IN3(_301_),
    .VDD(VDD));
 ORND00 _586_ (.GROUND(GROUND),
    .OUT1(_302_),
    .IN1(\u_core.u_blink.cnt[17] ),
    .IN2(_299_),
    .IN3(_193_),
    .VDD(VDD));
 ADNR00 _587_ (.GROUND(GROUND),
    .OUT1(_084_),
    .IN1(\u_core.u_blink.cnt[17] ),
    .IN2(_299_),
    .IN3(_302_),
    .VDD(VDD));
 ORND00 _588_ (.GROUND(GROUND),
    .OUT1(_303_),
    .IN1(\u_core.u_blink.cnt[16] ),
    .IN2(_298_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _589_ (.GROUND(GROUND),
    .OUT1(_085_),
    .IN1(_299_),
    .IN2(_303_),
    .VDD(VDD));
 NND200 _590_ (.GROUND(GROUND),
    .OUT1(_111_),
    .IN1(_193_),
    .IN2(_293_),
    .VDD(VDD));
 ADNR00 _591_ (.GROUND(GROUND),
    .OUT1(_304_),
    .IN1(_193_),
    .IN2(_293_),
    .IN3(_134_),
    .VDD(VDD));
 ORND00 _592_ (.GROUND(GROUND),
    .OUT1(_305_),
    .IN1(_192_),
    .IN2(_292_),
    .IN3(\u_core.u_blink.cnt[0] ),
    .VDD(VDD));
 NOR200 _593_ (.GROUND(GROUND),
    .OUT1(_306_),
    .IN1(_133_),
    .IN2(_305_),
    .VDD(VDD));
 NOR300 _594_ (.GROUND(GROUND),
    .OUT1(_307_),
    .IN1(_129_),
    .IN2(_133_),
    .IN3(_305_),
    .VDD(VDD));
 AND400 _595_ (.GROUND(GROUND),
    .OUT1(_308_),
    .IN1(\u_core.u_blink.cnt[2] ),
    .IN2(\u_core.u_blink.cnt[3] ),
    .IN3(\u_core.u_blink.cnt[1] ),
    .IN4(_304_),
    .VDD(VDD));
 AND200 _596_ (.GROUND(GROUND),
    .OUT1(_309_),
    .IN1(\u_core.u_blink.cnt[4] ),
    .IN2(_308_),
    .VDD(VDD));
 NOR600 _597_ (.GROUND(GROUND),
    .OUT1(_310_),
    .IN1(_129_),
    .IN2(_130_),
    .IN3(_131_),
    .IN4(_132_),
    .IN5(_133_),
    .IN6(_305_),
    .VDD(VDD));
 AND200 _598_ (.GROUND(GROUND),
    .OUT1(_311_),
    .IN1(\u_core.u_blink.cnt[6] ),
    .IN2(_310_),
    .VDD(VDD));
 AND400 _599_ (.GROUND(GROUND),
    .OUT1(_312_),
    .IN1(\u_core.u_blink.cnt[6] ),
    .IN2(\u_core.u_blink.cnt[7] ),
    .IN3(_296_),
    .IN4(_310_),
    .VDD(VDD));
 AND500 _600_ (.GROUND(GROUND),
    .OUT1(_313_),
    .IN1(\u_core.u_blink.cnt[12] ),
    .IN2(\u_core.u_blink.cnt[6] ),
    .IN3(\u_core.u_blink.cnt[7] ),
    .IN4(_296_),
    .IN5(_310_),
    .VDD(VDD));
 NND600 _601_ (.GROUND(GROUND),
    .OUT1(_314_),
    .IN1(\u_core.u_blink.cnt[12] ),
    .IN2(\u_core.u_blink.cnt[6] ),
    .IN3(\u_core.u_blink.cnt[13] ),
    .IN4(\u_core.u_blink.cnt[7] ),
    .IN5(_296_),
    .IN6(_310_),
    .VDD(VDD));
 ORND00 _602_ (.GROUND(GROUND),
    .OUT1(_315_),
    .IN1(_128_),
    .IN2(_314_),
    .IN3(\u_core.u_blink.cnt[15] ),
    .VDD(VDD));
 OR3100 _603_ (.GROUND(GROUND),
    .OUT1(_316_),
    .IN1(_128_),
    .IN2(\u_core.u_blink.cnt[15] ),
    .IN3(_314_),
    .VDD(VDD));
 AND300 _604_ (.GROUND(GROUND),
    .OUT1(_317_),
    .IN1(\u_core.u_blink.cnt[6] ),
    .IN2(\u_core.u_blink.cnt[7] ),
    .IN3(_310_),
    .VDD(VDD));
 AND500 _605_ (.GROUND(GROUND),
    .OUT1(_318_),
    .IN1(\u_core.u_blink.cnt[8] ),
    .IN2(\u_core.u_blink.cnt[6] ),
    .IN3(\u_core.u_blink.cnt[9] ),
    .IN4(\u_core.u_blink.cnt[7] ),
    .IN5(_310_),
    .VDD(VDD));
 ADNR00 _606_ (.GROUND(GROUND),
    .OUT1(_086_),
    .IN1(_315_),
    .IN2(_316_),
    .IN3(_192_),
    .VDD(VDD));
 ORND00 _607_ (.GROUND(GROUND),
    .OUT1(_319_),
    .IN1(_128_),
    .IN2(_314_),
    .IN3(_193_),
    .VDD(VDD));
 ADNR00 _608_ (.GROUND(GROUND),
    .OUT1(_087_),
    .IN1(_128_),
    .IN2(_314_),
    .IN3(_319_),
    .VDD(VDD));
 NOR200 _609_ (.GROUND(GROUND),
    .OUT1(_320_),
    .IN1(\u_core.u_blink.cnt[13] ),
    .IN2(_313_),
    .VDD(VDD));
 NND200 _610_ (.GROUND(GROUND),
    .OUT1(_321_),
    .IN1(_193_),
    .IN2(_314_),
    .VDD(VDD));
 NOR200 _611_ (.GROUND(GROUND),
    .OUT1(_088_),
    .IN1(_320_),
    .IN2(_321_),
    .VDD(VDD));
 ORND00 _612_ (.GROUND(GROUND),
    .OUT1(_322_),
    .IN1(\u_core.u_blink.cnt[12] ),
    .IN2(_312_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _613_ (.GROUND(GROUND),
    .OUT1(_089_),
    .IN1(_313_),
    .IN2(_322_),
    .VDD(VDD));
 ADNR00 _614_ (.GROUND(GROUND),
    .OUT1(_323_),
    .IN1(\u_core.u_blink.cnt[10] ),
    .IN2(_318_),
    .IN3(\u_core.u_blink.cnt[11] ),
    .VDD(VDD));
 NOR300 _615_ (.GROUND(GROUND),
    .OUT1(_090_),
    .IN1(_192_),
    .IN2(_312_),
    .IN3(_323_),
    .VDD(VDD));
 ORND00 _616_ (.GROUND(GROUND),
    .OUT1(_324_),
    .IN1(\u_core.u_blink.cnt[10] ),
    .IN2(_318_),
    .IN3(_193_),
    .VDD(VDD));
 ADNR00 _617_ (.GROUND(GROUND),
    .OUT1(_091_),
    .IN1(\u_core.u_blink.cnt[10] ),
    .IN2(_318_),
    .IN3(_324_),
    .VDD(VDD));
 ADNR00 _618_ (.GROUND(GROUND),
    .OUT1(_325_),
    .IN1(\u_core.u_blink.cnt[8] ),
    .IN2(_317_),
    .IN3(\u_core.u_blink.cnt[9] ),
    .VDD(VDD));
 NOR300 _619_ (.GROUND(GROUND),
    .OUT1(_092_),
    .IN1(_192_),
    .IN2(_318_),
    .IN3(_325_),
    .VDD(VDD));
 ORND00 _620_ (.GROUND(GROUND),
    .OUT1(_326_),
    .IN1(\u_core.u_blink.cnt[8] ),
    .IN2(_317_),
    .IN3(_193_),
    .VDD(VDD));
 ADNR00 _621_ (.GROUND(GROUND),
    .OUT1(_093_),
    .IN1(\u_core.u_blink.cnt[8] ),
    .IN2(_317_),
    .IN3(_326_),
    .VDD(VDD));
 ORND00 _622_ (.GROUND(GROUND),
    .OUT1(_327_),
    .IN1(\u_core.u_blink.cnt[7] ),
    .IN2(_311_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _623_ (.GROUND(GROUND),
    .OUT1(_094_),
    .IN1(_317_),
    .IN2(_327_),
    .VDD(VDD));
 ORND00 _624_ (.GROUND(GROUND),
    .OUT1(_328_),
    .IN1(\u_core.u_blink.cnt[6] ),
    .IN2(_310_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _625_ (.GROUND(GROUND),
    .OUT1(_095_),
    .IN1(_311_),
    .IN2(_328_),
    .VDD(VDD));
 ORND00 _626_ (.GROUND(GROUND),
    .OUT1(_329_),
    .IN1(\u_core.u_blink.cnt[5] ),
    .IN2(_309_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _627_ (.GROUND(GROUND),
    .OUT1(_096_),
    .IN1(_310_),
    .IN2(_329_),
    .VDD(VDD));
 ORND00 _628_ (.GROUND(GROUND),
    .OUT1(_330_),
    .IN1(\u_core.u_blink.cnt[4] ),
    .IN2(_308_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _629_ (.GROUND(GROUND),
    .OUT1(_097_),
    .IN1(_309_),
    .IN2(_330_),
    .VDD(VDD));
 ORND00 _630_ (.GROUND(GROUND),
    .OUT1(_331_),
    .IN1(\u_core.u_blink.cnt[3] ),
    .IN2(_307_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _631_ (.GROUND(GROUND),
    .OUT1(_098_),
    .IN1(_308_),
    .IN2(_331_),
    .VDD(VDD));
 ORND00 _632_ (.GROUND(GROUND),
    .OUT1(_332_),
    .IN1(\u_core.u_blink.cnt[2] ),
    .IN2(_306_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _633_ (.GROUND(GROUND),
    .OUT1(_099_),
    .IN1(_307_),
    .IN2(_332_),
    .VDD(VDD));
 ORND00 _634_ (.GROUND(GROUND),
    .OUT1(_333_),
    .IN1(\u_core.u_blink.cnt[1] ),
    .IN2(_304_),
    .IN3(_193_),
    .VDD(VDD));
 NOR200 _635_ (.GROUND(GROUND),
    .OUT1(_100_),
    .IN1(_306_),
    .IN2(_333_),
    .VDD(VDD));
 MX2100 _636_ (.GROUND(GROUND),
    .S(_293_),
    .D0(_351_),
    .OUT1(_334_),
    .D1(\u_core.u_blink.cnt[0] ),
    .VDD(VDD));
 NOR200 _637_ (.GROUND(GROUND),
    .OUT1(_101_),
    .IN1(_192_),
    .IN2(_334_),
    .VDD(VDD));
 NOR200 _638_ (.GROUND(GROUND),
    .OUT1(_335_),
    .IN1(_189_),
    .IN2(_193_),
    .VDD(VDD));
 XNR200 _639_ (.GROUND(GROUND),
    .OUT1(_102_),
    .IN1(_135_),
    .IN2(_335_),
    .VDD(VDD));
 AND400 _640_ (.GROUND(GROUND),
    .OUT1(_336_),
    .IN1(_138_),
    .IN2(_139_),
    .IN3(_181_),
    .IN4(_192_),
    .VDD(VDD));
 NOR200 _641_ (.GROUND(GROUND),
    .OUT1(_337_),
    .IN1(\u_core.u_counter.count[1] ),
    .IN2(_192_),
    .VDD(VDD));
 ORND00 _642_ (.GROUND(GROUND),
    .OUT1(_338_),
    .IN1(_189_),
    .IN2(_193_),
    .IN3(_184_),
    .VDD(VDD));
 NOR300 _643_ (.GROUND(GROUND),
    .OUT1(_103_),
    .IN1(_336_),
    .IN2(_337_),
    .IN3(_338_),
    .VDD(VDD));
 MX2100 _644_ (.GROUND(GROUND),
    .S(_193_),
    .D0(_350_),
    .OUT1(_339_),
    .D1(\u_core.u_counter.count[0] ),
    .VDD(VDD));
 INVR00 _645_ (.GROUND(GROUND),
    .OUT1(_104_),
    .IN1(_339_),
    .VDD(VDD));
 ADNR00 _646_ (.GROUND(GROUND),
    .OUT1(_340_),
    .IN1(_135_),
    .IN2(\u_core.u_counter.count[1] ),
    .IN3(_178_),
    .VDD(VDD));
 ORND00 _647_ (.GROUND(GROUND),
    .OUT1(\seg_c[6] ),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(_340_),
    .IN3(_180_),
    .VDD(VDD));
 MX2100 _648_ (.GROUND(GROUND),
    .S(_160_),
    .D0(\u_core.u_debounce.btn_sync_1 ),
    .OUT1(_341_),
    .D1(\u_core.u_debounce.btn_out ),
    .VDD(VDD));
 INVR00 _649_ (.GROUND(GROUND),
    .OUT1(_105_),
    .IN1(_341_),
    .VDD(VDD));
 XNR200 _650_ (.GROUND(GROUND),
    .OUT1(_342_),
    .IN1(\u_core.u_blink.cnt[19] ),
    .IN2(_301_),
    .VDD(VDD));
 NOR200 _651_ (.GROUND(GROUND),
    .OUT1(_106_),
    .IN1(_192_),
    .IN2(_342_),
    .VDD(VDD));
 NOR300 _652_ (.GROUND(GROUND),
    .OUT1(_343_),
    .IN1(_141_),
    .IN2(_286_),
    .IN3(_291_),
    .VDD(VDD));
 ORND00 _653_ (.GROUND(GROUND),
    .OUT1(_107_),
    .IN1(_140_),
    .IN2(_343_),
    .IN3(_193_),
    .VDD(VDD));
 XNR200 _654_ (.GROUND(GROUND),
    .OUT1(_344_),
    .IN1(\u_core.u_debounce.stable_cnt[15] ),
    .IN2(_154_),
    .VDD(VDD));
 NOR200 _655_ (.GROUND(GROUND),
    .OUT1(_118_),
    .IN1(_162_),
    .IN2(_344_),
    .VDD(VDD));
 AND300 _656_ (.GROUND(GROUND),
    .OUT1(_345_),
    .IN1(\u_core.u_counter.count[3] ),
    .IN2(\u_core.u_counter.count[2] ),
    .IN3(_335_),
    .VDD(VDD));
 ADNR00 _657_ (.GROUND(GROUND),
    .OUT1(_346_),
    .IN1(\u_core.u_counter.count[2] ),
    .IN2(_335_),
    .IN3(\u_core.u_counter.count[3] ),
    .VDD(VDD));
 NOR300 _658_ (.GROUND(GROUND),
    .OUT1(_108_),
    .IN1(_336_),
    .IN2(_345_),
    .IN3(_346_),
    .VDD(VDD));
 NND300 _659_ (.GROUND(GROUND),
    .OUT1(_347_),
    .IN1(\u_core.u_sleep.idle_cnt[22] ),
    .IN2(_230_),
    .IN3(_232_),
    .VDD(VDD));
 MX2100 _660_ (.GROUND(GROUND),
    .S(\u_core.u_sleep.idle_cnt[23] ),
    .D0(_347_),
    .OUT1(_109_),
    .D1(_233_),
    .VDD(VDD));
 NND200 _661_ (.GROUND(GROUND),
    .OUT1(_348_),
    .IN1(\u_core.u_sleep.state ),
    .IN2(_192_),
    .VDD(VDD));
 NND200 _662_ (.GROUND(GROUND),
    .OUT1(_349_),
    .IN1(\u_core.u_sleep.sleep_out ),
    .IN2(_348_),
    .VDD(VDD));
 NND300 _663_ (.GROUND(GROUND),
    .OUT1(_110_),
    .IN1(_206_),
    .IN2(_209_),
    .IN3(_349_),
    .VDD(VDD));
 DFCL11 _664_ (.Q(\u_core.u_counter.count[0] ),
    .GROUND(GROUND),
    .C(clknet_5_21_0_clk_c),
    .D(_104_),
    .QB(_350_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _665_ (.Q(\u_core.u_counter.count[1] ),
    .GROUND(GROUND),
    .C(clknet_5_21_0_clk_c),
    .D(_103_),
    .QB(_002_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _666_ (.Q(\u_core.u_counter.count[2] ),
    .GROUND(GROUND),
    .C(clknet_5_23_0_clk_c),
    .D(_102_),
    .QB(_357_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _667_ (.Q(\u_core.u_counter.count[3] ),
    .GROUND(GROUND),
    .C(clknet_5_20_0_clk_c),
    .D(_108_),
    .QB(_058_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _668_ (.Q(\u_core.u_debounce.btn_out ),
    .GROUND(GROUND),
    .C(clknet_5_7_0_clk_c),
    .D(_105_),
    .QB(_356_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _669_ (.Q(\u_core.u_blink.cnt[0] ),
    .GROUND(GROUND),
    .C(clknet_5_0_0_clk_c),
    .D(_101_),
    .QB(_351_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _670_ (.Q(\u_core.u_blink.cnt[1] ),
    .GROUND(GROUND),
    .C(clknet_5_4_0_clk_c),
    .D(_100_),
    .QB(_003_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _671_ (.Q(\u_core.u_blink.cnt[2] ),
    .GROUND(GROUND),
    .C(clknet_5_5_0_clk_c),
    .D(_099_),
    .QB(_004_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _672_ (.Q(\u_core.u_blink.cnt[3] ),
    .GROUND(GROUND),
    .C(clknet_5_5_0_clk_c),
    .D(_098_),
    .QB(_005_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _673_ (.Q(\u_core.u_blink.cnt[4] ),
    .GROUND(GROUND),
    .C(clknet_5_16_0_clk_c),
    .D(_097_),
    .QB(_006_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _674_ (.Q(\u_core.u_blink.cnt[5] ),
    .GROUND(GROUND),
    .C(clknet_5_16_0_clk_c),
    .D(_096_),
    .QB(_007_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _675_ (.Q(\u_core.u_blink.cnt[6] ),
    .GROUND(GROUND),
    .C(clknet_5_16_0_clk_c),
    .D(_095_),
    .QB(_008_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _676_ (.Q(\u_core.u_blink.cnt[7] ),
    .GROUND(GROUND),
    .C(clknet_5_17_0_clk_c),
    .D(_094_),
    .QB(_009_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _677_ (.Q(\u_core.u_blink.cnt[8] ),
    .GROUND(GROUND),
    .C(clknet_5_20_0_clk_c),
    .D(_093_),
    .QB(_010_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _678_ (.Q(\u_core.u_blink.cnt[9] ),
    .GROUND(GROUND),
    .C(clknet_5_17_0_clk_c),
    .D(_092_),
    .QB(_011_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _679_ (.Q(\u_core.u_blink.cnt[10] ),
    .GROUND(GROUND),
    .C(clknet_5_20_0_clk_c),
    .D(_091_),
    .QB(_012_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _680_ (.Q(\u_core.u_blink.cnt[11] ),
    .GROUND(GROUND),
    .C(clknet_5_22_0_clk_c),
    .D(_090_),
    .QB(_013_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _681_ (.Q(\u_core.u_blink.cnt[12] ),
    .GROUND(GROUND),
    .C(clknet_5_18_0_clk_c),
    .D(_089_),
    .QB(_014_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _682_ (.Q(\u_core.u_blink.cnt[13] ),
    .GROUND(GROUND),
    .C(clknet_5_19_0_clk_c),
    .D(_088_),
    .QB(_015_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _683_ (.Q(\u_core.u_blink.cnt[14] ),
    .GROUND(GROUND),
    .C(clknet_5_18_0_clk_c),
    .D(_087_),
    .QB(_016_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _684_ (.Q(\u_core.u_blink.cnt[15] ),
    .GROUND(GROUND),
    .C(clknet_5_19_0_clk_c),
    .D(_086_),
    .QB(_017_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _685_ (.Q(\u_core.u_blink.cnt[16] ),
    .GROUND(GROUND),
    .C(clknet_5_4_0_clk_c),
    .D(_085_),
    .QB(_018_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _686_ (.Q(\u_core.u_blink.cnt[17] ),
    .GROUND(GROUND),
    .C(clknet_5_24_0_clk_c),
    .D(_084_),
    .QB(_019_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _687_ (.Q(\u_core.u_blink.cnt[18] ),
    .GROUND(GROUND),
    .C(clknet_5_3_0_clk_c),
    .D(_083_),
    .QB(_020_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _688_ (.Q(\u_core.u_blink.cnt[19] ),
    .GROUND(GROUND),
    .C(clknet_5_0_0_clk_c),
    .D(_106_),
    .QB(_057_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _689_ (.Q(\u_core.u_blink.pulse ),
    .GROUND(GROUND),
    .C(clknet_5_1_0_clk_c),
    .D(_107_),
    .QB(_358_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _690_ (.Q(\u_core.u_sleep.idle_cnt[0] ),
    .GROUND(GROUND),
    .C(clknet_5_4_0_clk_c),
    .D(_082_),
    .QB(_353_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _691_ (.Q(\u_core.u_sleep.idle_cnt[1] ),
    .GROUND(GROUND),
    .C(clknet_5_2_0_clk_c),
    .D(_081_),
    .QB(_021_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _692_ (.Q(\u_core.u_sleep.idle_cnt[2] ),
    .GROUND(GROUND),
    .C(clknet_5_12_0_clk_c),
    .D(_080_),
    .QB(_022_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _693_ (.Q(\u_core.u_sleep.idle_cnt[3] ),
    .GROUND(GROUND),
    .C(clknet_5_9_0_clk_c),
    .D(_079_),
    .QB(_023_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _694_ (.Q(\u_core.u_sleep.idle_cnt[4] ),
    .GROUND(GROUND),
    .C(clknet_5_9_0_clk_c),
    .D(_078_),
    .QB(_024_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _695_ (.Q(\u_core.u_sleep.idle_cnt[5] ),
    .GROUND(GROUND),
    .C(clknet_5_2_0_clk_c),
    .D(_077_),
    .QB(_025_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _696_ (.Q(\u_core.u_sleep.idle_cnt[6] ),
    .GROUND(GROUND),
    .C(clknet_5_2_0_clk_c),
    .D(_076_),
    .QB(_026_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _697_ (.Q(\u_core.u_sleep.idle_cnt[7] ),
    .GROUND(GROUND),
    .C(clknet_5_8_0_clk_c),
    .D(_075_),
    .QB(_027_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _698_ (.Q(\u_core.u_sleep.idle_cnt[8] ),
    .GROUND(GROUND),
    .C(clknet_5_11_0_clk_c),
    .D(_074_),
    .QB(_028_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _699_ (.Q(\u_core.u_sleep.idle_cnt[9] ),
    .GROUND(GROUND),
    .C(clknet_5_8_0_clk_c),
    .D(_073_),
    .QB(_029_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _700_ (.Q(\u_core.u_sleep.idle_cnt[10] ),
    .GROUND(GROUND),
    .C(clknet_5_10_0_clk_c),
    .D(_072_),
    .QB(_030_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _701_ (.Q(\u_core.u_sleep.idle_cnt[11] ),
    .GROUND(GROUND),
    .C(clknet_5_8_0_clk_c),
    .D(_071_),
    .QB(_031_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _702_ (.Q(\u_core.u_sleep.idle_cnt[12] ),
    .GROUND(GROUND),
    .C(clknet_5_10_0_clk_c),
    .D(_070_),
    .QB(_032_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _703_ (.Q(\u_core.u_sleep.idle_cnt[13] ),
    .GROUND(GROUND),
    .C(clknet_5_11_0_clk_c),
    .D(_069_),
    .QB(_033_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _704_ (.Q(\u_core.u_sleep.idle_cnt[14] ),
    .GROUND(GROUND),
    .C(clknet_5_12_0_clk_c),
    .D(_068_),
    .QB(_034_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _705_ (.Q(\u_core.u_sleep.idle_cnt[15] ),
    .GROUND(GROUND),
    .C(clknet_5_13_0_clk_c),
    .D(_067_),
    .QB(_035_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _706_ (.Q(\u_core.u_sleep.idle_cnt[16] ),
    .GROUND(GROUND),
    .C(clknet_5_12_0_clk_c),
    .D(_066_),
    .QB(_036_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _707_ (.Q(\u_core.u_sleep.idle_cnt[17] ),
    .GROUND(GROUND),
    .C(clknet_5_6_0_clk_c),
    .D(_065_),
    .QB(_037_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _708_ (.Q(\u_core.u_sleep.idle_cnt[18] ),
    .GROUND(GROUND),
    .C(clknet_5_14_0_clk_c),
    .D(_064_),
    .QB(_038_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _709_ (.Q(\u_core.u_sleep.idle_cnt[19] ),
    .GROUND(GROUND),
    .C(clknet_5_6_0_clk_c),
    .D(_063_),
    .QB(_039_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _710_ (.Q(\u_core.u_sleep.idle_cnt[20] ),
    .GROUND(GROUND),
    .C(clknet_5_15_0_clk_c),
    .D(_062_),
    .QB(_040_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _711_ (.Q(\u_core.u_sleep.idle_cnt[21] ),
    .GROUND(GROUND),
    .C(clknet_5_7_0_clk_c),
    .D(_061_),
    .QB(_041_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _712_ (.Q(\u_core.u_sleep.idle_cnt[22] ),
    .GROUND(GROUND),
    .C(clknet_5_14_0_clk_c),
    .D(_060_),
    .QB(_042_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _713_ (.Q(\u_core.u_sleep.idle_cnt[23] ),
    .GROUND(GROUND),
    .C(clknet_5_15_0_clk_c),
    .D(_109_),
    .QB(_000_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _714_ (.Q(\u_core.u_sleep.sleep_out ),
    .GROUND(GROUND),
    .C(clknet_5_3_0_clk_c),
    .D(_110_),
    .QB(_359_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _715_ (.Q(rst_sync_0),
    .GROUND(GROUND),
    .C(clknet_5_29_0_clk_c),
    .D(rst_sync_d),
    .QB(_354_),
    .CLR(rst_n_c),
    .VDD(VDD));
 DFCL11 _716_ (.Q(rst_sync_1),
    .GROUND(GROUND),
    .C(clknet_5_29_0_clk_c),
    .D(rst_sync_0),
    .QB(_362_),
    .CLR(rst_n_c),
    .VDD(VDD));
 DFCL11 _717_ (.Q(\u_core.u_sleep.state ),
    .GROUND(GROUND),
    .C(clknet_5_0_0_clk_c),
    .D(_365_),
    .QB(_364_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _718_ (.Q(\u_core.u_blink.running ),
    .GROUND(GROUND),
    .C(clknet_5_1_0_clk_c),
    .D(_111_),
    .QB(_355_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _719_ (.Q(\u_core.u_edge.sig_prev ),
    .GROUND(GROUND),
    .C(clknet_5_18_0_clk_c),
    .D(\u_core.u_debounce.btn_out ),
    .QB(_059_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _720_ (.Q(\u_core.u_debounce.btn_sync_0 ),
    .GROUND(GROUND),
    .C(clknet_5_26_0_clk_c),
    .D(btn_c),
    .QB(_361_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _721_ (.Q(\u_core.u_debounce.stable_cnt[0] ),
    .GROUND(GROUND),
    .C(clknet_5_25_0_clk_c),
    .D(_112_),
    .QB(_352_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _722_ (.Q(\u_core.u_debounce.stable_cnt[1] ),
    .GROUND(GROUND),
    .C(clknet_5_25_0_clk_c),
    .D(_119_),
    .QB(_056_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _723_ (.Q(\u_core.u_debounce.stable_cnt[2] ),
    .GROUND(GROUND),
    .C(clknet_5_24_0_clk_c),
    .D(_120_),
    .QB(_055_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _724_ (.Q(\u_core.u_debounce.stable_cnt[3] ),
    .GROUND(GROUND),
    .C(clknet_5_13_0_clk_c),
    .D(_121_),
    .QB(_054_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _725_ (.Q(\u_core.u_debounce.stable_cnt[4] ),
    .GROUND(GROUND),
    .C(clknet_5_24_0_clk_c),
    .D(_122_),
    .QB(_053_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _726_ (.Q(\u_core.u_debounce.stable_cnt[5] ),
    .GROUND(GROUND),
    .C(clknet_5_27_0_clk_c),
    .D(_123_),
    .QB(_052_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _727_ (.Q(\u_core.u_debounce.stable_cnt[6] ),
    .GROUND(GROUND),
    .C(clknet_5_27_0_clk_c),
    .D(_124_),
    .QB(_051_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _728_ (.Q(\u_core.u_debounce.stable_cnt[7] ),
    .GROUND(GROUND),
    .C(clknet_5_30_0_clk_c),
    .D(_125_),
    .QB(_050_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _729_ (.Q(\u_core.u_debounce.stable_cnt[8] ),
    .GROUND(GROUND),
    .C(clknet_5_30_0_clk_c),
    .D(_126_),
    .QB(_049_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _730_ (.Q(\u_core.u_debounce.stable_cnt[9] ),
    .GROUND(GROUND),
    .C(clknet_5_28_0_clk_c),
    .D(_127_),
    .QB(_048_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _731_ (.Q(\u_core.u_debounce.stable_cnt[10] ),
    .GROUND(GROUND),
    .C(clknet_5_22_0_clk_c),
    .D(_113_),
    .QB(_047_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _732_ (.Q(\u_core.u_debounce.stable_cnt[11] ),
    .GROUND(GROUND),
    .C(clknet_5_23_0_clk_c),
    .D(_114_),
    .QB(_046_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _733_ (.Q(\u_core.u_debounce.stable_cnt[12] ),
    .GROUND(GROUND),
    .C(clknet_5_28_0_clk_c),
    .D(_115_),
    .QB(_045_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _734_ (.Q(\u_core.u_debounce.stable_cnt[13] ),
    .GROUND(GROUND),
    .C(clknet_5_28_0_clk_c),
    .D(_116_),
    .QB(_044_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _735_ (.Q(\u_core.u_debounce.stable_cnt[14] ),
    .GROUND(GROUND),
    .C(clknet_5_31_0_clk_c),
    .D(_117_),
    .QB(_043_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _736_ (.Q(\u_core.u_debounce.stable_cnt[15] ),
    .GROUND(GROUND),
    .C(clknet_5_31_0_clk_c),
    .D(_118_),
    .QB(_001_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 DFCL11 _737_ (.Q(\u_core.u_debounce.btn_sync_1 ),
    .GROUND(GROUND),
    .C(clknet_5_26_0_clk_c),
    .D(\u_core.u_debounce.btn_sync_0 ),
    .QB(_360_),
    .CLR(rst_sync_1),
    .VDD(VDD));
 VSSCON _738_ (.GROUND(GROUND),
    .TIELO(_363_),
    .VDD(VDD));
 BUFF00 clkbuf_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_0_clk_c),
    .IN1(clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_0_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_0_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_1_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_1_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_2_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_2_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_3_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_3_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_4_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_4_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_5_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_5_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_6_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_6_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_3_7_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_3_7_0_clk_c),
    .IN1(clknet_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_0_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_0_0_clk_c),
    .IN1(clknet_3_0_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_10_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_10_0_clk_c),
    .IN1(clknet_3_5_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_11_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_11_0_clk_c),
    .IN1(clknet_3_5_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_12_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_12_0_clk_c),
    .IN1(clknet_3_6_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_13_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_13_0_clk_c),
    .IN1(clknet_3_6_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_14_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_14_0_clk_c),
    .IN1(clknet_3_7_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_15_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_15_0_clk_c),
    .IN1(clknet_3_7_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_1_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_1_0_clk_c),
    .IN1(clknet_3_0_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_2_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_2_0_clk_c),
    .IN1(clknet_3_1_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_3_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_3_0_clk_c),
    .IN1(clknet_3_1_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_4_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_4_0_clk_c),
    .IN1(clknet_3_2_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_5_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_5_0_clk_c),
    .IN1(clknet_3_2_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_6_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_6_0_clk_c),
    .IN1(clknet_3_3_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_7_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_7_0_clk_c),
    .IN1(clknet_3_3_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_8_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_8_0_clk_c),
    .IN1(clknet_3_4_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_4_9_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_4_9_0_clk_c),
    .IN1(clknet_3_4_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_0_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_0_0_clk_c),
    .IN1(clknet_4_0_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_10_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_10_0_clk_c),
    .IN1(clknet_4_5_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_11_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_11_0_clk_c),
    .IN1(clknet_4_5_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_12_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_12_0_clk_c),
    .IN1(clknet_4_6_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_13_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_13_0_clk_c),
    .IN1(clknet_4_6_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_14_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_14_0_clk_c),
    .IN1(clknet_4_7_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_15_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_15_0_clk_c),
    .IN1(clknet_4_7_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_16_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_16_0_clk_c),
    .IN1(clknet_4_8_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_17_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_17_0_clk_c),
    .IN1(clknet_4_8_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_18_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_18_0_clk_c),
    .IN1(clknet_4_9_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_19_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_19_0_clk_c),
    .IN1(clknet_4_9_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_1_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_1_0_clk_c),
    .IN1(clknet_4_0_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_20_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_20_0_clk_c),
    .IN1(clknet_4_10_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_21_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_21_0_clk_c),
    .IN1(clknet_4_10_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_22_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_22_0_clk_c),
    .IN1(clknet_4_11_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_23_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_23_0_clk_c),
    .IN1(clknet_4_11_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_24_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_24_0_clk_c),
    .IN1(clknet_4_12_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_25_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_25_0_clk_c),
    .IN1(clknet_4_12_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_26_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_26_0_clk_c),
    .IN1(clknet_4_13_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_27_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_27_0_clk_c),
    .IN1(clknet_4_13_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_28_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_28_0_clk_c),
    .IN1(clknet_4_14_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_29_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_29_0_clk_c),
    .IN1(clknet_4_14_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_2_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_2_0_clk_c),
    .IN1(clknet_4_1_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_30_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_30_0_clk_c),
    .IN1(clknet_4_15_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_31_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_31_0_clk_c),
    .IN1(clknet_4_15_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_3_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_3_0_clk_c),
    .IN1(clknet_4_1_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_4_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_4_0_clk_c),
    .IN1(clknet_4_2_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_5_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_5_0_clk_c),
    .IN1(clknet_4_2_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_6_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_6_0_clk_c),
    .IN1(clknet_4_3_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_7_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_7_0_clk_c),
    .IN1(clknet_4_3_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_8_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_8_0_clk_c),
    .IN1(clknet_4_4_0_clk_c),
    .VDD(VDD));
 BUFF00 clkbuf_5_9_0_clk_c (.GROUND(GROUND),
    .OUT1(clknet_5_9_0_clk_c),
    .IN1(clknet_4_4_0_clk_c),
    .VDD(VDD));
 SPAD00 u_pad_btn (.GROUND(GROUND),
    .PADIN(btn_in),
    .OUT1(btn_c),
    .VDD(VDD));
 SPAD00 u_pad_clk (.GROUND(GROUND),
    .PADIN(clk),
    .OUT1(clk_c),
    .VDD(VDD));
 OTPD01 u_pad_led (.GROUND(GROUND),
    .IN1(\u_core.u_blink.pulse ),
    .PAD(led_blink),
    .VDD(VDD));
 SPAD00 u_pad_rst (.GROUND(GROUND),
    .PADIN(rst_n),
    .OUT1(rst_n_c),
    .VDD(VDD));
 OTPD01 u_pad_seg0 (.GROUND(GROUND),
    .IN1(\seg_c[0] ),
    .PAD(seg_out[0]),
    .VDD(VDD));
 OTPD01 u_pad_seg1 (.GROUND(GROUND),
    .IN1(\seg_c[1] ),
    .PAD(seg_out[1]),
    .VDD(VDD));
 OTPD01 u_pad_seg2 (.GROUND(GROUND),
    .IN1(\seg_c[2] ),
    .PAD(seg_out[2]),
    .VDD(VDD));
 OTPD01 u_pad_seg3 (.GROUND(GROUND),
    .IN1(\seg_c[3] ),
    .PAD(seg_out[3]),
    .VDD(VDD));
 OTPD01 u_pad_seg4 (.GROUND(GROUND),
    .IN1(\seg_c[4] ),
    .PAD(seg_out[4]),
    .VDD(VDD));
 OTPD01 u_pad_seg5 (.GROUND(GROUND),
    .IN1(\seg_c[5] ),
    .PAD(seg_out[5]),
    .VDD(VDD));
 OTPD01 u_pad_seg6 (.GROUND(GROUND),
    .IN1(\seg_c[6] ),
    .PAD(seg_out[6]),
    .VDD(VDD));
 OTPD01 u_pad_slp (.GROUND(GROUND),
    .IN1(\u_core.u_sleep.sleep_out ),
    .PAD(sleep_led),
    .VDD(VDD));
 PVDD01 u_pad_vdd0 (.GROUND(GROUND),
    .VDD(VDD));
 PVDD01 u_pad_vdd1 (.GROUND(GROUND),
    .VDD(VDD));
 PVSS01 u_pad_vss0 (.GROUND(GROUND),
    .VDD(VDD));
 PVSS01 u_pad_vss1 (.GROUND(GROUND),
    .VDD(VDD));
 INVR00 u_rst_tie_hi (.GROUND(GROUND),
    .OUT1(rst_sync_d),
    .IN1(_363_),
    .VDD(VDD));
endmodule

