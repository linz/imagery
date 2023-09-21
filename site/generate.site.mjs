import showdown from 'showdown';
import { JSDOM, VirtualConsole } from 'jsdom';
import * as fs from 'fs';

const readme = fs.readFileSync('README.md', 'utf-8');
const linzLogo = fs.readFileSync('linz-logo-col-n-white-txt.svg', 'utf-8');
const nzGovtLogo = fs.readFileSync('nz-govt-logo-rev.svg', 'utf-8');
const template = fs.readFileSync('site/default.html', 'utf-8');
const converter = new showdown.Converter();
const html = converter.makeHtml(readme);

// add README content
let index = template.replace('CONTENT_PLACEHOLDER', html);
// modify links to point to GitHub
index = index.replaceAll('docs/', 'https://github.com/linz/imagery/tree/master/docs/');
// add images
index = index.replace('LINZ_LOGO_PLACEHOLDER', linzLogo);
index = index.replace('NZ_GOVT_LOGO_PLACEHOLDER', nzGovtLogo);

// parse the DOM
const virtualConsole = new VirtualConsole(); // avoid writting console errors (remove to debug)
const dom = new JSDOM(index, { virtualConsole });
// add CSS
const luiCSS = fs.readFileSync('lui.css', 'utf-8');
let style = dom.window.document.getElementsByTagName('style')[0].innerHTML;
style = luiCSS + style;
dom.window.document.getElementsByTagName('style')[0].innerHTML = style;
// Apply images sizes
const svgLinzLogo = dom.window.document.getElementsByClassName('lui-header-logo')[0].getElementsByTagName('svg')[0];
svgLinzLogo.classList.add('linz-logo');
const svgNzGovtLogo = dom.window.document.getElementsByClassName('nz-govt-logo')[0].getElementsByTagName('svg')[0];
// manually set the size that fits better
svgNzGovtLogo.setAttribute('width', '200px');
svgNzGovtLogo.setAttribute('height', '50px');

fs.writeFileSync('index.html', dom.window.document.documentElement.outerHTML);
