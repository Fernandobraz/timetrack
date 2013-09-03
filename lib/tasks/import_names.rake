task :import_names => :environment do
  
  puts "Importing Names..."
  
  File.open("#{Rails.root}/sample_names.txt", "r") do |file_handle|
    file_handle.each_line do |line|
      # do stuff to server here
      first, rest = line.split(' ')
      
      u = User.new
      u.first_name = first
      u.last_name = rest
      email = "#{line.strip.downcase.gsub(" ", '.')}@volcanic.co.uk"
      u.email = email
      u.password = u.password_confirmation = "123456789"
      
      role = rand(1...8)
      u.role_id = role
      
      days_ago = rand(10...200).days
      u.created_at = u.updated_at = Date.today - days_ago
      
      if u.save
        puts "#{line}"
      else
        puts u.errors.inspect
      end
      
    end
  end
  
end
