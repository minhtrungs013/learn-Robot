def custom_keyword():
    print("This is a custom keyword")


def clean_underscores(text):
    return text.replace(' - ', '_').replace(' _', '_').replace('_ ', '_')


def is_substring(substring, string):
    """Kiểm tra xem 'substring' có nằm trong 'string' hay không."""
    return substring in string
