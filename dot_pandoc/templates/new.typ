#import "dark-report.typ":*




#whole_doc(
    title: [HackTheBox Attacking Enterprise Networks],
    subtitle: [InlaneFreights Penetration Test],
    authors: (
    (name: [Alexander Chin-Lenn], affiliation: [HackTheBox], email: [alex@chin-tech.org])
),
    date: datetime.today().display(),

    doc: [
    #align(center)[= Title Time]
    This is the introduction portion

    #box(
        fill: rgb("#e64b540"),
        width: 100%,
        inset: 8pt,
    )[#block[Note] This is an alert]

    Code Block:
    ```python
    print("Hello, Typst")
    ```

    Customized
],



)

