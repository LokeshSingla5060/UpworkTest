require 'selenium-webdriver'
require 'yaml'

class TestCase

    def initialize(driver)
        @driver=driver
    end
    #Search for freelancer and store the data
    def searchFreeLancer(testData,log)
        begin
            @locators= YAML.load_file('../objectRepository/locatorValue.yml')

            log.info '********* Search FreeLancer for '+testData.freelancer_keyword+' *********'
            sleep 0.50
            log.info 'Click on Search Freelancer textfield'
            @driver.find_element(:xpath, @locators['searchTextField']).click
            log.info 'Clicked on Search Freelancer textfield'
            sleep 0.10
            log.info 'Send '+testData.freelancer_keyword+' in Search Freelancer textfield'
            @driver.find_element(:xpath, @locators['searchTextField']).send_keys testData.freelancer_keyword
            log.info 'Sent '+testData.freelancer_keyword+' in Search Freelancer textfield'
            log.info 'Click on Search Icon'
            @driver.find_element(:xpath, @locators['searchIcon']).click
            log.info 'Clicked on Search Icon'
            sleep 0.50
            #create a map to store freelancer name as key and relevant data as value
            @data={}
            @driver.find_elements(xpath: "//section[@data-log-sublocation='search_results']").each.with_index do |cell, i|
                k =i+1
                # fetch freelancer name present on screen
                freeLancerName=@driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+k.to_s+"]").text
                @data[freeLancerName] = cell.text
                log.info "Freelancer Name : "+freeLancerName
            end
            #store keys to iterate map
            keys = @data.keys
            
            #for loop to iterate map
            for n in 0..keys.length-1 do            
              if(@data.fetch(keys[n])[testData.freelancer_keyword])
                log.info "**** Freelancer present with keyword ****"
                log.info keys[n]
              else
                log.info "**** Freelancer not present with keyword ****"
                log.info keys[n]           
                end
            end
            #click on user profile
            randomNumber=rand(1..9)
            freeLancerName=@driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+randomNumber.to_s+"]").text
            log. info freeLancerName+" is selected"
            @driver.find_element(:xpath, "(//a[@class='freelancer-tile-name']/span)["+randomNumber.to_s+"]").click
            sleep 1.0

            profileDescription=@driver.find_element(:xpath,@locators['profileDescription']).attribute('innerText')
            log.info "Profile Description : "+profileDescription
            title=@driver.find_element(:xpath,@locators['title']).text
            log.info "Title : "+title
            skills=@driver.find_element(:xpath,@locators['skills']).text
            log.info "Skills : "+skills

            #verify keyword in freelancer profile
            if(profileDescription.downcase[testData.freelancer_keyword.downcase] || title.downcase[testData.freelancer_keyword.downcase] || skills.downcase[testData.freelancer_keyword.downcase])
                log.info testData.freelancer_keyword+" Keyword is matched in profile description"
            else
                log.info testData.freelancer_keyword+" Keyword is not matched in profile description"
            end
            rescue StandardError => e  
            puts e.message  
            log.error e.message
        end

    end



end
