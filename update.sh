if [ -z "$1" ]
then
  echo "Please specify the version as an argument.\n"
  exit 0
else
  echo "Building mast distributables..."
  sh dev_compile.sh
  sh compile.sh
  sed 's/{{version}}/'$1'/' package.json.template > package.json
  #todo: use second argument (optional) as commit message and annotated tag message
  git tag "$1"
  git commit -am "Bumped version to $1."
  npm publish --force && git push --tags && git push
fi