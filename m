Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE4E0C3ABD2
	for <linux-um@archiver.kernel.org>; Mon, 16 Sep 2024 05:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=; b=mOt61/HHp9+w8bxxDTK0tTxzi8
	h305V6KFpU+lCTW07m+ePkrgcjRlEJA4ntA2M49QrVfv6Regck8sx+7MxnUwXfacgkSbpQSokGzSx
	3xyEUfmFI3g82RCPEhe15fJcr2OQRgc0COLaJ2CMZpFrpNZIr7yEYS9/nFU5bbkIeXg1JI3lhKhNl
	CL8qbHiksWsbMpXUgO0lPFex/yYdmJoz0i619bmaHx1r8TrEgN9VsqoY62lrDtbeP7sXA9La+CoC8
	cXHPYMtptuAYVMsDjJYnB4YqidBNQC/EIzS4kdTq9kLxQDoRwNMCsY/AXB837awdngW5TqXMuyfq3
	KtaWeP0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qQ-000000035Sv-25VO;
	Mon, 16 Sep 2024 05:00:14 +0000
Received: from out0-193.mail.aliyun.com ([140.205.0.193])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sq3qL-000000035Q7-0sBn
	for linux-um@lists.infradead.org;
	Mon, 16 Sep 2024 05:00:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726462805; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=ICwDMhjJ7dbADtxlBSbI8KnsxD7naRbiR1HvDVegF5k=;
	b=ynWKEDUBCMpclAFcP1leXS2SCvQz47YGrhlk7T6e0e0cSmZPJ1wId60qaJO90PdSxCwcg2EgdLWN+AUdOKY/7Dg3b9KiLPYbgiwMBiSZzYtCfoF77Bx2k9LxjEfvObiXqGMBTLiOCDN1Hz42hbZB4HVL/2bfjN6zPYOQ6pikH8g=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKOkLRT_1726462802)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 13:00:04 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
   <benjamin@sipsolutions.net>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH v2 1/4] um: Remove the redundant declaration of high_physmem
Date: Mon, 16 Sep 2024 12:59:47 +0800
Message-Id: <20240916045950.508910-2-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916045950.508910-1-tiwei.btw@antgroup.com>
References: <20240916045950.508910-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240915_220009_801281_3C45499C 
X-CRM114-Status: UNSURE (   7.84  )
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

high_physmem has already been declared in as-layout.h, so there is
no need to declare it explicitly in the .c file again.

While at it, group the declarations of __real_malloc and __real_free
together to make the code slightly more readable.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/os-Linux/main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index f98ff79cdbf7..cf1179ed1aec 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -182,6 +182,7 @@ int __init main(int argc, char **argv, char **envp)
 }
 
 extern void *__real_malloc(int);
+extern void __real_free(void *);
 
 /* workaround for -Wmissing-prototypes warnings */
 void *__wrap_malloc(int size);
@@ -219,10 +220,6 @@ void *__wrap_calloc(int n, int size)
 	return ptr;
 }
 
-extern void __real_free(void *);
-
-extern unsigned long high_physmem;
-
 void __wrap_free(void *ptr)
 {
 	unsigned long addr = (unsigned long) ptr;
-- 
2.34.1


