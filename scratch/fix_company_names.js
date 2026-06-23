const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'src', 'config', 'companies.json');
if (fs.existsSync(filePath)) {
  const companies = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  
  const titleCase = (str) => {
    return str
      .toLowerCase()
      .split(' ')
      .map(word => word.charAt(0).toUpperCase() + word.slice(1))
      .join(' ');
  };

  companies.forEach(c => {
    // If it's fully uppercase or has weird casing, title-case it
    // Except for known acronyms like TCS, IBM, JPMC, etc.
    const upper = c.name.toUpperCase();
    const acronyms = ['TCS', 'IBM', 'JPMC', 'CRED', 'MNC', 'IT', 'LTI', 'EY', 'DXC', 'HCL', 'UST', 'JSW', 'NLB', 'CGI', 'PITCS', 'RGBSI', 'EY-3'];
    if (acronyms.includes(upper)) {
      c.name = upper;
    } else {
      c.name = titleCase(c.name);
    }
  });

  fs.writeFileSync(filePath, JSON.stringify(companies, null, 2), 'utf8');
  console.log('Fixed casing for all company names in companies.json');
} else {
  console.error('companies.json not found');
}
