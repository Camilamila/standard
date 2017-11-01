#!/bin/bash
set -e
cd standard
CODELIST_LANG=en python schema/utils/translate_codelists.py schema
CODELIST_LANG=en python schema/utils/translate_codelists.py docs/en/extensions

pybabel compile --use-fuzzy -d docs/locale -D schema
pybabel compile --use-fuzzy -d docs/locale -D codelists

cd ..
python standard/schema/utils/translate_schema.py en es fr es_MX

# Create a symlink for the current language, so we can reference the
# translated JSON schema from Sphinx directives
rm build/current_lang || true
ln -s en build/current_lang

cd standard
sphinx-build -b dirhtml docs/en ../build/en
sphinx-build -b gettext docs/en ../build/locale

pybabel extract -F .babel_schema . -o ../build/locale/schema.pot
pybabel extract -F .babel_codelists . -o ../build/locale/codelists.pot

cd ..
cp -r standard/assets build

cd standard
for lang in es_MX; do
    CODELIST_LANG=$lang python schema/utils/translate_codelists.py schema
    CODELIST_LANG=$lang python schema/utils/translate_codelists.py docs/en/extensions
    # Create a symlink for the current language, so we can reference the
    # translated JSON schema from Sphinx directives
    rm ../build/current_lang
    ln -s ../build/$lang ../build/current_lang
    sphinx-build -b dirhtml -D language="$lang" docs/en ../build/$lang
done

# Our deploy script doesn't like it if this still exists
rm ../build/current_lang
