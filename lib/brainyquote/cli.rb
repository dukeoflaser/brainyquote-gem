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
    puts "Welcome to BrainyQuote." if options.include?('intro')
    puts "That is not a valid option." if options.include?('invalid')
    puts "Hit 'Enter' to see available topics." if options.include?('topics')
    if options.include?('retry')
      puts "Would you like to try another from this topic? (y/n)"
      puts "'n' will display the topic list."
    end
    puts "Enter a number from the list to select a topic." if options.include?('choose')
    puts "Type 'exit' to leave." if options.include?('exit')
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
        display_instructions_for('invalid', 'topics', 'exit')
        get_input
      end
    elsif @filter == 'topic'
      if (1..122) === @input.to_i
        translate_input_to_topic_name
        retrieve_quote
        format_quote
        display_instructions_for('retry', 'exit')
        decide_to_retry
      else
        display_instructions_for('invalid', 'choose', 'exit')
        get_input
        continue_or_exit
      end
    end
  end



  def topic_controller
    @filter = 'topic'
    get_topics
    format_topics
    display_instructions_for('choose', 'exit')
    get_input
    continue_or_exit
  end



  def quote_controller

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

  def format_quote
    puts ""
    puts "  ~#{@quote.topic_name.split.map(&:capitalize).join(' ')}~"
    puts ""
    puts ""
    p @quote.text
    puts ""
    puts "  - #{@quote.author}"
    puts ""
    puts ""
    puts ""
    puts ""
  end









  def get_topics
    @topics = BrainyQuote::Quote.topics
  end



  private
  def translate_input_to_topic_name
    @topic_name = @topics[@input.to_i - 1].downcase
  end

  def retrieve_quote
    @quote = BrainyQuote::Quote.quote_about(@topic_name)
  end



  def decide_to_retry
    get_input

    if @input == 'y'
      retrieve_quote
      format_quote
      display_instructions_for('retry', 'exit')
      decide_to_retry
    elsif @input == 'n'
      topic_controller
    end
  end

end
