Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6954EC433FE
	for <linux-um@archiver.kernel.org>; Tue, 22 Nov 2022 10:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Q7S5QXZsNR4eOAb8gXnkKh4h0treIpYqYSxmwMzrtg=; b=2RIgwUqv8AOQSi
	P0+9FQzwV9nSOR9KLhS07IqolP2PsB8ir4Z5EhJGLPgxdSCEq4tzEYGgti3ISp9nlACXDs8+tt/dV
	sKisOH2m23+rnx6mjD9Tl1KXHB50o/0agPkhKOjC6Wp5dVs4h8NIzo6EX+ShMOeg/VixfyJ7MIhI5
	I5wxpNuuz5EEIYHlKIMYc0KaPNJQZaj/5ZLo3nceUQqHqbF8j3v706h6hcc3oEe46LsTjO72mtroF
	Yq/iDxuiWapVclr2wA1fTuS3duaQuTNPo0lo2ZyXHVcNFjjy53NCog9F0GFt71mqc7hGWqjO5mbAq
	yxH8zHEVWO0mFplYG5Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQFS-007g5m-Fy; Tue, 22 Nov 2022 10:11:26 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxQF3-007feR-3D
	for linux-um@lists.infradead.org; Tue, 22 Nov 2022 10:11:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0GOKaITcnUfATMBExVcQ+K8tMwNSYEyX3r0fYos9ylk=;
	t=1669111860; x=1670321460; b=ZeBzAvmhcSp99OhTOvjbPLawW7BtBTZTIDF0u1WTOQCoQnT
	RbDQAVYOaaftGLc2q0xjLemlyIUAUXAuAAPR+/2CTWr086D5o3s7LvmucZS/DbiSpa53QZcXsJAst
	VBEskVdm9lip8/BGbZIOxsTCeoCCb2pZiIZnJQKqFs3vmfpfO3SmAYqIdgAKi5xD9eRNy7dDbAgG9
	Z+SLzZy3aoiEjZDUgwf3Mgqd/D46GMSFIo9TcgQOzvwx7LnGp0tk1WMv7hdHlVV7pyaEfOBNFv2wC
	JDrVMBkV0ok8TsBwbyTZjgGx+KSBNPARHBFZGsjYXCKX3qPWJjhRKbsgNY0DAVTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1oxQEo-006IGn-2k;
	Tue, 22 Nov 2022 11:10:46 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH v2 09/28] um: Do not use printk in userspace trampoline
Date: Tue, 22 Nov 2022 11:07:40 +0100
Message-Id: <20221122100759.208290-10-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122100759.208290-1-benjamin@sipsolutions.net>
References: <20221122100759.208290-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221122_021101_227821_880BD358 
X-CRM114-Status: UNSURE (   9.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin@sipsolutions.net>

The trampoline is running in a cloned process. It is not safe to use
printk for error printing there.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/process.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 90db8add1231..4198ca21e4ab 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -221,8 +221,8 @@ static int userspace_tramp(void *stack)
 	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
 		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, errno = %d\n",
-		       STUB_CODE, errno);
+		os_info("mapping mmap stub at 0x%lx failed, errno = %d\n",
+			STUB_CODE, errno);
 		exit(1);
 	}
 
@@ -231,8 +231,8 @@ static int userspace_tramp(void *stack)
 		    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
 		    MAP_FIXED | MAP_SHARED, fd, offset);
 	if (addr == MAP_FAILED) {
-		printk(UM_KERN_ERR "mapping segfault stack at 0x%lx failed, errno = %d\n",
-		       STUB_DATA, errno);
+		os_info("mapping segfault stack at 0x%lx failed, errno = %d\n",
+			STUB_DATA, errno);
 		exit(1);
 	}
 
@@ -242,8 +242,8 @@ static int userspace_tramp(void *stack)
 	sa.sa_sigaction = (void *) segv_handler;
 	sa.sa_restorer = NULL;
 	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-		printk(UM_KERN_ERR "%s - setting SIGSEGV handler failed - errno = %d\n",
-		       __func__, errno);
+		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
+			__func__, errno);
 		exit(1);
 	}
 
-- 
2.38.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
