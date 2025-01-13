Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF191E7719E
	for <linux-um@archiver.kernel.org>; Mon, 13 Jan 2025 09:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wpyC88o32Kmzio3lHXNOTnww/k2SJG8O1PGtRJXg6C8=; b=B5JzWvnJX2OETKXxF61g3ejyhp
	5aNOWhiUTxq7i+R5dz51sYOplz+dQCBlUxMSfStjLuwoFWtMZXf5bOD2oJSXbSK4fdi+GTchrzTOJ
	3ei8ANjYyJuOXqJZMklcQ/gLdMWxAM1+zdxel5YjA5rbbGqA3wNzGNLS9T4CC+S/YjLkd+wWRuyxB
	qTqF/C23HmeXNNx21I9iCSW2XoHkEM+eLmQ/lx209OIfTGDmQCfDTGdyADLsYZVkM47ULIpL2gmR+
	kqWyrXbXBeVj1D6LePJlTNA91fU1v1SmHoNUHTWHR5Gs02wpOntn1yK9OEKpBW/oIDVwomq5wrC06
	aruyT3fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXGyB-00000004fgB-16PC;
	Mon, 13 Jan 2025 09:42:51 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXGxY-00000004fX3-3smR
	for linux-um@lists.infradead.org;
	Mon, 13 Jan 2025 09:42:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=wpyC88o32Kmzio3lHXNOTnww/k2SJG8O1PGtRJXg6C8=; t=1736761332; x=1737970932; 
	b=G3mKLNKQinOhV/K1J4J69pN2RCjV+Kg5ytXpbUaP/k3TXxGT6SoBQA6g7OMkmNyck4SH1zuSJcq
	spTSQ6pYefpbTxd1lDCXUOR3gM/fzQNeXaWGin6/enxAKV/+raK/a1+uG1tgnyLEq+U8cXOXrwqSJ
	HPm8ZwqoUpN1Gj5ewvutWp1D+rz11rkPY5Qj3Tjyepd50badF9tI58LGCteJ/9fFQn2d8u2lCqwZ7
	DjOlmsrMmY0Jb+1YiMLjOaT2eTgaEf3n3eptMqiySfvNLLwflIIRLq0KoHUz2zXki7NfE2b0NUtY5
	dYFyMhtDkOdOB9SUBfaJ6AyaZp3RmlPO4YSg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1tXGxU-0000000DU3E-0LUp;
	Mon, 13 Jan 2025 10:42:08 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Glenn Washburn <development@efficientek.com>
Subject: [PATCH v2] um: fix execve stub execution on old host OSs
Date: Mon, 13 Jan 2025 10:41:07 +0100
Message-ID: <20250113094107.674738-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_014212_964566_A9189558 
X-CRM114-Status: GOOD (  10.32  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

The stub execution uses the somewhat new close_range and execveat
syscalls. Of these two, the execveat call is essential, but the
close_range call is more about stub process hygiene rather than safety
(and its result is ignored).

Replace both calls with a raw syscall as older machines might not have a
recent enough kernel for close_range (with CLOSE_RANGE_CLOEXEC) or a
libc that does not yet expose both of the syscalls.

Fixes: 32e8eaf263d9 ("um: use execveat to create userspace MMs")
Reported-by: Glenn Washburn <development@efficientek.com>
Closes: https://lore.kernel.org/20250108022404.05e0de1e@crass-HP-ZBook-15-G2
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

v2:
- Fix regression in previous version to not close FD 0
---
 arch/um/os-Linux/skas/process.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index f683cfc9e51a..e2f8f156402f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -181,6 +181,10 @@ extern char __syscall_stub_start[];
 
 static int stub_exe_fd;
 
+#ifndef CLOSE_RANGE_CLOEXEC
+#define CLOSE_RANGE_CLOEXEC	(1U << 2)
+#endif
+
 static int userspace_tramp(void *stack)
 {
 	char *const argv[] = { "uml-userspace", NULL };
@@ -202,8 +206,12 @@ static int userspace_tramp(void *stack)
 	init_data.stub_data_fd = phys_mapping(uml_to_phys(stack), &offset);
 	init_data.stub_data_offset = MMAP_OFFSET(offset);
 
-	/* Set CLOEXEC on all FDs and then unset on all memory related FDs */
-	close_range(0, ~0U, CLOSE_RANGE_CLOEXEC);
+	/*
+	 * Avoid leaking unneeded FDs to the stub by setting CLOEXEC on all FDs
+	 * and then unsetting it on all memory related FDs.
+	 * This is not strictly necessary from a safety perspective.
+	 */
+	syscall(__NR_close_range, 0, ~0U, CLOSE_RANGE_CLOEXEC);
 
 	fcntl(init_data.stub_data_fd, F_SETFD, 0);
 	for (iomem = iomem_regions; iomem; iomem = iomem->next)
@@ -224,7 +232,9 @@ static int userspace_tramp(void *stack)
 	if (ret != sizeof(init_data))
 		exit(4);
 
-	execveat(stub_exe_fd, "", argv, NULL, AT_EMPTY_PATH);
+	/* Raw execveat for compatibility with older libc versions */
+	syscall(__NR_execveat, stub_exe_fd, (unsigned long)"",
+		(unsigned long)argv, NULL, AT_EMPTY_PATH);
 
 	exit(5);
 }
-- 
2.47.1


