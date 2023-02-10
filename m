Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DF6C05027
	for <linux-um@archiver.kernel.org>; Fri, 10 Feb 2023 21:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zuPgz2hPaDl8ORFibrVaold9dTa+X0A8jBncEpdZCgE=; b=Sab3Ij8SVU2b2u
	genIiGAOLaPKu6le4V8jrlgYmGERMo9CqFWnropiQ8pYWRzT/DJWUJ85TR83Rr0aclYaCWaE9dtvp
	ZK6mwgCqHGcS7QROTLQdmmw2Xe9ZYNmhQtmwViPMjgjOuBMTSkNrJqT2wtBQ0iVHfH35BhWH5ckQd
	UFzLs9tnOP4QiIuMoz63Py5BpBQiPczFrKVgo6994gBvOBV0XxbzLG9bZZGQytVe71FSEZ/HTBXGf
	3WZc5bgscnIt9C6kWc8rWYRcAN1cuhDgqGTB/w+NWO9xwJUwIByOPltmcwqxnVk0IJZkvP8ffjsMU
	ij5d0m3CDU9FkRUUtsAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQagl-007apC-Lb; Fri, 10 Feb 2023 21:12:11 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQaaH-007YSs-0r
	for linux-um@lists.infradead.org; Fri, 10 Feb 2023 21:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=7MKtjR1dpvy8eAZAyuTDKj6h2sc3YdHif5e2CFsjr2Y=; t=1676063125; x=1677272725; 
	b=Zn986+pg8DppSa3ScHfe12yKDHnp2noo4pza/pyhUkwBXhODDmtGz1baCx2A/7A09jKksBg4fAj
	quOSAZaC880G2k5CC9zG/j/AGc4MObs0FdLb35ESApHkB+FoXJM29RYq2K6v1FFp8iqFcM1FrHUAx
	pIX8E0K/xxkCoVdLbHKBG+g4kaTD2OzLwLQz1KvOJlpGNHEbFt/8zpomEq363ua3LGOTcnEj1205M
	Dd2diTIuujrsNfz0l7ApAGE3cfFSZSS93TjzTsH7SOSnxpvO8DnuJKBSzEHfkZRLvFuJBY+xnmf17
	k1j0kfhn1aU/LRj1lgijJj0eJpSBSXlhiFjg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1pQaa8-008R0g-29;
	Fri, 10 Feb 2023 22:05:20 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] um: hostfs: define our own API boundary
Date: Fri, 10 Feb 2023 22:05:08 +0100
Message-Id: <20230210220511.fe9e2c4d805b.I2c7f7e32c861bfb10ff13860e80ef7daf4f60df9@changeid>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_130529_199676_04335991 
X-CRM114-Status: GOOD (  13.08  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
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
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

Instead of exporting the set of functions provided by
glibc that are needed for hostfs_user.c, just build that
into the kernel image whenever hostfs is built, and then
export _those_ functions cleanly, to be independent of
the libc implementation.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/user_syms.c | 70 ------------------------------------
 fs/Makefile                  |  2 +-
 fs/hostfs/Makefile           |  6 ++--
 fs/hostfs/hostfs_user_exp.c  | 28 +++++++++++++++
 4 files changed, 33 insertions(+), 73 deletions(-)
 create mode 100644 fs/hostfs/hostfs_user_exp.c

diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index fd575ecbcaec..22ed13a9b3e7 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -34,81 +34,11 @@ EXPORT_SYMBOL(memset);
 
 EXPORT_SYMBOL(printf);
 
-/* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
- * However, the modules will use the CRC defined *here*, no matter if it is
- * good; so the versions of these symbols will always match
- */
-#define EXPORT_SYMBOL_PROTO(sym)       \
-	int sym(void);                  \
-	EXPORT_SYMBOL(sym);
-
-extern void readdir64(void) __attribute__((weak));
-EXPORT_SYMBOL(readdir64);
-extern void truncate64(void) __attribute__((weak));
-EXPORT_SYMBOL(truncate64);
-
 #ifdef CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA
 EXPORT_SYMBOL(vsyscall_ehdr);
 EXPORT_SYMBOL(vsyscall_end);
 #endif
 
-EXPORT_SYMBOL_PROTO(__errno_location);
-
-EXPORT_SYMBOL_PROTO(access);
-EXPORT_SYMBOL_PROTO(open);
-EXPORT_SYMBOL_PROTO(open64);
-EXPORT_SYMBOL_PROTO(close);
-EXPORT_SYMBOL_PROTO(read);
-EXPORT_SYMBOL_PROTO(write);
-EXPORT_SYMBOL_PROTO(dup2);
-EXPORT_SYMBOL_PROTO(__xstat);
-EXPORT_SYMBOL_PROTO(__lxstat);
-EXPORT_SYMBOL_PROTO(__lxstat64);
-EXPORT_SYMBOL_PROTO(__fxstat64);
-EXPORT_SYMBOL_PROTO(lseek);
-EXPORT_SYMBOL_PROTO(lseek64);
-EXPORT_SYMBOL_PROTO(chown);
-EXPORT_SYMBOL_PROTO(fchown);
-EXPORT_SYMBOL_PROTO(truncate);
-EXPORT_SYMBOL_PROTO(ftruncate64);
-EXPORT_SYMBOL_PROTO(utime);
-EXPORT_SYMBOL_PROTO(utimes);
-EXPORT_SYMBOL_PROTO(futimes);
-EXPORT_SYMBOL_PROTO(chmod);
-EXPORT_SYMBOL_PROTO(fchmod);
-EXPORT_SYMBOL_PROTO(rename);
-EXPORT_SYMBOL_PROTO(__xmknod);
-
-EXPORT_SYMBOL_PROTO(symlink);
-EXPORT_SYMBOL_PROTO(link);
-EXPORT_SYMBOL_PROTO(unlink);
-EXPORT_SYMBOL_PROTO(readlink);
-
-EXPORT_SYMBOL_PROTO(mkdir);
-EXPORT_SYMBOL_PROTO(rmdir);
-EXPORT_SYMBOL_PROTO(opendir);
-EXPORT_SYMBOL_PROTO(readdir);
-EXPORT_SYMBOL_PROTO(closedir);
-EXPORT_SYMBOL_PROTO(seekdir);
-EXPORT_SYMBOL_PROTO(telldir);
-
-EXPORT_SYMBOL_PROTO(ioctl);
-
-EXPORT_SYMBOL_PROTO(pread64);
-EXPORT_SYMBOL_PROTO(pwrite64);
-
-EXPORT_SYMBOL_PROTO(statfs);
-EXPORT_SYMBOL_PROTO(statfs64);
-
-EXPORT_SYMBOL_PROTO(getuid);
-
-EXPORT_SYMBOL_PROTO(fsync);
-EXPORT_SYMBOL_PROTO(fdatasync);
-
-EXPORT_SYMBOL_PROTO(lstat64);
-EXPORT_SYMBOL_PROTO(fstat64);
-EXPORT_SYMBOL_PROTO(mknod);
-
 /* Export symbols used by GCC for the stack protector. */
 extern void __stack_smash_handler(void *) __attribute__((weak));
 EXPORT_SYMBOL(__stack_smash_handler);
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..59d2e7ecfc36 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_9P_FS)		+= 9p/
 obj-$(CONFIG_AFS_FS)		+= afs/
 obj-$(CONFIG_NILFS2_FS)		+= nilfs2/
 obj-$(CONFIG_BEFS_FS)		+= befs/
-obj-$(CONFIG_HOSTFS)		+= hostfs/
+obj-y				+= hostfs/
 obj-$(CONFIG_CACHEFILES)	+= cachefiles/
 obj-$(CONFIG_DEBUG_FS)		+= debugfs/
 obj-$(CONFIG_TRACING)		+= tracefs/
diff --git a/fs/hostfs/Makefile b/fs/hostfs/Makefile
index d5beaffad43b..1c573eb6193f 100644
--- a/fs/hostfs/Makefile
+++ b/fs/hostfs/Makefile
@@ -3,9 +3,11 @@
 # Licensed under the GPL
 #
 
-hostfs-objs := hostfs_kern.o hostfs_user.o
+hostfs-objs := hostfs_kern.o
 
-obj-y :=
+hostfs-builtin-$(CONFIG_HOSTFS) += hostfs_user.o hostfs_user_exp.o
+
+obj-y := $(hostfs-builtin-y) $(hostfs-builtin-m)
 obj-$(CONFIG_HOSTFS) += hostfs.o
 
 include arch/um/scripts/Makefile.rules
diff --git a/fs/hostfs/hostfs_user_exp.c b/fs/hostfs/hostfs_user_exp.c
new file mode 100644
index 000000000000..250c91c55c46
--- /dev/null
+++ b/fs/hostfs/hostfs_user_exp.c
@@ -0,0 +1,28 @@
+#include <linux/module.h>
+#include "hostfs.h"
+
+EXPORT_SYMBOL_GPL(stat_file);
+EXPORT_SYMBOL_GPL(access_file);
+EXPORT_SYMBOL_GPL(open_file);
+EXPORT_SYMBOL_GPL(open_dir);
+EXPORT_SYMBOL_GPL(seek_dir);
+EXPORT_SYMBOL_GPL(read_dir);
+EXPORT_SYMBOL_GPL(read_file);
+EXPORT_SYMBOL_GPL(write_file);
+EXPORT_SYMBOL_GPL(lseek_file);
+EXPORT_SYMBOL_GPL(fsync_file);
+EXPORT_SYMBOL_GPL(replace_file);
+EXPORT_SYMBOL_GPL(close_file);
+EXPORT_SYMBOL_GPL(close_dir);
+EXPORT_SYMBOL_GPL(file_create);
+EXPORT_SYMBOL_GPL(set_attr);
+EXPORT_SYMBOL_GPL(make_symlink);
+EXPORT_SYMBOL_GPL(unlink_file);
+EXPORT_SYMBOL_GPL(do_mkdir);
+EXPORT_SYMBOL_GPL(hostfs_do_rmdir);
+EXPORT_SYMBOL_GPL(do_mknod);
+EXPORT_SYMBOL_GPL(link_file);
+EXPORT_SYMBOL_GPL(hostfs_do_readlink);
+EXPORT_SYMBOL_GPL(rename_file);
+EXPORT_SYMBOL_GPL(rename2_file);
+EXPORT_SYMBOL_GPL(do_statfs);
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
