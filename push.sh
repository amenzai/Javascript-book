gitbook build

rm -rf docs
mv -rf _book docs
rm -rf docs/docs

git add .
git commit -m 'update !!!'
git pull
git push