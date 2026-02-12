# Nyumba - Housing Marketplace Flutter App

## Complete Extended Version with Full User Flow

A fully functional Flutter real estate marketplace app with phone authentication, role-based dashboards, property browsing, and profile management. All built with mock test data ready for backend integration.

### Project Structure

```
lib/
├── main.dart                              # App entry point with complete routing
├── data/
│   └── test_data.dart                    # TEST DATA - Delete when integrating real backend
├── models/
│   └── auth_model.dart                   # Authentication state model
├── providers/
│   └── auth_provider.dart                # State management with Provider
├── screens/
│   ├── phone_entry_screen.dart           # Phone number entry
│   ├── otp_verification_screen.dart      # OTP code verification
│   ├── profile_registration_screen.dart  # Role selection & name entry
│   ├── dashboard_screen.dart             # Role-based dashboard (tenant/landlord/agent)
│   ├── properties_list_screen.dart       # Property browsing with filters & search
│   ├── property_details_screen.dart      # Property details with image carousel
│   ├── profile_screen.dart               # User profile management
│   └── home_screen.dart                  # Legacy home screen
└── theme/
    └── app_theme.dart                    # App styling & colors
```

### Complete User Flow

1. **Phone Entry** → Enter phone number
2. **OTP Verification** → Enter 6-digit OTP code
3. **Profile Registration** → Enter name and select role (Tenant/Landlord/Agent)
4. **Dashboard** → Role-specific dashboard with personalized content
5. **Property Browsing** → Search, filter, and browse properties
6. **Property Details** → View full property information with image gallery
7. **Profile Management** → Edit profile, change settings, logout

### Features Implemented

#### Authentication
- Phone number entry with automatic country code formatting
- OTP verification (test OTP: 123456)
- Profile registration with role selection
- Multi-role support (Tenant, Landlord, Agent)

#### Dashboards (Role-Based)
- **Tenant Dashboard**: Quick actions (Browse Properties, Saved Properties, Applications), Featured properties
- **Landlord Dashboard**: Add properties, View listings, Tenant inquiries, Statistics
- **Agent Dashboard**: Browse properties, Client management, Commission tracking, Activity feed

#### Properties
- Property listing with 5 mock properties (different types and prices)
- Search functionality
- Advanced filtering by type (Rent/Sale), location, price range
- Property details page with:
  - Image carousel with dots indicator
  - Full property description
  - Amenities list
  - Key features (bedrooms, bathrooms, size)
  - Contact owner button (frontend placeholder)

#### User Profile
- View and edit profile information
- Role display
- Change password option (placeholder)
- Notification settings (placeholder)
- Help & support (placeholder)
- Logout with confirmation dialog

### Test Data Overview

All test data in `/lib/data/test_data.dart`:

**Test Credentials:**
- Phone: `+265991972355`
- OTP: `123456`

**Mock Properties:** 5 properties with:
- Various types (rent/sale)
- Different locations (Lilongwe, Blantyre)
- Amenities, descriptions, full details
- Placeholder images from picsum.photos

**Mock User:** 
- Default user with phone and placeholder role
- Ready to accept registration input

### Building the App

```bash
# Clean and setup
flutter clean
flutter pub get

# Build APK
flutter build apk --release

# Install on phone
flutter install

# Or debug build
flutter run
```

### Testing Workflow

1. Launch app
2. Enter any phone number (auto-formats with +265)
3. Navigate to OTP screen
4. Enter `123456`
5. Enter name and select role
6. Explore dashboard based on role
7. Browse properties with filters and search
8. Click property to view details
9. Edit profile or logout

### State Management Architecture

**AuthProvider** manages:
- Phone number and OTP verification state
- User registration (name and role)
- User profile data
- Role-based screen display
- Logout functionality

**Simple Flow:**
```
PhoneEntryScreen 
  → OTP Verification 
    → Profile Registration 
      → DashboardScreen (role-based)
```

### Code Organization

- **Screens**: Self-contained, build complete UI pages
- **Providers**: Single AuthProvider for all state
- **Test Data**: Centralized mock data file
- **Theme**: Unified styling across app
- **Models**: Simple AuthModel for state structure

### Ready for Backend Integration

All API call placeholders are marked with `// TODO: Connect to PHP backend`:
- `AuthProvider.requestOTP()` → Replace with PHP OTP service
- `AuthProvider.verifyOTP()` → Replace with PHP OTP validation
- Properties loading → Replace with PHP property API
- Profile updates → Replace with PHP profile API

### Next Steps for Backend

1. Replace test data file references
2. Implement PHP API endpoints in AuthProvider methods
3. Connect property list to PHP API
4. Add real image uploads
5. Implement real geolocation and map features

---

**Status**: Complete extended app with all planned features. Ready for production backend integration.
