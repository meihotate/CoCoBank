# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_12_111659) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "chatmembers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatmessages", force: :cascade do |t|
    t.text "message", null: false
    t.integer "chatmember_id", null: false
    t.integer "chatroom_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "from_user_id"
    t.integer "to_user_id"
    t.integer "friendstatus", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["from_user_id", "to_user_id"], name: "index_friendships_on_from_user_id_and_to_user_id", unique: true
    t.index ["from_user_id"], name: "index_friendships_on_from_user_id"
    t.index ["to_user_id"], name: "index_friendships_on_to_user_id"
  end

  create_table "profile_images", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "profile_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.boolean "is_deleted", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "name"
    t.integer "sex"
    t.integer "location"
    t.integer "degree", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "approved", default: 0, null: false
    t.index ["approved"], name: "index_users_on_approved"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "watson_reqs", force: :cascade do |t|
    t.integer "user_id"
    t.text "text1", default: "", null: false
    t.text "text2", default: "", null: false
    t.text "text3", default: "", null: false
    t.text "text4", default: "", null: false
    t.text "text5", default: "", null: false
    t.text "text6", default: "", null: false
    t.text "text7", default: "", null: false
    t.text "text8", default: "", null: false
    t.text "text9", default: "", null: false
    t.text "text10", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "big5_openness_name"
    t.float "big5_openness"
    t.string "big5_conscientiousness_name"
    t.float "big5_conscientiousness"
    t.string "big5_extraversion_name"
    t.float "big5_extraversion"
    t.string "big5_agreeableness_name"
    t.float "big5_agreeableness"
    t.string "big5_neuroticism_name"
    t.float "big5_neuroticism"
    t.string "need_challenge_name"
    t.float "need_challenge"
    t.string "need_closeness_name"
    t.float "need_closeness"
    t.string "need_curiosity_name"
    t.float "need_curiosity"
    t.string "need_excitement_name"
    t.float "need_excitement"
    t.string "need_harmony_name"
    t.float "need_harmony"
    t.string "need_ideal_name"
    t.float "need_ideal"
    t.string "need_liberty_name"
    t.float "need_liberty"
    t.string "need_love_name"
    t.float "need_love"
    t.string "need_practicality_name"
    t.float "need_practicality"
    t.string "need_self_expression_name"
    t.float "need_self_expression"
    t.string "need_stability_name"
    t.float "need_stability"
    t.string "need_structure_name"
    t.float "need_structure"
    t.string "value_conservation_name"
    t.float "value_conservation"
    t.string "value_openness_to_change_name"
    t.float "value_openness_to_change"
    t.string "value_hedonism_name"
    t.float "value_hedonism"
    t.string "value_self_enhancement_name"
    t.float "value_self_enhancement"
    t.string "value_self_transcendence_name"
    t.float "value_self_transcendence"
  end

  create_table "watson_results", force: :cascade do |t|
    t.integer "watson_req_id", null: false
    t.text "result", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "big5_openness_name"
    t.float "big5_openness"
    t.string "big5_conscientiousness_name"
    t.float "big5_conscientiousness"
    t.string "big5_extraversion_name"
    t.float "big5_extraversion"
    t.string "big5_agreeableness_name"
    t.float "big5_agreeableness"
    t.string "big5_neuroticism_name"
    t.float "big5_neuroticism"
    t.string "need_challenge_name"
    t.float "need_challenge"
    t.string "need_closeness_name"
    t.float "need_closeness"
    t.string "need_curiosity_name"
    t.float "need_curiosity"
    t.string "need_excitement_name"
    t.float "need_excitement"
    t.string "need_harmony_name"
    t.float "need_harmony"
    t.string "need_ideal_name"
    t.float "need_ideal"
    t.string "need_liberty_name"
    t.float "need_liberty"
    t.string "need_love_name"
    t.float "need_love"
    t.string "need_practicality_name"
    t.float "need_practicality"
    t.string "need_self_expression_name"
    t.float "need_self_expression"
    t.string "need_stability_name"
    t.float "need_stability"
    t.string "need_structure_name"
    t.float "need_structure"
    t.string "value_conservation_name"
    t.float "value_conservation"
    t.string "value_openness_to_change_name"
    t.float "value_openness_to_change"
    t.string "value_hedonism_name"
    t.float "value_hedonism"
    t.string "value_self_enhancement_name"
    t.float "value_self_enhancement"
    t.string "value_self_transcendence_name"
    t.float "value_self_transcendence"
  end

end
