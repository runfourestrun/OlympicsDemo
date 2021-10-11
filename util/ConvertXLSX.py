import xlrd
import csv
import os

'''helper function to convert files on csv from xlsx'''



def get_all_file_names(directory):
    paths = []
    for dirpath,_,filenames in os.walk(directory):
        for f in filenames:
            path = os.path.abspath(os.path.join(dirpath,f))
            paths.append(path)
    return paths



def create_csv_files(xlsx_file):
     path,ext = os.path.splitext(xlsx_file)
     csv_path = os.path.join(path + '.csv')
     return csv_path







if __name__ == '__main__':

    paths = get_all_file_names('/Users/alexanderfournier/documents/datasets/tokyo_olympics')
    for file in paths:
        csv_file = create_csv_files(file)
        my_csv_file = open(csv_file,'w')
        wr = csv.writer(my_csv_file,quoting=csv.QUOTE_ALL)
        xl_workbook = xlrd.open_workbook(file)
        xl_sheet = xl_workbook.sheet_by_index(0)
        for rownum in range(xl_sheet.nrows):
            wr.writerow(xl_sheet.row_values(rownum))
        my_csv_file.close()



    #     wb = xlrd.open_workbook(file)
    #
    #     csv_file = open()
    #     for row in data:
    #         l = list(row)
    #         print(l)




