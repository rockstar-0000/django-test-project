from django import template


def extractFirstName(username):
    return username.split()[0]


register = template.Library()
register.filter('extractFirstName', extractFirstName)
