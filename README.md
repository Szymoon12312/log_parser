# Log Parser

Script for collecting and listing statistics about visits on specific application pages based on the provided log file. 

## Requirements
- ruby 3.1.0

### Supported log format
    # webserver.txt
    <PATH> <IP_ADDRESS>

#### Example:

    /home 111.111.111.113   
    /home/1 111.111.111.112   
    /home 111.111.111.113

### Usage

        ruby run_script.rb [LOG_FILE_PATH]
        
#### Defaults:
- [LOG_FILE_PATH] - webserver.txt

#### Output: 

    List by views:

    /home - Number of views: 2
    /home/1 - Number of views: 1
    
    List by unieque views: 
    
    /home - Number of unique views: 1
    /home/1 - Number of unique views: 1
    
#### Errors
- when file is empty - ```ruby EmptyFile``` 
- when file does not exists - ```ruby FileNotExists``` 

### Tests
To run the test You need to install gems by running:

    bundle install --with test

Then run the tests by using:
    
    rspec
