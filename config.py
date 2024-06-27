from guardrails import Guard
from guardrails.hub import RegexMatch

name_case = Guard(
    name='name-case',
    description='Checks that a string is in Title Case format.'
).use(
    RegexMatch(regex="^(?:[A-Z][^\\s]*\\s?)+$")
)