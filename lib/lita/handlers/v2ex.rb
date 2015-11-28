module Lita
  module Handlers
    class V2ex < Handler
      route(/v2ex/, :fetch_hot_topic, command: true, help: {
        "v2ex" => "display 10 hot posts of v2ex today"
      })

      def fetch_hot_topic response
        hots = redis.get(key_of_today)
        hots = access_api unless hots
        response.reply hots
      end

      def key_of_today
        'v2ex_' + Time.now.strftime('%Y-%m-%d')
      end

      def access_api
        url = 'https://www.v2ex.com/api/topics/hot.json'
        res = http.get url
        hash_res = MultiJson.load(res.body)
        content = filter_data(hash_res).join("\n")
        redis.set(key_of_today, content)
        content
      end

      def filter_data(res)
        if res
          res.map {|item| "#{item['title']}: #{item['url']}" }
        else
          []
        end
      end


      Lita.register_handler(self)
    end
  end
end
