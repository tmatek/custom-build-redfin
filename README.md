### Custom AOSP build for Pixel 5 (redfin)

Requirements:

- at least 32 gigs of RAM
- at least 300 gigs of disk space
- A decent Debian/Ubuntu machine

Clone this repo. First setup the basics:

```bash
source pre-requisites.sh
```

Then fetch the kernel + AOSP repos:

```bash
repo-sync.sh
```

Next apply custom patches to the repos:

```bash
patch.sh
```

Now its time to build the kernel:

```bash
build-kernel.sh
```

Then build AOSP:

```bash
build-aosp.sh
```

Its time to sign the build with a custom release key:

```bash
sign-build.sh
```

Finally, package everything up, ready to flash:

```bash
package.sh
# output is in dist/ folder
```
