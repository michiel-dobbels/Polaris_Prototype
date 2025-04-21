import "@hotwired/turbo-rails"
import "controllers"

console.log("🔥 JavaScript loaded!");

document.addEventListener("DOMContentLoaded", () => {
  const likeButtons = document.querySelectorAll(".like-toggle-button");

  likeButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
      event.preventDefault();
      event.stopPropagation();

      const likeableId = button.dataset.likeableId;
      const likeableType = button.dataset.likeableType;
      const liked = button.dataset.action === "unlike";
      const likeId = button.dataset.likeId; // Needed for reply unlike
      const token = document.querySelector("meta[name='csrf-token']").content;

      let path = "";
      let method = "";

      if (likeableType === "Post") {
        path = `/posts/${likeableId}/like`;
        method = liked ? "DELETE" : "POST";
      } else if (likeableType === "Reply") {
        if (liked && likeId) {
          path = `/replies/${likeableId}/likes/${likeId}`;
          method = "DELETE";
        } else {
          path = `/replies/${likeableId}/likes`;
          method = "POST";
        }
      }

      fetch(path, {
        method: method,
        headers: {
          "X-CSRF-Token": token,
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
      })
      .then((response) => {
        if (response.ok) {
          // toggle action
          button.dataset.action = liked ? "like" : "unlike";
          button.textContent = liked ? "🤍 Like" : "💔 Unlike";
      
          const wrapper = button.closest(".like-wrapper");
          const likeCountSpan = wrapper.querySelector(".like-count");
          const currentCount = parseInt(likeCountSpan.textContent, 10);
          const newCount = liked ? currentCount - 1 : currentCount + 1;
          likeCountSpan.textContent = newCount;
      
          // For replies, update likeId on the button
          if (!liked && likeableType === "Reply") {
            response.json().then(data => {
              if (data.like_id) {
                button.dataset.likeId = data.like_id;
              }
            });
          } else if (liked) {
            delete button.dataset.likeId;
          }
        }
      })
      
      .catch((error) => {
        console.error("❌ JS Error:", error);
      });
    });
  });

  // Prevent post/reply card clicks from triggering like/delete buttons
  const replyCards = document.querySelectorAll(".reply-card");

  replyCards.forEach((card) => {
    card.addEventListener("click", (event) => {
      if (
        event.target.closest(".like-toggle-button") ||
        event.target.closest(".delete-reply-button")
      ) {
        event.stopPropagation();
        return;
      }

      const url = card.dataset.url;
      if (url) {
        window.location.href = url;
      }
    });
  });
});
