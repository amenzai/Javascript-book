git add .
git commit -m 'update !!!'
git pull
git push
gitbook build
rm -rf docs/*
cp -rf _book/* docs/