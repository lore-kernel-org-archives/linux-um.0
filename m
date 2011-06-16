Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Date: Fri, 17 Jun 2011 00:11:20 +0200
Message-Id: <1308262280-21200-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] Fix infinite loop in search_binary_handler()
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

When search_binary_handler() is called to find a handler
for /sbin/modprobe it will end up in an infinite loop because
it executes request_module() to load a binfmt module with
/sbin/modprobe...

Running a x86_64 kernel without ia32 emulation and a x86 user land
triggers this issue.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 fs/exec.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 97e0d52..7271b22 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1411,7 +1411,10 @@ int search_binary_handler(struct linux_binprm *bprm,struct pt_regs *regs)
 			    printable(bprm->buf[2]) &&
 			    printable(bprm->buf[3]))
 				break; /* -ENOEXEC */
-			request_module("binfmt-%04x", *(unsigned short *)(&bprm->buf[2]));
+
+			/* Avoid an infinite loop */
+			if (strcmp(modprobe_path, bprm->filename))
+				request_module("binfmt-%04x", *(unsigned short *)(&bprm->buf[2]));
 #endif
 		}
 	}
-- 
1.7.5.4

