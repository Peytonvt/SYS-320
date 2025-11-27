$scraped_page = Invoke-WebRequest -UseBasicParsing http://10.0.17.12/ToBeScraped.html

# Get a count of the links in the page
$scraped_page.Links.Count