#!/usr/bin/env python3
"""Extract user and assistant messages from a Claude chat log JSONL file."""

import json
import sys


def extract(log_file):
    with open(log_file) as f:
        for line in f:
            try:
                e = json.loads(line)
                msg = e.get('message', {})
                role = msg.get('role', '')
                content = msg.get('content', '')
                if isinstance(content, list):
                    text = ' '.join(
                        c.get('text', '')
                        for c in content
                        if isinstance(c, dict) and c.get('type') == 'text'
                    )
                else:
                    text = str(content)
                if text.strip():
                    print(f'[{role}]: {text[:500]}')
            except Exception:
                pass


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: extract_chat_log.py <log_file>', file=sys.stderr)
        sys.exit(1)
    extract(sys.argv[1])
