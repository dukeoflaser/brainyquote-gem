class BrainyQuote::Quote
  attr_accessor :text, :author
  attr_reader :topic_name

  def initialize(topic_name)
    @topic_name = topic_name
  end

  def data_from_topic
    text_and_author = []
    doc = Nokogiri::HTML(open(random_pagination_url))

    #Retrieve text/author pairs.
    doc.css('.bqQt').each do |data|
      text_and_author << data.text.split("\n").reject!(&:empty?).take(2)
    end

    #Randomly selectand return a scraped quote/author.
    index = (rand(text_and_author.length) - 1)
    text_and_author[index]
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




  class << self
    def quote_about(topic_name)
      quote_object = self.new(topic_name)
      quote_data = quote_object.data_from_topic

      quote_object.text = quote_data.first
      quote_object.author = quote_data.last
      quote_object
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
  
  private :random_pagination_url
end
