import boto3

# Initialize a session using Amazon IAM
iam = boto3.client('iam')

def list_iam_users():
    try:
        # Retrieve the list of IAM users
        response = iam.list_users()

        # Print out each user's information
        print("Listing IAM Users:")
        for user in response['Users']:
            print(f"User Name: {user['UserName']}, User ID: {user['UserId']}, Created On: {user['CreateDate']}")
    except Exception as e:
        print(f"An error occurred: {e}")

# Call the function
if __name__ == "__main__":
    list_iam_users()

