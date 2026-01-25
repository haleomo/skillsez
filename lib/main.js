/**
 * Get the API URL based on the ENVIRONMENT variable
 * Checks window.ENVIRONMENT first, then falls back to location hostname
 */
function getApiUrl() {
    // Check if ENVIRONMENT variable is set on window object
    const environment = window.ENVIRONMENT || localStorage.getItem('ENVIRONMENT') || 'dev';
    
    if (environment === 'prod') {
        return 'http://192.168.102.194:8081';
    }
    // Default to dev
    return 'http://localhost:8080';
}

document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('learningForm');
    const API_URL = getApiUrl();
    console.log('[Main] Using environment:', window.ENVIRONMENT || localStorage.getItem('ENVIRONMENT') || 'dev');
    console.log('[Main] API URL:', API_URL);

    // Check for user registration and show modal if needed
    checkUserRegistration();

    if (form) {
        form.addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(form);
            const data = Object.fromEntries(formData);

            try {
                showLoading();
                hideResults();
                const jsonData = JSON.stringify(data);
                
                const response = await fetch(`${API_URL}/learning-plan/generate`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: jsonData,
                });

                const result = await response.json();
                console.log('Response received:', result);
                
                if (response.ok) {
                    displayLearningPlan(result.data);
                } else {
                    const errorMessage = `Error ${response.status}: ${result.error || 'Unknown error'}`;
                    showErrorAlert('Request Failed', errorMessage);
                }
            } catch (error) {
                const detailedError = `Failed to generate plan: ${error.message}<br><br>Please check:<br> - API server is running (${API_URL})<br> - GEMINI_API_KEY is set<br> - Network connection is active`;
                showErrorAlert('Connection Error', detailedError);
            } finally {
                hideLoading();
            }
        });
    }
});

function showLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) overlay.style.display = 'flex';
}

function hideLoading() {
    const overlay = document.getElementById('loadingOverlay');
    if (overlay) overlay.style.display = 'none';
}

function displayLearningPlan(data) {
    const resultsContainer = document.getElementById('learningPlanResults');
    const planTopic = document.getElementById('planTopic');
    const planMeta = document.getElementById('planMeta');
    const planContent = document.getElementById('planContent');
    
    if (!resultsContainer || !planContent) return;
    
    const learningPlan = data.learning_plan;
    const queryProfile = data.query_profile;

      // Store data for printing
    window.currentPlanData = {
        learningPlan: learningPlan,
        queryProfile: queryProfile
    };
    
    // Set header information
    planTopic.textContent = `Learning Plan: ${learningPlan.topic}`;
    planMeta.textContent = `For ${queryProfile.role || 'your goal'} | Generated on ${new Date(learningPlan.generated_at).toLocaleDateString()}`;
    
    // Parse and display the content
    const content = learningPlan.content;
    const sections = parseMarkdownContent(content);
    
    planContent.innerHTML = sections;
    
    // Show results and scroll to them
    resultsContainer.style.display = 'block';
    setTimeout(() => {
        resultsContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }, 100);
}

function parseMarkdownContent(content) {
    // Split content by major headings (## or **bolded sections**)
    const lines = content.split('\n');
    let html = '';
    let currentSection = '';
    let sectionTitle = '';
    let inSection = false;
    
    for (let line of lines) {
        line = line.trim();
        //console.log('Processing line:', line);
        
        // Check for markdown heading (## or **heading**)
        if (line.startsWith('###')) {
            // Save previous section
            if (inSection && currentSection) {
                html += createPlanSection(sectionTitle, currentSection);
            }
            // Start new section
            sectionTitle = line.replace('###', '').replace(/\*\*/g, '');
            currentSection = '';
            inSection = true;
        } else if (line.match(/^\*\*(.+?)\*\*$/)) {
            // Bold line as heading
            if (inSection && currentSection) {
                html += createPlanSection(sectionTitle, currentSection);
            }
            sectionTitle = line.replace(/\*\*/g, '');
            currentSection = '';
            inSection = true;
        } else if (line.match(/^\d+\.\s+\*\*(.+?)\*\*/)) {
            // Numbered bold heading
            if (inSection && currentSection) {
                html += createPlanSection(sectionTitle, currentSection);
            }
            sectionTitle = line.replace(/^\d+\.\s+/, '').replace(/\*\*/g, '');
            currentSection = '';
            inSection = true;
        } else if (inSection) {
            currentSection += line + '\n';
        }
    }
    
    // Add final section
    if (inSection && currentSection) {
        html += createPlanSection(sectionTitle, currentSection);
    }
    
    // If no sections were found, display raw content
    if (!html) {
        html = `<div class="plan-section"><div class="plan-raw-content">${escapeHtml(content)}</div></div>`;
    }
    
    return html;
}

function createPlanSection(title, content) {
    if (!title || !content.trim()) return '';
    //console.log('Creating section:', content);
    // Convert markdown formatting
    let formattedContent = content
        .replace(/\*\*(.+?)\*\*/g, '<p><strong>$1</strong>') // Bold
        .replace(/\*(.+?) \*/g, '<em>$1</em>') // Italic
        .replace(/^- (.+)$/gm, '<li>$1</li>') // Bullet points
        .replace(/^\d+\.\s+(.+)$/gm, '<li>$1</li>') // Numbered lists
        .replace(/\n\n/g, '</p>') // paragraphs
        .replace(/\* /g, '')
        .replace(/\s\-\-\-\s/g, ''); // clean up stray asterisks
    // Wrap lists
    formattedContent = formattedContent.replace(/(<li>.*<\/li>)/gs, '<ul>$1</ul>');
    
    // Wrap in paragraphs if not already wrapped
    if (!formattedContent.includes('<ul>') && !formattedContent.includes('<p>')) {
        formattedContent = `<p>${formattedContent}</p>`;
    }
    
    return `
        <div class="plan-section">
            <h3>${escapeHtml(title)}</h3>
            ${formattedContent}
        </div>
    `;
}

function escapeHtml(text) {
    const div = document.createElement('div');
    div.textContent = text;
    return div.innerHTML;
}

function hideResults() {
    const resultsContainer = document.getElementById('learningPlanResults');
    if (resultsContainer) {
        resultsContainer.style.display = 'none';
    }
}

function createNewPlan() {
    hideResults();
    closeAlert('formSubmitSuccess');
    closeAlert('formSubmitError');
    
    // Clear form fields
    const form = document.getElementById('learningForm');
    if (form) {
        form.reset();
    }
    
    // Scroll to form
    form.scrollIntoView({ behavior: 'smooth', block: 'start' });
    
    // Set focus to first input field
    const firstInput = form.querySelector('input[type="text"]');
    if (firstInput) {
        setTimeout(() => firstInput.focus(), 300);
    }
}

function printLearningPlan() {
    if (!window.currentPlanData) {
        alert('No learning plan to print');
        return;
    }
    
    const { learningPlan, queryProfile } = window.currentPlanData;
    const planContent = document.getElementById('planContent').innerHTML;
    
    const printWindow = window.open('', '_blank');
    const printDate = new Date(learningPlan.generated_at).toLocaleDateString();
    
    const printHtml = `
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Learning Plan - ${learningPlan.topic}</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }
                
                body {
                    font-family: 'Roboto', Arial, sans-serif;
                    line-height: 1.6;
                    color: #0f172a;
                    background-color: #fff;
                    padding: 20px;
                }
                
                .print-header {
                    border-bottom: 3px solid #01589B;
                    padding-bottom: 20px;
                    margin-bottom: 30px;
                    text-align: center;
                }
                
                .print-header h1 {
                    color: #01589B;
                    font-size: 2em;
                    margin-bottom: 10px;
                }
                
                .print-meta {
                    color: #475569;
                    font-size: 0.95em;
                    margin-bottom: 10px;
                }
                
                .print-meta-item {
                    margin: 5px 0;
                }
                
                .plan-section {
                    background-color: #f8fafc;
                    padding: 15px;
                    margin-bottom: 20px;
                    border-left: 4px solid #01589B;
                    page-break-inside: avoid;
                }
                
                .plan-section h3 {
                    color: #01589B;
                    font-size: 1.3em;
                    margin-bottom: 10px;
                }
                
                .plan-section p {
                    margin-bottom: 10px;
                    text-align: justify;
                }
                
                .plan-section ul, .plan-section ol {
                    margin: 10px 0 10px 20px;
                }
                
                .plan-section li {
                    margin-bottom: 5px;
                }
                
                .plan-section strong {
                    color: #0f172a;
                    font-weight: 700;
                }
                
                .plan-section em {
                    font-style: italic;
                }
                
                .print-footer {
                    margin-top: 40px;
                    padding-top: 20px;
                    border-top: 1px solid #e2e8f0;
                    text-align: center;
                    color: #475569;
                    font-size: 0.9em;
                }
                
                @media print {
                    body {
                        padding: 0;
                    }
                    
                    .plan-section {
                        page-break-inside: avoid;
                        box-shadow: none;
                    }
                    
                    .print-header {
                        page-break-after: avoid;
                    }
                }
            </style>
        </head>
        <body>
            <div class="print-header">
                <h1>${escapeHtml(learningPlan.topic)}</h1>
                <div class="print-meta">
                    <div class="print-meta-item"><strong>Learning Goal:</strong> ${escapeHtml(learningPlan.learning_goal)}</div>
                    <div class="print-meta-item"><strong>Target Role:</strong> ${escapeHtml(queryProfile.role || 'Not specified')}</div>
                    <div class="print-meta-item"><strong>Education Level:</strong> ${escapeHtml(queryProfile.subjectEducationLevel || 'Not specified')}</div>
                    <div class="print-meta-item"><strong>Generated:</strong> ${printDate}</div>
                </div>
            </div>
            
            <div class="plan-content">
                ${planContent}
            </div>
            
            <div class="print-footer">
                <p>This learning plan was generated by <strong>Skills Ez</strong> - AI-crafted learning plans</p>
                <p>Generated on ${printDate}</p>
            </div>
        </body>
        </html>
    `;
    
    printWindow.document.write(printHtml);
    printWindow.document.close();
    
    // Trigger print dialog after content loads
    printWindow.onload = function() {
        printWindow.print();
    };
}

function showErrorAlert(title, alertText) {
    var alertBox = document.getElementById("formSubmitError");
    if (alertBox) {
        alertBox.innerHTML = `
            <span class="close-btn" onclick="closeAlert('formSubmitError')">&times;</span>
            <h2 class=".alert-title-failure">${title}</h2>
            <p>${alertText}</p>
        `;
        alertBox.style.display = "block";
    }
}

function showSuccessAlert() {
    var alertBox = document.getElementById("formSubmitSuccess");
    if (alertBox) {
        alertBox.innerHTML = `
            <span class="close-btn" onclick="closeAlert('formSubmitSuccess')">&times;</span>
            <h2 class="alert-title-success">Success!</h2>
            <p>Your learning plan has been generated successfully!</p>
        `;
        alertBox.style.display = "block";
    }
}

function closeAlert(formSubmitStatus) {
    var alertBox = document.getElementById(formSubmitStatus);
    if (alertBox) {
        alertBox.style.display = "none";
    }
}

// ===== USER REGISTRATION FUNCTIONS =====

/**
 * Check if user is already registered via cookie
 * Show registration modal if not registered
 */
function checkUserRegistration() {
    console.log('Checking user registration...');
    const userCookie = getCookie('skillsez_user');
    console.log('User cookie:', userCookie);
    
    if (!userCookie) {
        // No cookie found, show registration modal
        console.log('No user cookie found, showing registration modal');
        showRegistrationModal();
    } else {
        console.log('User already registered:', userCookie);
    }
}

/**
 * Show the registration modal
 */
function showRegistrationModal() {
    console.log('showRegistrationModal called');
    const modal = document.getElementById('registrationModal');
    console.log('Modal element:', modal);
    
    if (modal) {
        modal.style.display = 'flex';
        modal.style.visibility = 'visible';
        modal.style.opacity = '1';
        console.log('Modal display set to flex');
        
        // Setup form submission handler
        const registrationForm = document.getElementById('registrationForm');
        if (registrationForm) {
            registrationForm.addEventListener('submit', handleRegistrationSubmit);
            console.log('Registration form handler attached');
        } else {
            console.error('Registration form not found!');
        }
        
        // Setup decline button handler
        const declineBtn = document.getElementById('declineBtn');
        if (declineBtn) {
            declineBtn.addEventListener('click', declineRegistration);
            console.log('Decline button handler attached');
        } else {
            console.error('Decline button not found!');
        }
    } else {
        console.error('Registration modal element not found!');
    }
}

/**
 * Hide the registration modal
 */
function hideRegistrationModal() {
    const modal = document.getElementById('registrationModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

/**
 * Handle registration form submission
 */
async function handleRegistrationSubmit(e) {
    e.preventDefault();
    
    const email = document.getElementById('userEmail').value.trim();
    const lastName = document.getElementById('userLastName').value.trim();
    
    if (!email || !lastName) {
        alert('Please fill in all fields');
        return;
    }
    
    console.log('Attempting to register user:', email, lastName);
    
    try {
        // Call API to save user
        console.log('Sending request to: http://localhost:8080/user');
        const response = await fetch('http://localhost:8080/user', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ email, lastName }),
        });
        
        console.log('Response status:', response.status);
        const result = await response.json();
        console.log('Response data:', result);
        
        if (response.ok) {
            // Success - create cookie with user data
            const userData = JSON.stringify({ 
                email, 
                lastName,
                userId: result.data.id 
            });
            setCookie('skillsez_user', userData, 365); // Cookie valid for 1 year
            
            console.log('User registered successfully:', result.data);
            alert('Registration successful! Welcome to Skills Ez.');
            hideRegistrationModal();
        } else {
            alert('Registration failed: ' + (result.error || 'Unknown error'));
        }
    } catch (error) {
        console.error('Registration error:', error);
        
        // Offer option to continue without API
        const continueAnyway = confirm(
            'Cannot connect to API server.\n\n' +
            'This could mean:\n' +
            '• API server is not running (run: dart_frog dev in api folder)\n' +
            '• Database is not configured\n' +
            '• CORS issues\n\n' +
            'Click OK to continue without saving to database, or Cancel to try again.'
        );
        
        if (continueAnyway) {
            // Create cookie without database ID
            const userData = JSON.stringify({ 
                email, 
                lastName,
                userId: null // No database ID
            });
            setCookie('skillsez_user', userData, 365);
            console.log('User session created locally (not saved to database)');
            hideRegistrationModal();
        }
    }
}

/**
 * Handle decline registration
 */
function declineRegistration() {
    // Create cookie with declined values
    const userData = JSON.stringify({ 
        email: 'declined@skills-ez.me', 
        lastName: 'Declined' 
    });
    setCookie('skillsez_user', userData, 365);
    
    console.log('User declined registration');
    hideRegistrationModal();
}

/**
 * Set a cookie
 */
function setCookie(name, value, days) {
    let expires = '';
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = '; expires=' + date.toUTCString();
    }
    document.cookie = name + '=' + (value || '') + expires + '; path=/';
}

/**
 * Get a cookie value
 */
function getCookie(name) {
    const nameEQ = name + '=';
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
    }
    return null;
}

/**
 * Get current user data from cookie
 */
function getCurrentUser() {
    const userCookie = getCookie('skillsez_user');
    if (userCookie) {
        try {
            return JSON.parse(userCookie);
        } catch (e) {
            console.error('Failed to parse user cookie:', e);
            return null;
        }
    }
    return null;
}

/**
 * Save learning plan and query profile to database
 */
async function saveLearningPlan(event) {
    console.log('[SavePlan] Button clicked, event:', event);
    
    const API_URL = getApiUrl();
    
    if (!window.currentPlanData) {
        console.log('[SavePlan] No plan data found');
        showErrorAlert('No Plan to Save', 'Generate a learning plan first.');
        return;
    }
    
    const currentUser = getCurrentUser();
    console.log(`[SavePlan] Current user: ${JSON.stringify(currentUser)} ${!currentUser || !currentUser.userId}`);
    
    if (Object.values(currentUser).length == 0) {
        console.log('[SavePlan] No user or user ID found');
        showErrorAlert('User Not Found', 'Please register to save learning plans. Which may require removing cookies and refreshing the page.');
        return;
    }

    const { learningPlan, queryProfile } = window.currentPlanData;
    
    // Show naming modal instead of saving directly
    showPlanNamingModal(queryProfile, learningPlan, API_URL, currentUser);
}

/**
 * Show modal for naming the learning plan
 */
function showPlanNamingModal(queryProfile, learningPlan, apiUrl, currentUser) {
    const modal = document.getElementById('savePlanNameModal');
    const planNameInput = document.getElementById('planName');
    const form = document.getElementById('savePlanNameForm');
    
    // Set default name
    const defaultName = `${queryProfile.topic} - ${queryProfile.goal}`;
    planNameInput.value = defaultName;
    planNameInput.select(); // Select all text for easy replacement
    
    console.log('[SavePlan] Showing naming modal with default name:', defaultName);
    
    if (modal) {
        modal.style.display = 'block';
    }
    
    // Handle form submission
    form.onsubmit = async function(e) {
        e.preventDefault();
        const planName = planNameInput.value.trim();
        
        if (!planName) {
            showErrorAlert('Invalid Name', 'Please enter a name for your learning plan.');
            return;
        }
        
        // Hide modal
        modal.style.display = 'none';
        
        // Proceed with saving
        await performSave(queryProfile, learningPlan, apiUrl, currentUser, planName);
    };
}

/**
 * Actually save the learning plan with the provided name
 */
async function performSave(queryProfile, learningPlan, apiUrl, currentUser, planName) {
    const savePlanBtn = document.getElementById('savePlanBtn');
    
    try {
        // Disable button and show loading state
        savePlanBtn.disabled = true;
        savePlanBtn.textContent = '💾 Saving...';
        console.log('[SavePlan] Button disabled, starting save with name:', planName);

        // Step 1: Save the query profile
        console.log('[SavePlan] Saving query profile...');
        const profileResponse = await fetch(`${apiUrl}/query-profile`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                userId: currentUser.userId,
                queryText: queryProfile.queryText ?? '',
                sourceExpertDiscipline: queryProfile.sourceExpertDiscipline,
                subjectEducationLevel: queryProfile.subjectEducationLevel,
                subjectDiscipline: queryProfile.subjectDiscipline,
                subjectWorkExperience: queryProfile.subjectWorkExperience,
                topic: queryProfile.topic,
                goal: queryProfile.goal,
                role: queryProfile.role,
            }),
        });

        console.log('[SavePlan] Profile response status:', profileResponse.status);
        
        if (!profileResponse.ok) {
            const errorText = await profileResponse.text();
            console.error('[SavePlan] Profile response error:', errorText);
            throw new Error(`Failed to save Learning Plan: ${profileResponse.status} - ${errorText}`);
        }

        const profileResult = await profileResponse.json()
        const queryProfileId = profileResult.data.id;
        console.log('[SavePlan] Learning Plan saved with ID:', queryProfileId);

        // Step 2: Save the learning plan (query result) with user-provided name
        console.log('[SavePlan] Saving learning plan with name:', planName);
        const resultResponse = await fetch(`${apiUrl}/query-result`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                queryProfileId: queryProfileId,
                queryResultNickname: planName,
                resultText: learningPlan.content,
            }),
        });

        console.log('[SavePlan] Result response status:', resultResponse.status);
        
        if (!resultResponse.ok) {
            const errorText = await resultResponse.text();
            console.error('[SavePlan] Result response error:', errorText);
            throw new Error(`Failed to save learning plan: ${resultResponse.status} - ${errorText}`);
        }

        const resultData = await resultResponse.json();
        console.log('[SavePlan] Learning plan saved successfully:', resultData);

        // Show success message
        showSuccessAlert('Plan Saved!', `Your learning plan "${planName}" has been saved successfully.`);
        
        // Re-enable button
        savePlanBtn.disabled = false;
        savePlanBtn.textContent = '💾 Save Plan';

    } catch (error) {
        console.error('[SavePlan] Error saving learning plan:', error);
        showErrorAlert('Save Failed', `Could not save your learning plan: ${error.message}`);
        
        // Re-enable button
        savePlanBtn.disabled = false;
        savePlanBtn.textContent = '💾 Save Plan';
    }
}

/**
 * Hide the plan naming modal
 */
function hidePlanNamingModal() {
    const modal = document.getElementById('savePlanNameModal');
    if (modal) {
        modal.style.display = 'none';
    }
}

/**
 * Show success alert
 */
function showSuccessAlert(title, message) {
    const alertElement = document.getElementById('formSubmitSuccess');
    if (alertElement) {
        const alertTitle = alertElement.querySelector('.alert-title');
        if (alertTitle) {
            alertTitle.innerHTML = `<strong>${title}</strong><br>${message}`;
        }
        alertElement.style.display = 'block';
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            closeAlert('formSubmitSuccess');
        }, 5000);
    }
}

// Attach save handler when page loads
document.addEventListener('DOMContentLoaded', function() {
    console.log('[Main] DOMContentLoaded event triggered');
    const savePlanBtn = document.getElementById('savePlanBtn');
    const cancelSaveBtn = document.getElementById('cancelSaveBtn');
    console.log('[Main] savePlanBtn element:', savePlanBtn);
    
    if (savePlanBtn) {
        console.log('[Main] Attaching click listener to savePlanBtn');
        savePlanBtn.addEventListener('click', saveLearningPlan);
    } else {
        console.error('[Main] savePlanBtn element not found!');
    }
    
    if (cancelSaveBtn) {
        console.log('[Main] Attaching click listener to cancelSaveBtn');
        cancelSaveBtn.addEventListener('click', function() {
            console.log('[Main] Cancel save button clicked');
            hidePlanNamingModal();
        });
    }
});

