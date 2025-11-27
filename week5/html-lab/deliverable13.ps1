
# Print innerText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { `
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$divs1