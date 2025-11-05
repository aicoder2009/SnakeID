import json
import base64
import os
import boto3

def lambda_handler(event, context):
    try:
        # Initialize Bedrock client
        bedrock = boto3.client('bedrock-runtime', region_name=os.environ.get('AWS_REGION', 'us-east-1'))

        # Parse the request body
        body = json.loads(event['body']) if isinstance(event['body'], str) else event['body']
        image_data = body['image']

        # Create the prompt for snake identification
        prompt = """Analyze this image of a snake and provide:
1. Species identification (if possible)
2. Safety classification: "Venomous", "Mildly Venomous", or "Not Venomous"
3. Brief description with key identifying features
4. Safety advice

Format your response as JSON with 'status' and 'description' fields."""

        # Use AWS Bedrock with Claude 3 Haiku (cheapest multimodal model)
        # Note: Llama models don't support image analysis, so using Claude 3 Haiku for cost-effectiveness
        request_body = {
            "anthropic_version": "bedrock-2023-05-31",
            "max_tokens": 500,
            "messages": [
                {
                    "role": "user",
                    "content": [
                        {
                            "type": "image",
                            "source": {
                                "type": "base64",
                                "media_type": "image/jpeg",
                                "data": image_data
                            }
                        },
                        {
                            "type": "text",
                            "text": prompt
                        }
                    ]
                }
            ]
        }

        # Call Bedrock API
        response = bedrock.invoke_model(
            modelId="anthropic.claude-3-haiku-20240307-v1:0",
            body=json.dumps(request_body)
        )

        # Parse the response
        response_body = json.loads(response['body'].read())
        ai_response = response_body['content'][0]['text']
        
        # Try to extract JSON from response
        try:
            # Look for JSON in the response
            start = ai_response.find('{')
            end = ai_response.rfind('}') + 1
            if start != -1 and end != 0:
                result = json.loads(ai_response[start:end])
            else:
                # Fallback: parse manually
                lines = ai_response.split('\n')
                status = "Unknown"
                description = ai_response
                
                for line in lines:
                    if any(word in line.lower() for word in ['venomous', 'dangerous', 'poisonous']):
                        if 'not' in line.lower() or 'non' in line.lower():
                            status = "Not Venomous"
                        elif 'mildly' in line.lower() or 'slightly' in line.lower():
                            status = "Mildly Venomous"
                        else:
                            status = "Venomous"
                        break
                
                result = {
                    "status": status,
                    "description": description
                }
        except:
            result = {
                "status": "Unknown",
                "description": ai_response
            }
        
        return {
            'statusCode': 200,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST, OPTIONS'
            },
            'body': json.dumps(result)
        }
        
    except Exception as e:
        return {
            'statusCode': 500,
            'headers': {
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Headers': 'Content-Type',
                'Access-Control-Allow-Methods': 'POST, OPTIONS'
            },
            'body': json.dumps({
                'status': 'Error',
                'description': f'Error processing image: {str(e)}'
            })
        }
