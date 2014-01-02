	#!/usr/bin/ruby
	require 'mysql'
	require 'dropbox_sdk'
	begin
	  print "Database Name:"
		@database = gets.chomp
		print "User Name :"
		@user = gets.chomp 
		print "Password :"
		@pass = gets.chomp
		`mysql -u "#{@user}" -p "#{@pass}" "#{@database}" > "#{@database}".sql`
		  
		# Get your app key and secret from the Dropbox developer website
		APP_KEY = 'fh4dcybcbo3nb91'
		APP_SECRET = 'q8rn212l7ehg3oq'
		flow = DropboxOAuth2FlowNoRedirect.new(APP_KEY, APP_SECRET)
		authorize_url = flow.start()
		puts '1. Go to: ' + authorize_url
		puts '2. Click "Allow" (you might have to log in first)'
		puts '3. Copy the authorization code'
		print 'Enter the authorization code here: '
		code = gets.strip
		access_token, user_id = flow.finish(code)
		@client = DropboxClient.new(access_token)
		puts "linked account:", 
	  @filename = Dir.pwd+"/"+"#{@database}.sql"
  	puts @filename
  	if @client.search('/', "#{@database}.sql", file_limit=1000, include_deleted=false).length >0
  		@client.file_delete("#{@database}.sql")
  		puts "Deleted Last File"
  	end
	  file = open(@filename)
	  puts File.expand_path(__FILE__)
	  response = @client.put_file("/#{@database}.sql", file)
	  puts "Uploaded:"
	  puts "Updated at: #{Time.now}"	
		puts "uploaded:", response.inspect
		end