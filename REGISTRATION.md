# User Registration Implementation

## Overview
The web application now includes a user registration popup that appears when users first visit the site. This system integrates with the database API to save user information and uses browser cookies for session persistence.

## Features

### Registration Modal
- **Automatic Display**: Shows on first page load if no registration cookie exists
- **Two Options**:
  - **Save**: Registers user and saves to database
  - **Decline**: Creates anonymous session without database registration

### Data Storage
1. **Database**: User information saved via API endpoint `/user/create`
2. **Browser Cookie**: Stores user data locally for 365 days
   - Cookie name: `skillsez_user`
   - Contains: email, lastName, userId (if registered)

### User Flow

#### Registration (Save)
1. User enters email and last name
2. Click "Save" button
3. API call to `POST /user/create` saves to database
4. Cookie created with actual user data including database ID
5. Modal closes automatically

#### Decline Registration
1. User clicks "Decline" button
2. Cookie created with placeholder values:
   - Email: `declined@skills-ez.me`
   - Last Name: `Declined`
3. Modal closes automatically

## Implementation Details

### JavaScript Functions

**Core Functions:**
- `checkUserRegistration()` - Checks for existing cookie on page load
- `showRegistrationModal()` - Displays the registration popup
- `handleRegistrationSubmit()` - Processes registration form submission
- `declineRegistration()` - Handles decline action
- `getCurrentUser()` - Retrieves current user data from cookie

**Cookie Management:**
- `setCookie(name, value, days)` - Creates/updates browser cookie
- `getCookie(name)` - Retrieves cookie value

### API Integration

**Endpoint**: `POST /user/create`

**Request:**
```json
{
  "email": "user@example.com",
  "lastName": "Smith"
}
```

**Response (Success):**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "email": "user@example.com",
    "lastName": "Smith"
  }
}
```

### Cookie Structure

**Registered User:**
```json
{
  "email": "user@example.com",
  "lastName": "Smith",
  "userId": 1
}
```

**Declined User:**
```json
{
  "email": "declined@skills-ez.me",
  "lastName": "Declined"
}
```

## Styling

The modal uses a modern, clean design:
- Backdrop blur effect
- Slide-in animation
- Responsive layout
- Color-coded buttons (blue for Save, gray for Decline)
- Form validation with focus states

## Testing

### Test Registration
1. Clear browser cookies for localhost
2. Refresh the page
3. Registration modal should appear
4. Fill in email and last name
5. Click "Save"
6. Check browser cookies for `skillsez_user`

### Test Decline
1. Clear browser cookies
2. Refresh the page
3. Click "Decline"
4. Check cookie contains declined values

### Test Persistence
1. After registering/declining
2. Refresh the page
3. Modal should NOT appear again

## Files Modified

- `lib/index.html` - Added modal HTML structure
- `lib/main.js` - Added registration logic and cookie management
- `lib/styles.css` - Added modal styling

## Future Enhancements

Potential improvements:
- Email validation (format check)
- Duplicate email detection
- User profile editing
- "Remember me" option
- Social login integration
- Link query profiles and results to user ID

## Troubleshooting

**Modal not appearing:**
- Check browser console for errors
- Verify JavaScript is loaded
- Clear cookies and try again

**Registration failing:**
- Ensure API server is running on `localhost:8080`
- Check database connection in API `.env` file
- Verify `/user/create` endpoint is accessible

**Cookie not persisting:**
- Check browser cookie settings
- Verify cookie expiration (set to 365 days)
- Ensure page is served over HTTP/HTTPS (not file://)
