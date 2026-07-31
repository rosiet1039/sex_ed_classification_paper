# Purpose: This file contains the code to create the sex ed dataset
# Author: Rosemarie Topp
# Date: 15 July 2026
# Contact: rosie.topp@mail.utoronto.ca
# Pre-requisites: Install pdfminer, nltk, re, csv packages

# loading libraries
from pdfminer.high_level import extract_pages
from pdfminer.layout import LTTextContainer
import nltk
import re
import csv
nltk.download("punkt")
nltk.download("punkt_tab")

#extract text from pdf
pages = range(6, 97)
def extract_main_text(pdf_path):
    text = ""

    for page_layout in extract_pages(pdf_path, page_numbers = pages ):

        page_width = page_layout.width
        page_height = page_layout.height

        for element in page_layout:

            if isinstance(element, LTTextContainer):

                x0, y0, x1, y1 = element.bbox

                #ignoring text in margins
                if (
                        x0 > 50 and
                        x1 < page_width - 50 and
                        y0 > 50 and
                        y1 < page_height - 50
                ):
                    text += element.get_text()

    return text

text = extract_main_text("../data/its_perfectly_normal.pdf")

#extract unnecessary spaces and newlines
text = re.sub(r"\n+", " ", text)
text = re.sub(r"\s+", " ", text).strip()

#tokenize sentences
sentences = nltk.sent_tokenize(text)

clean_sentences = [
    s.strip()
    for s in sentences
    if s.strip()
    and re.search(r"[A-Za-z]", s)
    and s.strip()[0].isupper()
]

#write tokens into csv file
with open("../data/sentences.csv", "w", newline="", encoding="utf-8") as file:
    writer = csv.writer(file)
    writer.writerow(["sentence"])
    for sentence in clean_sentences:
        writer.writerow([sentence])
