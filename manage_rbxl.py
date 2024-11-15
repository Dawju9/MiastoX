# manage_rbxl.py
import argparse
import os

from rblx_open_cloud as RobloxOpenCloud
def upload_rbxl(api_key, universe_id, file_path):
    """
    Uploads a .rbxl file to Roblox using the Roblox Open Cloud API.

    Args: 
    game id = 4125094708
data-place-id="11633610328"
  data-universe-id  4125094708
        api_key (str): Your Roblox Open Cloud API Key
        universe_id (str): The Universe ID to upload the .rbxl file to
        file_path (str): Path to the .rbxl file

    Returns:
        None
    """
    if api_key is None:
        raise ValueError("api_key cannot be None")
    if universe_id is None:
        raise ValueError("universe_id cannot be None")
    if file_path is None:
        raise ValueError("file_path cannot be None")

    client = RobloxOpenCloud(api_key=api_key)
    try:
        print(f"Uploading {file_path} to Universe {universe_id}...")
        result = client.upload_place(universe_id=universe_id, file_path=file_path)
        if result is None:
            raise ValueError("upload_place returned None")
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