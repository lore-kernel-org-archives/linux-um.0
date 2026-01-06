Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C457CD0423
	for <linux-um@archiver.kernel.org>; Tue,  6 Jan 2026 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lUnHboSUOcQXGakRQ7X5EXkeghfdBrLtfgJH3Io2RZc=; b=rfhH+8dfDEuJsCyc6uf8NcpwG5
	WoTMvVhCtpTQCbpo5U8Uvo0U4bvtsE6SpjiWdPkdLjub/Xf3pKEsLy4fvQ2w6USKQB/B16PNoG+Ep
	j7Ywkc0N+pwWMTbH6wjhqKGJ9ujcce6L+AHxlRFscSWq4Xkxk6mQB7r2GOsQt8Zty+6jORoyU2vel
	mkB8eR2/UTnvF1yNOIe56U5P9X1llhJtOOHbus8hS/RxDNId4OVTRnnV9wnunmMAIHrqU3+oqCNmx
	3cNamh7z5Oct33Y2EtKIU1SWiWKos+XpiRK6e64Qf5ivOTLczq2PO36kbrt8Ek8CajT/RGuTs8mNX
	GhgRlnpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhS-0000000CFoC-3xTP;
	Tue, 06 Jan 2026 00:13:26 +0000
Received: from out28-194.mail.aliyun.com ([115.124.28.194])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcuhN-0000000CFmj-0Yct
	for linux-um@lists.infradead.org;
	Tue, 06 Jan 2026 00:13:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1767658392; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=lUnHboSUOcQXGakRQ7X5EXkeghfdBrLtfgJH3Io2RZc=;
	b=gvEjYicJluo4L/zhs4AFd8l6+O50Tn2fSWelvoUU7Yn1qGP/enJT5yQ8QK+F/tgzhSJXEfJCkVpCZf5v3deAMebQ3EdXqllIb8WNuhk1VA00qqCDEzR0l+dXbLMdk9XJ4GEDrpNHUdPjqdcxwoPQKj1FDHyLSqrZRu6QDX+DEyA=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.g-qgwWy_1767658390 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 06 Jan 2026 08:13:10 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: Handle SIGCHLD in seccomp mode like other IRQ signals
Date: Tue,  6 Jan 2026 08:12:28 +0800
Message-Id: <20260106001228.1531146-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106001228.1531146-1-tiwei.btw@antgroup.com>
References: <20260106001228.1531146-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_161321_375244_60B8431A 
X-CRM114-Status: UNSURE (   6.47  )
X-CRM114-Notice: Please train this message.
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

In seccomp mode, SIGCHLD serves as the child reaper IRQ. So, let's
handle it in the same way as other IRQ signals, including preventing
them from nesting with each other and allowing interrupted syscalls
to be automatically restarted.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index de372b936a80..6c993bc8c78e 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -16,6 +16,7 @@
 #include <as-layout.h>
 #include <kern_util.h>
 #include <os.h>
+#include <skas.h>
 #include <sysdep/mcontext.h>
 #include <um_malloc.h>
 #include <sys/ucontext.h>
@@ -224,6 +225,8 @@ void set_handler(int sig)
 	sigaddset(&action.sa_mask, SIGIO);
 	sigaddset(&action.sa_mask, SIGWINCH);
 	sigaddset(&action.sa_mask, SIGALRM);
+	if (using_seccomp)
+		sigaddset(&action.sa_mask, SIGCHLD);
 
 	if (sig == SIGSEGV)
 		flags |= SA_NODEFER;
-- 
2.34.1


