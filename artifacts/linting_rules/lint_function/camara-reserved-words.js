const reservedWords = [
  'abstract',
  'apiclient',
  'apiexception',
  'apiresponse',
  'assert',
  'boolean',
  'break',
  'byte',
  'case',
  'catch',
  'char',
  'class',
  'configuration',
  'const',
  'continue',
  'do',
  'double',
  'else',
  'extends',
  'file',
  'final',
  'finally',
  'float',
  'for',
  'goto',
  'if',
  'implements',
  'import',
  'instanceof',
  'int',
  'interface',
  'list',
  'localdate',
  'localreturntype',
  'localtime',
  'localvaraccept',
  'localvaraccepts',
  'localvarauthnames',
  'localvarcollectionqueryparams',
  'localvarcontenttype',
  'localvarcontenttypes',
  'localvarcookieparams',
  'localvarformparams',
  'localvarheaderparams',
  'localvarpath',
  'localvarpostbody',
  'localvarqueryparams',
  'long',
  'native',
  'new',
  'null',
  'object',
  'offsetdatetime',
  'package',
  'private',
  'protected',
  'public',
  'return',
  'short',
  'static',
  'strictfp',
  'stringutil',
  'super',
  'switch',
  'synchronized',
  'this',
  'throw',
  'throws',
  'transient',
  'try',
  'void',
  'volatile',
  'while'
];

// Reserved word 'enum' and 'default' are removed from above reservedWords array as they are common in openapi keywords
export default async function (input) {
  
  // Iterate over properties of the input object
  for (const path in input) {
    
    if (typeof path === 'string') {
      for (const word of reservedWords) {
        const regex = new RegExp(`\\b${word}\\b`, 'g');  // Use a regular expression to match 'word' as a standalone word
    
           if (regex.test(path)) {
               console.log(`Warn: Reserved words found in input: '${path}' Consider avoiding the use of reserved word '${word}'. `);
        }
      }
    }
  }
}
