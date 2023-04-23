select url, count(*) as n_clicks
from clicks
WHERE date(time) = CURDATE()
group by url
order by count(*) desc;