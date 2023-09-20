import showdown from 'showdown';

import * as fs from 'fs';

const readme = fs.readFileSync('README.md', 'utf-8');
const template = fs.readFileSync('site/default.html', 'utf-8');
const converter = new showdown.Converter();
const html = converter.makeHtml(readme);
let index = template.replace('CONTENT_PLACEHOLDER', html);
index = index.replaceAll('docs/', 'https://github.com/linz/imagery/tree/master/docs/');

fs.writeFileSync('index.html', index);
