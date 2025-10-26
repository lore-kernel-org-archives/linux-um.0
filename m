Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6393CCF9E9
	for <linux-um@archiver.kernel.org>; Sun, 26 Oct 2025 23:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8iv4wWSSxzBBPprQcaPfqau6KPNlNUBMGQbg+ZD+dbQ=; b=xHsr1cA4z5lXE0s6lZ/8ztliQL
	c5AytX1Ed9LAdkrWRX8Ds2sEiBqY46byuZFGYJ4UjEEiPWSmZeOhmD3ajn+qLwSWFTd71PM3lNPM6
	H8U+44GB1f8G0egBwb/1y8M+L9IZV5KkBFU/qM0HVqIBJJsLE+NUbmz71SciF26Nbwr5KMEnXku2M
	F4W898kVfONQGcUy+yZreW7E+6HtklfrQ8kZIgMnNbXluVXqqSpqY7n7w/KNCH4oQ9L4Us0JVxCyS
	Ji07zYt8SS/dwIsgipo/HZ+yYNqeBpwzv6K/oYjn+WZ7WqchyMgXS4yxit+w8oHLc4CNppgUpn5tt
	6ADeJQ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeL-0000000CsHw-0V4U;
	Sun, 26 Oct 2025 23:59:49 +0000
Received: from out-178.mta0.migadu.com ([91.218.175.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDAeH-0000000CsHB-3bX4
	for linux-um@lists.infradead.org;
	Sun, 26 Oct 2025 23:59:47 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761523182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8iv4wWSSxzBBPprQcaPfqau6KPNlNUBMGQbg+ZD+dbQ=;
	b=YQdvB4pM/K/qXKGa2cW57VkHjRWYxidiE+u5PO+7PY1s98BM7SLGhYrl2s3tJREIyzyYtw
	sjgrFye52XQeTdWoGMZxQxK217Uw7o6d2BUbC3EUYmvmLS8HcJ3dpR8hhmmLhStIyzGmgk
	Q9GfEgXgUJ9JBfr9fkuDsCIizWRj/5g=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 2/3] um: Replace UML_ROUND_UP() with PAGE_ALIGN()
Date: Mon, 27 Oct 2025 07:59:11 +0800
Message-Id: <20251026235912.1654016-3-tiwei.bie@linux.dev>
In-Reply-To: <20251026235912.1654016-1-tiwei.bie@linux.dev>
References: <20251026235912.1654016-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251026_165946_342799_10B0A24F 
X-CRM114-Status: GOOD (  11.30  )
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

Although UML_ROUND_UP() is defined in a shared header file, it
depends on the PAGE_SIZE and PAGE_MASK macros, so it can only be
used in kernel code. Considering its name is not very clear and
its functionality is the same as PAGE_ALIGN(), replace its usages
with a direct call to PAGE_ALIGN() and remove it.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/shared/kern_util.h | 3 ---
 arch/um/kernel/mem.c               | 2 +-
 arch/um/kernel/um_arch.c           | 5 ++---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 00ca3e12fd9a..949a03c7861e 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -15,9 +15,6 @@ extern int uml_exitcode;
 
 extern int kmalloc_ok;
 
-#define UML_ROUND_UP(addr) \
-	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
-
 extern unsigned long alloc_stack(int order, int atomic);
 extern void free_stack(unsigned long stack, int order);
 
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 32e3b1972dc1..19d40b58eac4 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -71,7 +71,7 @@ void __init arch_mm_preinit(void)
 	/* Map in the area just after the brk now that kmalloc is about
 	 * to be turned on.
 	 */
-	brk_end = (unsigned long) UML_ROUND_UP(sbrk(0));
+	brk_end = PAGE_ALIGN((unsigned long) sbrk(0));
 	map_memory(brk_end, __pa(brk_end), uml_reserved - brk_end, 1, 1, 0);
 	memblock_free((void *)brk_end, uml_reserved - brk_end);
 	uml_reserved = brk_end;
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 4bba77a28454..fa11528ba617 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -351,12 +351,11 @@ int __init linux_main(int argc, char **argv, char **envp)
 	 * so they actually get what they asked for. This should
 	 * add zero for non-exec shield users
 	 */
-
-	diff = UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
+	diff = PAGE_ALIGN(brk_start) - PAGE_ALIGN((unsigned long) &_end);
 	if (diff > 1024 * 1024) {
 		os_info("Adding %ld bytes to physical memory to account for "
 			"exec-shield gap\n", diff);
-		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
+		physmem_size += diff;
 	}
 
 	uml_physmem = (unsigned long) __binary_start & PAGE_MASK;
-- 
2.34.1


