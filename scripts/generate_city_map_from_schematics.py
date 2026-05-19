#!/usr/bin/env python3
"""Generate a city map JSON for the website using SchematicsAgent.
The script calls the internal `generate_roblox_schematic` function to produce an XML
layout, then extracts a minimal representation (chunk id, type) and writes a JSON
file that the web viewer can consume.
"""
import json
import xml.etree.ElementTree as ET
import os
import sys

# Adjust import path to locate SchematicsAgent package
script_dir = os.path.dirname(os.path.abspath(__file__))
project_root = os.path.abspath(os.path.join(script_dir, "..", ".."))
schematics_path = os.path.join(project_root, "SchematicsAgent")
sys.path.insert(0, schematics_path)

try:
    from SchematicAgent import generate_roblox_schematic
except Exception as e:
    print("Failed to import SchematicsAgent:", e)
    sys.exit(1)

# Output locations
assets_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "assets"))
os.makedirs(assets_dir, exist_ok=True)
xml_path = os.path.join(assets_dir, "city_map.xml")
json_path = os.path.join(assets_dir, "city_map.json")

# Generate XML schematic
print("Generating XML schematic...")
generate_roblox_schematic(xml_path, chunk_count=14)

# Parse XML and build a simple JSON structure
print("Parsing XML and building JSON representation...")
try:
    tree = ET.parse(xml_path)
    root = tree.getroot()
except Exception as e:
    print("Failed to parse generated XML:", e)
    sys.exit(1)

blocks = []
for i, chunk in enumerate(root.findall('Chunk')):
    block = {
        "id": i + 1,
        "type": chunk.attrib.get('type', 'unknown'),
        "position": {"x": i * 50, "y": 0, "z": 0},
        "difficulty": "easy"  # default – you can map chunk types to difficulty if desired
    }
    blocks.append(block)

with open(json_path, "w") as f:
    json.dump({"blocks": blocks}, f, indent=2)

print(f"City map JSON written to {json_path}")
