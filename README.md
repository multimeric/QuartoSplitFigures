# Quarto Split Figures

This is a simple extension for splitting your figures into multiple documents, one for each figure.
Some journals require you to submit each figure as a separate file, which this extension aims to facilitate.

## Installing

```bash
quarto add multimeric/QuartoSplitFigures
```

## Using

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

Then, you render your regular document as normal, but when you want to output the figures, you run `quarto render split-figures-docx`, and several docx files will be generated in your working directory.

## Example

[example.qmd](example.qmd) demonstrates a simple example of this.
It presents 3 figures, and the appropriate metadata.
Then, after running `quarto render example.qmd`, the following files will be created:
* `fig-js.docx`
* `fig-python.docx`
* `fig-r.docx`
