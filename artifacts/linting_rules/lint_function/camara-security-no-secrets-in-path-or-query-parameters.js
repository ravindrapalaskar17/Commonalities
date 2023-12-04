const sensetiveData = ['MSISDN','IMSI'];

export default async function (input) {
  
  // Iterate over properties of the input object
  for (const path in input) {
    
    if (typeof path === 'string') {
      for (const word of sensetiveData) {
        const regex = new RegExp(`\\b${word}\\b`, 'g');  // Use a regular expression to match 'word' as a standalone word
    
           if (regex.test(path)) {
               console.log(`Warn: Sensetive Data found in input: '${path}' Consider avoiding the use of Sesentive data '${word}'. `);
        }
      }
    }
  }
}
