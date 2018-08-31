gitbook build
git add .
git commit -m 'update !!!'
git pull
git push
rm -rf docs/*
cp -rf _book/* docs/