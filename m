Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A297CCFA02
	for <linux-um@archiver.kernel.org>; Sun,  2 Nov 2025 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=; b=gKDQ8IVoXSZHQzdAPw3GXRql8F
	uAVQ5D1qwQc+skmOWUAmxE/X+L2AcApVFZNZEv7OWJnWjonpZMNMKslb0vZfejsdPMpk8HBj6GVTK
	MGd9VZnNNio6GF4yK/m7Y4SBofQ2TmDSAW5AY2ipPlq0RHdUK1yA1RidcTqN73QP9HncDrgsLBlJ9
	viaK/k1y92GveL45q9SInAtBPVDeCQQKrif6NKrdsEZMJA15hjJ4rKgAZE10gncBxMZFGVu3/bk1d
	lJWYb78O5uqvz2WSJoKhfALALSiHYG1gFgGsWfPMlb+kiT5x4CnOlWiRwPmfIXCqxEgWmLE8Lqcsh
	W3jD185g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUir-00000008RxQ-0O2s;
	Sun, 02 Nov 2025 09:50:05 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFUin-00000008Rsx-2Js5
	for linux-um@lists.infradead.org;
	Sun, 02 Nov 2025 09:50:03 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-29470bc80ceso38735195ad.1
        for <linux-um@lists.infradead.org>; Sun, 02 Nov 2025 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077001; x=1762681801; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=E4r/z8lWEyKJ5S4knfN71gS9Qn8RSRe1QcH9RtHPEor+zwJPNpR0KIDBfbFdvlrqFt
         phU4j6cJBxZcdz4D3TmU2iFHLMhPAOHQyz/B9qghWVJqOIY9HD7MiYpqzHIYKAdrDZ8v
         QIdO7g2ja9BhYPVqd51WDaym4lgIfgf7bwv/RPCBTuKpZb5XA/oRX/Uqay2rM8RFbfDk
         vC6BWrvw3UclTgdPBJohdyffvHCKRAEXbYEeSRo6zTULtZT2z+DrPVUzS3736ODb7+s4
         C6TS3eXfemiS2hJvVpRWee9CY8dDUzD0YgJi6c/CDAjNFrrO5dUJO5c+auaEQLH77yKC
         ueiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077001; x=1762681801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KXlvIxBTzUi2fvQwFF5f1ABJZvc5EYR8EZzXkNvyLME=;
        b=kxKECQW4gkSk71CTiKE5h7gb5t2Wg5cYSktYYvmpRZ7XnQFpa3krKqIx2ZNgADjAEz
         pQgYSCWEthogs2m64oIP6WEavZ8dCA3E2f40kHiOFs3hnogCmDfj5CVlq9Nz+TvDqyRb
         eJhEHFPAgG+K8Cy8BrZ/Ayqye2FBfc2uBaXWLSRTqja0O50b8OwC2RDGoC1mrK7v6Z/Z
         uCD4OAwlevnYoy9p1hMr4dfLQefPKkftctbdQ+zKqVGQ4LwqGo4EDft4AkI+ykVNhtmM
         53+8G0ze1lRaimjjvXD3FRF4QenSZIPnuW3rAgcEpqtWcjYQGTOP3KZUhngowmE8znTE
         xftQ==
X-Gm-Message-State: AOJu0Yxh96oibM94R8vbwGfhH6z2SArN9Nm2F/JtuGFDd24+cP22EZA2
	fRru/xA5JFiWHfD/QexXjULPEC/z/ctPG0tAH1Q1icSU78R4nM2JfRjPFheDWw==
X-Gm-Gg: ASbGncvNcpugORbHeMi0MVNfULDtNC99MXRiwZZ78aROAEjUxjNBKiwIMRxTokU1P/0
	B8/euBn/vr6ofReq+s3kY8QWcKRgJMG6aKUNliOHK7CfC6vlfbc/j/OUEru3jGdahPTkxQEYc6h
	zMQ+OFY/iIT9Tnbu03k8D69d9fwr1YDn/QdWyeKWWIsFy8baThlkAZuyNfhXEbfq1bB/vV6lkq0
	lsB4CoAT5/hqgzscZIwojixjQaa3i++tutdp41Ove/glwHGB513wWGzNilVv7jFy7qcdTjw9KE7
	8knAnGpfeQ1LNwjMOn4UQ09l2szY7aSF83v4vR1ULLeV2Wa/RGT9ycMy3kQYwlc+Qx0tIHrXrBe
	GhBzuNwnE4sAenUEWtDrDoGDPNdrfkmXTIraQvwQ+yqNuvSTgSE3xSGviZWSvtcslNHAY9cIBAj
	q2bB5QCN2zUUCX7N6rwD+0dSFAFamZMsXMqiR6tffGxSR2LQ==
X-Google-Smtp-Source: AGHT+IF6VpzjPS9k/xuod2eADBDKoo5bQTtUF+qS4DJNZKzsKjProRzGMXg47Us7ItLnPnxUlti0ag==
X-Received: by 2002:a17:902:d505:b0:290:b10f:9aec with SMTP id d9443c01a7336-294ed2c61c2mr141344925ad.26.1762077000826;
        Sun, 02 Nov 2025 01:50:00 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd6f4sm79732315ad.101.2025.11.02.01.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:49:56 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B530F112380D; Sun,  2 Nov 2025 18:49:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 08/13] x86/um/vdso: nommu: vdso memory update
Date: Sun,  2 Nov 2025 18:49:33 +0900
Message-ID: <8036933c8c46dbf1ec32b8b57ecebc94c2cdb2ca.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_015002_237637_98448C9F 
X-CRM114-Status: GOOD (  13.97  )
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


