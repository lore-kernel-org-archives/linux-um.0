Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071ABC04A95
	for <linux-um@archiver.kernel.org>; Fri, 10 Nov 2023 18:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aRqO7uOgq8J8k4eIL7HDDZsXu/YuXjBxt6f0qNs2F2s=; b=2pPMgbs+2+KEeW
	M90aRWu2Fr+wfJW+CHFQCTU6V24VuFCGV4RN7IqEziYMpO/Z8dwppwd89cy4AzjuGq1yHsAknzie4
	6sAY+HRuMege0M1YOiKXxyhZ31LUqRXVKWUnJBqEjuwR5y5ic6BhDySj6+NCnpn5LxeSKgrZzLNIY
	A20M1TsDZPOW0LsOfQeqGAc/rm53aI5FbQQmlqgd3nMpfFGwoL/W8z+j1qpqThfXpzWyZ6rJEbLAm
	7VO5D4LCNb6DoDm8xdZS46di/r+m3xG4hb2CLXNC0LGwH9PDR5xwo/NIc8GjidwJL4h9yMdFXUmuf
	3SPiwqZLhb5P+FPWm5jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WeI-009GVs-21;
	Fri, 10 Nov 2023 18:54:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r1WeE-009GSm-0a
	for linux-um@lists.infradead.org;
	Fri, 10 Nov 2023 18:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RgaJZJlPOYPkyAC5ygJC8dXNwfLDTBziiQ/hasKAHI0=;
	t=1699642470; x=1700852070; b=LQZKz+zXiTB/KeOjXtpDBdKgstgp8P0KEzd7qjHPGDa6xod
	2sAzENhO9tDwErOPOB7yHnlHG5XKLbTFVhsxI5/bsZGKBkpTHlcfpFLu0Pvnh0QHZGbMsYh0nyPjy
	xA19nUzcBwfZ1iteFcN+/WezyWznrC7bCPXLzvY0Yi17InHE4hCSCxh1DGniKMyXce6r7tPpEHzEQ
	uZB5riRq5uGlwu+kLUbM9kCFcaw/W9KLmAHydF4PH9UxKkcgVOwJCsvkXbmam6mKjPeO86k5Su+n1
	d+V8qhlhElgJo62RmyfBjMmB/JSlVsgBDBo5FZ96qnJC4wAvOk1taZ/IXrDbdbkA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r1WeC-000000039LG-0VJo;
	Fri, 10 Nov 2023 19:54:28 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] um: add mmap/mremap/munmap OS calls
Date: Fri, 10 Nov 2023 19:52:59 +0100
Message-ID: <20231110195255.711150d60a27.Ic2da1d3a983fe57340c1b693badfa9c5bd2d8c61@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110185255.32006-5-johannes@sipsolutions.net>
References: <20231110185255.32006-5-johannes@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231110_105430_222404_1DEABDF8 
X-CRM114-Status: GOOD (  10.46  )
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

For the upcoming shared-memory time-travel external
optimisations, we need to be able to mmap/mremap
(and on error munmap). Add the necessary OS calls.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/shared/os.h |  3 +++
 arch/um/os-Linux/file.c     | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 4fbe574eff4c..1a82c6548dd5 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -180,6 +180,9 @@ extern int os_eventfd(unsigned int initval, int flags);
 extern int os_sendmsg_fds(int fd, const void *buf, unsigned int len,
 			  const int *fds, unsigned int fds_num);
 int os_poll(unsigned int n, const int *fds);
+void *os_mmap_rw_shared(int fd, size_t size);
+void *os_mremap_rw_shared(void *old_addr, size_t old_size, size_t new_size);
+void os_munmap(void *addr, size_t size);
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index c972dfeab9a3..c482850f27d8 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
 #include <sys/un.h>
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/eventfd.h>
 #include <poll.h>
@@ -708,3 +709,30 @@ int os_poll(unsigned int n, const int *fds)
 
 	return -EIO;
 }
+
+void *os_mmap_rw_shared(int fd, size_t size)
+{
+	void *res = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+
+	if (res == MAP_FAILED)
+		return NULL;
+
+	return res;
+}
+
+void *os_mremap_rw_shared(void *old_addr, size_t old_size, size_t new_size)
+{
+	void *res;
+
+	res = mremap(old_addr, old_size, new_size, MREMAP_MAYMOVE, NULL);
+
+	if (res == MAP_FAILED)
+		return NULL;
+
+	return res;
+}
+
+void os_munmap(void *addr, size_t size)
+{
+	munmap(addr, size);
+}
-- 
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
