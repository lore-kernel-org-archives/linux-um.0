Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4090BCF11F9
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=n5AusyZW+IWCDnypqEsptazQ7H9DSo8gfkV623p7nI0=; b=KfcsqAzk1wrWBdVySmqecG/eFF
	KOn4Ylcm1d3rY0wS/x9WTHIFTdXoqLHcs00XDClYv3szVpH93+yvWabXcjRZceDLH1x87M6e//uxn
	GJZIIORc3AFxW5uU5VWv/tdeB0aFoKTnMQP72yDdTQweZMlXciiIasogRZFZ+fAtFKcD3biW2vYHi
	sPFA+ULTNodhs4u0u9vQs90MM7eUeQQf+7Q3HXXvOF4JoPx7GRLFa9vbllykXDrtyq2hWXCdmUt61
	ltaL4OHFpakZDQq+EN3Dxw//xARHaCiM7wBj0NrdZDs2hLyxkSqlvwhS0YDaBUP1FQMNl28xWQajO
	vNzABJ5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sytwD-0000000D3Qe-0GmX;
	Thu, 10 Oct 2024 14:14:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sytvl-0000000D3K9-2MuJ
	for linux-um@lists.infradead.org;
	Thu, 10 Oct 2024 14:14:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=n5AusyZW+IWCDnypqEsptazQ7H9DSo8gfkV623p7nI0=; t=1728569656; x=1729779256; 
	b=EDRrVBYRrjlW94U9p0VztIiqoNXB7cOJYf/GnQ7VH08BLlaS3e6RMnGveo6J5zJICqcpkAZ6Kjh
	0/GAiA/+cjJzMx35W1GgAOW8T4oiDBm+cZyHe0pxb6MxB+3cA4fQ3VdVuh15vpfbjGm5cEBO+bpAP
	46CbCXstBjemH+G7/f7r8OsuLbASXCBtqXzIXQKC6CpAbykxlLO/uHjVNXK1d8seWXWbe/ZadU5VO
	IpWniTPYP8lPkG8bD4DfzUmjImCQ6nhXuflbfJvQul3g00kIlODkFkCTiCulK71HcpcfOTjBeqm4u
	x6SA8zrHITqiinCLNt6GRnzZ/YEIrz0tW1lQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sytvh-000000068Br-453A;
	Thu, 10 Oct 2024 16:14:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: restore process name
Date: Thu, 10 Oct 2024 16:14:12 +0200
Message-ID: <20241010161411.c576e2aeb3e5.I244d4f34b8a8555ee5bec0e1cf5027bce4cc491b@changeid>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_071417_756568_2668646E 
X-CRM114-Status: GOOD (  11.66  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Johannes Berg <johannes.berg@intel.com>

After the execve() to disable ASLR, comm is now "exe",
which is a bit confusing. Use readlink() to get this
to the right name again.

Disable stack frame size warnings on main.o since it's
part of the initial userspace and can use larger stack.

Fixes: 68b9883cc16e ("um: Discover host_task_size from envp")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/os-Linux/Makefile |  2 ++
 arch/um/os-Linux/main.c   | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 544e0b344c75..049dfa5bc9c6 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -12,6 +12,8 @@ obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 
 CFLAGS_signal.o += -Wframe-larger-than=4096
 
+CFLAGS_main.o += -Wno-frame-larger-than
+
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 8a52c49c5361..31dba0912a19 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
+#include <limits.h>
 #include <sys/resource.h>
 #include <sys/personality.h>
 #include <as-layout.h>
@@ -112,8 +113,17 @@ int __init main(int argc, char **argv, char **envp)
 	/* Disable randomization and re-exec if it was changed successfully */
 	ret = personality(PER_LINUX | ADDR_NO_RANDOMIZE);
 	if (ret >= 0 && (ret & (PER_LINUX | ADDR_NO_RANDOMIZE)) !=
-			 (PER_LINUX | ADDR_NO_RANDOMIZE))
-		execve("/proc/self/exe", argv, envp);
+			 (PER_LINUX | ADDR_NO_RANDOMIZE)) {
+		char buf[PATH_MAX];
+		ssize_t ret;
+
+		ret = readlink("/proc/self/exe", buf, sizeof(buf));
+		if (ret < 0 || ret >= sizeof(buf)) {
+			perror("readlink failure");
+			exit(1);
+		}
+		execve(buf, argv, envp);
+	}
 
 	set_stklim();
 
-- 
2.47.0


