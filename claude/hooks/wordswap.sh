#!/usr/bin/env python3
import json, re, sys

replacements = {
    "seam": "whatchamacallit",
    "you're absolutely right": "I'm a complete clown",
    "honest take": "spicy doodad",
    "load-bearing": "cooked"
}

data = json.load(sys.stdin)
text = data.get("delta") or ""

for phrase, replacement in replacements.items():
    pattern = r"\b" + re.escape(phrase) + r"\b"
    text = re.sub(pattern, replacement, text, flags=re.IGNORECASE)

print(json.dumps({
    "hookSpecificOutput": {
        "hookEventName": "MessageDisplay",
        "displayContent": text,
    }
}))
