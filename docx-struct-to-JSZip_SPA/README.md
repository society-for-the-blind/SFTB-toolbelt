Still in progress

Stores a docx document (containing template hooks for various fiels) as a BASE64 javascript string in the `<header>` and the form submission triggers the population and download of the populated word document.

This is only used by one person currently so I didn't not spend time automating the process below:

`template.docx`  
---> `template.zip`  
---> `$ base64 -w0 template.zip > tempfile`  
---> `<script> var f = "`{tempfile content}`"; </script>`  
---> ???

The templating scheme is really unimaginative and MS Word also does not help by splitting content strings with `proofErr` tags that do grammar check therefore simple `split()` does not work. Yet.  

To give an example: my templates are `{{input-label-goes-here{{?itemname{{` so my idea was to split this with `split("{{")`, manipulate the array in place, `join()` the array and generate the docx with [JSZip](https://github.com/Stuk/jszip).  
But here's the glitch:
```xml
    <w:p w:rsidR="002515AF" w:rsidRDefault="00D55435" w:rsidP="00502BB0">
      <w:pPr>
        <w:jc w:val="both"/>
        <w:rPr>
          <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
        </w:rPr>
      </w:pPr>
      <w:r>
        <w:rPr>
          <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
        </w:rPr>
        <w:t xml:space="preserve">{{General attitude and </w:t>
      </w:r>
      <w:proofErr w:type="gramStart"/>
      <w:r>
        <w:rPr>
          <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
        </w:rPr>
        <w:t>motivation{</w:t>
      </w:r>
      <w:proofErr w:type="gramEnd"/>
      <w:r>
        <w:rPr>
          <w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman"/>
        </w:rPr>
        <w:t>{?item{{</w:t>
      </w:r>
    </w:p>
```

Therefore I either spend hours (and portions of my sanity) to figure out some regex-magic or I sanitize the input docx by hand (because the template shouldn't change once it is done).  

__Help for editing/viewing OpenXML documents:__

**LINUX**  
`xmllint`

**VIM**
```vim
function! DoPrettyXML()  
  silent %!xmllint --format -  
endfunction  
command! PrettyXML call DoPrettyXML()
```
Vim will also open zip files (and docx as it is just a bunch of zipped XML files) and it will persist changes on save in the archive as well. (This seems to be built in.)

**RESOURCES**  
[Exploring the Office Open XML Formats File](https://msdn.microsoft.com/en-us/library/aa982683(v=office.12).aspx#Anchor_2)
