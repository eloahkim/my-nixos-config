export function greet(name: string): string {
  return `Olá, ${name}!`;
}

const button = document.querySelector<HTMLButtonElement>("#action");
const output = document.querySelector<HTMLParagraphElement>("#output");

button?.addEventListener("click", () => {
  if (output) {
    output.textContent = greet("Emacs");
  }
});
