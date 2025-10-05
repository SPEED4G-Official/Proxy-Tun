ps aux | grep "php artisan queue:work" | grep -v grep | awk '{print $2}' | xargs kill -9
