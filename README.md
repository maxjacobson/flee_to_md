# flee to md

helps convert a big xml file (like from squarespace) to markdown files

## dependencies

* get [rubygems](http://rubygems.org/pages/download)
* run `gem install nokogiri kramdown ruby-progressbar`

## usage

* download this repo and run `ruby flee.rb your.xml` from the same directory as your xml file and it will make a folder of markdown files right there

## changelog

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


