Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEDEC36010
	for <linux-um@archiver.kernel.org>; Fri,  4 Apr 2025 15:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hpxcIuD5HsqJ5CiEEdtrVwqDIkDCLo7rIQyfGLvVh9w=; b=yvlUxdLhMMegEYE5ejV2JLW+XS
	wo6VvWHQ0sErT5v5HaBezJTRcdO+FOMPFLM8J+4bDYLBb+k60bxa6hzf1Pw1YnQyaswAJhRn/HPSh
	5CZE37Y6NPlRw5j7e0z9vF2AJFOItmkKf3sHu67mleWjcXxjcjzQl/y4/OcdPoVL8EpagYw29PFAz
	bLOULr6gDcaSMvIiD9HvBQJS1hPStqwvIkxlL9ycLehIK8dJ1Q/WNX4rseS7YT6f1gftyYd4y/Zej
	tvwX+lHYToHdR7VBPSOFlOgpQ4hZh91/92xQ/gRvXiBi4rt/Yz3K1uYZ4+r+CUo29fYEYcmxNlatg
	XGUlSn9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ibp-0000000C6UA-2nme;
	Fri, 04 Apr 2025 15:05:29 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0ibn-0000000C6Sx-1rAw
	for linux-um@lists.infradead.org;
	Fri, 04 Apr 2025 15:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=hpxcIuD5HsqJ5CiEEdtrVwqDIkDCLo7rIQyfGLvVh9w=; t=1743779126; x=1744988726; 
	b=p6Hk0E8EUF9Y2aVnI9vnxC7ggEARegwurZolxWc37U6ZJcuRJQaFYOvZIYlxEtuPSFVMqaDeP1I
	rB2iySNOgnRY0hRqJwIPNf4FYeuPIzryJxM4jWPqAmSe52YnAeN7/zZ/bs8PoIgZfNYZbmCSfNnob
	BE2ruu+pOCUW5fGPuWnP91hEzszIUkt+r7usZq1VVgRBTj03pFPIgwQ79WfiYaQU8dXyIOqPo1xBc
	3293XSefYKuxv68P1P4SBGru+nxg4r0lpRdat1w974bQsNV7jHk/kvHcXb9V2SMzSgIzpRFtwSC+8
	nLVipHPwZJS3J719ywADuOrtRc64RwnYf3kw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u0ibj-0000000GImp-40ae;
	Fri, 04 Apr 2025 17:05:24 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] um: fix _nofault accesses
Date: Fri,  4 Apr 2025 17:05:19 +0200
Message-ID: <20250404170518.e88e8ad2d4cc.Ia93876fd0393b68c171d47cd9678aa458ed10d98@changeid>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_080527_485928_96F5FC4A 
X-CRM114-Status: GOOD (  15.85  )
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

Nathan reported [1] that when built with clang, the um kernel
crashes pretty much immediately. This turned out to be an issue
with the inline assembly I had added, when clang used %rax/%eax
for both operands. Reorder it so current->thread.segv_continue
is written first, and then the lifetime of _faulted won't have
overlap with the lifetime of segv_continue.

In the email thread Benjamin also pointed out that current->mm
is only NULL for true kernel tasks, but we could do this for a
userspace task, so the current->thread.segv_continue logic must
be lifted out of the mm==NULL check.

Finally, while looking at this, put a barrier() so the NULL
assignment to thread.segv_continue cannot be reorder before
the possibly faulting operation.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/r/20250402221254.GA384@ax162 [1]
Fixes: d1d7f01f7cd3 ("um: mark rodata read-only and implement _nofault accesses")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/include/asm/uaccess.h            |  2 ++
 arch/um/kernel/trap.c                    | 26 ++++++++++++------------
 arch/x86/um/shared/sysdep/faultinfo_32.h |  2 +-
 arch/x86/um/shared/sysdep/faultinfo_64.h |  2 +-
 4 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 3a08f9029a3f..1c6e0ae41b0c 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -55,6 +55,7 @@ do {									\
 		goto err_label;						\
 	}								\
 	*((type *)dst) = get_unaligned((type *)(src));			\
+	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
 
@@ -66,6 +67,7 @@ do {									\
 	if (__faulted)							\
 		goto err_label;						\
 	put_unaligned(*((type *)src), (type *)(dst));			\
+	barrier();							\
 	current->thread.segv_continue = NULL;				\
 } while (0)
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ce073150dc20..ef2272e92a43 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -225,20 +225,20 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 			panic("Failed to sync kernel TLBs: %d", err);
 		goto out;
 	}
-	else if (current->mm == NULL) {
-		if (current->pagefault_disabled) {
-			if (!mc) {
-				show_regs(container_of(regs, struct pt_regs, regs));
-				panic("Segfault with pagefaults disabled but no mcontext");
-			}
-			if (!current->thread.segv_continue) {
-				show_regs(container_of(regs, struct pt_regs, regs));
-				panic("Segfault without recovery target");
-			}
-			mc_set_rip(mc, current->thread.segv_continue);
-			current->thread.segv_continue = NULL;
-			goto out;
+	else if (current->pagefault_disabled) {
+		if (!mc) {
+			show_regs(container_of(regs, struct pt_regs, regs));
+			panic("Segfault with pagefaults disabled but no mcontext");
 		}
+		if (!current->thread.segv_continue) {
+			show_regs(container_of(regs, struct pt_regs, regs));
+			panic("Segfault without recovery target");
+		}
+		mc_set_rip(mc, current->thread.segv_continue);
+		current->thread.segv_continue = NULL;
+		goto out;
+	}
+	else if (current->mm == NULL) {
 		show_regs(container_of(regs, struct pt_regs, regs));
 		panic("Segfault with no mm");
 	}
diff --git a/arch/x86/um/shared/sysdep/faultinfo_32.h b/arch/x86/um/shared/sysdep/faultinfo_32.h
index ab5c8e47049c..9193a7790a71 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_32.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_32.h
@@ -31,8 +31,8 @@ struct faultinfo {
 
 #define ___backtrack_faulted(_faulted)					\
 	asm volatile (							\
-		"mov $0, %0\n"						\
 		"movl $__get_kernel_nofault_faulted_%=,%1\n"		\
+		"mov $0, %0\n"						\
 		"jmp _end_%=\n"						\
 		"__get_kernel_nofault_faulted_%=:\n"			\
 		"mov $1, %0;"						\
diff --git a/arch/x86/um/shared/sysdep/faultinfo_64.h b/arch/x86/um/shared/sysdep/faultinfo_64.h
index 26fb4835d3e9..61e4ca1e0ab5 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_64.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_64.h
@@ -31,8 +31,8 @@ struct faultinfo {
 
 #define ___backtrack_faulted(_faulted)					\
 	asm volatile (							\
-		"mov $0, %0\n"						\
 		"movq $__get_kernel_nofault_faulted_%=,%1\n"		\
+		"mov $0, %0\n"						\
 		"jmp _end_%=\n"						\
 		"__get_kernel_nofault_faulted_%=:\n"			\
 		"mov $1, %0;"						\
-- 
2.49.0


