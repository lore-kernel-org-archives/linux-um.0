Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lorenzo@google.com>) id 1Zz3rU-0003V6-MB
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 14:37:28 +0000
Received: from mail-pa0-f46.google.com ([209.85.220.46])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zz3rT-0004GV-TU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Nov 2015 14:37:28 +0000
Received: by padhx2 with SMTP id hx2so46734617pad.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 18 Nov 2015 06:37:22 -0800 (PST)
From: Lorenzo Colitti <lorenzo@google.com>
Date: Wed, 18 Nov 2015 23:12:09 +0900
Message-Id: <1447855929-92862-1-git-send-email-lorenzo@google.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH] arch: um: fix error when linking vmlinux.
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

On gcc Ubuntu 4.8.4-2ubuntu1~14.04, linking vmlinux fails with:

arch/um/os-Linux/built-in.o: In function `os_timer_create':
/android/kernel/android/arch/um/os-Linux/time.c:51: undefined reference to `timer_create'
arch/um/os-Linux/built-in.o: In function `os_timer_set_interval':
/android/kernel/android/arch/um/os-Linux/time.c:84: undefined reference to `timer_settime'
arch/um/os-Linux/built-in.o: In function `os_timer_remain':
/android/kernel/android/arch/um/os-Linux/time.c:109: undefined reference to `timer_gettime'
arch/um/os-Linux/built-in.o: In function `os_timer_one_shot':
/android/kernel/android/arch/um/os-Linux/time.c:132: undefined reference to `timer_settime'
arch/um/os-Linux/built-in.o: In function `os_timer_disable':
/android/kernel/android/arch/um/os-Linux/time.c:145: undefined reference to `timer_settime'

This is because -lrt appears in the generated link commandline
after arch/um/os-Linux/built-in.o. Fix this by removing -lrt from
arch/um/Makefile and adding it to the UM-specific section of
scripts/link-vmlinux.sh.

Signed-off-by: Lorenzo Colitti <lorenzo@google.com>
---
 arch/um/Makefile        | 2 +-
 scripts/link-vmlinux.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 25ed409..e3abe6f 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -131,7 +131,7 @@ export LDS_ELF_FORMAT := $(ELF_FORMAT)
 # The wrappers will select whether using "malloc" or the kernel allocator.
 LINK_WRAPS = -Wl,--wrap,malloc -Wl,--wrap,free -Wl,--wrap,calloc
 
-LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt)) -lrt
+LD_FLAGS_CMDLINE = $(foreach opt,$(LDFLAGS),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
 export CFLAGS_vmlinux := $(LINK-y) $(LINK_WRAPS) $(LD_FLAGS_CMDLINE)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1a10d8a..dacf71a 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -62,7 +62,7 @@ vmlinux_link()
 			-Wl,--start-group                                    \
 				 ${KBUILD_VMLINUX_MAIN}                      \
 			-Wl,--end-group                                      \
-			-lutil ${1}
+			-lutil -lrt ${1}
 		rm -f linux
 	fi
 }
-- 
2.6.0.rc2.230.g3dd15c0


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

