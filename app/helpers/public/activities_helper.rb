module Public::ActivitiesHelper
  def transition_path(activity)
    case activity.action_type.to_sym
    when :chatted_by_admin
      chat_rooms_path
    when :chatted_by_user
      admin_chat_room_path(activity.subject.chat_room, anchor: "js-comment-#{activity.subject.id}")
    when :leveled_up
      user_path(activity.subject)
    end
  end
end
