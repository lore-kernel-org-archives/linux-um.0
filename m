Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8E6EB3646
	for <linux-um@archiver.kernel.org>; Mon,  2 Mar 2026 23:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xIreYV0sMsRS3QpI/zsGkp6cixIiaG5GGyFCkMmBg9I=; b=d15NiS7R8q1iAC1+pxd5qOjtq8
	wb8MAYmGugIrRStU84cXxi2ey79N0ELprPopqYfdwShgajNg0+dSgHe1tMydBrP0HEdwV2PCgt3oN
	GiJ5eJ5Ygz0bDY/TZyERchwYgD7ojaBdMy/ZQO1I18xtSMJmUlH9s9nc3grF/pBxsZ3Pomtgr4egQ
	x1AHHMIOWmuPrE3BRsPEiErXuuOb8WgXKy23v2B+XiVDuhwh8IJSyOX9fpJ/vkYBSrQm5MfPSkeS6
	ojbU9SLnbyBEPbLrKHUwxUYmMFZt2eQi8aIoSyd2NJspCuE6g6UVCDzAFVcbZNoWZ27m4JN1jCdrl
	DdxP2J6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4V-0000000EERC-2ziM;
	Mon, 02 Mar 2026 23:53:07 +0000
Received: from out28-73.mail.aliyun.com ([115.124.28.73])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxD4R-0000000EEPD-1YA4
	for linux-um@lists.infradead.org;
	Mon, 02 Mar 2026 23:53:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1772495576; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xIreYV0sMsRS3QpI/zsGkp6cixIiaG5GGyFCkMmBg9I=;
	b=fF74JqlbS2XsGTv/MonUZyvOcc0H16sjn6hvTDPTczJsaSPVtdK+BNxTb8N7AgPL8m/p7+8MOjrgcv9Fd8ykdSvWPX/WM8vEbXODJL7b8vAqT8d1RKDlutJTVrNznDkWEXe8pECJKwympIedLY61Y1MjK66/DYrhmnHruK5l2q8=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.gj968mS_1772495573 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 07:52:53 +0800
From: Tiwei Bie <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	Tiwei Bie <tiwei.btw@antgroup.com>
Subject: [PATCH 2/2] um: Fix pte_read() and pte_exec() for kernel mappings
Date: Tue,  3 Mar 2026 07:52:24 +0800
Message-Id: <20260302235224.1915380-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260302235224.1915380-1-tiwei.btw@antgroup.com>
References: <20260302235224.1915380-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_155303_916871_F6B98116 
X-CRM114-Status: GOOD (  11.02  )
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

The pte_read() and pte_exec() helpers are only used during the TLB
sync to determine the read/exec permissions for mmap. However, for
kernel mappings, they will always return 0. This leads to kern_map()
having to unconditionally set the exec flag to 1 and the read flag
unexpectedly always being 0. Remove the unnecessary check for the
_PAGE_USER bit in these helpers to ensure that the kernel mapping
permissions can be correctly determined.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/include/asm/pgtable.h | 9 ++++-----
 arch/um/kernel/tlb.c          | 3 +--
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 3b42b0f45bf6..e156ef6f4fdb 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -121,13 +121,12 @@ static inline int pte_none(pte_t pte)
  */
 static inline int pte_read(pte_t pte)
 {
-	return((pte_get_bits(pte, _PAGE_USER)) &&
-	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
+	return !pte_get_bits(pte, _PAGE_PROTNONE);
 }
 
-static inline int pte_exec(pte_t pte){
-	return((pte_get_bits(pte, _PAGE_USER)) &&
-	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
+static inline int pte_exec(pte_t pte)
+{
+	return !pte_get_bits(pte, _PAGE_PROTNONE);
 }
 
 static inline int pte_write(pte_t pte)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 5386ab2d0da5..1f175716b474 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -29,10 +29,9 @@ static int kern_map(struct mm_id *mm_idp,
 		    unsigned long virt, unsigned long len, int prot,
 		    int phys_fd, unsigned long long offset)
 {
-	/* TODO: Why is executable needed to be always set in the kernel? */
 	return os_map_memory((void *)virt, phys_fd, offset, len,
 			     prot & UM_PROT_READ, prot & UM_PROT_WRITE,
-			     1);
+			     prot & UM_PROT_EXEC);
 }
 
 static int kern_unmap(struct mm_id *mm_idp,
-- 
2.34.1


