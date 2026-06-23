const fs = require('fs');
const path = require('path');

const filePath = path.join(__dirname, '..', 'src', 'config', 'companies.json');
if (!fs.existsSync(filePath)) {
  console.error('companies.json not found');
  process.exit(1);
}

const companies = JSON.parse(fs.readFileSync(filePath, 'utf8'));

// Curated list of Hirist featured companies (High-growth product & tech startups in India)
const hiristFeatured = [
  { name: 'InMobi', tier: 2, techStack: ['React', 'Java', 'Node.js', 'Python', 'Spark'], website: 'https://www.inmobi.com/careers', headquarters: 'Bengaluru, India', type: 'Product' },
  { name: 'Curefit', tier: 3, techStack: ['React', 'React Native', 'Node.js', 'MongoDB'], website: 'https://www.cult.fit/careers', headquarters: 'Bengaluru, India', type: 'Startup' },
  { name: 'Dunzo', tier: 3, techStack: ['React', 'Node.js', 'Go', 'PostgreSQL'], website: 'https://www.dunzo.com/careers', headquarters: 'Bengaluru, India', type: 'Startup' },
  { name: 'ShareChat', tier: 2, techStack: ['React', 'React Native', 'Node.js', 'Go', 'NoSQL'], website: 'https://careers.sharechat.com', headquarters: 'Bengaluru, India', type: 'Startup' },
  { name: 'MakeMyTrip', tier: 2, techStack: ['React', 'Java', 'Spring Boot', 'MySQL', 'AWS'], website: 'https://careers.makemytrip.com', headquarters: 'Gurugram, India', type: 'Product' },
  { name: 'BookMyShow', tier: 2, techStack: ['React', 'Node.js', 'PHP', 'MySQL', 'AWS'], website: 'https://careers.bookmyshow.com', headquarters: 'Mumbai, India', type: 'Product' },
  { name: 'Delhivery', tier: 2, techStack: ['React', 'Python', 'Django', 'PostgreSQL'], website: 'https://www.delhivery.com/careers', headquarters: 'Gurugram, India', type: 'Product' },
  { name: 'Udaan', tier: 2, techStack: ['React', 'Node.js', 'Kotlin', 'PostgreSQL'], website: 'https://careers.udaan.com', headquarters: 'Bengaluru, India', type: 'Startup' },
  { name: 'Urban Company', tier: 2, techStack: ['React', 'Node.js', 'Express.js', 'MongoDB'], website: 'https://careers.urbancompany.com', headquarters: 'Gurugram, India', type: 'Startup' },
  { name: 'Pine Labs', tier: 2, techStack: ['React', 'Java', 'Spring Boot', 'SQL Server'], website: 'https://www.pinelabs.com/careers', headquarters: 'Noida, India', type: 'Product' },
  { name: 'PolicyBazaar', tier: 2, techStack: ['React', 'Node.js', 'Java', 'MySQL'], website: 'https://careers.policybazaar.com', headquarters: 'Gurugram, India', type: 'Product' },
  { name: 'Lenskart', tier: 2, techStack: ['React', 'React Native', 'Node.js', 'MongoDB'], website: 'https://careers.lenskart.com', headquarters: 'Gurugram, India', type: 'Product' },
  { name: 'Mindtickle', tier: 2, techStack: ['React', 'Go', 'Java', 'Node.js', 'AWS'], website: 'https://www.mindtickle.com/careers', headquarters: 'Pune, India', type: 'Product' },
  { name: 'Zenoti', tier: 2, techStack: ['React', 'C#', 'DotNet', 'SQL Server'], website: 'https://www.zenoti.com/careers', headquarters: 'Hyderabad, India', type: 'Product' },
  { name: 'Fractal Analytics', tier: 2, techStack: ['React', 'Python', 'R', 'SQL', 'Azure'], website: 'https://fractal.ai/careers', headquarters: 'Mumbai, India', type: 'Product' },
  { name: 'Mu Sigma', tier: 3, techStack: ['React', 'Python', 'R', 'SQL', 'PowerBI'], website: 'https://www.mu-sigma.com/careers', headquarters: 'Bengaluru, India', type: 'Service' },
  { name: 'ElasticRun', tier: 3, techStack: ['React', 'Node.js', 'PostgreSQL', 'AWS'], website: 'https://www.elasticrun.com/careers', headquarters: 'Pune, India', type: 'Startup' },
  { name: 'Myntra', tier: 2, techStack: ['React', 'Node.js', 'Java', 'React Native', 'MongoDB'], website: 'https://careers.myntra.com', headquarters: 'Bengaluru, India', type: 'Product' }
];

// Curated list of Fortune 500 active hirers in India (Major MNCs, Financial Institutions, Tech hubs)
const fortune500India = [
  { name: 'Reliance Industries', tier: 2, techStack: ['React', 'Java', 'Python', 'SAP', 'SQL'], website: 'https://careers.jio.com', headquarters: 'Mumbai, India', type: 'MNC' },
  { name: 'HDFC Bank', tier: 2, techStack: ['React', 'Java', 'Spring Boot', 'Oracle', 'DotNet'], website: 'https://careers.hdfcbank.com', headquarters: 'Mumbai, India', type: 'MNC' },
  { name: 'ICICI Bank', tier: 2, techStack: ['React', 'Java', 'Spring Boot', 'SQL Server'], website: 'https://www.icicibank.com/careers', headquarters: 'Mumbai, India', type: 'MNC' },
  { name: 'Larsen and Toubro', tier: 4, techStack: ['React', 'Java', 'C#', 'SQL', 'AutoCAD'], website: 'https://www.larsentoubro.com/corporate/careers', headquarters: 'Mumbai, India', type: 'Service' },
  { name: 'Tata Steel', tier: 4, techStack: ['React', 'Java', 'Python', 'SAP'], website: 'https://www.tatasteel.com/careers', headquarters: 'Jamshedpur, India', type: 'MNC' },
  { name: 'State Bank of India', tier: 4, techStack: ['React', 'Java', 'Oracle', 'Cobol'], website: 'https://bank.sbi/careers', headquarters: 'Mumbai, India', type: 'MNC' },
  { name: 'ITC Limited', tier: 4, techStack: ['React', 'Java', 'SQL', 'SAP'], website: 'https://www.itcportal.com/careers', headquarters: 'Kolkata, India', type: 'MNC' },
  { name: 'Maruti Suzuki', tier: 4, techStack: ['React', 'Java', 'C#', 'SAP'], website: 'https://www.marutisuzuki.com/corporate/careers', headquarters: 'Gurugram, India', type: 'MNC' },
  { name: 'Mahindra and Mahindra', tier: 4, techStack: ['React', 'Java', 'Python', 'SAP'], website: 'https://www.mahindra.com/careers', headquarters: 'Mumbai, India', type: 'MNC' },
  
  // Fortune 500 Tech MNCs
  { name: 'Salesforce', tier: 1, techStack: ['React', 'TypeScript', 'Java', 'Apex', 'Python'], website: 'https://careers.salesforce.com', headquarters: 'San Francisco, CA', type: 'MNC' },
  { name: 'Intel', tier: 1, techStack: ['React', 'C++', 'Python', 'Verilog', 'C'], website: 'https://www.intel.com/careers', headquarters: 'Santa Clara, CA', type: 'MNC' },
  { name: 'Cisco', tier: 1, techStack: ['React', 'TypeScript', 'Python', 'C++', 'Java'], website: 'https://careers.cisco.com', headquarters: 'San Jose, CA', type: 'MNC' },
  { name: 'HP', tier: 2, techStack: ['React', 'C#', 'C++', 'Java', 'DotNet'], website: 'https://jobs.hp.com', headquarters: 'Palo Alto, CA', type: 'MNC' },
  { name: 'Dell', tier: 2, techStack: ['React', 'TypeScript', 'C#', 'Java', 'SQL'], website: 'https://jobs.dell.com', headquarters: 'Round Rock, TX', type: 'MNC' },
  { name: 'Siemens', tier: 2, techStack: ['React', 'C++', 'Java', 'C#', 'Cloud'], website: 'https://new.siemens.com/global/en/company/jobs.html', headquarters: 'Munich, Germany', type: 'MNC' },
  { name: 'Bosch', tier: 2, techStack: ['React', 'C++', 'Java', 'Python', 'IoT'], website: 'https://www.bosch.in/careers', headquarters: 'Gerlingen, Germany', type: 'MNC' },
  { name: 'GE', tier: 2, techStack: ['React', 'Java', 'Python', 'C#', 'SQL'], website: 'https://www.ge.com/careers', headquarters: 'Boston, MA', type: 'MNC' },
  { name: 'Samsung', tier: 1, techStack: ['React', 'Android', 'Java', 'Kotlin', 'C++'], website: 'https://www.samsung.com/in/about-us/careers', headquarters: 'Suwon, South Korea', type: 'MNC' },
  { name: 'Sony', tier: 2, techStack: ['React', 'C++', 'Java', 'Python', 'Swift'], website: 'https://www.sony.net/SonyInfo/Careers', headquarters: 'Tokyo, Japan', type: 'MNC' }
];

const allNew = [...hiristFeatured, ...fortune500India];
let added = 0;

allNew.forEach(company => {
  const exists = companies.some(c => c.name.toLowerCase() === company.name.toLowerCase());
  if (!exists) {
    companies.push({
      name: company.name,
      tier: company.tier,
      techStack: company.techStack,
      hiringFrequency: 75,
      salaryPotential: company.tier === 1 ? 95 : (company.tier === 2 ? 85 : 75),
      engineeringCulture: company.tier === 1 ? 90 : 80,
      remoteFlexibility: ['Hybrid', 'Remote', 'Onsite'],
      growthPotential: 80,
      website: company.website,
      headquarters: company.headquarters
    });
    added++;
    console.log(`Added: "${company.name}"`);
  }
});

if (added > 0) {
  fs.writeFileSync(filePath, JSON.stringify(companies, null, 2), 'utf8');
  console.log(`Successfully added ${added} new Fortune 500 / Hirist featured companies!`);
} else {
  console.log('All companies are already present in config.');
}
