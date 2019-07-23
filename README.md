# collectionsasdatajam2019
Experiments with World Digital Library in ACH Collections as Data Jam 2019 in Pittsburgh, PA


## Running the code

There are two scripts that were written for this.  First is the main data extraction library, which is a node.js script.

You can install the dependencies with `npm install`, and then run the script with `node index.js`. It will export a CSV file to standard output, which is not that useful.  I ran it with `node index.js > locations.csv` and `node index.js > item_data.csv` which actually generate the output.  To toggle between the two modes, you can comment out one or the other lines at the bottom of the `index.js` file:

```
      createLocationSpreadsheet(allURLs)
      // createObjectSpreadsheet(allURLs)

```

The other file, `test.rb`, is a small Ruby script to scrape URLs.  You can install the dependencies with `bundle install` (Assuming you have both Ruby and Bundler installed on your system).  It crawls a pre-determined list of URLs, munges an Image API url into a Manifest URL, and then downloads the thumbnail URLs parsed from that manifest.  It's not a very elegant solution.


