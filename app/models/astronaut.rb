class Astronaut < ActiveRecord::Base


 def download_details
 	url = "https://en.wikipedia.org/w/api.php?action=query&prop=extracts&exintro=&explaintext=&pageids=#{self.wiki_pageid}&format=json"
    json_string_data = open(url).read
    movie_data = JSON.parse(json_string_data)

    self.intro = movie_data["extract"]

 end

end
