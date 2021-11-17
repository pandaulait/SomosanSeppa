module ApplicationHelper
  TITLES = {
    'alert' => 'warning',
    'notice' => 'success',
    'error' => 'danger'
  }
  def bootstrap_alert(key)
    TITLES[key]
  end
  require 'uri'

  def text_url_to_link(text)
    URI.extract(text, %w[http https]).uniq.each do |url|
      sub_text = ''
      sub_text << '<a href=' << url << " target=\"_blank\" onclick=\"return confirm('外部のページへ移動します。よろしいですか？')\">" << url << '</a>'

      text.gsub!(url, sub_text)
    end
    text
  end
end
