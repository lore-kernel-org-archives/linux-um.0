Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QL-0001pM-PJ
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:39:10 +0000
Received: by mail-pf1-x442.google.com with SMTP id q5so12072120pfg.13
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:39:05 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 27/47] lkl: Android ARM (arm/arm64) support
Date: Wed, 23 Oct 2019 13:38:01 +0900
Message-Id: <90e3c9dc2e9b24f2b94b634191e198b0340566b0.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

Initial attempt to run an application with hijack library on Android
platform.  Tested mostly on Android 6.x and 7.x.

The build process assumes that the android ndk toolchain is installed in
a host system as circle.yml does in its test.  arm32 build uses
alternate linker, stored in tools/lkl/bin directory, in order to avoid
the link issue (issue #59).

The CircleCI test infrastructure requires to use ubuntu 14.04 for this
test.

* Limitations
- aarch64 isn't tested on circleci due to difficulties on aarch64
emulator.
- bionic libc on android-24 emulator (arm32) doesn't call destructor, so
some of tests in hijack-test.sh fail.
- net.sh doesn't properly test network related issue.

Fixes #59.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 tools/lkl/bin/arm-linux-androideabi-ld | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 tools/lkl/bin/arm-linux-androideabi-ld

diff --git a/tools/lkl/bin/arm-linux-androideabi-ld b/tools/lkl/bin/arm-linux-androideabi-ld
new file mode 120000
index 000000000000..4194d24c4b5c
--- /dev/null
+++ b/tools/lkl/bin/arm-linux-androideabi-ld
@@ -0,0 +1 @@
+arm-linux-androideabi-ld.gold
\ No newline at end of file
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

