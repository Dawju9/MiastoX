# manage_rbxl.py
import argparse
import os
import rblx_open_cloud
from rblx_open_cloud import RobloxOpenCloud

def upload_rbxl(api_key, universe_id, file_path):
    client = RobloxOpenCloud(api_key=api_key)
    try:
        print(f"Uploading {file_path} to Universe {universe_id}...")
        result = client.upload_place(universe_id=universe_id, file_path=file_path)
        if result['success']:
            print(f"Upload successful! Place ID: {result['placeId']}")
        else:
            print("Upload failed:", result['errorMessage'])
    except Exception as e:
        print("An error occurred:", e)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Upload .rbxl file to Roblox using Roblox Open Cloud API.")
    parser.add_argument('--api_key', required=True, help='Your Roblox Open Cloud API Key')
    parser.add_argument('--universe_id', required=True, help='The Universe ID to upload the .rbxl file to')
    parser.add_argument('--file_path', required=True, help='Path to the .rbxl file')

    args = parser.parse_args()
    upload_rbxl(args.api_key, args.universe_id, args.file_path)