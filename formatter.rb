require 'json'
require 'mongo'
require 'nokogiri'

include Mongo

def to_boolean(str)
    str.downcase == 'true'
end

# Connect to the Mongo server
client = MongoClient.new
db = client["coursecycle"]
collection = db["explorecourses-cs"]

file = File.open("data.xml", "r:UTF-8")
source = Nokogiri::XML(file)

courses = source.css("course")
courses.each do |course|
    if course.at_css("subject").content == "CS"
        h = Hash.new
        h["year"] = course.at_css("year").content
        h["subject"] = course.at_css("subject").content
        h["code"] = course.at_css("code").content
        h["title"] = course.at_css("title").content
        h["description"] = course.at_css("description").content
        h["gers"] = course.at_css("gers").content.split(",").map(&:strip)
        h["repeatable"] = to_boolean(course.at_css("gers").content)
        h["grading"] = course.at_css("grading").content.split(" or ").map(&:strip)
        h["unitsMin"] = course.at_css("unitsMin").content.to_i
        h["unitsMax"] = course.at_css("unitsMax").content.to_i
        h["sections"] = Array.new
        sections = course.css("section")
        sections.each do |section|
            j = Hash.new
            term = section.at_css("term").content.split(" ")
            j["name"] = term[1]
            j["year"] = term[0]
            j["start_time"] = section.at_css("startTime").content
            j["end_time"] = section.at_css("endTime").content
            j["location"] = section.at_css("location").content
            j["days"] = section.at_css("days").content.split(" ")
            j["instructors"] = Array.new
            instructors = section.css("instructor")
            instructors.each do |instructor|
                k = Hash.new
                k["first_name"] = instructor.at_css("firstName").content
                k["middle_name"] = instructor.at_css("middleName").content
                k["last_name"] = instructor.at_css("lastName").content
                k["sunet"] = instructor.at_css("sunet").content
                k["role"] = instructor.at_css("role").content
                j["instructors"] << k
            end
            h["sections"] << j
        end
        puts h["subject"] + h["code"]
        collection.insert(h)
    end
end
