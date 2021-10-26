module ApplicationHelper
  TITLES = {
    'alert' => 'warning',
    'notice' => 'success',
    'error' => 'danger'
  }
  def bootstrap_alert(key)
    TITLES[key]
  end
end
