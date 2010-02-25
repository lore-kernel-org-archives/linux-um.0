Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 25 Feb 2010 22:55:46 +0800
From: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Subject: [RESEND Patch] um: tell git to ignore generated files
Message-ID: <20100225145546.GC3842@hack>
References: <20100220143359.GD3000@hack> <20100220150936.GP30031@ZenIV.linux.org.uk> <20100220153521.GK3000@hack>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100220153521.GK3000@hack>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Am=C3=A9rico?= Wang <xiyou.wangcong@gmail.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Tell git to ignore the generated files under um, except:

 include/shared/kern_constants.h
 include/shared/user_constants.h

which will be moved to include/generated.

Signed-off-by: WANG Cong <xiyou.wangcong@gmail.com>

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
@@ -0,0 +1,3 @@
+kernel/config.c
+kernel/config.tmp
+kernel/vmlinux.lds
