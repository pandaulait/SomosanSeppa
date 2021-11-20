require 'base64'
require 'json'
require 'net/https'

module Language
  class << self
    def get_data(text)
      # APIのURL作成
      api_url = "https://language.googleapis.com/v1beta1/documents:analyzeEntities?key=#{ENV['GOOGLE_API_KEY']}"
      # APIリクエスト用のJSONパラメータ
      params = {
        document: {
          type: 'PLAIN_TEXT',
          content: text
        }
      }.to_json
      # Google Cloud Natural Language APIにリクエスト
      uri = URI.parse(api_url)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri)
      request['Content-Type'] = 'application/json'
      response = https.request(request, params)
      # APIレスポンス出力
      response_body = JSON.parse(response.body)
      response_body['entities'].delete_if { |entities| entities['salience'] < 0.01 }
      array = []
      # 返り値を後々取り出すいよう、arrayに保存し直す。
      response_body['entities'].each do |text|
        array << { entity: text['name'], score: text['salience'] } if text['name']
      end

      if (error = response_body['error']).present?
        raise error['message']
      else
        array
      end
    end
  end
end
