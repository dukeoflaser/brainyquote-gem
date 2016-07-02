require 'nokogiri'
require 'open-uri'

class BrainyQuote::Quote
  attr_accessor :text, :author
  attr_reader :topic_name

  def initialize(topic_name)
    @topic_name = topic_name
  end

  class << self
    def quote_about(topic_name)
      quote = self.new(topic_name)
      quote.text = quote.quote_from_topic.values.first
      quote.author = quote.quote_from_topic.keys.first
      quote
    end

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




  def quote_from_topic
    quote_info = {}
    quotes = []
    authors = []

    url = random_pagination_url
    doc = Nokogiri::HTML(open(url))

    #Retrieve authors and text indiviudally from page.
    doc.css('.bq-aut a').each do |author|
      authors << author.text
    end
    doc.css('.bqQuoteLink a').each do |quote|
      quotes << quote.text
    end

    #Randomly select a scraped quote/author.
    index = (rand(quotes.length) - 1)
    quote = quotes[index]
    author = authors[index]

    #Associtate text/author
    quote_info[author] = quote
    quote_info
  end


  def random_pagination_url
    #Prepare basic topic_url
    page_name = @topic_name.split(/\W/).join.downcase
    url = "http://www.brainyquote.com/quotes/topics/topic_#{page_name}.html"

    doc = Nokogiri::HTML(open(url))

    #Find number of available pages for topics and pick one at random
    max = doc.css('ul.pagination').first.css('li:nth-last-child(2)').text.to_i
    page = rand(max)

    #Render url for selected page
    "http://www.brainyquote.com/quotes/topics/topic_#{page_name}#{page}.html"
  end

end
