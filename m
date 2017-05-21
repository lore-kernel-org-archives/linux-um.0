Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [RFC][PATCH] um: Remove proc command from mconsole
Date: Sun, 21 May 2017 23:19:03 +0200
Message-Id: <1495401543-6314-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, hch@lst.de, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This feature is another abuser of set_fs().
Reading proc files from the host side is a debugging feature
with no security checks at all. The path is not sanitized, therefore
any file could be read.
Let's get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
Hi!

Unless I miss something is feature is not ABI since it was addeded for
debugging UML only. It is broken wrt. security and abuses set_fs().
I think we can just remove it.

mconsole_proc anyone? ;)

Thanks,
//richard

---

 arch/um/drivers/mconsole_kern.c | 52 -----------------------------------------
 arch/um/drivers/mconsole_user.c |  1 -
 2 files changed, 53 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index af326fb6510d..b7fedf77f9f3 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -122,57 +122,6 @@ void mconsole_log(struct mc_request *req)
 	mconsole_reply(req, "", 0, 0);
 }
 
-void mconsole_proc(struct mc_request *req)
-{
-	struct vfsmount *mnt = task_active_pid_ns(current)->proc_mnt;
-	char *buf;
-	int len;
-	struct file *file;
-	int first_chunk = 1;
-	char *ptr = req->request.data;
-
-	ptr += strlen("proc");
-	ptr = skip_spaces(ptr);
-
-	file = file_open_root(mnt->mnt_root, mnt, ptr, O_RDONLY, 0);
-	if (IS_ERR(file)) {
-		mconsole_reply(req, "Failed to open file", 1, 0);
-		printk(KERN_ERR "open /proc/%s: %ld\n", ptr, PTR_ERR(file));
-		goto out;
-	}
-
-	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (buf == NULL) {
-		mconsole_reply(req, "Failed to allocate buffer", 1, 0);
-		goto out_fput;
-	}
-
-	do {
-		loff_t pos = file->f_pos;
-		mm_segment_t old_fs = get_fs();
-		set_fs(KERNEL_DS);
-		len = vfs_read(file, buf, PAGE_SIZE - 1, &pos);
-		set_fs(old_fs);
-		file->f_pos = pos;
-		if (len < 0) {
-			mconsole_reply(req, "Read of file failed", 1, 0);
-			goto out_free;
-		}
-		/* Begin the file content on his own line. */
-		if (first_chunk) {
-			mconsole_reply(req, "\n", 0, 1);
-			first_chunk = 0;
-		}
-		buf[len] = '\0';
-		mconsole_reply(req, buf, 0, (len > 0));
-	} while (len > 0);
- out_free:
-	kfree(buf);
- out_fput:
-	fput(file);
- out: ;
-}
-
 #define UML_MCONSOLE_HELPTEXT \
 "Commands: \n\
     version - Get kernel version \n\
@@ -188,7 +137,6 @@ void mconsole_proc(struct mc_request *req)
     stop - pause the UML; it will do nothing until it receives a 'go' \n\
     go - continue the UML after a 'stop' \n\
     log <string> - make UML enter <string> into the kernel log\n\
-    proc <file> - returns the contents of the UML's /proc/<file>\n\
     stack <pid> - returns the stack of the specified pid\n\
 "
 
diff --git a/arch/um/drivers/mconsole_user.c b/arch/um/drivers/mconsole_user.c
index 99209826adb1..59d81d7ead58 100644
--- a/arch/um/drivers/mconsole_user.c
+++ b/arch/um/drivers/mconsole_user.c
@@ -30,7 +30,6 @@ static struct mconsole_command commands[] = {
 	{ "stop", mconsole_stop, MCONSOLE_PROC },
 	{ "go", mconsole_go, MCONSOLE_INTR },
 	{ "log", mconsole_log, MCONSOLE_INTR },
-	{ "proc", mconsole_proc, MCONSOLE_PROC },
 	{ "stack", mconsole_stack, MCONSOLE_INTR },
 };
 
-- 
2.7.3


