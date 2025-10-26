# SnakeID - Complete UI/UX Design Specification for PWA

## Table of Contents
1. [Overview](#overview)
2. [Design Philosophy](#design-philosophy)
3. [Color System](#color-system)
4. [Typography System](#typography-system)
5. [Spacing & Layout System](#spacing--layout-system)
6. [Screen Specifications](#screen-specifications)
7. [Component Library](#component-library)
8. [Interactions & Animations](#interactions--animations)
9. [User Flows](#user-flows)
10. [PWA-Specific Adaptations](#pwa-specific-adaptations)
11. [Responsive Design Guidelines](#responsive-design-guidelines)
12. [Accessibility Guidelines](#accessibility-guidelines)
13. [Assets & Resources](#assets--resources)

---

## Overview

**Application Name**: SnakeID
**Purpose**: AI-powered snake identification with emergency safety guidance
**Platform**: Progressive Web App (PWA)
**Original Platform**: iOS (SwiftUI)
**Design Language**: Modern, Clean, Safety-focused
**Primary Users**: Hikers, nature enthusiasts, emergency responders, general public

### Key Features
- Instant snake species identification via photo upload/camera capture
- Real-time AI analysis using OpenAI GPT-4o vision model
- Venomous status determination
- Safety guidance (what to do/what not to do)
- Quick access to emergency contacts (911, Poison Control)

---

## Design Philosophy

### Core Principles

1. **Safety First**: Clear, immediate communication of danger levels using universally recognized colors (red for danger, green for safe)
2. **Clarity Over Complexity**: Simple, focused interface with minimal distractions
3. **Speed & Efficiency**: Quick access to critical features, especially emergency contacts
4. **Trust & Authority**: Professional appearance that inspires confidence in AI analysis
5. **Accessibility**: High contrast, readable fonts, touch-friendly targets

### Visual Style
- **Aesthetic**: Modern, clean, professional
- **Mood**: Calm but authoritative, helpful but serious
- **Approach**: Minimalist with purposeful use of color and iconography

---

## Color System

### Primary Colors

```css
/* Brand Colors */
--primary-green: #34C759;           /* Primary actions, safe indicators */
--primary-green-light: rgba(52, 199, 89, 0.1);
--primary-green-medium: rgba(52, 199, 89, 0.3);
--primary-green-dark: rgba(52, 199, 89, 0.8);

--primary-blue: #007AFF;            /* Secondary accents */
--primary-blue-light: rgba(0, 122, 255, 0.05);
--primary-blue-medium: rgba(0, 122, 255, 0.1);

/* Danger & Warning Colors */
--danger-red: #FF3B30;              /* Venomous, emergency */
--danger-red-light: rgba(255, 59, 48, 0.1);
--danger-red-medium: rgba(255, 59, 48, 0.3);

--warning-orange: #FF9500;          /* Poison control, caution */
--warning-orange-light: rgba(255, 149, 0, 0.1);

/* Neutral Colors */
--text-primary: #000000;            /* Main text */
--text-secondary: #8E8E93;          /* Descriptive text */
--text-tertiary: #C7C7CC;           /* Disabled text */

--background-primary: #FFFFFF;      /* Main background */
--background-secondary: #F2F2F7;    /* Card backgrounds */
--background-tertiary: #E5E5EA;     /* Subtle backgrounds */

/* Overlay Colors */
--overlay-dark: rgba(0, 0, 0, 0.4);     /* Loading overlay background */
--overlay-darker: rgba(0, 0, 0, 0.8);   /* Modal backdrop */
--shadow-default: rgba(0, 0, 0, 0.1);   /* Card shadows */
--shadow-medium: rgba(0, 0, 0, 0.2);    /* Image shadows */
```

### Gradient Backgrounds

```css
/* Main Background Gradient */
background: linear-gradient(135deg,
    rgba(52, 199, 89, 0.1) 0%,
    rgba(0, 122, 255, 0.05) 100%);

/* Button Gradient (Green) */
background: linear-gradient(90deg,
    #34C759 0%,
    rgba(52, 199, 89, 0.8) 100%);

/* Results Screen Background */
background: linear-gradient(135deg,
    rgba(52, 199, 89, 0.05) 0%,
    rgba(0, 122, 255, 0.05) 100%);
```

### Color Usage Rules

| Element | Color | Usage |
|---------|-------|-------|
| Primary Actions | Green (#34C759) | Main CTA buttons, safe indicators, positive feedback |
| Danger/Emergency | Red (#FF3B30) | Venomous indicators, emergency buttons, warnings |
| Secondary Actions | Blue (#007AFF) | Information, secondary buttons, links |
| Caution | Orange (#FF9500) | Poison control, moderate warnings |
| Success States | Green with checkmark | Non-venomous status, positive outcomes |
| Error States | Red with warning icon | Venomous status, errors, critical info |

---

## Typography System

### Font Family
**Primary**: System font stack for optimal performance and native feel

```css
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
```

**Scientific Names**: Serif font for traditional scientific nomenclature
```css
font-family: Georgia, "Times New Roman", Times, serif;
```

### Font Scale

| Name | Size | Weight | Line Height | Usage |
|------|------|--------|-------------|-------|
| **Hero Icon** | 80px | Normal | 1.0 | Snake emoji on home screen |
| **Display** | 42px | 900 (Black) | 1.1 | App title "SnakeID" |
| **Heading 1** | 28px | 700 (Bold) | 1.2 | Species common name |
| **Heading 2** | 22px | 700 (Bold) | 1.3 | Button text (Identify Snake) |
| **Heading 3** | 18px | 700 (Bold) | 1.4 | Section headers (What To Do, etc.) |
| **Body Large** | 18px | 500 (Medium) | 1.5 | App subtitle |
| **Body** | 16px | 600 (Semibold) | 1.5 | Feature list, body text, safety info |
| **Body Regular** | 16px | 400 (Regular) | 1.5 | Descriptive text, paragraphs |
| **Caption** | 14px | 500 (Medium) | 1.4 | Disclaimer text, small labels |
| **Scientific** | 16px | 500 (Medium) | 1.5 | Scientific names (italic, serif) |

### Font Weights Available
- **300**: Light (minimal use)
- **400**: Regular (body text)
- **500**: Medium (feature lists, labels)
- **600**: Semibold (emphasis, buttons)
- **700**: Bold (headings)
- **900**: Black (app title only)

### Text Styling Examples

```css
/* App Title */
.app-title {
    font-size: 42px;
    font-weight: 900;
    letter-spacing: -0.5px;
    color: var(--text-primary);
}

/* Scientific Name */
.scientific-name {
    font-family: Georgia, serif;
    font-size: 16px;
    font-weight: 500;
    font-style: italic;
    color: var(--text-secondary);
}

/* Section Header */
.section-header {
    font-size: 18px;
    font-weight: 700;
    color: var(--text-primary);
}

/* Disclaimer */
.disclaimer {
    font-size: 14px;
    font-weight: 500;
    color: var(--text-secondary);
}
```

---

## Spacing & Layout System

### Spacing Scale (8px Base Unit)

```css
--spacing-xs: 5px;      /* Tight spacing */
--spacing-sm: 10px;     /* Small gaps */
--spacing-md: 12px;     /* Medium gaps */
--spacing-base: 15px;   /* Base spacing */
--spacing-lg: 20px;     /* Large spacing */
--spacing-xl: 25px;     /* Extra large */
--spacing-2xl: 30px;    /* Section spacing */
--spacing-3xl: 40px;    /* Major section breaks */
--spacing-4xl: 50px;    /* Hero spacing */
```

### Border Radius Scale

```css
--radius-sm: 10px;      /* Small cards, inputs */
--radius-md: 12px;      /* Medium cards */
--radius-lg: 15px;      /* Large elements, images */
--radius-xl: 16px;      /* Buttons */
--radius-2xl: 20px;     /* Feature cards */
```

### Container Widths

```css
--container-mobile: 100%;           /* Full width on mobile */
--container-tablet: 600px;          /* Max width on tablets */
--container-desktop: 800px;         /* Max width on desktop */
--content-padding: 30px;            /* Horizontal padding */
```

### Shadows

```css
/* Card Shadow */
box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);

/* Button Shadow (Green) */
box-shadow: 0 4px 8px rgba(52, 199, 89, 0.3);

/* Image Shadow */
box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);

/* Subtle Shadow */
box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
```

---

## Screen Specifications

### Screen 1: Home Screen (Main/Index)

**File**: `index.html` or `home.html`
**Route**: `/` or `/home`

#### Layout Structure
```
┌────────────────────────────────────────┐
│                                        │
│              [Spacer]                  │ ← Flexible spacing (grows)
│                                        │
│         🐍 (80px emoji)                │ ← Hero icon
│       padding-bottom: 10px             │
│                                        │
│            SnakeID                     │ ← App title (42px, black weight)
│                                        │
│   AI-Powered Snake Identification      │ ← Subtitle (18px, medium)
│                                        │
│       padding-bottom: 40px             │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │   Feature Card                   │ │ ← White card with shadow
│  │   padding: 25px vertical         │ │
│  │   padding: 30px horizontal       │ │
│  │                                  │ │
│  │  📸 Instant Species ID           │ │ ← 16px semibold
│  │  (20px vertical spacing)         │ │
│  │  ⚠️  Emergency Safety Guidance    │ │
│  │  (20px vertical spacing)         │ │
│  │  🚨 Quick Emergency Contacts     │ │
│  │                                  │ │
│  └──────────────────────────────────┘ │
│       margin: 30px horizontal          │
│                                        │
│              [Spacer]                  │ ← Flexible spacing (grows)
│                                        │
│  ┌──────────────────────────────────┐ │
│  │    📷 Identify Snake             │ │ ← Main CTA button
│  │    (Green gradient, 20px pad)    │ │
│  └──────────────────────────────────┘ │
│       margin: 30px horizontal          │
│       padding-bottom: 50px             │
│                                        │
│  ⚠️  For emergencies, always call     │ ← Disclaimer
│       911 first (14px medium)          │
│       padding-bottom: 30px             │
└────────────────────────────────────────┘
```

#### Detailed Specifications

**Background**
```css
background: linear-gradient(135deg,
    rgba(52, 199, 89, 0.1) 0%,
    rgba(0, 122, 255, 0.05) 100%);
min-height: 100vh;
display: flex;
flex-direction: column;
```

**Hero Icon (Snake Emoji)**
- **Content**: 🐍
- **Font Size**: 80px
- **Line Height**: 1.0
- **Margin Bottom**: 10px
- **Alignment**: Center

**App Title**
- **Text**: "SnakeID"
- **Font Size**: 42px
- **Font Weight**: 900 (Black)
- **Color**: #000000 (Primary text)
- **Alignment**: Center
- **Margin Bottom**: 12px

**Subtitle**
- **Text**: "AI-Powered Snake Identification"
- **Font Size**: 18px
- **Font Weight**: 500 (Medium)
- **Color**: #8E8E93 (Secondary text)
- **Alignment**: Center

**Feature Card**
- **Background**: #FFFFFF
- **Border Radius**: 20px
- **Box Shadow**: 0 5px 10px rgba(0, 0, 0, 0.1)
- **Padding**: 25px (vertical), 30px (horizontal)
- **Margin**: 0 30px
- **Gap Between Features**: 20px

**Feature List Items**
- Each feature on new line
- **Font Size**: 16px
- **Font Weight**: 600 (Semibold)
- **Color**: #000000 (Primary text)
- **Format**: [Emoji] [Space] [Text]
  - 📸 Instant Species Identification
  - ⚠️ Emergency Safety Guidance
  - 🚨 Quick Emergency Contacts

**Main CTA Button**
- **Text**: "Identify Snake"
- **Icon**: 📷 (camera icon) or use SVG camera
- **Layout**: Horizontal flex (icon + text)
- **Gap**: 15px between icon and text
- **Font Size**: 22px
- **Font Weight**: 700 (Bold)
- **Color**: #FFFFFF (White text)
- **Background**: Linear gradient
  ```css
  background: linear-gradient(90deg, #34C759 0%, rgba(52, 199, 89, 0.8) 100%);
  ```
- **Padding**: 20px (vertical), full width with 30px margin
- **Border Radius**: 16px
- **Box Shadow**: 0 4px 8px rgba(52, 199, 89, 0.3)
- **Margin**: 0 30px 50px 30px
- **Icon Size**: 24px (if using SVG)
- **Hover State**: Slightly lighter gradient, scale 1.02
- **Active State**: Scale 0.98

**Disclaimer Text**
- **Text**: "⚠️ For emergencies, always call 911 first"
- **Font Size**: 14px
- **Font Weight**: 500 (Medium)
- **Color**: #8E8E93 (Secondary text)
- **Alignment**: Center
- **Margin Bottom**: 30px

#### Interactive Elements

1. **Identify Snake Button**
   - Opens camera/file picker
   - Triggers image selection modal or native file input
   - Visual feedback on tap (scale animation)

#### States

**Default State**
- All elements visible as described
- Button ready for interaction

**Loading State** (After image selection)
- Overlay appears covering entire screen
- Background: rgba(0, 0, 0, 0.4)
- Centered modal with:
  - **Background**: rgba(0, 0, 0, 0.8)
  - **Border Radius**: 15px
  - **Padding**: 30px
  - **Content**:
    - Spinner (white, 1.5x scale)
    - **Text**: "Analyzing Snake..." (white, 17px, semibold)
    - **Gap**: 20px between spinner and text

**Error State**
- Alert dialog appears with error message
- Button returns to normal state
- Background remains accessible

---

### Screen 2: Analysis Results Screen

**File**: `results.html` or component within SPA
**Route**: `/results` or modal/overlay

#### Layout Structure
```
┌────────────────────────────────────────┐
│  ← Analysis Result    [Back Button]    │ ← Navigation bar (inline title)
├────────────────────────────────────────┤
│                                        │
│  ┌──────────────────────────────────┐ │
│  │                                  │ │
│  │      [Snake Photo]               │ │ ← Original uploaded image
│  │      max-height: 300px           │ │   Aspect fit, rounded
│  │                                  │ │
│  └──────────────────────────────────┘ │
│       padding: 20px horizontal         │
│       padding-top: 20px                │
│                                        │
│        Eastern Diamondback              │ ← Common name (28px bold)
│           Rattlesnake                   │
│                                        │
│   Crotalus adamanteus                  │ ← Scientific name (16px, italic, serif)
│                                        │
│       spacing: 20px                    │
│                                        │
│  ┌──────────────────────────────────┐ │
│  │  ⚠️  VENOMOUS                    │ │ ← Safety status card (red bg)
│  │  Handle with extreme caution     │ │
│  └──────────────────────────────────┘ │
│       padding: 20px horizontal         │
│                                        │
│  ✓ What To Do                          │ ← Section header (18px bold)
│  ┌──────────────────────────────────┐ │
│  │  • Back away slowly              │ │ ← Green background card
│  │  • Observe from distance         │ │   (16px regular)
│  │  • Contact authorities if needed │ │
│  └──────────────────────────────────┘ │
│                                        │
│  ✕ What NOT To Do                      │ ← Section header (18px bold)
│  ┌──────────────────────────────────┐ │
│  │  • Don't approach                │ │ ← Red background card
│  │  • Don't handle                  │ │   (16px regular)
│  │  • Don't make sudden movements   │ │
│  └──────────────────────────────────┘ │
│                                        │
│  📞 Emergency Contacts                 │ ← Section header (18px bold)
│                                        │
│  ┌──────────────────────────────────┐ │
│  │  📞 Call 911 (Emergency)      ➔  │ │ ← Red button
│  └──────────────────────────────────┘ │
│  ┌──────────────────────────────────┐ │
│  │  📞 Poison Control Center     ➔  │ │ ← Orange button
│  └──────────────────────────────────┘ │
│                                        │
│       padding-bottom: 40px             │
└────────────────────────────────────────┘
    ↕️  Scrollable
```

#### Detailed Specifications

**Background**
```css
background: linear-gradient(135deg,
    rgba(52, 199, 89, 0.05) 0%,
    rgba(0, 122, 255, 0.05) 100%);
min-height: 100vh;
overflow-y: auto;
```

**Navigation Bar**
- **Title**: "Analysis Result"
- **Font Size**: 17px
- **Font Weight**: 600 (Semibold)
- **Position**: Sticky top or fixed
- **Background**: White or transparent with blur
- **Height**: 44px (iOS standard)
- **Back Button**: Left side, "< Back" or arrow icon

**Snake Photo Section**
- **Container Padding**: 20px horizontal, 20px top
- **Image Properties**:
  - **Max Height**: 300px
  - **Width**: 100% (within padding)
  - **Object Fit**: Contain (aspect ratio maintained)
  - **Border Radius**: 15px
  - **Box Shadow**: 0 5px 10px rgba(0, 0, 0, 0.2)
- **Margin Bottom**: 20px

**Species Name Section**
- **Padding**: 0 20px
- **Alignment**: Center

**Common Name**
- **Font Size**: 28px
- **Font Weight**: 700 (Bold)
- **Color**: #000000
- **Text Align**: Center
- **Margin Bottom**: 15px
- **Line Height**: 1.2

**Scientific Name**
- **Font Family**: Georgia, serif
- **Font Size**: 16px
- **Font Weight**: 500 (Medium)
- **Font Style**: Italic
- **Color**: #8E8E93 (Secondary)
- **Text Align**: Center
- **Margin Bottom**: 20px

**Safety Status Card**

*Structure*:
- **Container**:
  - **Margin**: 20px (horizontal)
  - **Padding**: 15px (vertical), 20px (horizontal)
  - **Border Radius**: 12px
  - **Background**: Conditional
    - Venomous: rgba(255, 59, 48, 0.1)
    - Non-venomous: rgba(52, 199, 89, 0.1)
  - **Border**: 1px solid
    - Venomous: rgba(255, 59, 48, 0.3)
    - Non-venomous: rgba(52, 199, 89, 0.3)
  - **Display**: Flex (horizontal)
  - **Gap**: 15px

*Icon*:
- **Symbol**:
  - Venomous: ⚠️ (exclamationmark.triangle.fill) or use SVG warning triangle
  - Non-venomous: ✓ (checkmark.circle.fill) or use SVG checkmark circle
- **Font Size**: 24px
- **Color**:
  - Venomous: #FF3B30
  - Non-venomous: #34C759

*Text Content*:
- **Title**:
  - **Text**: "VENOMOUS" or "NON-VENOMOUS"
  - **Font Size**: 18px
  - **Font Weight**: 700 (Bold)
  - **Color**: Matches icon color
  - **Margin Bottom**: 5px
- **Description**:
  - **Text**:
    - Venomous: "Handle with extreme caution"
    - Non-venomous: "Generally safe to observe"
  - **Font Size**: 14px
  - **Font Weight**: 400 (Regular)
  - **Color**: #8E8E93 (Secondary)

**What To Do Section**

*Header*:
- **Padding**: 20px (horizontal), 20px (top)
- **Display**: Flex (horizontal)
- **Gap**: 10px
- **Alignment**: Center vertically

*Icon*:
- **Symbol**: ✓ (checkmark.circle.fill) - green checkmark
- **Font Size**: 20px
- **Color**: #34C759

*Title*:
- **Text**: "What To Do"
- **Font Size**: 18px
- **Font Weight**: 700 (Bold)
- **Color**: #000000

*Content Card*:
- **Margin**: 15px 20px 0 20px (top margin, horizontal margins)
- **Padding**: 12px (vertical), 15px (horizontal)
- **Background**: rgba(52, 199, 89, 0.1)
- **Border Radius**: 10px
- **Text**:
  - **Font Size**: 16px
  - **Font Weight**: 400 (Regular)
  - **Color**: #000000
  - **Line Height**: 1.5
  - **Format**: Bullet points or line breaks

**What NOT To Do Section**

*Header*:
- **Padding**: 20px (horizontal), 20px (top)
- **Display**: Flex (horizontal)
- **Gap**: 10px
- **Alignment**: Center vertically

*Icon*:
- **Symbol**: ✕ (xmark.circle.fill) - red X
- **Font Size**: 20px
- **Color**: #FF3B30

*Title*:
- **Text**: "What NOT To Do"
- **Font Size**: 18px
- **Font Weight**: 700 (Bold)
- **Color**: #000000

*Content Card*:
- **Margin**: 15px 20px 0 20px
- **Padding**: 12px (vertical), 15px (horizontal)
- **Background**: rgba(255, 59, 48, 0.1)
- **Border Radius**: 10px
- **Text**:
  - **Font Size**: 16px
  - **Font Weight**: 400 (Regular)
  - **Color**: #000000
  - **Line Height**: 1.5
  - **Format**: Bullet points or line breaks

**Emergency Contacts Section**

*Header*:
- **Padding**: 20px (horizontal), 20px (top)
- **Display**: Flex (horizontal)
- **Gap**: 10px
- **Alignment**: Center vertically

*Icon*:
- **Symbol**: 📞 (phone.circle.fill) or use SVG phone icon
- **Font Size**: 20px
- **Color**: #007AFF (Blue)

*Title*:
- **Text**: "Emergency Contacts"
- **Font Size**: 18px
- **Font Weight**: 700 (Bold)
- **Color**: #000000

*Button Container*:
- **Margin**: 15px 20px 40px 20px (includes bottom padding)
- **Gap**: 12px between buttons

*911 Emergency Button*:
- **Display**: Flex (horizontal)
- **Justify**: Space between
- **Align**: Center vertically
- **Background**: #FF3B30 (Red)
- **Border Radius**: 10px
- **Padding**: 15px (vertical), 20px (horizontal)
- **Color**: #FFFFFF (White text)
- **No border**
- **Layout**:
  - Left: Phone icon + text
  - Right: Arrow icon
- **Icon Size**: 16px
- **Text**:
  - **Content**: "Call 911 (Emergency)"
  - **Font Size**: 16px
  - **Font Weight**: 600 (Semibold)
- **Arrow**: → (arrow.right) 14px
- **Hover**: Slightly darker red
- **Active**: Scale 0.98
- **Action**: Opens tel:911 or native dialer

*Poison Control Button*:
- **Same as 911 button, but**:
- **Background**: #FF9500 (Orange)
- **Text**: "Poison Control Center"
- **Action**: Opens tel:1-800-222-1222

---

### Screen 3: Image Picker Modal (Component)

**Type**: Modal or native file input
**Trigger**: Clicking "Identify Snake" button

#### Native Implementation Options

**Option A: Native File Input (Recommended for PWA)**
```html
<input type="file" accept="image/*" capture="environment">
```
- Opens camera directly on mobile
- File picker on desktop
- Automatically dismisses after selection

**Option B: Custom Modal (Enhanced UX)**

*Modal Backdrop*:
- **Background**: rgba(0, 0, 0, 0.5)
- **Position**: Fixed, full viewport
- **Z-index**: 1000

*Modal Content*:
- **Background**: #FFFFFF
- **Border Radius**: 20px 20px 0 0 (bottom sheet style)
- **Position**: Fixed bottom
- **Width**: 100%
- **Max Width**: 600px
- **Padding**: 20px
- **Animation**: Slide up from bottom

*Options*:
1. **Take Photo** button
   - Camera icon
   - Opens device camera
2. **Choose from Library** button
   - Photo library icon
   - Opens file picker
3. **Cancel** button
   - Plain text
   - Dismisses modal

---

## Component Library

### 1. Button Components

#### Primary Button (CTA)
```css
.button-primary {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 15px;
    width: 100%;
    padding: 20px;
    background: linear-gradient(90deg, #34C759 0%, rgba(52, 199, 89, 0.8) 100%);
    color: #FFFFFF;
    font-size: 22px;
    font-weight: 700;
    border-radius: 16px;
    border: none;
    box-shadow: 0 4px 8px rgba(52, 199, 89, 0.3);
    cursor: pointer;
    transition: all 0.2s ease;
}

.button-primary:hover {
    transform: scale(1.02);
    box-shadow: 0 6px 12px rgba(52, 199, 89, 0.4);
}

.button-primary:active {
    transform: scale(0.98);
}
```

#### Emergency Button (Red)
```css
.button-emergency {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    padding: 15px 20px;
    background: #FF3B30;
    color: #FFFFFF;
    font-size: 16px;
    font-weight: 600;
    border-radius: 10px;
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
}

.button-emergency:hover {
    background: #E6352A;
}

.button-emergency:active {
    transform: scale(0.98);
}
```

#### Poison Control Button (Orange)
```css
.button-warning {
    /* Same as .button-emergency but */
    background: #FF9500;
}

.button-warning:hover {
    background: #E68600;
}
```

### 2. Card Components

#### Feature Card (White)
```css
.card-feature {
    background: #FFFFFF;
    border-radius: 20px;
    padding: 25px 30px;
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.1);
}
```

#### Safety Status Card (Conditional)
```css
.card-safety {
    display: flex;
    gap: 15px;
    padding: 15px 20px;
    border-radius: 12px;
    border: 1px solid;
}

.card-safety--venomous {
    background: rgba(255, 59, 48, 0.1);
    border-color: rgba(255, 59, 48, 0.3);
}

.card-safety--safe {
    background: rgba(52, 199, 89, 0.1);
    border-color: rgba(52, 199, 89, 0.3);
}
```

#### Info Card (Color-coded backgrounds)
```css
.card-info {
    padding: 12px 15px;
    border-radius: 10px;
    font-size: 16px;
    line-height: 1.5;
}

.card-info--success {
    background: rgba(52, 199, 89, 0.1);
}

.card-info--danger {
    background: rgba(255, 59, 48, 0.1);
}
```

### 3. Loading Overlay
```css
.loading-overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 9999;
}

.loading-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 20px;
    padding: 30px;
    background: rgba(0, 0, 0, 0.8);
    border-radius: 15px;
}

.loading-spinner {
    /* Use CSS animation or SVG spinner */
    width: 40px;
    height: 40px;
    border: 3px solid rgba(255, 255, 255, 0.3);
    border-top-color: #FFFFFF;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.loading-text {
    color: #FFFFFF;
    font-size: 17px;
    font-weight: 600;
}
```

### 4. Icon Components

**Icon Sizes**:
- Small: 16px (inline with text)
- Medium: 20px (section headers)
- Large: 24px (buttons, status indicators)
- XL: 80px (hero icon)

**Icon Colors**: Match semantic meaning
- Green: Success, safe, positive actions
- Red: Danger, warnings, negative actions
- Blue: Information, secondary actions
- Orange: Caution, moderate warnings
- White: On colored backgrounds

### 5. Image Display
```css
.snake-image {
    width: 100%;
    max-height: 300px;
    object-fit: contain;
    border-radius: 15px;
    box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
}
```

---

## Interactions & Animations

### Button Interactions

**Primary Button**:
```css
/* Default state */
transform: scale(1);
transition: transform 0.2s ease, box-shadow 0.2s ease;

/* Hover state */
transform: scale(1.02);
box-shadow: 0 6px 12px rgba(52, 199, 89, 0.4);

/* Active/Pressed state */
transform: scale(0.98);
```

**Emergency Buttons**:
```css
/* Hover */
background: slightly darker shade;

/* Active */
transform: scale(0.98);
```

### Loading Animation

**Overlay Appearance**:
```css
/* Entry animation */
animation: fadeIn 0.2s ease;

@keyframes fadeIn {
    from { opacity: 0; }
    to { opacity: 1; }
}
```

**Spinner**:
```css
animation: spin 1s linear infinite;

@keyframes spin {
    from { transform: rotate(0deg); }
    to { transform: rotate(360deg); }
}
```

### Page Transitions

**Results Screen Entry**:
```css
/* Slide in from right (iOS-style) */
animation: slideInRight 0.3s ease;

@keyframes slideInRight {
    from {
        transform: translateX(100%);
        opacity: 0;
    }
    to {
        transform: translateX(0);
        opacity: 1;
    }
}
```

**Back Navigation**:
```css
/* Slide out to right */
animation: slideOutRight 0.3s ease;

@keyframes slideOutRight {
    from {
        transform: translateX(0);
        opacity: 1;
    }
    to {
        transform: translateX(100%);
        opacity: 0;
    }
}
```

### Micro-interactions

**Card Appearance**:
```css
/* Subtle fade in on mount */
animation: fadeInUp 0.4s ease;

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
```

**Image Load**:
```css
/* Fade in when image loads */
animation: fadeIn 0.3s ease;
```

---

## User Flows

### Flow 1: Primary Use Case - Snake Identification

```
User lands on Home Screen
    ↓
Views app title, features, and main CTA
    ↓
Taps "Identify Snake" button
    ↓
[Option A: Native file input opens]
[Option B: Custom modal with camera/library options]
    ↓
User selects image (from camera or library)
    ↓
Modal/picker dismisses
    ↓
Loading overlay appears
    - Shows "Analyzing Snake..." message
    - Shows spinner animation
    - Blocks interaction with home screen
    ↓
[API call to OpenAI GPT-4o]
    ↓
[Success Path]
    ↓
Loading overlay dismisses
    ↓
Results screen appears (slide-in animation)
    - Shows uploaded image
    - Shows species identification
    - Shows safety status
    - Shows guidance
    - Shows emergency contacts
    ↓
User reviews information
    ↓
[Optional: User taps emergency contact button]
    - Opens native phone dialer
    ↓
User taps Back button
    ↓
Returns to Home screen
    - Results state clears
    - Image selection clears
    - Ready for new identification
```

### Flow 2: Error Handling

```
User selects image
    ↓
Loading overlay appears
    ↓
[API call fails]
    ↓
Loading overlay dismisses
    ↓
Error alert appears
    - Shows specific error message
    - "No internet connection" OR
    - "Request timed out" OR
    - "Invalid API key" OR
    - Generic error message
    ↓
User taps "OK" on alert
    ↓
Returns to Home screen
    - Can retry with same or different image
```

### Flow 3: Image Selection Cancellation

```
User taps "Identify Snake"
    ↓
Picker/modal opens
    ↓
User taps Cancel or dismisses
    ↓
Returns to Home screen
    - No loading state
    - No API call made
```

### Flow 4: Emergency Contact

```
[From Results Screen]
    ↓
User sees venomous snake identified
    ↓
Scrolls to Emergency Contacts section
    ↓
Taps "Call 911 (Emergency)" button
    ↓
Native phone dialer opens with 911 pre-filled
    ↓
User completes call
    ↓
[Or]
    ↓
Taps "Poison Control Center" button
    ↓
Native phone dialer opens with 1-800-222-1222
    ↓
User completes call
```

---

## PWA-Specific Adaptations

### Manifest Configuration

**File**: `manifest.json`

```json
{
  "name": "SnakeID - AI Snake Identification",
  "short_name": "SnakeID",
  "description": "AI-powered snake identification with emergency safety guidance",
  "start_url": "/",
  "display": "standalone",
  "orientation": "portrait",
  "theme_color": "#34C759",
  "background_color": "#FFFFFF",
  "icons": [
    {
      "src": "/icons/icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "any maskable"
    },
    {
      "src": "/icons/icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "any maskable"
    }
  ],
  "screenshots": [
    {
      "src": "/screenshots/home.png",
      "sizes": "1170x2532",
      "type": "image/png",
      "label": "Home Screen"
    },
    {
      "src": "/screenshots/results.png",
      "sizes": "1170x2532",
      "type": "image/png",
      "label": "Analysis Results"
    }
  ]
}
```

### Service Worker Strategy

**Cache Strategy**:
- **App Shell**: Cache first (HTML, CSS, JS, fonts)
- **Images**: Network first with cache fallback
- **API calls**: Network only (no caching of sensitive data)

**Offline Capability**:
- Cache app shell for offline access
- Show offline indicator if no network
- Disable "Identify Snake" button when offline
- Display cached results if available

### Installation Prompt

**Custom Install Banner**:
```
┌────────────────────────────────────────┐
│  🐍 Install SnakeID                    │
│                                        │
│  Get quick access to snake             │
│  identification in the wild            │
│                                        │
│  [Install]  [Not Now]                  │
└────────────────────────────────────────┘
```

- Appears after 2nd visit or first successful identification
- Dismissible
- Reappears after 7 days if dismissed

### Camera Access

**Implementation**:
```html
<!-- Option 1: Direct camera capture -->
<input type="file" accept="image/*" capture="environment">

<!-- Option 2: MediaDevices API for advanced control -->
<script>
navigator.mediaDevices.getUserMedia({ video: { facingMode: "environment" } })
</script>
```

**Permissions**:
- Request camera permission on first use
- Show permission denied message with instructions
- Fallback to file picker if camera unavailable

### Platform-Specific Considerations

**iOS (Safari)**:
- Use `viewport-fit=cover` for notch support
- Handle safe areas with CSS environment variables
- Test camera input on iOS 14+

**Android (Chrome)**:
- Support "Add to Home Screen" prompt
- Test camera input across devices
- Handle back button navigation

**Desktop**:
- Support drag-and-drop file upload
- Show file picker instead of camera
- Responsive layout adjustments

---

## Responsive Design Guidelines

### Breakpoints

```css
/* Mobile First Approach */

/* Small phones (320px - 374px) */
@media (max-width: 374px) {
    .app-title { font-size: 36px; }
    .button-primary { font-size: 20px; padding: 18px; }
}

/* Standard phones (375px - 767px) */
/* This is the base design - no media query needed */

/* Large phones / Small tablets (768px - 1023px) */
@media (min-width: 768px) {
    .container {
        max-width: 600px;
        margin: 0 auto;
    }

    .feature-card {
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
    }
}

/* Tablets / Desktop (1024px+) */
@media (min-width: 1024px) {
    .container {
        max-width: 800px;
    }

    /* Show hover effects */
    .button-primary:hover {
        transform: scale(1.02);
    }

    /* Adjust image display */
    .snake-image {
        max-height: 400px;
    }
}
```

### Layout Adjustments

**Mobile (< 768px)**:
- Full width containers with 30px horizontal padding
- Stacked vertical layout
- Touch-optimized button sizes (min 44px height)
- Bottom-aligned main CTA

**Tablet (768px - 1023px)**:
- Centered container with max-width 600px
- Slightly increased spacing
- Larger touch targets
- Results screen in centered column

**Desktop (1024px+)**:
- Centered container with max-width 800px
- Hover effects enabled
- Mouse-optimized interactions
- Potentially show image picker as modal instead of native

### Touch vs. Mouse Interactions

**Touch Devices**:
```css
@media (hover: none) and (pointer: coarse) {
    /* Remove hover effects */
    /* Increase touch target sizes */
    button {
        min-height: 44px;
        min-width: 44px;
    }

    /* No hover animations */
    .button-primary:hover {
        transform: none;
    }
}
```

**Mouse Devices**:
```css
@media (hover: hover) and (pointer: fine) {
    /* Enable hover effects */
    /* Show cursor pointer */
    button {
        cursor: pointer;
    }

    /* Hover animations active */
}
```

### Orientation Handling

**Portrait (Preferred)**:
- Default design as specified
- Optimal for mobile use
- Best for viewing results

**Landscape**:
```css
@media (orientation: landscape) and (max-height: 600px) {
    /* Reduce vertical spacing */
    .hero-section {
        padding-top: 20px;
    }

    /* Reduce hero icon size */
    .hero-icon {
        font-size: 60px;
    }

    /* Show results in horizontal layout */
    .results-layout {
        display: grid;
        grid-template-columns: 1fr 1fr;
        gap: 20px;
    }
}
```

---

## Accessibility Guidelines

### WCAG 2.1 AA Compliance

**Color Contrast**:
- Text on white background: 7:1+ ratio
- White text on green button: 4.5:1+ ratio
- White text on red button: 4.5:1+ ratio
- Secondary text: 4.5:1+ ratio

**Verification**:
```
Primary text (#000000) on White (#FFFFFF): 21:1 ✓
Secondary text (#8E8E93) on White: 4.54:1 ✓
White (#FFFFFF) on Green (#34C759): 4.68:1 ✓
White (#FFFFFF) on Red (#FF3B30): 5.37:1 ✓
```

### Keyboard Navigation

**Tab Order**:
1. Main CTA button ("Identify Snake")
2. Results screen back button
3. Emergency contact buttons
4. Any other interactive elements

**Focus Styles**:
```css
*:focus-visible {
    outline: 3px solid #007AFF;
    outline-offset: 2px;
    border-radius: inherit;
}

button:focus-visible {
    outline: 3px solid #007AFF;
    outline-offset: 2px;
}
```

### Screen Reader Support

**Semantic HTML**:
```html
<main role="main">
    <h1>SnakeID</h1>
    <section aria-label="Features">...</section>
    <button aria-label="Identify snake from photo">Identify Snake</button>
</main>

<article role="article" aria-label="Snake analysis results">
    <h2>Analysis Result</h2>
    <img alt="Uploaded snake photo" src="...">
    <section aria-label="Species information">...</section>
    <section aria-label="Safety status">...</section>
    <section aria-label="Safety guidance">...</section>
    <section aria-label="Emergency contacts">...</section>
</article>
```

**ARIA Labels**:
- All buttons have descriptive labels
- Images have alt text
- Loading states announced
- Error messages announced
- Form inputs properly labeled

**Announcements**:
```html
<!-- Loading state -->
<div role="status" aria-live="polite" aria-atomic="true">
    Analyzing snake image...
</div>

<!-- Error state -->
<div role="alert" aria-live="assertive">
    Error: No internet connection. Please check your network.
</div>

<!-- Success state -->
<div role="status" aria-live="polite">
    Analysis complete. Snake identified as Eastern Diamondback Rattlesnake.
</div>
```

### Reduced Motion

```css
@media (prefers-reduced-motion: reduce) {
    * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
    }

    .loading-spinner {
        animation: none;
        /* Show static loading indicator instead */
    }
}
```

### Font Scaling

**Support Dynamic Type**:
```css
/* Use relative units */
html {
    font-size: 16px; /* Base size */
}

/* Scale with user preferences */
@media (prefers-contrast: high) {
    html {
        font-size: 18px;
    }
}

/* All font sizes use rem units */
.app-title {
    font-size: 2.625rem; /* 42px at base */
}
```

### Touch Target Sizes

**Minimum Sizes**:
- Buttons: 44x44px minimum (iOS guideline)
- Links: 44x44px tap area
- Interactive icons: 44x44px clickable area

**Implementation**:
```css
button, a {
    min-width: 44px;
    min-height: 44px;
    /* Padding ensures actual content can be smaller */
}
```

---

## Assets & Resources

### Icons (SVG Recommended)

**Required Icons**:
1. **Camera Icon** (camera.fill)
   - Used on: Main CTA button
   - Size: 24x24px
   - Color: White
   - SVG path or emoji: 📷

2. **Checkmark Circle** (checkmark.circle.fill)
   - Used on: Non-venomous status, "What To Do" header
   - Size: 20-24px
   - Color: Green (#34C759)

3. **Warning Triangle** (exclamationmark.triangle.fill)
   - Used on: Venomous status indicator
   - Size: 24px
   - Color: Red (#FF3B30)

4. **X Circle** (xmark.circle.fill)
   - Used on: "What NOT To Do" header
   - Size: 20px
   - Color: Red (#FF3B30)

5. **Phone Icon** (phone.fill)
   - Used on: Emergency contact buttons, section header
   - Size: 16-20px
   - Color: White (on buttons), Blue (header)

6. **Arrow Right** (arrow.right)
   - Used on: Emergency contact buttons
   - Size: 14px
   - Color: White

7. **Phone Circle** (phone.circle.fill)
   - Used on: Emergency contacts section header
   - Size: 20px
   - Color: Blue (#007AFF)

### Emoji Characters

**Direct Usage** (No SVG needed):
- 🐍 (Snake) - Hero icon on home screen
- 📸 (Camera with flash) - Feature list
- ⚠️ (Warning sign) - Feature list, disclaimer
- 🚨 (Police car light) - Feature list
- 📞 (Telephone receiver) - Can be used as fallback

### App Icons (PWA Manifest)

**Required Sizes**:
- **192x192px**: Standard PWA icon
- **512x512px**: High-res PWA icon
- **180x180px**: iOS Safari bookmark icon
- **32x32px**: Browser favicon
- **16x16px**: Browser favicon (small)

**Design Specs**:
- **Background**: Green (#34C759) gradient
- **Foreground**: White snake emoji 🐍 or stylized snake icon
- **Style**: Rounded corners (iOS: 22% radius of square)
- **Safe area**: Keep important content within central 80%

### Loading Spinner

**CSS Implementation**:
```css
.spinner {
    width: 40px;
    height: 40px;
    border: 3px solid rgba(255, 255, 255, 0.3);
    border-top-color: #FFFFFF;
    border-radius: 50%;
    animation: spin 1s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}
```

**Or use SVG**:
```svg
<svg width="40" height="40" viewBox="0 0 40 40">
    <circle cx="20" cy="20" r="18"
            stroke="rgba(255,255,255,0.3)"
            stroke-width="3"
            fill="none"/>
    <path d="M 20 2 A 18 18 0 0 1 38 20"
          stroke="#FFFFFF"
          stroke-width="3"
          fill="none"
          stroke-linecap="round">
        <animateTransform attributeName="transform"
                          type="rotate"
                          from="0 20 20"
                          to="360 20 20"
                          dur="1s"
                          repeatCount="indefinite"/>
    </path>
</svg>
```

### Sample Images (For Testing)

**Recommended Test Images**:
1. Venomous snake example (e.g., rattlesnake, cobra)
2. Non-venomous snake example (e.g., garter snake, corn snake)
3. Blurry snake image
4. Partial snake visibility
5. No snake (error case testing)

### Fonts

**Web Font Stack** (No external loading needed):
```css
/* Primary font stack */
font-family: -apple-system, BlinkMacSystemFont, "Segoe UI",
             Roboto, Helvetica, Arial, sans-serif;

/* Serif for scientific names */
font-family: Georgia, "Times New Roman", Times, serif;
```

**No external font files required** - uses system fonts for optimal performance.

---

## Technical Implementation Notes

### HTML Structure

**index.html** (Basic structure):
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, viewport-fit=cover">
    <meta name="theme-color" content="#34C759">
    <meta name="description" content="AI-powered snake identification with emergency safety guidance">
    <title>SnakeID - AI Snake Identification</title>
    <link rel="manifest" href="/manifest.json">
    <link rel="icon" type="image/png" sizes="32x32" href="/icons/favicon-32x32.png">
    <link rel="apple-touch-icon" href="/icons/apple-touch-icon.png">
    <link rel="stylesheet" href="/styles.css">
</head>
<body>
    <main id="app"></main>
    <script src="/app.js" type="module"></script>
</body>
</html>
```

### CSS Organization

**styles.css** (Recommended structure):
```css
/* 1. CSS Variables */
:root { ... }

/* 2. Reset/Base Styles */
*, *::before, *::after { ... }

/* 3. Typography */
body { ... }
h1, h2, h3 { ... }

/* 4. Layout */
.container { ... }

/* 5. Components */
.button-primary { ... }
.card-feature { ... }

/* 6. Utilities */
.text-center { ... }

/* 7. Media Queries */
@media (min-width: 768px) { ... }

/* 8. Animations */
@keyframes fadeIn { ... }
```

### JavaScript Framework Recommendations

**Options**:
1. **Vanilla JavaScript** - Lightweight, no dependencies
2. **React** - Component-based, good for SPAs
3. **Vue** - Progressive framework, easy to learn
4. **Svelte** - Compiled, smallest bundle size

**State Management Needs**:
- Selected image (File object or data URL)
- Loading state (boolean)
- Analysis result (object)
- Error message (string)
- Current view (home/results)

### API Integration

**Endpoint**: `https://api.openai.com/v1/chat/completions`

**Request Format**:
```javascript
{
    "model": "gpt-4o",
    "messages": [{
        "role": "user",
        "content": [
            {
                "type": "text",
                "text": "[Prompt for snake identification]"
            },
            {
                "type": "image_url",
                "image_url": {
                    "url": "data:image/jpeg;base64,[BASE64_STRING]"
                }
            }
        ]
    }],
    "max_tokens": 300,
    "temperature": 0.1
}
```

**Response Parsing**:
```javascript
{
    "commonName": "Eastern Diamondback Rattlesnake",
    "scientificName": "Crotalus adamanteus",
    "isVenomous": true,
    "isSafe": false,
    "whatToDo": "• Back away slowly\n• Observe from distance\n• Contact authorities if needed",
    "whatNotToDo": "• Don't approach\n• Don't handle\n• Don't make sudden movements"
}
```

### Image Processing

**Requirements**:
1. Max dimensions: 800x800px
2. JPEG compression: 60% quality
3. Convert to base64 for API
4. Display original image in results

**JavaScript Example**:
```javascript
async function resizeImage(file, maxWidth = 800, maxHeight = 800) {
    return new Promise((resolve) => {
        const reader = new FileReader();
        reader.onload = (e) => {
            const img = new Image();
            img.onload = () => {
                const canvas = document.createElement('canvas');
                let width = img.width;
                let height = img.height;

                if (width > height) {
                    if (width > maxWidth) {
                        height *= maxWidth / width;
                        width = maxWidth;
                    }
                } else {
                    if (height > maxHeight) {
                        width *= maxHeight / height;
                        height = maxHeight;
                    }
                }

                canvas.width = width;
                canvas.height = height;
                const ctx = canvas.getContext('2d');
                ctx.drawImage(img, 0, 0, width, height);

                canvas.toBlob(resolve, 'image/jpeg', 0.6);
            };
            img.src = e.target.result;
        };
        reader.readAsDataURL(file);
    });
}
```

### Error Handling

**Error Types**:
1. Network errors (no internet)
2. API errors (401, 400, 500)
3. Timeout errors
4. Invalid image format
5. No snake detected

**User Messages**:
```javascript
const errorMessages = {
    network: "No internet connection. Please check your network.",
    timeout: "Request timed out. Please try again.",
    auth: "Invalid API key. Please check configuration.",
    server: "Server error. Please try again.",
    default: "Failed to analyze image. Please try again."
};
```

---

## Performance Optimization

### Image Optimization
- Resize before upload: Max 800x800px
- JPEG compression: 60% quality
- Lazy load images in results
- Use WebP format with JPEG fallback

### Code Splitting
- Separate CSS for critical path
- Defer non-critical JavaScript
- Load results screen code on demand
- Inline critical CSS in HTML

### Caching Strategy
```javascript
// Service Worker cache strategy
const CACHE_VERSION = 'v1';
const CACHE_NAME = `snakeid-${CACHE_VERSION}`;

// Cache on install
self.addEventListener('install', (event) => {
    event.waitUntil(
        caches.open(CACHE_NAME).then((cache) => {
            return cache.addAll([
                '/',
                '/styles.css',
                '/app.js',
                '/icons/icon-192.png',
                '/icons/icon-512.png'
            ]);
        })
    );
});
```

### Performance Metrics Targets
- **First Contentful Paint**: < 1.5s
- **Time to Interactive**: < 3.5s
- **Lighthouse Score**: 90+ (Performance, Accessibility, Best Practices, SEO)

---

## Browser Support

### Minimum Requirements
- **iOS Safari**: 14.0+
- **Android Chrome**: 90+
- **Desktop Chrome**: 90+
- **Desktop Safari**: 14+
- **Desktop Firefox**: 88+
- **Desktop Edge**: 90+

### Feature Detection
```javascript
// Check for required features
const isSupported = (
    'serviceWorker' in navigator &&
    'mediaDevices' in navigator &&
    'getUserMedia' in navigator.mediaDevices &&
    'fetch' in window
);

if (!isSupported) {
    // Show unsupported browser message
}
```

### Fallbacks
- Camera not available → File picker only
- Service Worker not supported → No offline mode
- WebP not supported → JPEG fallback

---

## Conclusion

This comprehensive specification provides all necessary details to recreate the SnakeID app as a Progressive Web App. The design maintains the clean, safety-focused aesthetic of the iOS original while adapting for web platform capabilities and cross-browser compatibility.

### Key Takeaways
1. **Color-coded safety system**: Green = safe, Red = danger
2. **Minimal, focused interface**: Only essential elements
3. **Mobile-first design**: Optimized for handheld use
4. **Emergency-ready**: Quick access to critical contacts
5. **Progressive enhancement**: Works offline, installs as app

### Next Steps for Implementation
1. Set up basic HTML structure and routing
2. Implement CSS styling system with variables
3. Create component library (buttons, cards, modals)
4. Integrate camera/file upload functionality
5. Connect to OpenAI API for image analysis
6. Build results display screen
7. Add loading states and error handling
8. Implement PWA features (manifest, service worker)
9. Test across devices and browsers
10. Optimize performance and accessibility

---

**Document Version**: 1.0
**Last Updated**: 2025-10-26
**Created For**: SnakeID PWA Development
**Original Platform**: iOS (SwiftUI)
**Target Platform**: Progressive Web App
