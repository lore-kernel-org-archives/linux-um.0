Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6127AC53209
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Nkq5ULqMRYGwjw+xLtrYJPITeI0l2K4PaMHFDVUKiEk=; b=WzE2a+VewA7J8QUFJnoM/XpWAP
	UtXfz4NhASAUqw1BzNoSlKXUt2436qvFYJnkfsaAxv9XQ24CgM/o/cZUPGSiazuhJN6/ZXtw5UdXK
	bYRzMrdG17vgHaWnh81HFmUiK+gxr9hWVH7JIIL0msvNWwXynW1OYsXiqFOEhxTsExSkJ3IdB1pmw
	5EWiyviJhb3x8D5YxCKT9CgcAZS+MRv9suFBIrKZvGNAg5HsJakTj9PTFX/QXHSvlLKnECUGV9OwQ
	DGvgMBmIryCMrMc2mI0KzwH4NhOifx/prtmFKnzV/vZGWWHJycAmV6VymjuoZS8t2iSdUdlSTX67l
	Y7yigoCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe8-0000000HGpj-3sFx;
	Fri, 24 Jul 2026 21:41:32 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.144.207])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGh9-3fGh
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id B50A5C0003E3;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com B50A5C0003E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=rP/30eNjoWdGI0nVXvPpYsc/XoqP1bck1OwJZBCRtDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCZhj/aoM02YOJgrXSJuLE5MsTsniRiQLjDAj2lRvUIAJfR33ONYYRCRCgL+5uS3H
	 9bR772mRXHQsgJTXu2JgZMi9GkUihcHfzFhfRwBJP7xaHslKMDYGK7+F83gfJNCLXk
	 vjMadfh8ZYqiFoCAN0PfLwtJDCCOCe6KE7+Oej1w=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 43C9BACE;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 1/9] um: Add os_set_pdeathsig helper function
Date: Fri, 24 Jul 2026 14:41:11 -0700
Message-Id: <20260724214119.1066665-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144125_009060_B84B8C2D 
X-CRM114-Status: GOOD (  11.10  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

commit 4e5adbe447db382cc76e05613581f96aef4f91d2 upstream

This helper can be used to set the parent-death signal of the calling
process to SIGKILL to ensure that the process will be killed if the
UML kernel dies unexpectedly without proper cleanup. This helper will
be used in the follow-up patches.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-2-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/include/shared/os.h | 2 ++
 arch/um/os-Linux/process.c  | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 77a8593f219a..2a0843cc2208 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -219,6 +219,8 @@ extern int os_unmap_memory(void *addr, int len);
 extern int os_drop_memory(void *addr, int length);
 extern int can_drop_memory(void);
 
+void os_set_pdeathsig(void);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 2686120ab232..4015d3dc3958 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -12,6 +12,7 @@
 #include <fcntl.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
+#include <sys/prctl.h>
 #include <sys/wait.h>
 #include <asm/unistd.h>
 #include <init.h>
@@ -234,3 +235,8 @@ void init_new_thread_signals(void)
 	set_handler(SIGIO);
 	signal(SIGWINCH, SIG_IGN);
 }
+
+void os_set_pdeathsig(void)
+{
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+}
-- 
2.34.1


