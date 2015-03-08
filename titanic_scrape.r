c('rvest','dplyr','pipeR', 'knitr') -> packages
lapply(packages, library, character.only = T)

url <- 'http://www.encyclopedia-titanica.org/manifest.php?q=1'
css_page <- '#manifest'
url %>>%
  html %>>%
  html_nodes(css_page) %>>%
  html_nodes('a') -> as

urls <- c()
for (a in as) {
  if (exists(html_attr(a, 'itemprop'))) {
    urls <- append(urls, html_attr(a, 'href')); 
  }
}

url %>>%
  html %>>%
  html_nodes(css_page) %>>%
  html_table(header = F) %>>%
  data.frame() %>>%
  tbl_df() -> total_table

#merge urls with total_table

total_table %>>%
  filter(total_table$X1 == 'Name') %>>% as.character -> names

#'Name' %>>% grep(x = total_table$X1) -> row_of_name_header #find where name is

#names %>>% tolower -> names(total_table)

#names(total_table) %>>% (gsub('\\%|/','\\.',.)) -> names(total_table)

#(row_of_name_header + 1) %>>% (total_table[.:nrow(total_table),]) -> total_table
#total_table %>>% head
#total_table %>>% write.csv('Desktop/titanic_two.csv', row.names = F)