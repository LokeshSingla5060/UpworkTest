require 'logger'
require 'date'


#create file directory 
class FileManager

    # create file with inside current date >>timestamp folder
    def createFile(folderPath)
        time = Time.new
        logFolderPath = folderPath
        createDirectory(logFolderPath)
        directory_name = logFolderPath+"/"+Date.today.to_s
        createDirectory(directory_name)
        subDirectory_name=directory_name+"/"+time.strftime("%k:%M:%S")
        createDirectory(subDirectory_name)
        return subDirectory_name
    end


    #create directory using provided file path
    def createDirectory(filePath)
        # puts "Directory is Ready to use"
        Dir.mkdir(filePath) unless File.exists?(filePath)
    end


end
