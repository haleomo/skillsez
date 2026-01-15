document.addEventListener("DOMContentLoaded", async () => {
    const listEl = document.querySelector(".scrollable-list ul");
    if (!listEl) return;

    try {
        const res = await fetch("../data/help.json", { cache: "no-store" });
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        const items = await res.json();

        // Preserve file order
        listEl.innerHTML = "";
        items.forEach((item) => {
        const li = document.createElement("li");

        const strong = document.createElement("strong");
        strong.textContent = item.question || item.title || "Item";

        const span = document.createElement("span");
        span.textContent = item.answer || item.text || item.description || "";

        li.appendChild(strong);
        li.appendChild(span);
        listEl.appendChild(li);
        });
    } catch (err) {
        console.error("Failed to load help.json:", err);
        listEl.innerHTML = `
        <li>
            <strong>Help unavailable</strong>
            <span>Could not load help content. Please try again later.</span>
        </li>
        `;
    }
});
