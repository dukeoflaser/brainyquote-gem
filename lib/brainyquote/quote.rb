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
      # binding.pry
      quote_object = self.new(topic_name)
      quote_data = quote_object.quote_from_topic
      
      quote_object.text = quote_data.first
      quote_object.author = quote_data.last
      quote_object
      # binding.pry
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
    text_and_author = []
    # quote_info = {}
    # quotes = []
    # authors = []

    url = random_pagination_url
    doc = Nokogiri::HTML(open(url))

    #Retrieve text/author pairs.
    doc.css('.bqQt').each do |data|
      text_and_author << data.text.split("\n").reject!(&:empty?).take(2)
    end

    #Retrieve authors and text indiviudally from page.
    # doc.css('.bq-aut a').each do |author|
    #   authors << author.text
    # end
    # doc.css('.bqQuoteLink a').each do |quote|
    #   quotes << quote.text
    # end

    #Randomly select a scraped quote/author.
    index = (rand(text_and_author.length) - 1)
    text_and_author[index]
    # binding.pry
    # quote = text_and_author[index].first
    # author = text_and_author[index].last

    # quote = quotes[index]
    # author = authors[index]

    #Associtate text/author
    # quote_info[author] = quote
    # quote_info

    # binding.pry
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
