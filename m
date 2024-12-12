Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0123E77188
	for <linux-um@archiver.kernel.org>; Thu, 12 Dec 2024 10:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=; b=IqRR+/O9/u1G9zwrTEmnEYmB4n
	Y1TpNEQWMpMpwUhrdG6F0FaqIsIjcVEeC6haptz61IGAF6RWWyRJjHLPhPx2m/IwZxB2YJxnoTqI3
	P3XVnV1pAHgBWUN65UjU12kx4R0bDhb+x073pM6YJHnDv7iwskdYgLSWJZqN1u1znaKlGpVkz4Dw5
	Svr2U4LtZU2/dUFkZjae3pZXIeAyX+ATCQLCcGCBdWQtiKXBXozDMD7wDUY0YEdzBG5mfUSUDDWaH
	J/Ic+E9iuhAku/P7NyeOvpOtK97a7Sc4xG0U1A74YgAhdzfzcCLQyUInsGC6cDzCS1cZYjUy6Sl9T
	Hm8IuHTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDg-000000001TQ-1Okq;
	Thu, 12 Dec 2024 10:14:56 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLgDN-000000001Li-0s5F
	for linux-um@lists.infradead.org;
	Thu, 12 Dec 2024 10:14:38 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21644e6140cso3667885ad.1
        for <linux-um@lists.infradead.org>; Thu, 12 Dec 2024 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733998476; x=1734603276; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=QTcZf6yBBrMRS1tY8MUoyyNWs8Yh7Io6H23HF0pjECdli9sVJffMi+s3hAFYd1P0qt
         41q6dWTVIbx1GY+aG4zzioTwBxIgppjwVZh7aRP6Fr/kBpakjdI3soMnNIXeFztLEhOm
         g98MOXTf3LJ7NddcTQ1pdHtGhDlfdtSn4zaYKG4U5qNFrDEyrJ1dBjyY2Rn6L2t0qUlv
         ddEzcnWZ9HTXGPRRrYFU9Bd801LKmk9omc4BthFwoPU4EeA2XcNQnJ9LtZiXVbbq5X3H
         YCI1G61pr5zdsAoxwqBRwom2R++Zmklkb9XV3gSBxIFhNvaEmhYdsLy7UQ85kiYXorbo
         WonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733998476; x=1734603276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=F//8Rsd0u2sX2xjkxts/WsteffMur1B6KKwHc9dtHekVBBJefDpRznkW63vu0+gnzi
         q2pj4mgr3/a8KEdu0vXxP2J+hvAIp61THU0jPbRLd0azttZM+2ZJd9MzM5JY+w+sDJcN
         1gpuDKuRBcXsJkQqhLiOne8qFEQtUQ+5agptT/0y3RRF8ijIJsuSjZoQGZ26QFHeBPcv
         oZ4EsD7yfKNgLWkqWXuu7fqEaj5+VZpB7ZRGtZpkHofuoBa1t6ZCOpwoBTsN/FJuPIqO
         /Lna1AcjEOikhbtYQfSZW5l3mWQjydhARYrOHX3v4Ifvg38qVzjGy0EmwLK+JZcflBuW
         kVlQ==
X-Gm-Message-State: AOJu0Yyfl3v2iQfwpY9gtZU+rhNzAl+ecgwKhK458p8XhvV9SK7PWP0s
	oc/rB2N9WL1my7GUUK3nyg6wK41p+u40QqWqqKUYRKNqd/ZybbxZ
X-Gm-Gg: ASbGncvVOUqNAolzRaZhRouHZYnCPIE4QWWC8R7SeSvEtPWzcjN8rdVHhb3CLOgIiwx
	yazTQ1/iVOUeNdMTUf304njUl40xb0nm+0edW03cFOhH4VFxQjZL1iKV7lyylkGOtFaHZ7zCvT8
	e3dVRXVsqKHw+S1vVcn4vCMXzMrUgoO3IpW0tv/fiTg8YlCmmL0Lkwm8VN/Poy/RVHhibMq3yI+
	MMJMVYx2pjHrZe6BLnZm6o0O2JsUg4RlVGOsb4JfHOvn4SA9qhZvud16sfgopaweFQlyA3Wfd39
	bnXh/1fVtncMbyds+/xjDdJdsTQ=
X-Google-Smtp-Source: AGHT+IFhtSH5iaIlalHR1QbCWtIROi0WU21qdvit9vpcAyQTXuYpwgxrlJ9oIcn9QBDxL801jJvnsw==
X-Received: by 2002:a17:902:e746:b0:216:3dc0:c8ab with SMTP id d9443c01a7336-2177852030amr97329665ad.9.1733998476132;
        Thu, 12 Dec 2024 02:14:36 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd55a9a5edsm4872964a12.55.2024.12.12.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 02:14:35 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 37D93DDEECE; Thu, 12 Dec 2024 19:14:34 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v5 09/13] x86/um/vdso: nommu: vdso memory update
Date: Thu, 12 Dec 2024 19:12:16 +0900
Message-ID: <69532135f8382a4d489a5f2f1e9c6ad209ee1a87.1733998168.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733998168.git.thehajime@gmail.com>
References: <cover.1733998168.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_021437_245159_6F421B95 
X-CRM114-Status: GOOD (  13.28  )
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
index f238f7b33cdd..2dc38cd77f23 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -9,6 +9,7 @@
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
+#include <os.h>
 
 static unsigned int __read_mostly vdso_enabled = 1;
 unsigned long um_vdso_addr;
@@ -24,8 +25,6 @@ static int __init init_vdso(void)
 
 	BUG_ON(vdso_end - vdso_start > PAGE_SIZE);
 
-	um_vdso_addr = task_size - PAGE_SIZE;
-
 	vdsop = kmalloc(sizeof(struct page *), GFP_KERNEL);
 	if (!vdsop)
 		goto oom;
@@ -40,6 +39,18 @@ static int __init init_vdso(void)
 	copy_page(page_address(um_vdso), vdso_start);
 	*vdsop = um_vdso;
 
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
@@ -50,6 +61,7 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
 
+#ifdef CONFIG_MMU
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
@@ -74,3 +86,4 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	return IS_ERR(vma) ? PTR_ERR(vma) : 0;
 }
+#endif
-- 
2.43.0


