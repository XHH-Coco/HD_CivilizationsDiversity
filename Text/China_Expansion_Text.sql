
insert or replace into EnglishText
	(Tag,                                                Text)
values
  ("LOC_LEADER_ZHUDI_NAME",                            "Zhu Di (Thousand Nations Paying Tribute)"),
	("LOC_TRAIT_ZHUDI_NAME",                             "Six Voyages to the Western Oceans"),
	("LOC_TRAIT_ZHUDI_DESCRIPTION",                      "When discovering a city-state: Provide corresponding yields to [ICON_TRADEROUTE] Trade Routes if is a different type from the one found last time. Upon first becoming Suzerain of each city-state type, receive +1 [ICON_TRADEROUTE] Trade Route capacity."),
  ("LOC_LOADING_INFO_LEADER_ZHUDI",                    "{LOC_LOADING_INFO_LEADER_YONGLE}"),
  ("LOC_AGENDA_HD_ZHUDI_NAME",                         "Sun and Moon Over the Oceans"),
  ("LOC_AGENDA_HD_ZHUDI_DESCRIPTION",                  "Likes civs those build the most coastal cities and does not explore the world; but dislikes those who explore the world but plunder wantonly."),
  ("LOC_DIPLO_KUDO_LEADER_ZHUDI_REASON_ANY",           "(You have built many coastal cities without exploring the world.)"),
  ("LOC_DIPLO_AGENDA_HD_ZHUDI_POSITIVE",               "Zhu Di was very glad to see that you built many coastal cities but did not engage in external exploration."),
  ("LOC_DIPLO_WARNING_LEADER_ZHUDI_REASON_ANY",        "(You plunder wantonly)"),
  ("LOC_DIPLO_AGENDA_HD_ZHUDI_NEGATIVE",               "Your plundering and atrocities against this world have enraged Zhu Di."),

  ("LOC_LEADER_WU_ZETIAN_ALT_NAME",                    "Wu Zetian (Holy Empress)"),
  ("LOC_TRAIT_WU_ZETIAN_ALT_NAME",                     "Wangxiang Temple"),
  ("LOC_TRAIT_WU_ZETIAN_ALT_DESCRIPTION",              "Districts receive +2 adjacency bonus from each adjacent Wonder. Complete 50% of the cost immediately when placing Holy Site district adjacent to Wonder. At the end of each turn, if you reach threshold of entering [ICON_GLORY_GOLDEN_AGE] Golden Age, covert each 10 [ICON_GLORY_NORMAL_AGE] era scores to +1 adjacency bonus for Holy Site districts in cities with Wonders."),
  ("LOC_LOADING_INFO_LEADER_WU_ZETIAN_ALT",            "{LOC_LOADING_INFO_LEADER_WU_ZETIAN}"),
  ("LOC_AGENDA_HD_TIANSHOU_NAME",                      "Tianshou Treasure Map"),
  ("LOC_AGENDA_HD_TIANSHOU_DESCRIPTION",               "Like civs those are in the golden age and build wonders; but dislikes those who provokes war in a dark age."),
  ("LOC_DIPLO_KUDO_LEADER_WU_ZETIAN_ALT_REASON_ANY",   "(You are in the golden age and have built many wonders.)"),
  ("LOC_DIPLO_AGENDA_HD_TIANSHOU_POSITIVE",            "Wu Zetian is very glad to see that your empire is at its peak."),
  ("LOC_DIPLO_WARNING_LEADER_WU_ZETIAN_ALT_REASON_ANY","(Your empire is in a dark age, yet you still provoked wars.)"),
  ("LOC_DIPLO_AGENDA_HD_TIANSHOU_NEGATIVE",            "Wu Zetian regards you as a failed warlike.");

insert or replace into LocalizedText
  (Language,    Tag,                                                Text)
values
  ("zh_Hans_CN","LOC_LEADER_ZHUDI_NAME",                            "朱棣（万国来朝）"),
  ("zh_Hans_CN","LOC_TRAIT_ZHUDI_NAME",                             "六下西洋"),
  ("zh_Hans_CN","LOC_TRAIT_ZHUDI_DESCRIPTION",                      "发现城邦时，如果与上一个发现的城邦类型不同，则你的所有 [ICON_TRADEROUTE] 贸易路线获得该城邦类型的对应产出。首次宗主每种类型的城邦后分别获得+1 [ICON_TRADEROUTE] 贸易路线容量。"),
  ("zh_Hans_CN","LOC_LOADING_INFO_LEADER_ZHUDI",                    "{LOC_LOADING_INFO_LEADER_YONGLE}"),
  ("zh_Hans_CN","LOC_AGENDA_HD_ZHUDI_NAME",                         "日月照四极"),
  ("zh_Hans_CN","LOC_AGENDA_HD_ZHUDI_DESCRIPTION",                  "喜欢建设最多沿海城市且不探索世界的文明；厌恶探索世界但肆意劫掠的文明。"),
  ("zh_Hans_CN","LOC_DIPLO_KUDO_LEADER_ZHUDI_REASON_ANY",           "（您建设了许多沿海城市且不探索世界）"),
  ("zh_Hans_CN","LOC_DIPLO_AGENDA_HD_ZHUDI_POSITIVE",               "朱棣很高心看到您建设了诸多沿海城市但不进行对外探索。"),
  ("zh_Hans_CN","LOC_DIPLO_WARNING_LEADER_ZHUDI_REASON_ANY",        "（您肆意劫掠）"),
  ("zh_Hans_CN","LOC_DIPLO_AGENDA_HD_ZHUDI_NEGATIVE",               "您对这个世界的劫掠暴行令朱棣感到震怒。"),

  ("zh_Hans_CN","LOC_LEADER_WU_ZETIAN_ALT_NAME",                    "武则天（圣母神皇）"),
  ("zh_Hans_CN","LOC_TRAIT_WU_ZETIAN_ALT_NAME",                     "万象神宫"),
  ("zh_Hans_CN","LOC_TRAIT_WU_ZETIAN_ALT_DESCRIPTION",              "所有区域从相邻的奇观获得+2相邻加成。相邻奇观建造的圣地直接获得50%的建造进度。每回合结束时，若已达到进入 [ICON_GLORY_GOLDEN_AGE] 黄金时代的临界值，消耗溢出的 [ICON_GLORY_NORMAL_AGE] 时代得分，每消耗10点，使有奇观的城市的圣地+1相邻加成。"),
  ("zh_Hans_CN","LOC_LOADING_INFO_LEADER_WU_ZETIAN_ALT",            "{LOC_LOADING_INFO_LEADER_WU_ZETIAN}"),
  ("zh_Hans_CN","LOC_AGENDA_HD_TIANSHOU_NAME",                      "天授神图"),
  ("zh_Hans_CN","LOC_AGENDA_HD_TIANSHOU_DESCRIPTION",               "喜欢处于黄金时代且建造奇观的文明；厌恶处于黑暗时代还挑起战争的文明。"),
  ("zh_Hans_CN","LOC_DIPLO_KUDO_LEADER_WU_ZETIAN_ALT_REASON_ANY",   "（您处于黄金时代且建造了许多奇观）"),
  ("zh_Hans_CN","LOC_DIPLO_AGENDA_HD_TIANSHOU_POSITIVE",            "武则天很高兴看到您的帝国处于鼎盛时期。"),
  ("zh_Hans_CN","LOC_DIPLO_WARNING_LEADER_WU_ZETIAN_ALT_REASON_ANY","（您的帝国处于黑暗时代，您却还挑起战争）"),
  ("zh_Hans_CN","LOC_DIPLO_AGENDA_HD_TIANSHOU_NEGATIVE",            "武则天认为您是个失败的好战者。");