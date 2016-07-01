require 'nokogiri'
require 'open-uri'

class BrainyQuote::Quote

  class << self
    def topics
      topics = []
      url = 'http://www.brainyquote.com/quotes/topics.html'
      doc = Nokogiri::HTML(open(url))

      doc.css('table .bqLn a').each do |link|
        topics << link.text
      end

      topics
    end
  end

end
