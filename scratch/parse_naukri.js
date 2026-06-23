const fs = require('fs');

const contentPath = 'C:/Users/Mush/.gemini/antigravity/brain/fdbfb4e7-eee0-4090-a1c8-af0e0a47dfa6/.system_generated/steps/15431/content.md';
const html = fs.readFileSync(contentPath, 'utf8');

const urls = new Set();
const regex = /href="([^"]+)"/g;
let match;
while ((match = regex.exec(html)) !== null) {
  urls.add(match[1]);
}

console.log('Total URLs found in Naukri page:', urls.size);
console.log('Sample URLs:', Array.from(urls).slice(0, 100));
