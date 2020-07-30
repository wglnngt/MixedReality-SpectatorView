param(
    [switch] $DebugCompositor
)

$RootDirectory = Join-Path -Path $PSScriptRoot -ChildPath "\..\..\src\SpectatorView.Native"
$MetaFiles = Join-Path -Path $RootDirectory -ChildPath "UnityMetaFiles"
$DependenciesPropsFile = Join-Path -Path $RootDirectory -ChildPath "SpectatorView.Compositor\dependencies.props"

$PluginDirectory = Join-Path -Path $PSScriptRoot -ChildPath "\..\..\src\SpectatorView.Unity\Assets\SpectatorView.Native\Plugins"
$DesktopDirectory = Join-Path -Path $PluginDirectory -ChildPath "x64"
$WSAx86Directory = Join-Path -Path $PluginDirectory -ChildPath "WSA\x86"
$WSAARMDirectory = Join-Path -Path $PluginDirectory -ChildPath "WSA\ARM"
$WSAARM64Directory = Join-Path -Path $PluginDirectory -ChildPath "WSA\ARM64"

New-Item -ItemType Directory -Force -Path $PluginDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $DesktopDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $WSAx86Directory | Out-Null
New-Item -ItemType Directory -Force -Path $WSAARMDirectory | Out-Null
New-Item -ItemType Directory -Force -Path $WSAARM64Directory | Out-Null

$OpenCVVersion = "" #A version may or may not exist depending on the build

$CompositorFlavor = "Release"
if ($DebugCompositor)
{
  $CompositorFlavor = "Debug"
}

$CompositorDlls = @( "$RootDirectory\x64\$CompositorFlavor\SpectatorView.Compositor.dll",
                     "$RootDirectory\x64\$CompositorFlavor\SpectatorView.Compositor.pdb",
		     "$RootDirectory\x64\$CompositorFlavor\SpectatorView.Compositor.UnityPlugin.dll",
		     "$RootDirectory\x64\$CompositorFlavor\SpectatorView.Compositor.UnityPlugin.pdb")

Write-Host "Copying DSLR compositor $CompositorFlavor dlls to $DesktopDirectory"
foreach ($Dll in $CompositorDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, DSLR Compositor may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $DesktopDirectory
  }
}


$CalibrationDlls = @( "$RootDirectory\x64\Release\SpectatorView.OpenCV.dll",
                      "$RootDirectory\x64\Release\SpectatorView.OpenCV.pdb",
                      "$RootDirectory\x64\Release\opencv_aruco$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_calib3d$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_core$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_features2d$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_flann$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\opencv_imgproc$OpenCVVersion.dll",
                      "$RootDirectory\x64\Release\zlib1.dll")

Write-Host "Copying DSLR camera calibration dlls to $DesktopDirectory"
foreach ($Dll in $CalibrationDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, DSLR camera calibration may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $DesktopDirectory
  }
}

$ArUcoDlls = @( "$RootDirectory\Release\SpectatorView.OpenCV.UWP\SpectatorView.OpenCV.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\SpectatorView.OpenCV.pdb",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_aruco$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_calib3d$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_core$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_features2d$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_flann$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\opencv_imgproc$OpenCVVersion.dll",
                "$RootDirectory\Release\SpectatorView.OpenCV.UWP\zlib1.dll")

Write-Host "Copying ArUco marker detector dlls to $WSAx86Directory"
foreach ($Dll in $ArUcoDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, ArUco marker detection may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAx86Directory
  }
}

$EmptyArUcoDlls = @( "$RootDirectory\EmptyDlls\ARM\SpectatorView.OpenCV.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_aruco$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_calib3d$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_core$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_features2d$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_flann$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\opencv_imgproc$OpenCVVersion.dll",
                     "$RootDirectory\EmptyDlls\ARM\zlib1.dll")

Write-Host "Copying empty ArUco marker detector dlls to $WSAARMDirectory and $WSAARM64Directory"
foreach ($Dll in $EmptyArUcoDlls)
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, visual studio build may fail."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAARMDirectory
    Copy-Item -Force $Dll -Destination $WSAARM64Directory
  }
}

$WinRTx86ExtensionDlls = @( "$RootDirectory\Release\SpectatorView.WinRTExtensions\SpectatorView.WinRTExtensions.dll")

Write-Host "Copying WinRTExtension dlls to $WSAx86Directory"
foreach ($Dll in $WinRTx86ExtensionDlls )
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, app functionality may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAx86Directory
  }
}

$WinRTARMExtensionDlls = @( "$RootDirectory\ARM\Release\SpectatorView.WinRTExtensions\SpectatorView.WinRTExtensions.dll")

Write-Host "Copying WinRTExtension dlls to $WSAARMDirectory"
foreach ($Dll in $WinRTARMExtensionDlls )
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, app functionality may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAARMDirectory
  }
}

$WinRTARM64ExtensionDlls = @( "$RootDirectory\ARM64\Release\SpectatorView.WinRTExtensions\SpectatorView.WinRTExtensions.dll")

Write-Host "Copying WinRTExtension dlls to $WSAARM64Directory"
foreach ($Dll in $WinRTARM64ExtensionDlls )
{
  if (!(Test-Path $Dll)) {
    Write-Warning "$Dll not found, app functionality may not work correctly."
  }
  else
  {
    Copy-Item -Force $Dll -Destination $WSAARM64Directory
  }
}

$AzureKinectDlls = @( "sdk\windows-desktop\amd64\release\bin\depthengine_2_0.dll",
                      "sdk\windows-desktop\amd64\release\bin\k4a.dll",
                      "sdk\windows-desktop\amd64\release\bin\k4arecord.dll")

$AzureKinectBodyTrackingDlls = @( "sdk\windows-desktop\amd64\release\bin\dnn_model_2_0.onnx",
                                  "sdk\windows-desktop\amd64\release\bin\k4abt.dll",
                                  "sdk\windows-desktop\amd64\release\bin\onnxruntime.dll"
                                  "tools\cublas64_100.dll",
                                  "tools\cudart64_100.dll",
                                  "tools\cudnn64_7.dll" )

if (Test-Path -Path $DependenciesPropsFile -PathType Leaf) {
  [xml]$DependenciesPropsContent = Get-Content $DependenciesPropsFile

  $SolutionDirVariable = "`$(SolutionDir)"
  $SolutionDir = "$PSScriptRoot\..\..\src\SpectatorView.Native\"
  $AzureKinectSDKFolder = $DependenciesPropsContent.Project.PropertyGroup.AzureKinectSDK.replace($SolutionDirVariable, $SolutionDir)
  Write-Host "Looking for Azure Kinect SDK: $AzureKinectSDKFolder"
  if (Test-Path -Path $AzureKinectSDKFolder -PathType Container) {
    Write-Host "Copying Azure Kinect SDK dlls to $DesktopDirectory"

    foreach ($Dll in $AzureKinectDlls) {
      $DllFullPath = Join-Path -Path $AzureKinectSDKFolder -ChildPath $Dll
      Copy-Item -Force $DllFullPath -Destination $DesktopDirectory
    }
  } else {
    Write-Host "Azure Kinect SDK is not specified, skipping plugins"
  }

  $AzureKinectBodyTrackingSDKFolder = $DependenciesPropsContent.Project.PropertyGroup.AzureKinectBodyTrackingSDK.replace($SolutionDirVariable, $SolutionDir)
  Write-Host "Looking for Azure Kinect Body Tracking SDK: $AzureKinectBodyTrackingSDKFolder"
  if (Test-Path -Path $AzureKinectBodyTrackingSDKFolder -PathType Container) {
     Write-Host "Copying Azure Kinect Body Tracking SDK dlls to $DesktopDirectory"

    foreach ($Dll in $AzureKinectBodyTrackingDlls) {
      $DllFullPath = Join-Path -Path $AzureKinectBodyTrackingSDKFolder -ChildPath $Dll
      Copy-Item -Force $DllFullPath -Destination $DesktopDirectory
    }
  } else {
    Write-Host "Azure Kinect Body Tracking SDK is not specified, skipping plugins"
  }
} else {
  Write-Error "Dependencies.props could not be located"
}

Write-Host "Copying .meta files"
Copy-Item -Force "$MetaFiles\WSA\x86\*.meta" -Destination $WSAx86Directory
Copy-Item -Force "$MetaFiles\WSA\ARM\*.meta" -Destination $WSAARMDirectory
Copy-Item -Force "$MetaFiles\WSA\ARM64\*.meta" -Destination $WSAARM64Directory
Copy-Item -Force "$MetaFiles\x64\*.meta" -Destination $DesktopDirectory