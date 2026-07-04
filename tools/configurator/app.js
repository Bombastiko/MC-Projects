document.addEventListener('DOMContentLoaded', () => {
  // Navigation elements
  const menuItems = document.querySelectorAll('.menu-item');
  const pages = document.querySelectorAll('.page');

  // Page switching logic
  menuItems.forEach(item => {
    item.addEventListener('click', () => {
      menuItems.forEach(i => i.classList.remove('active'));
      item.classList.add('active');

      const targetPage = item.getAttribute('data-page');
      pages.forEach(page => {
        if (page.id === targetPage) {
          page.classList.add('active');
        } else {
          page.classList.remove('active');
        }
      });
    });
  });

  // Configurator elements
  const playerInput = document.getElementById('player');
  const globalTypeGroup = document.getElementById('global-type-group');
  const globalTypeInput = document.getElementById('global_type');
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
  
  // Preview elements
  const previewPaused = document.getElementById('preview-paused');
  const actionbarPreview = document.getElementById('actionbarPreview');

  // Minecraft Hex Colors mapping
  const colorMap = {
    gold: '#ffaa00',
    yellow: '#ffff55',
    white: '#ffffff',
    gray: '#aaaaaa',
    red: '#ff5555',
    green: '#55ff55',
    blue: '#5555ff',
    dark_gray: '#555555'
  };

  // Generate Minecraft command and update HUD preview
  function updateAll() {
    const player = playerInput.value.trim() || '@a';
    
    // Hide/show global type selector depending on player target
    const isGlobalTarget = player === '@a';
    if (isGlobalTarget) {
      globalTypeGroup.style.display = 'flex';
    } else {
      globalTypeGroup.style.display = 'none';
    }

    const globalType = isGlobalTarget ? globalTypeInput.value : 'soft';
    const sw = swInput.value.trim() || 'demo';
    const format = formatInput.value;
    const color = colorInput.value;
    const colorSec = colorSecInput.value;
    const colorNum = colorNumInput.value;
    const prefix = prefixInput.value;
    const suffix = suffixInput.value;
    const bold = boldInput.checked ? 'true' : 'false';
    const isPaused = previewPaused.checked;

    // 1. Generate Command
    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const command = `/function fb:sw/display_ab_custom {player:"${player}",sw:"${sw}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    commandOutput.textContent = command;

    // 2. Render HUD Preview
    let previewHtml = '';

    // Color selectors
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = isPaused ? colorMap.gray : colorMap[colorSec];
    const colNum = isPaused ? colorMap.dark_gray : colorMap[colorNum];
    const styleBold = boldInput.checked ? 'font-weight: bold;' : 'font-weight: normal;';
    const styleItalic = isPaused ? 'font-style: italic;' : 'font-style: normal;';

    // Base style for HUD spans
    const buildSpan = (text, textColor) => {
      const dropShadowColor = textColor === '#ffffff' ? '#3f3f3f' : 'rgba(0,0,0,0.85)';
      const style = `color: ${textColor}; text-shadow: 2px 2px 0px ${dropShadowColor}; ${styleBold} ${styleItalic}`;
      return `<span style="${style}">${text}</span>`;
    };

    // Prefix
    if (prefix) {
      previewHtml += buildSpan(prefix, colMain);
    }

    // Timer body depending on format
    if (format === 'digital') {
      previewHtml += buildSpan('00', colNum);
      previewHtml += buildSpan(':', colSec);
      previewHtml += buildSpan('00', colNum);
      previewHtml += buildSpan(':', colSec);
      previewHtml += buildSpan('00', colNum);
    } else if (format === 'digital_short') {
      previewHtml += buildSpan('00', colNum);
      previewHtml += buildSpan(':', colSec);
      previewHtml += buildSpan('00', colNum);
      previewHtml += buildSpan('.', colSec);
      previewHtml += buildSpan('00', colNum);
    } else if (format === 'letters') {
      previewHtml += buildSpan('0', colNum);
      previewHtml += buildSpan('d ', colSec);
      previewHtml += buildSpan('0', colNum);
      previewHtml += buildSpan('h ', colSec);
      previewHtml += buildSpan('0', colNum);
      previewHtml += buildSpan('m ', colSec);
      previewHtml += buildSpan('0', colNum);
      previewHtml += buildSpan('s', colSec);
    } else if (format === 'dynamic') {
      previewHtml += buildSpan('0', colNum);
      previewHtml += buildSpan('s', colSec);
    }

    // Suffix
    if (suffix) {
      previewHtml += buildSpan(suffix, colMain);
    }

    actionbarPreview.innerHTML = previewHtml;
  }

  // Event Listeners for inputs
  const configInputs = [
    playerInput, globalTypeInput, swInput, formatInput, colorInput, 
    colorSecInput, colorNumInput, prefixInput, suffixInput, boldInput, previewPaused
  ];

  configInputs.forEach(input => {
    input.addEventListener('input', updateAll);
    input.addEventListener('change', updateAll);
  });

  // Copy to clipboard
  copyBtn.addEventListener('click', () => {
    const textToCopy = commandOutput.textContent;
    navigator.clipboard.writeText(textToCopy).then(() => {
      copyBtn.textContent = 'Copied!';
      copyBtn.style.backgroundColor = '#22c55e';
      copyBtn.style.color = '#ffffff';
      
      setTimeout(() => {
        copyBtn.textContent = 'Copy';
        copyBtn.style.backgroundColor = '';
        copyBtn.style.color = '';
      }, 1500);
    }).catch(err => {
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

  // Initialize
  updateAll();
});
