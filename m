Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666F7C0218B
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=; b=dIck5Ssbbt5jdPS+n5ZBFwiDE0
	tnhST8ayxhuqndzlmrHK9Zv1J25EK445EIgNNPo2ghjhAgc3ABq0X8AZsslIM6pOBeBUZ8hMpciNT
	7794+NhqF66owpVpoFiGYc/sz2nujQZVwX3jsxtu8NsJeraxfxZ+x3JPK+c1A5AM3xMfIuhwCO3ZR
	W05IjKozYnvYUwh8r2kyYYG8g33II/dqgUCiUvZM3ke8o9yeznMXnUlMBxxL01SF3uESIEvd74iaL
	N7eR2QqUHwkcxne1XqDfo0QGfyEm5WF1t+IOmgBf7fL6rv8WsxxzT7WnCVNFTYEfLW4uYe+e9RphK
	6laJfZDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9d-00000008GMo-0CAH;
	Tue, 14 Jan 2025 11:32:17 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8h-00000008G7M-01Xn
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:20 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so6784259a91.1
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854278; x=1737459078; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=KCEp7lElbYgSMlrxF5n4S64yki6IyMZU/QbxdZuLOBW7OdBLcMUK7IBEypw/6gtJ27
         31jn+J6gTVSf2wGryVoljtTb+FlWI2u8iokJLI1q0JLSbVkC/2DqOngSrhZFYSW3kIMh
         MFonr3vE6/PdGzp/8h09tR5e/g9rebBD7UQzJAlrjNmcSpRlEqdSehTLuXoRP94lX7xT
         aQvSZuqjCL0Ewfc9JelCI5lflpcpGdt9XrQjlGEo7c1R3Y//urnPsy9l/FfV4vTVhDNE
         xucqGVNmsfF5bpMoOEWEW0F9vIP/PhE3m//28w3rsNgA00eD9EFs86f4ZGplFyZAjDLc
         0s0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854278; x=1737459078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxwQVsybhdKNONI5OZ03CW9Pb9uuYQgJfh4piPN+9Hg=;
        b=GDnTd23lvtmhOBV7vTlcbupZKy3AkKmYUxOqWdLKGOTc4nAif5QFh2dMYn2OJNMI89
         7I+kqnaq+nOUnDiHQ/NRwi9QFZjWTVzGKvVn3rWvy4JoAszBTAwLvNDQ0hgraU/n7OYu
         cq2FJ+7cuQ8iFQjcYyJD2czurb96fI83NMeT1hJG3ofx8XA0fRrjekOzzcmORU9LwMCS
         w/idc9Tgq9feZKNGQ9qkmn4aswFmSzQiMS53MkjbkaeoBU634mQgO16xe7EOj5813cL0
         M8afmvlILmPhoQcDMOMFGAqr2BvA8/oRJ6kbGOlWmGv9w9/T7jx5VJ2ZiTXyO6/0E/Re
         DDIQ==
X-Gm-Message-State: AOJu0YxpPrYwQR69wY/PryeRMir04tHzzVz/G8dbTp88B1zEemoUHwsK
	mb/Bxx0e8pWbsg7GMvk/biOO5gvWk86vQAwb+b8lMU+HeuLl54Cl
X-Gm-Gg: ASbGncswynxlrbyHkqQPNNik5XS+w5HMMdbzGxOghVBjSd+pKldV3Aw/jJq7LvZRMXj
	NK5taugcPWx05GZLq1j7QQ1hIeoHYcDkwI81ScbM2y6HqvVWsoL0rTtv6RjSkXxEUsofYwdN3Ld
	iOc/bR0cRiHHsYWnUHSUzsocIQeprSKtFKLFJ1mFmFsl4TXhYVJyiM6wz3YLka0+ikSeQcUzlHp
	Oyr1VjdihLa8VqOb98e6GpR/fPkPTS2bJkhQyLnZpkYbgkxbieOPnXnz8zquCqrKyuumqfSynjH
	YliaOwMjmJcPcbqzUVFK+VsTaWgl
X-Google-Smtp-Source: AGHT+IGc1A73sz6c14/djD5+VteXPN9bZBce7LJRjlmUoR7o5XY1TA6MYQIbr54kqzRLQXlKpUTrYA==
X-Received: by 2002:a17:90b:540b:b0:2f2:3efd:96da with SMTP id 98e67ed59e1d1-2f548f4ea9emr38862652a91.24.1736854278203;
        Tue, 14 Jan 2025 03:31:18 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a34d87esm12594967a91.40.2025.01.14.03.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:17 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 57BFEE1AB5E; Tue, 14 Jan 2025 20:31:15 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 09/13] x86/um/vdso: nommu: vdso memory update
Date: Tue, 14 Jan 2025 20:30:47 +0900
Message-ID: <bc1bba7bdb3fd89d8dd14aacd16eedb7a4933cc5.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033119_048637_E7090BB8 
X-CRM114-Status: GOOD (  13.71  )
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


