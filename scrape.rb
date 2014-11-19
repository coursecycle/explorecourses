require 'json'
require 'mechanize'
require 'mongo'
require 'nokogiri'
require 'thread'

include Mongo

EXPLORECOURSES_URL = 'http://explorecourses.stanford.edu/print?page=0&q=%25&catalog=&filter-coursestatus-Active=on&descriptions=on&collapse=&academicYear=&catalog='

def getMechanizeInstance()
    m = Mechanize.new
    m.user_agent = 'Mac Safari'
    return m
end

def getCourses(m, collection)
    source = Nokogiri::HTML(m.get(EXPLORECOURSES_URL).body)
    courses = source.css("div.searchResult")
    count = 0
    courses.each do |course|
        c = Hash.new
        number = course.at_css("span.courseNumber")
        unless number.nil?
            c["number"] = number.content.chomp(':')
        end
        title = course.at_css("span.courseTitle")
        unless title.nil?
            c["title"] = title.content
        end
        description = course.at_css("div.courseDescription")
        unless description.nil?
            c["description"] = description.content
        end
        attributes = course.at_css("div.courseAttributes")
        unless attributes.nil?
            c["attributes"] = attributes.content.strip()
        end
        collection.insert(c)
        count += 1
        if count % 100 == 0
            puts "Inserted " + count.to_s + " records"
        end
    end
end

# Connect to the Mongo server
client = MongoClient.new
db = client["courseriver"]
collection = db["explorecourses"]

# Generate thread pool that pulls items off the queue
m = getMechanizeInstance()
getCourses(m, collection)

