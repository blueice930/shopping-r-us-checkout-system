require 'json'

module Initialization
  def init
    @@env = read_env
    @@price_list = get_price_list
    @@discount_rule_list = get_rule_list
    print_start_screen
  end

  def read_env
    begin
      file = File.read('env.json')
      env = JSON.parse(file)
      env
    rescue
      puts 'No ENV file found, Program shut down...' 
      exit
    end
  end

  def get_price_list
    begin
      file = File.read(@@env['PRICE_FILE_PATH'])
      price = JSON.parse(file)
      price
    rescue
      puts 'PRICE_FILE_PATH is not valid, Program shut down...' 
      exit
    end
  end

  def get_rule_list
    begin
      file = File.read(@@env['DISCOUNT_RULE_PATH'])
      price = JSON.parse(file)
      price
    rescue
      puts 'DISCOUNT_RULE_PATH is not valid, Program shut down...' 
      exit
    end
  end

  def print_start_screen
    text = File.read(@@env['START_SCREEN'])
    puts text
    # Fake loading time, but in real world reading files and db may take a while.
    0.step(20, 5) do |i|
      printf("\rProgress: [%-20s]", "=" * (i))
      sleep(0.1)
    end
  end
end
