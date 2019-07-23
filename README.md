# collectionsasdatajam2019
Experiments with World Digital Library in ACH Collections as Data Jam 2019 in Pittsburgh, PA (description of the event: http://ach2019.ach.org/full-day-collections-as-data-jam-30/)


At the ACH Conference in Pittsburgh, PA, July 23, 2019, at the Collections as Data Jam workshop. The team included: Kristen Mapes, Mickey Casad, David Newbury, Ellen Prokop, Anindita Basu Sempere, and Ece Turnator. We explored the World Digital Library (https://www.wdl.org/en/), and used its API (http://api.wdl.org/) to undertake a data exploration of a search for "dragon" in the library. The csv included here is the compiled data we created, which includes latitude and longitude, dates, subject headings, and image measurements (hue, saturation, brightness). The pdf is a slideshow with many screenshots of the work we did, including a data model of the process, and Palladio visualizations.

The tools we used were:
- Palladio
- Vistorian (well, we tried)
- Carto
- Image measurements - ImageJ (& Imageplot in some ways)
- RAW Graphs
- IIIF
- node-microdata-scraper
- Typhoeus

## Running the code

There are two scripts that were written for this.  First is the main data extraction library, which is a node.js script.

You can install the dependencies with `npm install`, and then run the script with `node index.js`. It will export a CSV file to standard output, which is not that useful.  I ran it with `node index.js > locations.csv` and `node index.js > item_data.csv` which actually generate the output.  To toggle between the two modes, you can comment out one or the other lines at the bottom of the `index.js` file:

```
      createLocationSpreadsheet(allURLs)
      // createObjectSpreadsheet(allURLs)

```

The other file, `test.rb`, is a small Ruby script to scrape URLs.  You can install the dependencies with `bundle install` (Assuming you have both Ruby and Bundler installed on your system).  It crawls a pre-determined list of URLs, munges an Image API url into a Manifest URL, and then downloads the thumbnail URLs parsed from that manifest.  It's not a very elegant solution.


