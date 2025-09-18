Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA1DCAC597
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=; b=dKiGF3D1uo2uR8Ll8cwgEapFHr
	N/PDEpCfAZp6MjzDPiBF2Y8UAwSCVU20/XAx2zOPD+3X7QvMlq6bDkLPw1jHe/AKxBQA7dzXyhnmx
	Ega5UYrig0O+mhsEy4OlZFd3EI+g5G3XuQ9Klt2jppLumsf/bWRL9H+009gTUIJmsDM22mv2Z0YKI
	dzf4AbzALEBlOzkM719OXhptNoNfT+weGUr1YUTuGppwsijPEqYDFLzprPzB3xevbQ5NzkMFtsslF
	khWblhw+mjWJ8XLzp2FAXbgSq9ixdAZfj1UcKSfQCu/Vw58zRmTuyaAISzM6F92OhAc4Nnl5AH4J6
	KO9LXHoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70l-0000000GILF-258A;
	Thu, 18 Sep 2025 05:16:51 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70f-0000000GIFI-3qBR
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:49 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2445824dc27so5311465ad.3
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172605; x=1758777405; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=afUH62lphjfQTwRY1ZsQvbte8WCz/ik3CH0DQQ6NdSkp1P82OTmZ+YAg4lfLFoXfE/
         YQ9FftdQv2nTzK78mcl0j/wzK9LPbi9RU0fGhpGUfETcny7xetZGdo2RlcC8w+pGtXPD
         snFUrS7j9mMXo3xNtL/7onQsYpp1IBUJkSCh/VStxyH72bvApvVDmAf1cZfc51bvESiv
         Hie+qCCwx7lKx6TJwYVXi+s+Ea4b9MTXt3/OO7HARZEzZCZLtV2SrnuK0ATRixl5d1Ok
         BgXXFA4Iida04J4GMUvOzxab5s71h8yoZFpVFyO9JSiSg97uFWxxf0Xu/xEO2bUZ8pEz
         ATeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172605; x=1758777405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0G7VVQnGQtrb3sGnx5GNm2Y3zP47y1QHGJfHFp/BsUc=;
        b=Z/LFtlQTUMf7GR92rJ45G6DNjChoLPc+3qaJ7O8D1uc6u2sHu/bDbNdnP0iXk4X8T0
         3rDfssSUi6hoJynIrAHDcsa/p6esPvvFHWpUCyTFJQFdi4s+7KmlhxFwxzNHrY20OfXZ
         KjEpWWIS1dVJuTiIlaXINMdACpllYe7IlpGqT60xJentGFnRV2PWQ0VUyzXlRlVuWt+C
         uMekOfdSBlXuLoGLsozlBJQVnBVj0bA7ch7vRuGZWQgqltOPGZoTFple6iLvXZDopJEm
         zMuj7L4UwN7WyNCg7V81N8vJtXtgYq0Q8eMds0PXLnUfgh+q3uFmnwO1koHDpn/YcyaF
         68rw==
X-Gm-Message-State: AOJu0YwKFdB1QD/VqscstUo5GmQvkP28pcDcMEVxiRLZoTF2dEhuOLPE
	T8mfGcu/8YKmFmuSGobGSgXGpH3zJpgvGGsMWY0El4Sk5tfcnuYtZp/r
X-Gm-Gg: ASbGnctf4pgg8fD+3elJIWmJu0zuh2rqSYUw/GjqSDdZa+Qv/oqWshOZNOMBYX0ntnr
	7iq2s+JIRMoyMAvcm3BfVzlhDSp3b3ST1KWqyDzgDoJidH/e3ZiIDMN2zvMHSLUUcb/juc+474x
	IUYQ5peCxrmCD/upH1vr/Ej22egzhX0kMRG2VyOA+I9fwDX9kB7G0g1SrbrRlFW2+7JrfOZdvCk
	p/Z6qzXzleMHPw1bcQBkTtYGnAPqXNwBmXemJi6mBxJQyqUDIumL+2h3nf+Lly1080Sz2yIftjm
	cx+azjsr4o7Mc1dSZw2VYRYelsHyyup20AWBWMmuL8CjpMPo/OpCpy41YEPOC9K9H9KZyeXlNAo
	891eGB5u2mFYyj8YlQHJz4CJiX+1j54SfVj5kDcercf3HngfhrZuGvjltAEu4D+pmLq8PjiCvBw
	TdPVJyXMN6J/k=
X-Google-Smtp-Source: AGHT+IENUWJEnq6oE7Ax3BDTY7kWNNijSyVEXEQa7OevR8qtv4uLVgHLKbgA4U1otQAK7eBXyC8eSg==
X-Received: by 2002:a17:903:298b:b0:263:7b6e:8da0 with SMTP id d9443c01a7336-2681216b6d7mr52232155ad.15.1758172604780;
        Wed, 17 Sep 2025 22:16:44 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980329745sm12581375ad.121.2025.09.17.22.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:44 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id DC5101061EF2; Thu, 18 Sep 2025 14:16:43 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 09/14] x86/um/vdso: nommu: vdso memory update
Date: Thu, 18 Sep 2025 14:16:02 +0900
Message-ID: <973b16819b91b5640029311ee8385059e3b41e71.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221645_980484_2268D00E 
X-CRM114-Status: GOOD (  14.50  )
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

On !MMU mode, the address of vdso is accessible from userspace.  This
commit implements the entry point by pointing a block of page address.

This commit also add memory permission configuration of vdso page to be
executable.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Ricardo Koller <ricarkol@google.com>
---
 arch/x86/um/vdso/vma.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index dc8dfb2abd80..1c8c39f87681 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -21,14 +22,24 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		goto oom;
 
 	copy_page(page_address(um_vdso), vdso_start);
 
+#ifdef CONFIG_MMU
+	um_vdso_addr = task_size - PAGE_SIZE;
+#else
+	/* this is fine with NOMMU as everything is accessible */
+	um_vdso_addr = (unsigned long)page_address(um_vdso);
+	os_protect_memory((void *)um_vdso_addr, vdso_end - vdso_start, 1, 0, 1);
+#endif
+
+	pr_info("vdso_start=%lx um_vdso_addr=%lx pg_um_vdso=%lx",
+	       (unsigned long)vdso_start, um_vdso_addr,
+	       (unsigned long)page_address(um_vdso));
+
 	return 0;
 
 oom:
@@ -39,6 +50,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -63,3 +75,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


