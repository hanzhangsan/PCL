param([Parameter(Mandatory=$true)][string]$PackagePath, [switch]$CompileOnly)
$ErrorActionPreference = 'Stop'
$PackagePath = (Resolve-Path -LiteralPath $PackagePath).Path
# Run with Windows PowerShell, matching the application's .NET Framework runtime.
$references = @('System', 'System.Core', 'System.Net.Http', 'WindowsBase', 'PresentationCore', 'PresentationFramework', 'System.Xaml', 'Microsoft.VisualBasic') | ForEach-Object { [Reflection.Assembly]::LoadWithPartialName($_).Location }
$references += @('Plain Craft Launcher 2.exe', 'PCLCS.dll', 'MeloongCore.dll', 'MeloongCore.Wpf.dll', 'Newtonsoft.Json.dll') | ForEach-Object { Join-Path $PackagePath $_ }
$references += [Reflection.Assembly]::LoadWithPartialName('netstandard').Location
$harness = @'
using System;
using System.IO;
using System.Reflection;
using System.Collections.Generic;
using System.Security.Cryptography;
using Newtonsoft.Json.Linq;
using PCL;

[assembly: System.Runtime.Versioning.TargetFramework(".NETFramework,Version=v4.8")]

public static class DownloadSmoke {
    [STAThread]
    public static int Main() {
        try {
            var app = new System.Windows.Application();
            MeloongCore.Main.Init("PCLDownloadSmoke");
            string root = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "download-test");
            Directory.CreateDirectory(root);
            ModBase.PathTemp = Path.Combine(root, "cache") + "\\";
            Directory.CreateDirectory(ModBase.PathTemp + "Download");
            Directory.CreateDirectory(ModBase.PathTemp + "Cache");
            ModMinecraft.McFolderSelected = Path.Combine(root, ".minecraft") + "\\";
            Settings.Set("ToolDownloadVersion", 2, null);
            Settings.Set("ToolDownloadSource", 2, null);
            const string version = "1.20.1";
            var manifest = ModDownload.DlClientListMojangLoader;
            manifest.WaitForExitTime(120000, version);
            JObject entry = null;
            foreach (JObject candidate in manifest.Output.Value["versions"])
                if ((string)candidate["id"] == version) { entry = candidate; break; }
            if (entry == null) throw new Exception("Requested version missing");
            string folder = ModMinecraft.McFolderSelected + "versions\\" + version + "\\";
            Directory.CreateDirectory(folder);
            var factory = typeof(ModDownloadLib).GetMethod("McDownloadClientLoader", BindingFlags.NonPublic | BindingFlags.Static);
            var tasks = (List<ModLoader.LoaderBase>)factory.Invoke(null, new object[] { version, (string)entry["url"], folder });
            var install = new ModLoader.LoaderCombo<string>("Vanilla download smoke test", tasks);
            install.WaitForExitTime(600000, null, "Vanilla install timed out");
            var json = JObject.Parse(File.ReadAllText(folder + version + ".json"));
            Verify(folder + version + ".jar", (string)json["downloads"]["client"]["sha1"]);
            string indexPath = ModMinecraft.McFolderSelected + "assets\\indexes\\" + (string)json["assetIndex"]["id"] + ".json";
            Verify(indexPath, (string)json["assetIndex"]["sha1"]);
            var index = JObject.Parse(File.ReadAllText(indexPath));
            int count = 0;
            foreach (JProperty asset in ((JObject)index["objects"]).Properties()) {
                string hash = (string)asset.Value["hash"];
                Verify(ModMinecraft.McFolderSelected + "assets\\objects\\" + hash.Substring(0, 2) + "\\" + hash, hash);
                count++;
            }
            Console.WriteLine("PASS: PCL vanilla loader installed " + version + "; client, asset index, " + count + " assets verified with SHA1.");
            return 0;
        } catch (Exception ex) {
            Console.Error.WriteLine(ex.ToString());
            return 1;
        }
    }
    static void Verify(string path, string expected) {
        using (var stream = File.OpenRead(path))
        using (var sha = SHA1.Create()) {
            string actual = BitConverter.ToString(sha.ComputeHash(stream)).Replace("-", "").ToLowerInvariant();
            if (actual != expected) throw new Exception("SHA1 mismatch: " + path);
        }
    }
}
'@
$exe = Join-Path $PackagePath 'DownloadSmoke.exe'
Copy-Item -LiteralPath (Join-Path $PackagePath 'PCL 下载修复版.exe') -Destination (Join-Path $PackagePath 'Plain Craft Launcher 2.exe')
$configuration = '<configuration><startup><supportedRuntime version="v4.0" sku=".NETFramework,Version=v4.8"/></startup><runtime><AppContextSwitchOverrides value="Switch.System.IO.UseLegacyPathHandling=false;Switch.System.IO.BlockLongPaths=false"/></runtime></configuration>'
[IO.File]::WriteAllText(($exe + '.config'), $configuration, [Text.UTF8Encoding]::new($true))
$sourcePath = Join-Path $PackagePath 'DownloadSmoke.cs'
[IO.File]::WriteAllText($sourcePath, $harness, [Text.UTF8Encoding]::new($true))
$compiler = Join-Path ([Runtime.InteropServices.RuntimeEnvironment]::GetRuntimeDirectory()) 'csc.exe'
$arguments = @('/nologo', '/noconfig', '/target:exe', ('/out:' + $exe))
$arguments += $references | ForEach-Object { '/reference:' + $_ }
$arguments += $sourcePath
& $compiler $arguments
if ($LASTEXITCODE -ne 0) { throw 'Download harness compilation failed' }
if (!$CompileOnly) {
    & $exe
    if ($LASTEXITCODE -ne 0) { throw "PCL download integration test failed: $LASTEXITCODE" }
}
