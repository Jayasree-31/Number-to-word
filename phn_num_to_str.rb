class PhnNumToWord
		#Checks Phone Number is Valid or not and also check number as 0 and 1
   def chk_phn_num(number)
   	return "Phone Number should not be Blank" if number.nil?
		return "Enter valid 10 digit phone number (Excluding 1 and 0)" if number.include?("0") ||  number.include?("1") || number.length != 10
		return "Enter only 10 digit phone number (Excluding 1 and 0)"if number =~ /^\d$/
	end
	def convert_phn_num_to_word	number
		letters_hash = {"2" => ["a", "b", "c"],"3" => ["d", "e", "f"],"4" => ["g", "h", "i"],"5" => ["j", "k", "l"],"6" => ["m", "n", "o"],"7" => ["p", "q","r", "s"],"8" => ["t", "u", "v"],"9" => ["w", "x", "y", "z"]}
		dict_hash = read_dict_txt_file
		num_arr = number.chars.map{|num|letters_hash[num]}
    result_arr = get_num_to_word(num_arr,dict_hash)
		return result_arr
	end 

	def read_dict_txt_file
	#read dictionary text file
		dict_hsh = {}
		for i in (2..25)
			dict_hsh[i] = []
		end
		File.foreach( "dictionary.txt" ) do |word|
			w = word.chomp.to_s.downcase
      dict_hsh[w.length] << w
    end
		dict_hsh
	end

  def get_num_to_word(num_arr,dict_hash)
		combo_hsh = {}
    num_length = num_arr.length-1
    for i in (2..num_length - 2)
      first_num_array = num_arr[0..i]
 			first_num_comb_arr = first_num_array.shift.product(*first_num_array).map(&:join) 
      second_num_array = num_arr[i + 1..num_length]
      second_num_comb_arr = second_num_array.shift.product(*second_num_array).map(&:join)
      combo_hsh[i] = [(first_num_comb_arr & dict_hash[i+1]), (second_num_comb_arr & dict_hash[num_length - i])] #get words contains in dictionary
    end
    words_arr = []
    combo_hsh.each do |key, combo|
			combo.shift.product(*combo).each do |combo_words|
				unless dict_hash[10].include?(combo_words.join)
			    words_arr << combo_words
				end
      end
    end
		words_arr = words_arr.sort!		#Sort array in alphabetical order
    words_arr << (num_arr.shift.product(*num_arr).map(&:join) & dict_hash[10]).join(", ")  #get 10 letters word from dictionary
    words_arr
	end
end
puts "Please Enter 10 digits Phone Number (Excluding 0 and 1)"
phn_to_wrd = PhnNumToWord.new()
phn_num = ""
num_resp = ""
while num_resp.nil?  == false  # loops until valid number is entered
	puts num_resp if num_resp != ""
	phn_num = gets.chomp.to_s
	num_resp = phn_to_wrd.chk_phn_num phn_num
end
word_arr =  phn_to_wrd.convert_phn_num_to_word phn_num
puts word_arr.inspect
