# iPhone Specs

A lightweight SwiftUI app that shows the available device information without asking for any permissions. It is intended for sideloading in LiveContainer.

## Build an IPA on a Mac

1. Copy this folder to a Mac with Xcode installed.
2. In Terminal, run `./make-ipa.sh`.
3. Copy `build/iPhoneSpecs.ipa` to your iPhone and open it from LiveContainer.

The IPA is deliberately unsigned: LiveContainer handles launching supported sideloaded apps. No private entitlements or jailbreak-only APIs are used.

## Notes

Apps running inside LiveContainer retain normal iOS sandbox restrictions. The app reports public device APIs only; carrier, serial-number, and IMEI data are not available to third-party apps.
