document.addEventListener('DOMContentLoaded', () => {
  const playerInput = document.getElementById('player');
  const swInput = document.getElementById('sw');
  const formatInput = document.getElementById('format');
  const colorInput = document.getElementById('color');
  const colorSecInput = document.getElementById('color_sec');
  const colorNumInput = document.getElementById('color_num');
  const prefixInput = document.getElementById('prefix');
  const suffixInput = document.getElementById('suffix');
  const boldInput = document.getElementById('bold');
  const commandOutput = document.getElementById('commandOutput');
  const copyBtn = document.getElementById('copyBtn');

  // Generate Minecraft command based on inputs
  function updateCommand() {
    const player = playerInput.value.trim() || '@a';
    const sw = swInput.value.trim() || 'demo';
    const format = formatInput.value;
    const color = colorInput.value;
    const colorSec = colorSecInput.value;
    const colorNum = colorNumInput.value;
    
    // Escape prefix and suffix for JSON safety
    const prefix = prefixInput.value.replace(/"/g, '\\"');
    const suffix = suffixInput.value.replace(/"/g, '\\"');
    
    const bold = boldInput.checked ? 'true' : 'false';

    const command = `/function fb:sw/display_ab_custom {player:"${player}",sw:"${sw}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${prefix}",suffix:"${suffix}",bold:"${bold}"}`;
    commandOutput.textContent = command;
  }

  // Event Listeners for form inputs
  const inputs = [
    playerInput, swInput, formatInput, colorInput, 
    colorSecInput, colorNumInput, prefixInput, suffixInput, boldInput
  ];

  inputs.forEach(input => {
    input.addEventListener('input', updateCommand);
    input.addEventListener('change', updateCommand);
  });

  // Copy to clipboard with visual feedback
  copyBtn.addEventListener('click', () => {
    const textToCopy = commandOutput.textContent;
    navigator.clipboard.writeText(textToCopy).then(() => {
      copyBtn.textContent = 'Copied!';
      copyBtn.style.background = '#22c55e'; // Green feedback
      copyBtn.style.boxShadow = '0 4px 15px rgba(34, 197, 94, 0.4)';
      
      setTimeout(() => {
        copyBtn.textContent = 'Copy';
        copyBtn.style.background = ''; // Reset
        copyBtn.style.boxShadow = '';
      }, 1500);
    }).catch(err => {
      console.error('Failed to copy: ', err);
      // Fallback: select text manually
      const textarea = document.createElement('textarea');
      textarea.value = textToCopy;
      document.body.appendChild(textarea);
      textarea.select();
      document.execCommand('copy');
      document.body.removeChild(textarea);
      
      copyBtn.textContent = 'Copied!';
      setTimeout(() => {
        copyBtn.textContent = 'Copy';
      }, 1500);
    });
  });

  // Run once to initialize
  updateCommand();
});
