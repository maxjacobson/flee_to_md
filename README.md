# flee to md

helps convert a big xml file (like from squarespace) to markdown files

## installation

`gem install flee_to_md`

(you'll need [rubygems](https://rubygems.org/pages/download))

## usage

run `flee_to_md {your_xml_file}.xml`

## changelog

* **2013-04-10**, v0.1.0,
    * repackaged as a rubygem for easier installation / usage
* **2013-04-01**, v0.0.6
    * better support for windows (I think)
* **2013-03-23**, v0.0.5
    * downloads attachments
* **2013-03-21**, v0.0.4
    * removed some of the escaping `\` characters that kramdown was adding
    * removed the trailing hyphens in some filenames (where the title ends in a -> like character)
* **2013-03-20**, v0.0.3
    * removed web interface ([too slow for (heroku's) love](http://www.youtube.com/watch?v=fiyROQNLhSU))
    * added 1.8.7 compatibility
* **2013-03-20**, v0.0.2
    * added web interface
    * titles in single quotes
* **2013-03-19**, v0.0.1 first try

## roadmap

* maybe make sure it works with wordpress exports
* maybe support other output structures

## license

The MIT License (MIT)
Copyright (c) 2013 Max Jacobson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


