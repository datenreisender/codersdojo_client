require 'tempfile'

class ShellWrapper

  MAX_STDOUT_LENGTH = 100000

  def cp source, destination
    FileUtils.cp source, destination
  end

  def cp_r source, destination
    FileUtils.cp_r source, destination
  end

  def mkdir dir
    FileUtils.mkdir dir
  end

  def mkdir_p dirs
    FileUtils.mkdir_p dirs
  end

	def rename old_filename, new_filename
		File.rename old_filename, new_filename
	end

	def current_file
		__FILE__
	end

  def execute command
    spec_pipe = IO.popen(command, "r")
    result = spec_pipe.read MAX_STDOUT_LENGTH
    spec_pipe.close
    puts result
    result
  end

  def write_file filename, content
    file = File.new filename, "w"
    file << content
    file.close
  end

  def read_file filename
    file = File.new filename
    content = file.read
    file.close
    content
  end

  def creation_time filename
    File.ctime(filename)
  end

  def modification_time filename
    File.mtime(filename)
  end

	def real_dir_entries dir
		Dir.new(dir).entries - ["..", "."]
	end

  def file? filename
		File.file? filename
	end
	
	def remove_command_name
		windows? ? 'del' : 'rm'
	end

	def shell_extension
		windows? ? 'cmd' : 'sh'
	end
	
	def path_separator
		windows? ? ';' : ':'
	end
	
	def windows?
		platform = RUBY_PLATFORM.downcase
		platform.include?("windows") or platform.include?("mingw32")
	end

end

