# Quarto Split Figures

This is a simple extension for splitting your figures into multiple documents, one for each figure.
Some journals require you to submit each figure as a separate file, which this extension aims to facilitate.

## Installing

```bash
quarto add multimeric/QuartoSplitFigures
```

## Usage

`QuartoSplitFigures` provides a new format for each of the main Quarto outputs.
These are:
    * `split-figures-docx`
    * `split-figures-pdf`
    * `split-figures-html`

For each format that you want to add figure generation to, you will have to add config to your quarto metadata to enable this format and the appropriate filter.
For example, if you want to output your figures in docx format, you would add the following to your Quarto metadata:
```yaml
format:
  split-figures-docx:
    filters:
      - quarto
      - split-figures
```
Note that the filter section is mandatory.

Then, you render your regular document as normal, but when you want to output the figures, you run `quarto render --to split-figures-docx`, and several docx files will be generated in your working directory.

## Example

[example.qmd](example.qmd) demonstrates a simple example of this.
It presents 3 figures, and the appropriate metadata.
Then, after running `quarto render example.qmd --to split-figures-docx`, the following files will be created:

* `fig-js.docx`
* `fig-python.docx`
* `fig-r.docx`

## Subfigures

If your document uses subfigures, `QuartoSplitFigures` will actually output one figure for each figure **and** subfigure.
So if you have figures 1a, 1b and 2, the extension will output four figures:

* Figure 1 (including both subfigures)
* Figure 1a
* Figure 1b
* Figure 2
## Known Issues

* The exact combination of `fig-align` and `layout-ncol` seems to cause the alignment to be lost

### PDF and LaTeX

LaTeX based formats are tricky, and improvements are welcome to how this is handled.
Firstly, to get PDF splitting to work, you have to put the split filter *before* Quarto:
```yaml
  split-figures-pdf:
    filters:
      - split-figures
```

However, even when you do this, Quarto will only output a `.latex` file for each figure, and not render a PDF.
You will have to run `pdflatex` on each `.latex` file to complete the transformation.

Unfortunately, figure numbering will be broken with PDF output. This is because, for LaTeX-based formats, the numbering is handled by LaTeX and not by Quarto, making it difficult if not impossible to split such a document.
