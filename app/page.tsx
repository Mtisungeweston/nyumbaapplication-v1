export default function Page() {
  return (
    <div style={{ padding: '40px', textAlign: 'center' }}>
      <h1>Nyumba - Flutter Mobile App</h1>
      <p>This is a Flutter mobile application project for a housing marketplace in Malawi.</p>
      <p>The frontend is built with Flutter, not Next.js/React.</p>
      
      <h2>Getting Started</h2>
      <pre style={{ background: '#f5f5f5', padding: '20px', borderRadius: '8px', textAlign: 'left' }}>
{`flutter clean
flutter pub get
flutter build apk --release

# Test Credentials:
# Phone: +265991972355
# OTP: 123456`}
      </pre>

      <h2>Project Details</h2>
      <ul style={{ textAlign: 'left', maxWidth: '600px', margin: '0 auto' }}>
        <li>Frontend: Flutter (Mobile)</li>
        <li>State Management: Provider</li>
        <li>Navigation: GoRouter</li>
        <li>Authentication: Mock OTP (ready for PHP backend)</li>
        <li>Data: Mock/Test data for frontend testing</li>
        <li>Backend: To be integrated with PHP later</li>
      </ul>

      <h2>Documentation</h2>
      <ul style={{ textAlign: 'left', maxWidth: '600px', margin: '0 auto' }}>
        <li><a href="/BUILD_AND_TEST.md">Build & Test Guide</a></li>
        <li><a href="/PROJECT_STATUS.md">Project Status</a></li>
      </ul>
    </div>
  );
}
