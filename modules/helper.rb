module Helper
  def print_menu(clear=true)
    $stdout.clear_screen if clear
    puts "Please input the command:\n 'scan / s' to scan products\n 'price / p' to list the price\n 'discount / d' to list the rules\n 'quit / q' to exit the program...\n"
  end
end