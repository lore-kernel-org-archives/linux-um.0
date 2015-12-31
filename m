Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Vegard Nossum <vegard.nossum@oracle.com>
Date: Thu, 31 Dec 2015 17:06:17 +0100
Message-Id: <1451577977-12990-1-git-send-email-vegard.nossum@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] um: link with -lpthread
To: Richard Weinberger <richard@nod.at>
Cc: Lorenzo Colitti <lorenzo@google.com>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Similarly to commit fb1770aa78a43530940d0c2dd161e77bc705bdac, with gcc 5
on Ubuntu and CONFIG_STATIC_LINK=y I was seeing these linker errors:

/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
(.text+0xcd): undefined reference to `pthread_once'
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
(.text+0x126): undefined reference to `pthread_attr_init'
/usr/lib/gcc/x86_64-linux-gnu/5/../../../x86_64-linux-gnu/librt.a(timer_create.o): In function `__timer_create_new':
(.text+0x168): undefined reference to `pthread_attr_setdetachstate'
[...]

Obviously we also need -lpthread for librt.a.

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
---
 scripts/link-vmlinux.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index dacf71a..ba6c34e 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -62,7 +62,7 @@ vmlinux_link()
 			-Wl,--start-group                                    \
 				 ${KBUILD_VMLINUX_MAIN}                      \
 			-Wl,--end-group                                      \
-			-lutil -lrt ${1}
+			-lutil -lrt -lpthread ${1}
 		rm -f linux
 	fi
 }
-- 
1.9.1

