import { useState, useRef } from 'react'
import Head from 'next/head'
import { Camera, Phone, ArrowRight, CheckCircle, XCircle, AlertTriangle } from 'lucide-react'

interface SnakeResult {
  commonName: string
  scientificName: string
  isVenomous: boolean
  whatToDo: string
  whatNotToDo: string
  description?: string
}

export default function Home() {
  const [image, setImage] = useState<string | null>(null)
  const [result, setResult] = useState<SnakeResult | null>(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)

  const handleImageUpload = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (file) {
      const reader = new FileReader()
      reader.onload = (e) => {
        const imageData = e.target?.result as string
        setImage(imageData)
        identifySnake(imageData)
      }
      reader.readAsDataURL(file)
    }
  }

  const parseAIResponse = (description: string): SnakeResult => {
    // Try to extract structured information from the AI response
    const lines = description.split('\n').filter(line => line.trim())

    let commonName = 'Unknown Snake'
    let scientificName = 'Species unknown'
    let isVenomous = false
    let whatToDo = '• Keep a safe distance\n• Observe calmly\n• Contact wildlife professionals if needed'
    let whatNotToDo = '• Don\'t approach the snake\n• Don\'t attempt to handle it\n• Don\'t make sudden movements'

    // Look for venomous indicators
    const venomousKeywords = ['venomous', 'dangerous', 'toxic', 'poisonous', 'rattlesnake', 'cobra', 'viper', 'mamba']
    const descLower = description.toLowerCase()
    isVenomous = venomousKeywords.some(keyword => descLower.includes(keyword))

    // Try to extract species name from first line or look for capitalized words
    for (const line of lines) {
      if (line.includes('(') && line.includes(')')) {
        // Likely contains scientific name in parentheses
        const match = line.match(/([^(]+)\(([^)]+)\)/)
        if (match) {
          commonName = match[1].trim()
          scientificName = match[2].trim()
          break
        }
      }
    }

    // If still unknown, use first substantial line as common name
    if (commonName === 'Unknown Snake' && lines.length > 0) {
      const firstLine = lines[0].replace(/^(species|snake|identified as):/i, '').trim()
      if (firstLine.length > 3) {
        commonName = firstLine
      }
    }

    // Customize advice based on venomous status
    if (isVenomous) {
      whatToDo = '• Back away slowly and calmly\n• Maintain a safe distance (at least 6 feet)\n• Contact emergency services if bitten\n• Remember the snake\'s appearance for medical treatment'
      whatNotToDo = '• Don\'t attempt to catch or kill the snake\n• Don\'t get close to take photos\n• Don\'t make sudden movements\n• Don\'t try to suck out venom if bitten'
    } else {
      whatToDo = '• Observe from a safe distance\n• Allow the snake to move away naturally\n• Take photos from a distance if desired\n• Appreciate this wildlife encounter'
      whatNotToDo = '• Don\'t attempt to handle the snake\n• Don\'t corner or provoke it\n• Don\'t assume all non-venomous snakes are safe to touch'
    }

    return {
      commonName,
      scientificName,
      isVenomous,
      whatToDo,
      whatNotToDo,
      description
    }
  }

  const identifySnake = async (imageData: string) => {
    setLoading(true)
    setError(null)
    try {
      const response = await fetch('https://42znlandtww7wnpuarx5dy2rt40kajds.lambda-url.us-east-1.on.aws/', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ image: imageData.split(',')[1] })
      })

      if (!response.ok) {
        throw new Error('Failed to analyze image')
      }

      const data = await response.json()
      const parsedResult = parseAIResponse(data.description || data.status || 'Unable to identify snake')
      setResult(parsedResult)
    } catch (error) {
      setError('Failed to analyze image. Please try again.')
      setResult(null)
    }
    setLoading(false)
  }

  const handleBackToHome = () => {
    setImage(null)
    setResult(null)
    setError(null)
  }

  const handleCall = (number: string) => {
    window.location.href = `tel:${number}`
  }

  // Home Screen
  if (!image && !result) {
    return (
      <>
        <Head>
          <title>SnakeID - AI Snake Identification</title>
          <meta name="description" content="AI-Powered Snake Identification" />
          <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
          <meta name="theme-color" content="#34C759" />
        </Head>

        <div
          className="min-h-screen flex flex-col"
          style={{
            background: 'linear-gradient(135deg, rgba(52, 199, 89, 0.1) 0%, rgba(0, 122, 255, 0.05) 100%)'
          }}
        >
          {/* Flexible spacer */}
          <div className="flex-grow" />

          {/* Hero Section */}
          <div className="text-center px-8">
            <div className="text-[80px] leading-none mb-[10px]">🐍</div>
            <h1 className="text-[42px] font-black mb-3 tracking-tight" style={{ color: 'var(--text-primary)' }}>
              SnakeID
            </h1>
            <p className="text-lg font-medium mb-10" style={{ color: 'var(--text-secondary)' }}>
              AI-Powered Snake Identification
            </p>
          </div>

          {/* Feature Card */}
          <div className="mx-[30px] mb-8 animate-fade-in-up">
            <div
              className="bg-white p-[25px] rounded-[20px]"
              style={{ boxShadow: '0 5px 10px var(--shadow-default)' }}
            >
              <div className="space-y-5">
                <div className="text-base font-semibold flex items-center gap-2">
                  <span>📸</span>
                  <span>Instant Species Identification</span>
                </div>
                <div className="text-base font-semibold flex items-center gap-2">
                  <span>⚠️</span>
                  <span>Emergency Safety Guidance</span>
                </div>
                <div className="text-base font-semibold flex items-center gap-2">
                  <span>🚨</span>
                  <span>Quick Emergency Contacts</span>
                </div>
              </div>
            </div>
          </div>

          {/* Flexible spacer */}
          <div className="flex-grow" />

          {/* Main CTA Button */}
          <div className="mx-[30px] mb-[50px]">
            <button
              onClick={() => fileInputRef.current?.click()}
              className="w-full flex items-center justify-center gap-4 py-5 px-6 text-white text-[22px] font-bold rounded-2xl transition-transform active:scale-[0.98] hover:scale-[1.02]"
              style={{
                background: 'linear-gradient(90deg, #34C759 0%, rgba(52, 199, 89, 0.8) 100%)',
                boxShadow: '0 4px 8px var(--primary-green-medium)'
              }}
            >
              <Camera size={24} />
              <span>Identify Snake</span>
            </button>
          </div>

          {/* Disclaimer */}
          <div className="text-center px-8 pb-[30px]">
            <p className="text-sm font-medium" style={{ color: 'var(--text-secondary)' }}>
              ⚠️ For emergencies, always call 911 first
            </p>
          </div>

          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            capture="environment"
            onChange={handleImageUpload}
            className="hidden"
          />
        </div>
      </>
    )
  }

  // Results Screen
  return (
    <>
      <Head>
        <title>Analysis Result - SnakeID</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover" />
        <meta name="theme-color" content="#34C759" />
      </Head>

      <div
        className="min-h-screen overflow-y-auto animate-slide-in"
        style={{
          background: 'linear-gradient(135deg, rgba(52, 199, 89, 0.05) 0%, rgba(0, 122, 255, 0.05) 100%)'
        }}
      >
        {/* Navigation Bar */}
        <div className="sticky top-0 bg-white/80 backdrop-blur-md border-b border-gray-200 z-10">
          <div className="flex items-center h-11 px-4">
            <button
              onClick={handleBackToHome}
              className="text-[#007AFF] text-[17px] font-semibold flex items-center gap-1"
            >
              <span className="text-xl">‹</span>
              <span>Back</span>
            </button>
            <div className="flex-grow text-center">
              <h2 className="text-[17px] font-semibold">Analysis Result</h2>
            </div>
            <div className="w-16" /> {/* Spacer for centering */}
          </div>
        </div>

        {/* Loading State */}
        {loading && (
          <div className="fixed inset-0 z-50 flex items-center justify-center animate-fade-in" style={{ background: 'var(--overlay-dark)' }}>
            <div className="flex flex-col items-center gap-5 p-8 rounded-2xl" style={{ background: 'var(--overlay-darker)' }}>
              <div className="w-10 h-10 border-3 border-white/30 border-t-white rounded-full animate-spin" />
              <p className="text-white text-[17px] font-semibold">Analyzing Snake...</p>
            </div>
          </div>
        )}

        {/* Error State */}
        {error && !loading && (
          <div className="p-5 m-5 bg-red-50 border border-red-200 rounded-xl">
            <p className="text-red-800 text-center">{error}</p>
            <button
              onClick={handleBackToHome}
              className="mt-4 w-full py-3 bg-red-600 text-white rounded-lg font-semibold"
            >
              Try Again
            </button>
          </div>
        )}

        {/* Snake Photo */}
        {image && (
          <div className="px-5 pt-5 pb-5">
            <img
              src={image}
              alt="Snake"
              className="w-full max-h-[300px] object-contain rounded-2xl"
              style={{ boxShadow: '0 5px 10px var(--shadow-medium)' }}
            />
          </div>
        )}

        {/* Results Content */}
        {result && !loading && (
          <div className="px-5 space-y-5 pb-10 animate-fade-in-up">
            {/* Species Names */}
            <div className="text-center">
              <h1 className="text-[28px] font-bold leading-tight mb-4" style={{ color: 'var(--text-primary)' }}>
                {result.commonName}
              </h1>
              <p className="scientific-name text-base font-medium mb-5" style={{ color: 'var(--text-secondary)' }}>
                {result.scientificName}
              </p>
            </div>

            {/* Safety Status Card */}
            <div
              className="flex gap-4 p-4 rounded-xl border"
              style={{
                background: result.isVenomous ? 'var(--danger-red-light)' : 'var(--primary-green-light)',
                borderColor: result.isVenomous ? 'var(--danger-red-medium)' : 'var(--primary-green-medium)'
              }}
            >
              <div className="flex-shrink-0">
                {result.isVenomous ? (
                  <AlertTriangle size={24} style={{ color: 'var(--danger-red)' }} />
                ) : (
                  <CheckCircle size={24} style={{ color: 'var(--primary-green)' }} />
                )}
              </div>
              <div>
                <div
                  className="text-lg font-bold mb-1"
                  style={{ color: result.isVenomous ? 'var(--danger-red)' : 'var(--primary-green)' }}
                >
                  {result.isVenomous ? 'VENOMOUS' : 'NON-VENOMOUS'}
                </div>
                <div className="text-sm" style={{ color: 'var(--text-secondary)' }}>
                  {result.isVenomous ? 'Handle with extreme caution' : 'Generally safe to observe'}
                </div>
              </div>
            </div>

            {/* What To Do Section */}
            <div>
              <div className="flex items-center gap-2 mb-4">
                <CheckCircle size={20} style={{ color: 'var(--primary-green)' }} />
                <h3 className="text-lg font-bold">What To Do</h3>
              </div>
              <div
                className="p-3 rounded-lg whitespace-pre-line"
                style={{ background: 'var(--primary-green-light)' }}
              >
                <p className="text-base leading-relaxed">{result.whatToDo}</p>
              </div>
            </div>

            {/* What NOT To Do Section */}
            <div>
              <div className="flex items-center gap-2 mb-4">
                <XCircle size={20} style={{ color: 'var(--danger-red)' }} />
                <h3 className="text-lg font-bold">What NOT To Do</h3>
              </div>
              <div
                className="p-3 rounded-lg whitespace-pre-line"
                style={{ background: 'var(--danger-red-light)' }}
              >
                <p className="text-base leading-relaxed">{result.whatNotToDo}</p>
              </div>
            </div>

            {/* Emergency Contacts Section */}
            <div>
              <div className="flex items-center gap-2 mb-4">
                <Phone size={20} style={{ color: 'var(--primary-blue)' }} />
                <h3 className="text-lg font-bold">Emergency Contacts</h3>
              </div>
              <div className="space-y-3">
                {/* 911 Button */}
                <button
                  onClick={() => handleCall('911')}
                  className="w-full flex items-center justify-between p-4 rounded-lg text-white font-semibold transition-transform active:scale-[0.98]"
                  style={{ background: 'var(--danger-red)' }}
                >
                  <div className="flex items-center gap-2">
                    <Phone size={16} />
                    <span>Call 911 (Emergency)</span>
                  </div>
                  <ArrowRight size={14} />
                </button>

                {/* Poison Control Button */}
                <button
                  onClick={() => handleCall('1-800-222-1222')}
                  className="w-full flex items-center justify-between p-4 rounded-lg text-white font-semibold transition-transform active:scale-[0.98]"
                  style={{ background: 'var(--warning-orange)' }}
                >
                  <div className="flex items-center gap-2">
                    <Phone size={16} />
                    <span>Poison Control Center</span>
                  </div>
                  <ArrowRight size={14} />
                </button>
              </div>
            </div>
          </div>
        )}
      </div>
    </>
  )
}
