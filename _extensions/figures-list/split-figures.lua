local pagebreak = {
  asciidoc = '<<<\n\n',
  context = '\\page',
  epub = '<p style="page-break-after: always;"> </p>',
  html = '<div style="page-break-after: always;"></div>',
  latex = '\\newpage',
  ms = '.bp',
  ooxml = '<w:p><w:r><w:br w:type="page"/></w:r></w:p>',
  odt = '<text:p text:style-name="Pagebreak"/>'
}

local function newpage(format)
  if format:match 'asciidoc' then
    return pandoc.RawBlock('asciidoc', pagebreak.asciidoc)
  elseif format == 'context' then
    return pandoc.RawBlock('context', pagebreak.context)
  elseif format == 'docx' then
    return pandoc.RawBlock('openxml', pagebreak.ooxml)
  elseif format:match 'epub' then
    return pandoc.RawBlock('html', pagebreak.epub)
  elseif format:match 'html.*' then
    return pandoc.RawBlock('html', pagebreak.html)
  elseif format:match 'latex' then
    return pandoc.RawBlock('tex', pagebreak.latex)
  elseif format:match 'ms' then
    return pandoc.RawBlock('ms', pagebreak.ms)
  elseif format:match 'odt' then
    return pandoc.RawBlock('opendocument', pagebreak.odt)
  else
    -- fall back to insert a form feed character
    return pandoc.Para{pandoc.Str '\f'}
  end
end

function Pandoc(doc)
  figures = {}
  doc:walk({
    Div = function(div)
      if div.identifier:sub(0, 3) == "fig" then
        table.insert(figures, div)
        table.insert(figures, newpage(FORMAT))
      end
    end
  })

  -- doc.meta.labels = {}
  -- Remove the title, which isn't needed
  doc.meta.title = pandoc.Inlines({})
  -- Remove page numbering
  if quarto.doc.is_format("pdf") then
    doc.meta["header-includes"][1]:insert(pandoc.RawBlock(
      "latex", "\\pagenumbering{gobble}"
    ))
  elseif quarto.doc.is_format("docx") then
    quarto.log.output(doc.meta)
  end

  return pandoc.Pandoc(figures, doc.meta)
end

-- print(
--       pandoc.writers
-- )
-- function Pandoc(code)
--   print("bar")
-- end

-- function Div(div)
--   if div.identifier:sub(0, 3) == "fig" then
--     file = assert(io.open(div.identifier .. "." .. FORMAT, "w"))
--     file:write(
--       pandoc.write(
--         pandoc.Pandoc(div), FORMAT, PANDOC_WRITER_OPTIONS
--       )
--     )
--   end
-- end
