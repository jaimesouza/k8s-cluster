def to_table_rows(pairs):

    template = '''
    <tr>
        <th class="align-middle" scope="row">{}</th>
        <td class="align-middle">{}</td>
        <td class="align-middle">{}</td>
        <td class="align-middle"><a href="/remove/{}" class="btn btn-danger">x</a></td>
    </tr>\n'''

    count = 1

    rows = ""

    for pair in pairs:

        key = pair['key']
        value = pair['value']

        rows = rows + template.format(count, key, value, key)

        count +=1

    return rows

def to_search_result(key, result):

    if result == None:
        return "Key \"{}\" not found".format(key)
    else:
        return "Key \"{}\" found. <br /><br /> The value is: {}".format(key, result['value'])
