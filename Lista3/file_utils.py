import csv


def read_csv_file(filename, delimiter=','):
    with open(filename) as csv_file:
        csv_reader = csv.DictReader(csv_file, delimiter=delimiter)
        rows = [row for row in csv_reader]
        return rows
