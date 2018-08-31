gitbook build
rm -rf docs/*
cp -rf _book/* docs/
rm -rf docs/docs
git add .
git commit -m 'update !!!'
git pull
git push