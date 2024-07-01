Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB2EC2BD09
	for <linux-um@archiver.kernel.org>; Mon,  1 Jul 2024 21:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ESsixDdius8VNpPMiTAxMFI20QYcV6IBwjMbUVI52VI=; b=VzVcVVPGC2cgPz7+8BxxNo6dHt
	NJws4lk98gi4jOyEVV2V0JjkI6NpTYpmRow8mjooHcrlnpwg2S/NVzmDSccCNRoi+K8piW+EVKPYZ
	ROb6X2sFrfMnN8tF9X2VowVccloO30wInnJMPzHbTKSJ4aV2ah1OdkMjsB3Q3JN1tNnzCjzsqjI9+
	0hvCWruaebSZYFSE2kdGPc/x8ZZ13FzSArS4ASg7UvEWeb+Jrk8yMHZpZf68Hv2BdQkIkR6Zwx0vz
	6Zl2A5Fut7DDYcJJfEDoBCKT/YtdKwqAY0R7uQ0n+2zrGXkOLuGFn4tb8DmXyhkJpZ4cksW6sSFVL
	0gcpqdvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOOVq-00000004san-3H6f;
	Mon, 01 Jul 2024 21:24:38 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOOVo-00000004sXL-10yo
	for linux-um@lists.infradead.org;
	Mon, 01 Jul 2024 21:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=ESsixDdius8VNpPMiTAxMFI20QYcV6IBwjMbUVI52VI=;
	t=1719869068; x=1721078668; b=k6FgHm3moqD3tlRW9cVVLBbnBINw6F+cor7LCvCZYn6+J/Y
	cvUstEPR5A64X5WYVeXHMp7mE4/9R4WPWVgdP9EnHsK7HNblQmBaDfSsjT80ZUtwIcYHV2RETUTms
	cWS5Uq9fQUzEHw8rvPaaPPA+QL3LFOFKl+NCcmh6mjU7RNQyYcdWePm3nlA9rYR/ypBylZJ45VqV2
	eBnsdfk08tddiVQLIggVO/GV/0Z/g0rWim84tenRDLrWBIliZ8S8IU7pej8etMUTc4UDGFshn9rza
	9PY/u9YrMVApL4agy8RuaNOBajijvJ/sdJqxAMBiU3L4jIz54Rg45f3FNrSYfVwA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOOVe-00000003JiD-1fq3;
	Mon, 01 Jul 2024 23:24:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] um: add mmap/mremap OS calls
Date: Mon,  1 Jul 2024 23:24:23 +0200
Message-ID: <20240701232420.02e9893c99f5.Ic2da1d3a983fe57340c1b693badfa9c5bd2d8c61@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701232420.efd62bd0dcd4.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
References: <20240701232420.efd62bd0dcd4.I2ca8d006b67feeb866ac2017af7b741c9e06445a@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_142436_317423_5809C787 
X-CRM114-Status: GOOD (  10.02  )
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

For the upcoming shared-memory time-travel external
optimisations, we need to be able to mmap/mremap
(and on error munmap). Add the necessary OS calls.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
--
v2: drop os_munmap()
---
 arch/um/include/shared/os.h |  2 ++
 arch/um/os-Linux/file.c     | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index fc4091c127c8..d269637adcd6 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -181,6 +181,8 @@ extern int os_eventfd(unsigned int initval, int flags);
 extern int os_sendmsg_fds(int fd, const void *buf, unsigned int len,
 			  const int *fds, unsigned int fds_num);
 int os_poll(unsigned int n, const int *fds);
+void *os_mmap_rw_shared(int fd, size_t size);
+void *os_mremap_rw_shared(void *old_addr, size_t old_size, size_t new_size);
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 6d3c73910946..5adf8f630049 100644
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
@@ -718,3 +719,25 @@ int os_poll(unsigned int n, const int *fds)
 
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
-- 
2.45.2


