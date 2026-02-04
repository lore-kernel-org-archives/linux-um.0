Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC9E8B383
	for <linux-um@archiver.kernel.org>; Wed,  4 Feb 2026 02:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=; b=ce7iDNlIrJWnVS+/glzCQTCldD
	LauRZv0CO3S6ekSSXdCttBPMN1xcdOaQ+M5jV6O+nkyloMUx2IsMPr69ZIH0gq7x9plG3JBJO3OI+
	G0vuljccMonoljgISYMAjLrNEHAK7a46kknV0f1kRvsKor03xoCw3AMeGGvMJaM0JsZWQaUeDU2aj
	GS5ZcJY7r/2Pi7k3r15GUOTJZbXynvd6r5oa/JuNUdxiTebijkEWIl+q6J6Iw71vYsGJofcpmvAHw
	i8i599f1jj0I0DpDyN1J7cfbaP3pPqT/+Yftmk/G9lbz2bDfyw7jSYgP2sNAx0fo5gaNbXvWDgNh+
	RYfG1rCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd9-00000007mDB-000N;
	Wed, 04 Feb 2026 02:28:35 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnSd5-00000007m9w-0PWA
	for linux-um@lists.infradead.org;
	Wed, 04 Feb 2026 02:28:33 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-823075fed75so220979b3a.1
        for <linux-um@lists.infradead.org>; Tue, 03 Feb 2026 18:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770172110; x=1770776910; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=PGGRnkaHAWJq3mYyM5NywGWe2yQXi5GXW0VlBR8ktAsASR2I1N4kp1HjEnXHc+/wG1
         RM0SBPEcvUyPkp9k5ywXZVx506mSyQ1Nt4kV8hn4bWrgK8CcB6S715FWKCuUYoMYO2lk
         IoSY5xTxxlmLFQKd5yzFlsOVT34eJ75qVe3OBgc2bp70rh9fR1bEC4HbECzSrqG7mulf
         W/xQ8mE/ipyMMBz6P9hI8dtqt40fmZQXbA92b0VlAUTmlZNBpsAmotGufBm2/Stjzk1E
         JHdqX/cfTtk+NnId7amwCOW5IFt8vaZ2QjYB0BR6DPTpAeHUunOwMlu7S2GgdbS6i1YN
         miAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770172110; x=1770776910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=iK8zEYyk6ufvbWFuFDH7UIpMx1u8atI8PKkupwrhiz8VZvYKj+9lxK27iU5BptTH1c
         pVBuF0fYsOTKMhLuvHfiVWSvTSC+RQFQ1Z/gG1nqLzoZS9tfsYMq6FxAF8WMbLO9cDTB
         gbANSC4g6ZRTjTx/ppkmEREniK0VT0qYt6zyuoNA+O0VR61YzYXSVrmlCVa3BBhh4b8k
         XZMWulpyBm7OYJW0A0QuTNjsQDfByumElZXkf8TFUDlmsdZujna4gPqurH2Z/JZDrCC0
         AT12SQYIQJhu/uQUKjL/495X6D/HuoHVTTX9iIl9bwGVNlTiwFxqzY8nk2SrGRlk2tqK
         Tm3A==
X-Gm-Message-State: AOJu0YzE2ejWwK0awZfTGzpAYger6Anr2G4UBbLqQkB3DZo5zAiFkyQ8
	sApV8a5K04kLdWkJcBszx6BTO2hB9MC87eYq3jTu2G1K1wbQ50ELmfgy
X-Gm-Gg: AZuq6aJfOm9CntlBVs586rm97un5v9Hw8YwrVDjIFP1skQKzLGoaXCcIU3UmpcirKOi
	/BR5hCOGl/Gb5tN85I6yMbyVwE7MHGSiduu6r+tspcd4FGkTt6tmd0mww4MqHJ6+TsI5ULTVrnH
	eiFlLladdFX9R34Ud/DXmusGEoYPRXQivjFLNG7FVHIYUjuCy3u0HqdN630P1mMHec7zWBRrof5
	sJ6PE9Ip2ZGmob655HM5P9Ju3kU0Lz/6RXnP1u2IlN1WJbpeNTxhSjzzJrHtc3z51L4Ie2/Knfn
	D5bt5uTiYy631fVXixi8E+fKZbkLeoyDN9bGUaCPbI/5Y+mz3FKBGyp2CPa12nxMOpiR8bc9XxN
	bRL0euGvSd0remq6NuFjysf0wgXI6Pw6bxwkozVYI+0dBk6SZ5IEbD5auji++QSDOjwD4VhPQGM
	+39QxF7vDErkwMfVxtY71LIyygbhki97uXKlVoR+Yr44PVuiHKuAmkq01AyN8WgDgnEbmljM+7V
	AWEjHdQvyzDRnlG
X-Received: by 2002:a05:6a00:1d9c:b0:81f:32cc:b1fc with SMTP id d2e1a72fcca58-82404255f03mr4635844b3a.3.1770172110336;
        Tue, 03 Feb 2026 18:28:30 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6c8321cb78sm565404a12.8.2026.02.03.18.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 18:28:29 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id BC0351200C3F; Wed,  4 Feb 2026 11:28:26 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v14 08/13] x86/um/vdso: nommu: vdso memory update
Date: Wed,  4 Feb 2026 11:28:06 +0900
Message-ID: <1779dfb80f0e6fc25c001062a1e00cb661531c23.1770170302.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770170302.git.thehajime@gmail.com>
References: <cover.1770170302.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_182831_138969_6146A52F 
X-CRM114-Status: GOOD (  14.16  )
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
index 51a2b9f2eca9..0799b3fe7521 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 unsigned long um_vdso_addr;
 static struct page *um_vdso;
@@ -20,18 +21,29 @@ static int __init init_vdso(void)
 {
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	um_vdso = alloc_page(GFP_KERNEL);
 	if (!um_vdso)
 		panic("Cannot allocate vdso\n");
 
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
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -53,3 +65,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


