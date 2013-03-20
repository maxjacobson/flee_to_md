# flee

helps convert a big xml file (like from squarespace) to markdown files

## usage

* convert your xml file online at <http://flee_to_md.herokuapp.com>
* or fork this repo and run `ruby flee.rb your.xml` from the same directory as your xml file and it will make a folder of markdown files right there

## dependencies

* get [rubygems](http://rubygems.org/pages/download)
* [nokogiri](http://rubygems.org/gems/nokogiri) -- run `gem install nokogiri`
* [kramdown](http://rubygems.org/gems/kramdown) -- run `gem install kramdown`
* [progressbar](http://rubygems.org/gems/progressbar) -- for nicer output

## changelog

* **2013-03-20**, v0.0.2
    * ruby 1.8.7 compatibility
    * titles in single quotes
    * updated the progressbar bc the one I was using was gonna pull a Google Reader and stop working in July
* **2013-03-19**, v0.0.1 first try

## roadmap

here's a little scratch I took out of the home.haml file... some options could be added

    %p
      convert from
      %label
        %input{:type => 'radio', :name => 'from_format', :value => 'squarespace', :id => 'from_squarespace', :checked => 'true'} squarespace
        %input{:type => 'radio', :name => 'from_format', :value => 'wordpress', :id => 'from_wordpress', :disabled => 'disabled'} wordpress
    %p
      convert to
      %label
        %input{:type => 'radio', :name => 'to_format', :value => 'statamic', :id => 'to_statamic', :checked => 'true'} statamic
        %input{:type => 'radio', :name => 'to_format', :value => 'statamic', :id => 'to_pelican', :disabled => 'disabled'} pelican
        %input{:type => 'radio', :name => 'to_format', :value => 'statamic', :id => 'to_jekyll', :disabled => 'disabled'} jekyll (and octopress)

## license

The MIT License (MIT)
Copyright (c) 2013 Max Jacobson

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


