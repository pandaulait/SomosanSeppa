# frozen_string_literal: true

module ApplicationHelper
  TITLES = {
    'alert' => 'warning',
    'notice' => 'success',
    'error' => 'danger'
  }.freeze
  def bootstrap_alert(key)
    TITLES[key]
  end
end
