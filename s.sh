curl 'https://api.quackquack.games/nest/collect' \
  -H 'accept: */*' \
  -H 'accept-language: vi-VN,vi;q=0.9,fr-FR;q=0.8,fr;q=0.7,en-US;q=0.6,en;q=0.5' \
  -H 'authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjkwNTk2LCJ0aW1lc3RhbXAiOjE3MTUwOTU5NTk5MzMsInR5cGUiOjEsImlhdCI6MTcxNTA5NTk1OSwiZXhwIjoxNzE1NzAwNzU5fQ.NTJySNEynzRBuYPu2Mj1YhykpXoe0_5cYfl2OvmodnY' \
  -H 'content-type: application/x-www-form-urlencoded' \
  -H 'origin: https://quackquack-prj.s3.ap-southeast-1.amazonaws.com' \
  -H 'priority: u=1, i' \
  -H 'referer: https://quackquack-prj.s3.ap-southeast-1.amazonaws.com/' \
  -H 'sec-ch-ua: "Chromium";v="124", "Google Chrome";v="124", "Not-A.Brand";v="99"' \
  -H 'sec-ch-ua-mobile: ?1' \
  -H 'sec-ch-ua-platform: "Android"' \
  -H 'sec-fetch-dest: empty' \
  -H 'sec-fetch-mode: cors' \
  -H 'sec-fetch-site: cross-site' \
  -H 'user-agent: Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Mobile Safari/537.36' \
  --data-raw 'nest_id=260765'
