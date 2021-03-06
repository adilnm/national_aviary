class NationalAviary::Cli
  def call
    puts"Thank you for visiting the biggest Aviary in the United States. Here is a list of all the birds that we have: \n\n"
   birdsList
   displayDescription
  end
  
  def birdsList
    NationalAviary::Scraper.new.getNames
    list
  end
  def list
    counter=1
    NationalAviary::Aviary.all.each do |item|
      puts "#{counter}. #{item.name}"
      counter+=1
    end
  end
  
  def displayDescription
    
      puts "\nPlease enter the number of the bird that you would like to know more information about or enter 'exit' to exit the program."
      input = gets.strip
      i = Integer(input) rescue false
      if input == "exit"
        puts"Goodbye"
        exit
        elsif input == "list"
        list
        displayDescription
      elsif !i || input.to_i< 1 || input.to_i>127
        puts "your input is not valid"
        displayDescription
      else
        puts"\n\n"
        puts"  -------------"
        puts"   DESCRIPTION"
        puts"  -------------"
        description(input.to_i)
        moreInfo(input.to_i)
      end
  end
      
      def description(input)
        description = NationalAviary::Aviary.all[input-1].getDescription
          if description == ""
            puts "Sorry, we do not have a description for this particular bird "
          else
            puts "#{description}\n\n"
          end
     end
      
      def moreInfo(input)
          puts "Would you like to know more about #{NationalAviary::Aviary.all[input-1].name} y/n ?"
          input1=nil
          until input1== "y" || input1 == "n" || input1 == "list" 
              input1=gets.strip.downcase
              if input1 == "y"
                options(input)
              elsif input1 == "n"
              displayDescription
              elsif input1 == "list"
               list
               displayDescription
              elsif input1 == "exit"
              puts"Goodbye"
               exit
              else
                puts "Please enter y or n or enter 'list' to go back to the original list"
              end
          end
      end
      
      def options(input)
        puts "\nPlease pick one of the options below or type 'exit' to finish:\n "
        puts " 1.Distribution \n\n 2.Habitat \n\n 3.Diet \n\n 4.Breeding\n\n 5.Status \n\n 6.FunFact\n\n"
        input1=gets.strip
        case input1
          when "1"
          puts"  -------------"
          puts"   DISTRIBUTION"
          puts"  -------------"
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getDistribution}\n\n"
          when "2"
          puts"  -------------"
          puts"   HABITAT"
          puts"  -------------"  
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getHabitat}\n\n"
          when "3"
          puts"  -------"
          puts"   DIET"
          puts"  -------"  
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getDiet}\n\n"
          when "4"
          puts"  ----------"
          puts"   BREEDING"
          puts"  ----------"  
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getBreeding}\n\n"
          when "5"
          puts"  --------"
          puts"   STATUS"
          puts"  --------"  
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getStatus}\n\n"
          when "6"
          puts"  ---------"
          puts"   FUNFACT"
          puts"  ---------"  
          puts "#{NationalAviary::Aviary.all[input.to_i-1].getFunFact}\n\n"
          when "exit"
            puts"Goodbye"
            exit
          else options(input)
        end
          puts "Would you like to know more about #{NationalAviary::Aviary.all[input.to_i-1].name} y/n ?"
        
          other_options(input)
      end
      
      def other_options(input)
        input2 = gets.strip.downcase
        if input2 == "y"
          options(input)
        elsif input2 == "n" 
        displayDescription
        elsif input2 == "exit"
        puts"Goodbye"
        exit
        else
          puts"Please enter a valid input"
          other_options(input)
        end
      end
end