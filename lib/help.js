document.addEventListener("DOMContentLoaded", async () => {
    const listEl = document.querySelector(".scrollable-list ul");
    if (!listEl) return;

    const allowedTags = new Set(["EM", "I", "STRONG", "B", "BR", "UL", "OL", "LI", "P"]);

    function sanitizeHelpHtml(html) {
        const template = document.createElement("template");
        template.innerHTML = html;

        const walker = document.createTreeWalker(template.content, NodeFilter.SHOW_ELEMENT, null);
        const nodesToRemove = [];

        while (walker.nextNode()) {
            const node = walker.currentNode;
            if (!allowedTags.has(node.tagName)) {
                nodesToRemove.push(node);
                continue;
            }
            [...node.attributes].forEach((attr) => node.removeAttribute(attr.name));
        }

        nodesToRemove.forEach((node) => {
            const textNode = document.createTextNode(node.textContent || "");
            node.replaceWith(textNode);
        });

        return template.innerHTML;
    }

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
        const rawHtml = item.answer || item.text || item.description || "";
        span.innerHTML = sanitizeHelpHtml(rawHtml);

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
