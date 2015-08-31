require 'sinatra'
require 'hexdump'
require 'shellwords'

include FileUtils::Verbose


get '/upload' do
	erb :upload
end

post '/upload' do 
	ida_path = '/home/user/.wine/drive_c/Program\ Files\ \(x86\)/IDA\ 6.6/idaw.exe'

	if params[:file].nil?
		return "You must specificy the file to process"
	end
	

	# Copy the uploaded file for analysis
	tmp_name = SecureRandom.hex
	tmp_file = "/tmp/#{tmp_name}"

	if params[:file][:filename] =~ /\.idb$/
		tmp_file = "#{tmp_file}.idb"
	end
	cp(params[:file][:tempfile].path, tmp_file)

	# Make sure the file type is supported
	mime = `file #{tmp_file}`
	functions = Shellwords.escape(params[:functions])

   res = system("wine #{ida_path} -Ohexrays:-nosave:#{tmp_name}:#{functions} -A #{tmp_file}")

   if res
      if File.exists?("#{tmp_name}.c")
         content_type 'text/x-c'
         return IO.binread("#{tmp_name}.c").gsub(/\r\n/, "\n")
      else
         content_type 'text/plain'
         return "ERROR: decompilation finished successfully but no output file was created"
      end
   else
      content_type 'text/plain'
      return "ERROR: decompilation failed"
   end	
end
