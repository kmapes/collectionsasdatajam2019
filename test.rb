require 'typhoeus'
require "json"

vals = [
"https://content.wdl.org/iiif/5210,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4677,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2374,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2387,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2388,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2391,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2565,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4325,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2396,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/3034,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/7307,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/9944,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4396,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/9189,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11757,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/7311,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11797,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/12883,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11761,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16721,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11880,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16093,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16147,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16715,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16916,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17234,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16817,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17267,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17539,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17538,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17107,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17610,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17613,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17611,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17691,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17717,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17754,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17745,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18003,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18023,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18043,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17782,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17771,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17779,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19093,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19218,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19149,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/1901,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/8975,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/10695,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17684,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/316,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/638,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/13818,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2351,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/14409,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17783,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19380,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/8959,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/7310,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/14287,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/650,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11762,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/629,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19515,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/14404,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18550,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11430,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16816,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/15575,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18556,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/7769,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/9734,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16199,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11834,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17775,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/340,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17221,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/14709,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18546,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18541,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17626,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2339,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18540,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19223,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2674,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/7317,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/20062,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/215,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18549,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2371,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19226,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11419,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18551,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17235,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17720,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4644,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19486,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11793,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18545,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/634,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2386,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2476,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2884,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11381,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4116,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16097,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/252,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17123,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17796,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16729,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2551,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16728,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18044,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2377,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16719,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17608,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4324,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17756,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16723,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17629,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19079,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18544,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/4397,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2375,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11290,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17628,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/3083,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17692,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18554,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2527,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17540,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2380,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17627,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/2389,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17787,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16800,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16720,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16104,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18547,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17537,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19084,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/26,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18552,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16738,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18553,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/11358,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19382,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18542,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18555,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/16777,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19092,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19108,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/20191,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/14696,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/19191,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17789,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17737,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/18548,1,1/full/!1024,1024/0/default.jpg",
"https://content.wdl.org/iiif/17984,1,1/full/!1024,1024/0/default.jpg"
]

vals.each do |val| 

  id = val.split(",").first.split("/").last;

  response = Typhoeus.get("https://www.wdl.org/en/item/#{id}/iiif/manifest.json");

  manifest = JSON.parse(response.body)
  thumb= manifest["thumbnail"]["@id"]
  response2 = Typhoeus.get(thumb, followlocation: true)
  
  File.open("images/#{id}.jpg", 'w') { |file| file.write(response2.body) }
end