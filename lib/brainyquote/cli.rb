class BrainyQuote::CLI
  def call
    starter
  end

  def starter
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
    if @input == ""
      topic_controller
    else
      puts "Sorry, that command is not understood. Please try again."
      get_input
    end
  end

  def topic_controller
    puts "Here are some topics."
    display_instructions_for('choose')
    get_input
  end

end
