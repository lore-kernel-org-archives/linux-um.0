Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 20 Feb 2010 22:33:59 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [Patch] um: tell git to ignore generated files
Message-ID: <20100220143359.GD3000@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


git should ignore these files, since they are generated.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>

---
diff --git a/.gitignore b/.gitignore
index de6344e..efab0eb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,6 +36,7 @@ modules.builtin
 #
 tags
 TAGS
+linux
 vmlinux
 vmlinuz
 System.map
diff --git a/arch/um/.gitignore b/arch/um/.gitignore
new file mode 100644
index 0000000..f22bd73
--- /dev/null
+++ b/arch/um/.gitignore
@@ -0,0 +1,5 @@
+include/shared/kern_constants.h
+include/shared/user_constants.h
+kernel/config.c
+kernel/config.tmp
+kernel/vmlinux.lds

