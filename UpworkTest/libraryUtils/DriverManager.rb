require 'selenium-webDriver'
#Create WebDriver Instance
module DriverManager
    class UIDriver
        #Initiate WebDriver instance
        def initiateDriver(testData,log)
            begin
                driver = Selenium::WebDriver.for :"#{testData.browser_name}", detach:true
                log.info 'Initiate '+testData.browser_name+' browser'
                driver.manage.window.maximize
                driver.navigate.to "#{testData.app_url}"
                log.info 'Navigate to '+testData.app_url
                return driver
            rescue StandardError => e  
                puts e.message  
                log.info 'Unable to open browser'
                log.error e.message
            end
        end
    end
end
