var microdata = require('node-microdata-scraper');
var searchURL = "https://www.wdl.org/en/search/?q=dragon&qla=en"
var prefix = "https://www.wdl.org"


function prettyPrint(data) {
   return JSON.stringify(data, null, 2);
}

function extractItemLocationData(url) {
  let fullUrl = prefix + url
  let output = ""
  microdata.parseUrl(fullUrl,(err, json)  => {
    if (!err && json) {

        let output = {}
        let data = JSON.parse(json);


        let itemPage = data.filter((d) => d.name == "http://schema.org/ItemPage")[0]
        
        let place = itemPage.properties.contentLocation;
        if (typeof place != "string") {
          place = place[0]
        }
          
        let geo = data.filter((d) => d.name == "http://schema.org/GeoCoordinates")[0]

        let lat = "";
        try{
           lat = geo.properties.latitude;
        } catch(e){}
        let lng = ""
        try {
          lng = geo.properties.longitude;
        } catch(e) {}

        let csv = (`${fullUrl},"${place}","${lat}, ${lng}"`)

        output = csv
        console.log(csv);
    }
  })
  return output;
}




function extractItemData(url) {
  let fullUrl = prefix + url
  let output = ""
  microdata.parseUrl(fullUrl,(err, json)  => {
    if (!err && json) {
        let data = JSON.parse(json);

        // console.log(prettyPrint(data));
// 
        let itemPage = data.filter((d) => d.name == "http://schema.org/ItemPage")[0]        
        let place = itemPage.properties.contentLocation;
        if (typeof place != "string") {
          place = place[0]
        }      


        let geo = data.filter((d) => d.name == "http://schema.org/GeoCoordinates")[0]

        let props = itemPage.properties;
        
        let title =       props.name;
        let creator =     props.creator;
        let dateCreated = props.dateCreated;
        let type = ""//props.
        let subjects = [...new Set(props.keywords)].join("; ")
        let partners = props.provider[0];
        let collection = "";
        let lat = "";
        try{
           lat = geo.properties.latitude;
        } catch(e){}
        let lng = ""
        try {
          lng = geo.properties.longitude;
        }
        catch(e){}
        let locName = props.contentLocation;
        let imgUrl = ""
        let lang_name = ""
        let recordUrl = fullUrl;
        let csv = (`"${title}","${creator}","${dateCreated}","${type}","${subjects}","${partners}","${collection}","${lat}","${lng}","${locName}","${imgUrl}","${lang_name}","${recordUrl}"`)



        console.log(csv);
    }
  })
  return output;
}



function createLocationSpreadsheet(urls) {
  console.log("Record URL,Place,LatLong")
  for (let item of urls) {
   extractItemLocationData(item)
  }
}

function createObjectSpreadsheet(urls) {
  console.log("Title of work,Artist or author display,Date,Type of Item,Subjects,Partner institutions, Collection Name,Latitude,Longitude,Location name,Image (link),Title in original language,Record url")
  for (let item of urls) {
   extractItemData(item)
   // return;
  }
}



var allURLs = []
var page = 1;

var getUrls = function myself(url) {

  microdata.parseUrl(url+"&page=" + page, function(err, json) {
    // console.log(json, err)
    if (!err && json) {
    
      // Take the returned data and convert it into a JS object
      var data = JSON.parse(json);
      var items = data.filter((d) => {return d.name == "http://schema.org/ListItem"})

      if (items.length > 0) {
      // create a list of URLs
      var urls = items.map((d)=> allURLs.push(d.properties.url))
      // console.log(page)
      page++;

      myself(url)
    }
    else {
      // console.log(allURLs);
       let fakeURLs = ["/en/item/4677/"]
      createLocationSpreadsheet(allURLs)
      // createObjectSpreadsheet(allURLs)
    }

    }
  });
}

getUrls(searchURL);
