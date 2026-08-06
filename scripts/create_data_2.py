import fitz
import pandas as pd
import nltk
import re

doc = fitz.open("../data/its_perfectly_normal.pdf")

rows = []
current_chapter = None

for page_num, page in enumerate(doc[6:98], start=1):

    # Extract page layout
    page_dict = page.get_text("dict")

    spans = []

    for block in page_dict["blocks"]:
        if "lines" in block:
            for line in block["lines"]:
                for span in line["spans"]:
                    spans.append(span)

    # Detect chapter number
    for span in spans:
        text = span["text"].strip()

        if text.isdigit() and span["size"] == 18.0:
            current_chapter = int(text)


    # Extract page text
    text_parts = []

    for span in spans:
        if span["size"] == 10.5:   # adjust these values as needed
            text_parts.append(span["text"])

    page_text = " ".join(text_parts)


    page_text = re.sub(r"-\n", "", page_text)       # remove hyphenated breaks
    page_text = re.sub(r"\n", " ", page_text)      # join lines
    page_text = re.sub(r"\s+", " ", page_text)     # remove extra spaces

    # Split into sentences
    sentences = nltk.sent_tokenize(page_text)

    # Store rows
    for sentence in sentences:
        sentence = sentence.strip()

        if len(sentence.split()) > 2\
                and sentence\
                and sentence[0].isupper():   # only keep non-empty sentences

            rows.append({
                "chapter": current_chapter,
                "page": page_num,
                "text": sentence
            })

df = pd.DataFrame(rows)

df.to_csv("../data/sentences2.csv", index=False)


#page = doc[8]  # page index (0-based)
#
#data = page.get_text("dict")
#
# for block in data["blocks"]:
#     if "lines" not in block:
#         continue
#
#     for line in block["lines"]:
#         for span in line["spans"]:
#             print(
#                 repr(span["text"]),
#                 "size:", span["size"],
#                 "font:", span["font"],
#                 "y:", span["bbox"][1]
#             )
