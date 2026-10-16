const { app, BrowserWindow, shell, Menu } = require('electron');
const path = require('path');
function createWindow() {
  const win = new BrowserWindow({ width: 1100, height: 800, minWidth: 420, minHeight: 600, title: 'Zad dz',
    icon: path.join(__dirname, 'build', 'icon.png'), webPreferences: { contextIsolation: true, nodeIntegration: false } });
  Menu.setApplicationMenu(null);
  win.loadFile(path.join(__dirname, 'app', 'index.html'));
  win.webContents.setWindowOpenHandler(({ url }) => { if (/^(https?:\/\/|mailto:|sms:)/i.test(url)) shell.openExternal(url); return { action: 'deny' }; });
  win.webContents.on('will-navigate', (e, url) => { if (/^https?:\/\//i.test(url)) { e.preventDefault(); shell.openExternal(url); } });
}
app.whenReady().then(createWindow);
app.on('window-all-closed', () => app.quit());
