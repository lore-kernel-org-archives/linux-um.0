Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9B8CDD567
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nRrBFO7PNaqc5P86M1rvaWj8PRj0WHOG5HCSV9U7JjA=; b=MtWKnNaORJ8SMWZrRTCNS9uU3u
	HMGlQoSuzn5tojA5frwkEF8Z0SqDHQ72QOG67HF6O03kalLA0zHBcMQ36myKj1NfTRXkZuLELb7rO
	uYZsx612bOXy5/pwZ20kRHzRAU8+5S765fmHuwuc/M9q58bTsmWihZds0x8FEvJpfdNhXB2w1xSMG
	h8M40kvS4JbjQCDO93NT9+4M2ix5bF8CyHgd3mPO7WIoxOvEf91ztmRaswgIYCZOhdp846Psfodxr
	pQ8Hk3pEQS7aTUZszECbmG9gsi6k572hmLmrgSNsBKp9er6hsc8gatxtLH0RYObhZwldEuZpsVj5m
	JZgghonA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXc-0000000AGso-3sY0;
	Thu, 19 Sep 2024 12:45:48 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXa-0000000AGqs-0Ej4
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nRrBFO7PNaqc5P86M1rvaWj8PRj0WHOG5HCSV9U7JjA=;
	t=1726749945; x=1727959545; b=DEixYTsb3tR7lavqAxR+HCeGxhYowjRegtG72dYQz7UZDO2
	3lUk2g0S1YKJLyKf65nsp0Qusr46ke7VfJnGHSQmg2I8OFZqI7fgNeEhkyy5FXfR3PfNfO/S9V+O9
	l9Hi5IMcV/GKZdm/OBZYzSNJ+HAuIWBwFQSMGeDelXfxRUETaTWfOOKiNJDqKWGSA74rlkpNJj2bd
	5PwjfFSXEMF+Bm0wd0VNr+d7ZnVeUUpwOEKEi9VngrsOHdmdjBOwCeqE2JS14Lh4GHhoj97epQm6X
	ojjhBiVzMGDUmfnk6j/qkU7wAnsd1Iip0/t0g+y6faRjZkSN/SVmi04u4LQBvygA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXX-000000047AZ-2eTt;
	Thu, 19 Sep 2024 14:45:44 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 06/10] um: Calculate stub data address relative to stub code
Date: Thu, 19 Sep 2024 14:45:07 +0200
Message-ID: <20240919124511.282088-7-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054546_155696_38C3051C 
X-CRM114-Status: GOOD (  12.55  )
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

Instead of using the current stack pointer, we can also use the current
instruction to calculate where the stub data is. With this the stub data
only needs to be aligned to a full page boundary.

Changing this has the advantage that we do not have a hole in the memory
space above the stub data (which would need to be explicitly cleared).

Another motivation to do this is that with the planned addition of a
SECCOMP based userspace the stack pointer may not be fully trustworthy.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/kernel/um_arch.c            |  6 ++----
 arch/x86/um/shared/sysdep/stub_32.h | 10 +++++++---
 arch/x86/um/shared/sysdep/stub_64.h |  8 +++++---
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8e594cda6d77..44589cbd4174 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -325,10 +325,8 @@ int __init linux_main(int argc, char **argv)
 		add_arg(DEFAULT_COMMAND_LINE_CONSOLE);
 
 	host_task_size = os_get_top_address();
-	/* reserve a few pages for the stubs (taking care of data alignment) */
-	/* align the data portion */
-	BUILD_BUG_ON(!is_power_of_2(STUB_DATA_PAGES));
-	stub_start = (host_task_size - 1) & ~(STUB_DATA_PAGES * PAGE_SIZE - 1);
+	/* reserve a few pages for the stubs */
+	stub_start = host_task_size - STUB_DATA_PAGES * PAGE_SIZE;
 	/* another page for the code portion */
 	stub_start -= PAGE_SIZE;
 	host_task_size = stub_start;
diff --git a/arch/x86/um/shared/sysdep/stub_32.h b/arch/x86/um/shared/sysdep/stub_32.h
index 0b44a86dd346..631a18d0ff44 100644
--- a/arch/x86/um/shared/sysdep/stub_32.h
+++ b/arch/x86/um/shared/sysdep/stub_32.h
@@ -112,10 +112,14 @@ static __always_inline void *get_stub_data(void)
 	unsigned long ret;
 
 	asm volatile (
-		"movl %%esp,%0 ;"
-		"andl %1,%0"
+		"call _here_%=;"
+		"_here_%=:"
+		"popl %0;"
+		"andl %1, %0 ;"
+		"addl %2, %0 ;"
 		: "=a" (ret)
-		: "g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)));
+		: "g" (~(UM_KERN_PAGE_SIZE - 1)),
+		  "g" (UM_KERN_PAGE_SIZE));
 
 	return (void *)ret;
 }
diff --git a/arch/x86/um/shared/sysdep/stub_64.h b/arch/x86/um/shared/sysdep/stub_64.h
index 8e4ff39dcade..17153dfd780a 100644
--- a/arch/x86/um/shared/sysdep/stub_64.h
+++ b/arch/x86/um/shared/sysdep/stub_64.h
@@ -117,10 +117,12 @@ static __always_inline void *get_stub_data(void)
 	unsigned long ret;
 
 	asm volatile (
-		"movq %%rsp,%0 ;"
-		"andq %1,%0"
+		"lea 0(%%rip), %0;"
+		"andq %1, %0 ;"
+		"addq %2, %0 ;"
 		: "=a" (ret)
-		: "g" (~(STUB_DATA_PAGES * UM_KERN_PAGE_SIZE - 1)));
+		: "g" (~(UM_KERN_PAGE_SIZE - 1)),
+		  "g" (UM_KERN_PAGE_SIZE));
 
 	return (void *)ret;
 }
-- 
2.46.0


