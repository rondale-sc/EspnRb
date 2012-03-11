module EspnRb
  module Utilities
    def self.help(str)
      puts "-----------------------------Welcome to EspnRb.---------------------------------\n\n"
      puts s = <<EOF
                               _.-=""=-._
                             .'\\\\-++++-//'.
                            (  ||      ||  )
                             './/      \\\\.'
                               `'-=..=-'`
EOF
      puts "--------------------------------------------------------------------------------"
      puts "You are currently using the headlines api from here you can do the follow:\n\n"
      puts "\t#{'Method'.ljust(25)} Description\n\n"
      puts str
    end
  end
end