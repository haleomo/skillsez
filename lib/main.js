document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('learningForm');
    const API_URL = 'http://localhost:8080';

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
                    //showSuccessAlert();
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
    document.getElementById('learningForm').scrollIntoView({ behavior: 'smooth', block: 'start' });
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
