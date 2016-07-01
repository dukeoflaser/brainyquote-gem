class BrainyQuote::CLI
  def call
    starter
  end

  def starter
    @filter = 'main'
    puts ""
    display_instructions_for('intro', 'topics', 'exit')
    puts ""
    get_input
    continue_or_exit
  end

  def display_instructions_for(*options)
    puts "Need a Quote?" if options.include?('intro')
    puts "Hit 'Enter' to see available topics." if options.include?('topics')
    puts "Would you like to try another? (y/n)" if options.include?('retry')
    puts "Type 'exit' to leave." if options.include?('exit')
    puts "Pick a number to select a topic." if options.include?('choose')
  end

  def get_input
    @input = gets.strip.downcase
  end

  def continue_or_exit
    until @input == 'exit'
      main_controller
    end

    puts "Goodbye!"
    exit
  end

  def main_controller
    if @filter == 'main'
      if @input == ""
        topic_controller
      else
        puts "Sorry, that command is not understood. Please try again."
        get_input
      end
    end
  end

  def topic_controller
    @filter = 'topic'
    get_topics
    format_topics
    display_instructions_for('choose')
    get_input
    retrieve_quote
  end

  def format_topics
    topics_string = ""
    @topics.each_with_index do |topic, i|
      cell =  "#{i + 1}) #{topic}"
      x = (25 - cell.length)
      x.times{ cell << " " }
      topics_string << cell
    end

    rows = topics_string.scan(/.{1,75}/)
    rows.each {|row| puts row}
    puts ""
  end

  def retrieve_quote
    puts "Here's a quote!"
  end

  def get_topics
    @topics = BrainyQuote::Quote.topics
  end

end
