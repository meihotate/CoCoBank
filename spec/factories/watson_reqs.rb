FactoryBot.define do
  factory :watson_req do
    text1 {"アイウエオアイウエオアイウエオアイウエオアイウエオアイウエオ"}
    text2 {"かきくけこかきくけこかきくけこかきくけこかきくけこかきくけこ"}
    text3 {"さしすせそさしすせそさしすせそさしすせそさしすせそさしすせそ"}
    text4 {"かきくけこかきくけこかきくけこかきくけこかきくけこかきくけこ"}
    text5 {"なにぬねのなにぬねのなにぬねのなにぬねのなにぬねのなにぬねの"}
    text6 {"はひふへほはひふへほはひふへほはひふへほはひふへほはひふへほ"}
    text7 {"まみむめもまみむめもまみむめもまみむめもまみむめもまみむめも"}
    text8 {"やいゆえよやいゆえよやいゆえよやいゆえよやいゆえよやいゆえよ"}
    text9 {"らりるれろらりるれろらりるれろらりるれろらりるれろらりるれろ"}
    text10 {"わをんわをんわをんわをんわをんわをんわをんわをんわをんわをん"}
    big5_openness_name {"あいう性"}
    big5_openness {0.5}
    big5_conscientiousness_name {"あいう性"}
    big5_conscientiousness {0.5}
    big5_extraversion_name {"あいう性"}
    big5_extraversion {0.5}
    big5_agreeableness_name {"あいう性"}
    big5_agreeableness {0.5}
    big5_neuroticism_name {"あいう性"}
    big5_neuroticism {0.5}
    need_challenge_name {"あいう性"}
    need_challenge {0.5}
    need_closeness_name {"あいう性"}
    need_closeness {0.5}
    need_curiosity_name {"あいう性"}
    need_curiosity {0.5}
    need_excitement_name {"あいう性"}
    need_excitement {0.5}
    need_harmony_name {"あいう性"}
    need_harmony {0.5}
    need_ideal_name {"あいう性"}
    need_ideal {0.5}
    need_liberty_name {"あいう性"}
    need_liberty {0.5}
    need_love_name {"あいう性"}
    need_love {0.5}
    need_practicality_name {"あいう性"}
    need_practicality {0.5}
    need_self_expression_name {"あいう性"}
    need_self_expression {0.5}
    need_stability_name {"あいう性"}
    need_stability {0.5}
    need_structure_name {"あいう性"}
    need_structure {0.5}
    value_conservation_name {"あいう性"}
    value_conservation {0.5}
    value_openness_to_change_name {"あいう性"}
    value_openness_to_change {0.5}
    value_hedonism_name {"あいう性"}
    value_hedonism {0.5}
    value_self_enhancement_name {"あいう性"}
    value_self_enhancement {0.5}
    value_self_transcendence_name {"あいう性"}
    value_self_transcendence {0.5}

    trait :no_text1 do
      text1 {}
    end
    trait :no_text2 do
      text2 {}
    end
    trait :no_text3 do
      text3 {}
    end
    trait :no_text4 do
      text4 {}
    end
    trait :no_text5 do
      text5 {}
    end
    trait :no_text6 do
      text5 {}
    end
    trait :no_text7 do
      text7 {}
    end
    trait :no_text8 do
      text8 {}
    end
    trait :no_text9 do
      text9 {}
    end
    trait :no_text10 do
      text10 {}
    end
    trait :no_text do
      	text1 {}
	    text2 {"かきく"}
	    text3 {"さしす"}
	    text4 {"かきく"}
	    text5 {"なにぬ"}
	    text6 {"はひふ"}
	    text7 {"まみむ"}
	    text8 {"やいゆ"}
	    text9 {"らりる"}
	    text10 {"わをん"}
    end

  end
end
