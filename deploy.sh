export RAILS_ENV=production
export SECRET_KEY_BASE=somekeybase

rm -rf public/carpool-assets

echo "MAKE SURE YOU PULL"

bundle install
rake db:migrate
rake assets:precompile


nohup rails server -b 0.0.0.0 -p 3000 &>../carpool.out &
