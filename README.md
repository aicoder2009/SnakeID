
# SnakeID

A Progressive Web App that identifies snakes using AI-powered computer vision to help users determine if a snake is venomous or not.

## 🐍 Overview

SnakeID allows users to take photos of snakes and receive instant AI-powered identification with safety information. The app determines whether a snake is venomous, mildly venomous, or not venomous, providing detailed descriptions to help users make informed decisions about snake encounters.

## 🏗️ Architecture

```
┌─────────────────┐    ┌──────────────────┐    ┌─────────────────┐
│   Frontend      │    │   AWS Lambda     │    │   OpenAI API    │
│   (Next.js PWA)│───▶│   Function       │───▶│   Vision Model  │
│                 │    │                  │    │                 │
└─────────────────┘    └──────────────────┘    └─────────────────┘
         │                       │
         ▼                       ▼
┌─────────────────┐    ┌──────────────────┐
│   CloudFront    │    │   Function URL   │
│   Distribution  │    │   (HTTPS)        │
└─────────────────┘    └──────────────────┘
         │
         ▼
┌─────────────────┐
│   S3 Bucket     │
│   Static Hosting│
└─────────────────┘
```

## 📁 Project Structure

```
SnakeID/
├── frontend/
│   ├── pages/
│   │   ├── index.tsx          # Main application page
│   │   └── _app.tsx           # Next.js app wrapper
│   ├── components/
│   │   └── ui/
│   │       └── button.tsx     # Reusable button component
│   ├── public/
│   │   └── manifest.json      # PWA manifest
│   ├── deploy-s3.sh          # S3 deployment script (new bucket)
│   ├── deploy-existing.sh     # Quick deploy to existing bucket
│   ├── next.config.js         # Next.js configuration
│   ├── tailwind.config.js     # Tailwind CSS configuration
│   ├── package.json           # Dependencies and scripts
│   └── tsconfig.json          # TypeScript configuration
├── backend/
│   └── deploy-lambda.sh       # Lambda deployment script
├── .gitignore                # Git ignore rules
└── README.md                 # Project documentation
```

## 🛠️ Technology Stack

### Frontend
- **Next.js 14** - React framework with static site generation
- **TypeScript** - Type-safe JavaScript
- **Tailwind CSS** - Utility-first CSS framework
- **Lucide React** - Icon library
- **PWA Features** - Offline capability, installable

### Backend
- **AWS Lambda** - Serverless compute for image processing
- **OpenAI Vision API** - AI-powered snake identification
- **AWS Lambda Function URLs** - Direct HTTPS endpoints

### Infrastructure
- **Amazon S3** - Static website hosting
- **Amazon CloudFront** - Global CDN for fast delivery
- **AWS CLI** - Deployment automation

## 📱 Features

### Camera Functionality
- **Live Camera Preview** - Real-time video feed
- **Camera Switching** - Toggle between front/rear cameras
- **Manual Capture** - Take photos with explicit user action
- **Mobile Optimized** - Touch-friendly interface

### AI Identification
- **Instant Analysis** - Real-time snake identification
- **Safety Classification** - Venomous, mildly venomous, or not venomous
- **Detailed Descriptions** - Comprehensive information about identified species
- **Visual Indicators** - Color-coded safety status

### Progressive Web App
- **Installable** - Add to home screen on mobile devices
- **Responsive Design** - Works on all screen sizes
- **Fast Loading** - Optimized performance with CDN

## 🎯 Use Cases

### 1. Outdoor Enthusiasts
- **Hikers** - Identify snakes encountered on trails
- **Campers** - Assess safety around campsites
- **Nature Photographers** - Learn about snake species

### 2. Educational Purposes
- **Students** - Learn snake identification skills
- **Teachers** - Educational tool for biology classes
- **Researchers** - Quick field identification

### 3. Safety Applications
- **Homeowners** - Identify snakes in yards or gardens
- **Emergency Responders** - Quick species identification for medical treatment
- **Wildlife Control** - Professional snake identification

## 🔄 How It Works

### 1. Image Capture
```
User opens app → Camera preview → Take picture → Image captured
```

### 2. AI Processing
```
Image sent to Lambda → OpenAI Vision API → Snake analysis → Safety classification
```

### 3. Result Display
```
AI response → Safety status → Detailed description → Visual indicators
```

## 🚀 Deployment

### Prerequisites
- AWS CLI configured
- Node.js 18+
- OpenAI API key

### Local Development
```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Run development server
npm run dev

# Open browser to http://localhost:3000
```

### Frontend Deployment
```bash
# Build and deploy to new S3 bucket with CloudFront
cd frontend
./deploy-s3.sh

# Or quick deploy to existing bucket
cd frontend
./deploy-existing.sh

# Or manual deployment
cd frontend
npm run build
aws s3 sync out/ s3://$S3_BUCKET_NAME --delete

# Invalidate CloudFront cache for immediate updates
aws cloudfront create-invalidation --distribution-id $CLOUDFRONT_DISTRIBUTION_ID --paths "/*"
```

### Backend Deployment
```bash
# Deploy Lambda function
./backend/deploy-lambda.sh
```

## 📊 Safety Classifications

| Status | Color | Description |
|--------|-------|-------------|
| **Venomous** | 🔴 Red | Dangerous - seek immediate medical attention if bitten |
| **Mildly Venomous** | 🟡 Yellow | Caution - may cause mild symptoms |
| **Not Venomous** | 🟢 Green | Generally safe - still avoid handling |

## 🔧 Configuration

### Environment Variables
- `OPENAI_API_KEY` - OpenAI API key for vision processing
- `AWS_REGION` - AWS region for Lambda deployment

### Current Deployment
- **CloudFront URL**: Set via deployment scripts
- **S3 Bucket**: Set via `S3_BUCKET_NAME` environment variable
- **Lambda Function URL**: Set via `NEXT_PUBLIC_LAMBDA_URL` environment variable
- **CloudFront Distribution ID**: Set via `CLOUDFRONT_DISTRIBUTION_ID` environment variable

### Lambda Function URL
The app reads the Lambda endpoint from the `NEXT_PUBLIC_LAMBDA_URL` environment variable:
```typescript
const response = await fetch(process.env.NEXT_PUBLIC_LAMBDA_URL!, {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({ image: imageData.split(',')[1] })
})
```

## 📱 Mobile Experience

### Camera Controls
- **Large capture button** - Easy to tap "Take Picture" button
- **Camera flip** - Switch between front/rear cameras
- **Cancel option** - Exit camera without taking photo

### Responsive Design
- **Mobile-first** - Optimized for smartphone usage
- **Touch-friendly** - Large buttons and intuitive gestures
- **Fast loading** - Optimized images and code splitting

## 🔒 Security & Privacy

- **HTTPS Only** - All communications encrypted
- **No Image Storage** - Images processed in real-time, not stored
- **API Security** - OpenAI API key secured in Lambda environment
- **CORS Protection** - Proper cross-origin resource sharing

## 🌐 Browser Support

- **Chrome/Safari** - Full camera API support
- **Firefox** - Full functionality
- **Mobile browsers** - Optimized experience
- **PWA Support** - Install on iOS/Android

## 📈 Performance

- **CDN Delivery** - Global CloudFront distribution
- **Static Generation** - Pre-built pages for fast loading
- **Image Optimization** - Compressed assets
- **Lazy Loading** - Components loaded on demand

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Test thoroughly
5. Submit pull request

## ⚠️ Disclaimer

This app is for educational and informational purposes only. Always consult with wildlife experts or medical professionals for snake-related emergencies. The AI identification may not be 100% accurate in all cases.
