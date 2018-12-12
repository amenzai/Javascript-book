rm -rf docs/*
gitbook build

cp -rf _book/* docs/
rm -rf _book

git add .
git commit -m 'update !!!'
git pull
git push