import sys
content = open('mockdata.sql').read()
content = content.replace("\\'", "''")
open('mockdata.sql', 'w').write(content)
