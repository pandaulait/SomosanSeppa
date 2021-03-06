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

ActiveRecord::Schema.define(version: 20_211_118_065_333) do
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.integer 'record_id', null: false
    t.integer 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'activities', force: :cascade do |t|
    t.string 'subject_type'
    t.integer 'subject_id'
    t.integer 'user_id'
    t.string 'content', default: '', null: false
    t.integer 'action_type', null: false
    t.boolean 'read', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[subject_type subject_id], name: 'index_activities_on_subject_type_and_subject_id'
    t.index ['user_id'], name: 'index_activities_on_user_id'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'content'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'chat_rooms', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_chat_rooms_on_user_id'
  end

  create_table 'chats', force: :cascade do |t|
    t.integer 'user_id'
    t.integer 'chat_room_id'
    t.string 'content', null: false
    t.boolean 'admin', default: false, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['chat_room_id'], name: 'index_chats_on_chat_room_id'
    t.index ['user_id'], name: 'index_chats_on_user_id'
  end

  create_table 'choices', force: :cascade do |t|
    t.integer 'selection_quiz_id', null: false
    t.string 'content', null: false
    t.boolean 'is_answer', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'descriptive_quizzes', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'content', null: false
    t.text 'explanation', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_descriptive_quizzes_on_user_id'
  end

  create_table 'results', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'quiz_type'
    t.integer 'quiz_id'
    t.integer 'correct_count', null: false
    t.string 'answer', null: false
    t.boolean 'content', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[quiz_type quiz_id], name: 'index_results_on_quiz_type_and_quiz_id'
    t.index ['user_id'], name: 'index_results_on_user_id'
  end

  create_table 'selection_quizzes', force: :cascade do |t|
    t.integer 'user_id'
    t.text 'content', null: false
    t.text 'explanation', default: '', null: false
    t.integer 'status', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_selection_quizzes_on_user_id'
  end

  create_table 'today_quizzes', force: :cascade do |t|
    t.date 'content', null: false
    t.string 'quiz_type'
    t.integer 'quiz_id'
    t.integer 'challenger', default: 0, null: false
    t.integer 'correct_answerer', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[quiz_type quiz_id], name: 'index_today_quizzes_on_quiz_type_and_quiz_id'
  end

  create_table 'today_results', force: :cascade do |t|
    t.integer 'user_id'
    t.string 'quiz_type'
    t.integer 'quiz_id'
    t.integer 'today_quiz_id', null: false
    t.integer 'correct_count', null: false
    t.string 'answer', null: false
    t.boolean 'content', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[quiz_type quiz_id], name: 'index_today_results_on_quiz_type_and_quiz_id'
    t.index ['today_quiz_id'], name: 'index_today_results_on_today_quiz_id'
    t.index ['user_id'], name: 'index_today_results_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'name', null: false
    t.boolean 'is_deleted', default: false, null: false
    t.boolean 'admin', default: false, null: false
    t.integer 'today_status', default: 0, null: false
    t.integer 'experience_point', default: 0, null: false
    t.integer 'level', default: 1, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end
end
