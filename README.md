### Explorecourses Scraper

This tool scrapes all the data from [ExploreCourses](http://explorecourses.stanford.edu) into a MongoDB database.

#### Payload

* `parse.rb` will do everything for you.

#### Requirements

This script uses the following gems

* mechanize - headless browsing
* mongo - Ruby API for storage in MongoDB
* nokogiri - XML parsing

In addition, [MongoDB](https://mongodb.com/) is used to store information, so it should be running in the default location (port 21027) on your machine.

#### License

This scraper is released under the MIT License (MIT).

Copyright (c) 2014 CourseCycle

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
