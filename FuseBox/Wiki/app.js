// Global Navigation Helpers for Dashboard Shortcuts
function switchPage(pageId) {
  const menuItems = document.querySelectorAll('.menu-item');
  const pages = document.querySelectorAll('.page');

  menuItems.forEach(i => {
    if (i.getAttribute('data-page') === pageId) {
      i.classList.add('active');
    } else {
      i.classList.remove('active');
    }
  });

  pages.forEach(page => {
    if (page.id === pageId) {
      page.classList.add('active');
      page.style.display = 'block';
    } else {
      page.classList.remove('active');
      page.style.display = 'none';
    }
  });
}

function switchDocTab(docId) {
  const docsTabs = document.querySelectorAll('.docs-tab');
  const docContents = document.querySelectorAll('.doc-content');

  docsTabs.forEach(tab => {
    if (tab.getAttribute('data-doc') === docId) {
      tab.classList.add('active');
    } else {
      tab.classList.remove('active');
    }
  });

  docContents.forEach(section => {
    if (section.id === docId) {
      section.classList.add('active');
      section.style.display = 'block';
    } else {
      section.classList.remove('active');
      section.style.display = 'none';
    }
  });
}

document.addEventListener('DOMContentLoaded', () => {
  // Navigation elements
  const menuItems = document.querySelectorAll('.menu-item');
  menuItems.forEach(item => {
    item.addEventListener('click', () => {
      const targetPage = item.getAttribute('data-page');
      switchPage(targetPage);
    });
  });

  // Documentation Tab switching logic
  const docsTabs = document.querySelectorAll('.docs-tab');
  docsTabs.forEach(item => {
    item.addEventListener('click', () => {
      const targetDoc = item.getAttribute('data-doc');
      switchDocTab(targetDoc);
    });
  });

  // Copy to Clipboard Utility
  function copyToClipboard(text, btnElement) {
    navigator.clipboard.writeText(text).then(() => {
      const originalText = btnElement.innerHTML;
      btnElement.classList.add('copied');
      btnElement.innerHTML = `✓ Copied!`;
      setTimeout(() => {
        btnElement.classList.remove('copied');
        btnElement.innerHTML = originalText;
      }, 1800);
    }).catch(err => {
      console.error('Failed to copy: ', err);
    });
  }

  // Minecraft Colors mapping
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

  function buildSpan(text, textColor, isBold, isItalic) {
    const dropShadowColor = textColor === '#ffffff' ? '#3f3f3f' : 'rgba(0,0,0,0.85)';
    const boldStyle = isBold ? 'font-weight: bold;' : 'font-weight: normal;';
    const italicStyle = isItalic ? 'font-style: italic;' : 'font-style: normal;';
    const style = `color: ${textColor}; text-shadow: 2px 2px 0px ${dropShadowColor}; ${boldStyle} ${italicStyle}`;
    return `<span style="${style}">${text}</span>`;
  }

  // ==========================================
  // 🛠 STOPWATCH CONFIGURATOR
  // ==========================================
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
  
  const previewPaused = document.getElementById('preview-paused');
  const actionbarPreview = document.getElementById('actionbarPreview');

  function updateSw() {
    if (!playerInput) return;
    const player = playerInput.value.trim() || '@a';
    const isGlobalTarget = player === '@a';
    
    if (globalTypeGroup) globalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? globalTypeInput.value : 'soft';
    const sw = swInput.value.trim() || 'demo';
    const format = formatInput.value;
    const color = colorInput.value;
    const colorSec = colorSecInput.value;
    const colorNum = colorNumInput.value;
    const prefix = prefixInput.value;
    const suffix = suffixInput.value;
    const bold = boldInput.checked;
    const isPaused = previewPaused.checked;

    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const command = `/function fb:sw/display_ab_custom {player:"${player}",sw:"${sw}",format:"${format}",color:"${color}",color_sec:"${colorSec}",color_num:"${colorNum}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    commandOutput.textContent = command;

    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = isPaused ? colorMap.gray : colorMap[colorSec];
    const colNum = isPaused ? colorMap.dark_gray : colorMap[colorNum];
    const isItalic = isPaused;

    if (prefix) previewHtml += buildSpan(prefix, colMain, bold, isItalic);

    if (format === 'digital') {
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else if (format === 'digital_short') {
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
      previewHtml += buildSpan('.', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else if (format === 'letters') {
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('d ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('h ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('m ', colSec, bold, isItalic);
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    } else if (format === 'dynamic') {
      previewHtml += buildSpan('0', colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    }

    if (suffix) previewHtml += buildSpan(suffix, colMain, bold, isItalic);

    actionbarPreview.innerHTML = previewHtml;
  }

  const swInputs = [
    playerInput, globalTypeInput, swInput, formatInput, colorInput, 
    colorSecInput, colorNumInput, prefixInput, suffixInput, boldInput, previewPaused
  ];
  swInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateSw);
      i.addEventListener('change', updateSw);
    }
  });

  if (copyBtn) copyBtn.addEventListener('click', () => copyToClipboard(commandOutput.textContent, copyBtn));

  // ==========================================
  // ⏳ COUNTDOWN CONFIGURATOR
  // ==========================================
  const cdPlayerInput = document.getElementById('cd-player');
  const cdGlobalTypeGroup = document.getElementById('cd-global-type-group');
  const cdGlobalTypeInput = document.getElementById('cd-global_type');
  const cdNameInput = document.getElementById('cd-name');
  const cdHInput = document.getElementById('cd-h');
  const cdMInput = document.getElementById('cd-m');
  const cdSInput = document.getElementById('cd-s');
  const cdCmdInput = document.getElementById('cd-cmd');
  const cdFormatInput = document.getElementById('cd-format');
  const cdColorInput = document.getElementById('cd-color');
  const cdPrefixInput = document.getElementById('cd-prefix');
  const cdBoldInput = document.getElementById('cd-bold');
  const cdPreviewPaused = document.getElementById('cd-preview-paused');
  const cdActionbarPreview = document.getElementById('cd-actionbarPreview');
  
  const cdCommandOutputCreate = document.getElementById('cd-commandOutputCreate');
  const cdCommandOutputStart = document.getElementById('cd-commandOutputStart');
  const cdCommandOutputDisplay = document.getElementById('cd-commandOutputDisplay');
  const cdCopyBtnCreate = document.getElementById('cd-copyBtnCreate');
  const cdCopyBtnStart = document.getElementById('cd-copyBtnStart');
  const cdCopyBtnDisplay = document.getElementById('cd-copyBtnDisplay');

  function updateCd() {
    if (!cdPlayerInput) return;
    const player = cdPlayerInput.value.trim() || '@a';
    const isGlobalTarget = player === '@a';
    
    if (cdGlobalTypeGroup) cdGlobalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? cdGlobalTypeInput.value : 'soft';
    const cdName = cdNameInput.value.trim() || 'timer1';
    const h = parseInt(cdHInput.value) || 0;
    const m = parseInt(cdMInput.value) || 0;
    const s = parseInt(cdSInput.value) || 0;
    const cdCmdRaw = cdCmdInput.value.trim();
    
    const cdCmd = cdCmdRaw.length > 0 ? cdCmdRaw : 'data get storage fb:tmp dummy';
    const format = cdFormatInput.value;
    const color = cdColorInput.value;
    const prefix = cdPrefixInput.value;
    const bold = cdBoldInput.checked;
    const isPaused = cdPreviewPaused.checked;

    const escapedCdCmd = cdCmd.replace(/'/g, "\\'");
    const escapedPrefix = prefix.replace(/"/g, '\\"');

    cdCommandOutputCreate.textContent = `/function fb:cd/create {name:"${cdName}",h:${h},m:${m},s:${s},cmd:'${escapedCdCmd}'}`;
    cdCommandOutputStart.textContent = `/function fb:cd/start {name:"${cdName}"}`;
    cdCommandOutputDisplay.textContent = `/function fb:cd/display_ab_custom {player:"${player}",cd:"${cdName}",format:"${format}",color:"${color}",color_sec:"gray",color_num:"white",prefix:"${escapedPrefix}",suffix:"",bold:"${bold}",global_type:"${globalType}"}`;

    let previewHtml = '';
    const colMain = isPaused ? colorMap.gray : colorMap[color];
    const colSec = colorMap.gray;
    const colNum = colorMap.white;
    const isItalic = isPaused;

    if (prefix) previewHtml += buildSpan(prefix, colMain, bold, isItalic);

    const pad = (n) => (n < 10 ? '0' + n : n);
    if (format === 'digital') {
      previewHtml += buildSpan(pad(h), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(m), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(s), colNum, bold, isItalic);
    } else if (format === 'digital_short') {
      previewHtml += buildSpan(pad(m), colNum, bold, isItalic);
      previewHtml += buildSpan(':', colSec, bold, isItalic);
      previewHtml += buildSpan(pad(s), colNum, bold, isItalic);
      previewHtml += buildSpan('.', colSec, bold, isItalic);
      previewHtml += buildSpan('00', colNum, bold, isItalic);
    } else {
      previewHtml += buildSpan(s, colNum, bold, isItalic);
      previewHtml += buildSpan('s', colSec, bold, isItalic);
    }

    cdActionbarPreview.innerHTML = previewHtml;
  }

  const cdInputs = [
    cdPlayerInput, cdGlobalTypeInput, cdNameInput, cdHInput, cdMInput, cdSInput, cdCmdInput,
    cdFormatInput, cdColorInput, cdPrefixInput, cdBoldInput, cdPreviewPaused
  ];
  cdInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateCd);
      i.addEventListener('change', updateCd);
    }
  });

  if (cdCopyBtnCreate) cdCopyBtnCreate.addEventListener('click', () => copyToClipboard(cdCommandOutputCreate.textContent, cdCopyBtnCreate));
  if (cdCopyBtnStart) cdCopyBtnStart.addEventListener('click', () => copyToClipboard(cdCommandOutputStart.textContent, cdCopyBtnStart));
  if (cdCopyBtnDisplay) cdCopyBtnDisplay.addEventListener('click', () => copyToClipboard(cdCommandOutputDisplay.textContent, cdCopyBtnDisplay));

  // ==========================================
  // 📱 ACTIONBAR CONFIGURATOR (CUSTOM TEXT OVERRIDES EXCLUSIVE)
  // ==========================================
  const abCustomTextInput = document.getElementById('ab-custom-text');
  const abPlayerInput = document.getElementById('ab-player');
  const abGlobalTypeGroup = document.getElementById('ab-global-type-group');
  const abGlobalTypeInput = document.getElementById('ab-global_type');
  const abColorInput = document.getElementById('ab-color');
  const abPrefixInput = document.getElementById('ab-prefix');
  const abSuffixInput = document.getElementById('ab-suffix');
  const abBoldInput = document.getElementById('ab-bold');
  const abActionbarPreview = document.getElementById('ab-actionbarPreview');
  const abCommandOutput = document.getElementById('ab-commandOutput');
  const abCopyBtn = document.getElementById('ab-copyBtn');
  const abClearOutput = document.getElementById('ab-clearOutput');
  const abClearCopyBtn = document.getElementById('ab-clearCopyBtn');

  function updateAb() {
    if (!abCustomTextInput) return;
    const player = abPlayerInput.value.trim() || '@a';
    const isGlobalTarget = player === '@a';

    if (abGlobalTypeGroup) abGlobalTypeGroup.style.display = isGlobalTarget ? 'flex' : 'none';

    const globalType = isGlobalTarget ? abGlobalTypeInput.value : 'soft';
    const customText = abCustomTextInput.value.trim() || 'Welcome to the Server!';
    const color = abColorInput.value;
    const prefix = abPrefixInput.value;
    const suffix = abSuffixInput.value;
    const bold = abBoldInput.checked;

    const escapedPrefix = prefix.replace(/"/g, '\\"');
    const escapedSuffix = suffix.replace(/"/g, '\\"');
    const escapedText = customText.replace(/"/g, '\\"');

    const command = `/function fb:ab/display_custom {player:"${player}",text:"${escapedText}",color:"${color}",prefix:"${escapedPrefix}",suffix:"${escapedSuffix}",bold:"${bold}",global_type:"${globalType}"}`;
    const clearCommand = `/tag ${player} remove fb.ab.custom`;

    abCommandOutput.textContent = command;
    if (abClearOutput) abClearOutput.textContent = clearCommand;

    let previewHtml = '';
    const colMain = colorMap[color];

    if (prefix) previewHtml += buildSpan(prefix, colMain, bold, false);
    previewHtml += buildSpan(customText, colMain, bold, false);
    if (suffix) previewHtml += buildSpan(suffix, colMain, bold, false);

    abActionbarPreview.innerHTML = previewHtml;
  }

  const abInputs = [
    abCustomTextInput, abPlayerInput, abGlobalTypeInput,
    abColorInput, abPrefixInput, abSuffixInput, abBoldInput
  ];
  abInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateAb);
      i.addEventListener('change', updateAb);
    }
  });

  if (abCopyBtn) abCopyBtn.addEventListener('click', () => copyToClipboard(abCommandOutput.textContent, abCopyBtn));
  if (abClearCopyBtn) abClearCopyBtn.addEventListener('click', () => copyToClipboard(abClearOutput.textContent, abClearCopyBtn));

  // ==========================================
  // ⚡ EVENT CONFIGURATOR
  // ==========================================
  const egTypeInput = document.getElementById('eg-type');
  const egFnLabel = document.getElementById('eg-fn-label');
  const egEventInput = document.getElementById('eg-event');
  const egItemInput = document.getElementById('eg-item');
  const egCdInput = document.getElementById('eg-cd');
  const egFnInput = document.getElementById('eg-fn');
  const egCommandOutput = document.getElementById('eg-commandOutput');
  const egCopyBtn = document.getElementById('eg-copyBtn');

  function updateEventGen() {
    if (!egEventInput) return;
    const actionType = egTypeInput ? egTypeInput.value : 'command';
    const eventName = egEventInput.value;
    const item = egItemInput.value.trim();
    const cd = egCdInput.value.trim() || '{id:"ascend"}';
    const fn = egFnInput.value.trim() || (actionType === 'command' ? 'scoreboard players add @s fb.t_fire 1' : 'my_pack:cast_spell');

    if (egFnLabel) {
      egFnLabel.textContent = actionType === 'command' ? 'Target Command' : 'Target Function';
    }

    const hasItem = item.length > 0;
    let fnName = '';

    if (actionType === 'command') {
      fnName = hasItem ? 'register_item_cmd' : 'register_cmd';
    } else {
      fnName = hasItem ? 'register_item' : 'register';
    }

    let command = '';
    if (hasItem) {
      command = `/function fb:event/${fnName} {name:"${eventName}",item_id:"${item}",custom_data:${cd},fn:"${fn}"}`;
    } else {
      command = `/function fb:event/${fnName} {name:"${eventName}",fn:"${fn}"}`;
    }

    egCommandOutput.textContent = command;
  }

  const egInputs = [egTypeInput, egEventInput, egItemInput, egCdInput, egFnInput];
  egInputs.forEach(i => {
    if (i) {
      i.addEventListener('input', updateEventGen);
      i.addEventListener('change', updateEventGen);
    }
  });

  if (egCopyBtn) egCopyBtn.addEventListener('click', () => copyToClipboard(egCommandOutput.textContent, egCopyBtn));

  // Initial runs
  updateSw();
  updateCd();
  updateAb();
  updateEventGen();
});
