import os, re

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            path = os.path.join(root, file)
            with open(path, 'r', encoding='utf-8') as f:
                content = f.read()
            # The broken text has literal: abstract class ClassName with _`$1
            # We want to replace it with: abstract class ClassName with _$ClassName
            new_content = re.sub(r'abstract class (\w+) with _`\$1', r'abstract class \1 with _$\1', content)
            if new_content != content:
                with open(path, 'w', encoding='utf-8') as f:
                    f.write(new_content)
                print(f'Fixed {path}')
