Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B38C02183
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=; b=CyC61JesbSYY2Ibh3A+YBBJOru
	Z3ihvGHOjmlvN2azblF844IKu8+WrFggolRFPAQbHI8aljYK+NVcqhtXhXKWYJG5t47VFWrkF40lR
	3vN7Si/f91D3Av/c515RH+sc482fT/jxhLOV2kA3Ks+nKd3ympdalIrEY2V4Lss8iSwWE+5YHOZ6f
	va4EbpB8IC5tANEf4Cse7n8tGKHiOI8l06e5r+spREcmIqEe0gzj6/nHdWVoDcrIM01iTmgGgaVgo
	sX7nm3nblp3FxhqZv7gyUxoHJ53sEPsRtMnM1wdtqliKMahb8IPynDVmP7Lqwpx1ogttuLKddNEuT
	6OiskOSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf9a-00000008GJ6-0Rw0;
	Tue, 14 Jan 2025 11:32:14 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXf8Q-00000008G1G-3fcu
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 11:31:04 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2163b0c09afso97027325ad.0
        for <linux-um@lists.infradead.org>; Tue, 14 Jan 2025 03:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736854262; x=1737459062; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=nC6DH+T/dS0fvsZeuX2mBldo8IAtxhPyAaicvHZcVsg0EcxkDJCb/hLQIYAO1DwzQ1
         sRuta8DAmOpXXCqL9g/VF6iFaRZTAzoUPX8JkVulp/+wfuQS1x4TW3/KX1PbjlK50RKb
         aaThOnNPCDeLGcvvnFYMUkQ+uxjKV7TtcZXsOU4KCTZ5AUofmNQao0tSUVKelf+9G5N2
         kqHIcnoXzwmyX3hIAHcpyvsUG754jNufUq8P9t1TKJ11/NqmqKawcnvQOHs9lQ989v8Y
         rT/nljGL8WmriMMUARvYZD6LWkkT4udxRIB9bFAjRLCKFhmRFWyeQaJRLM/Xf3JWtf4n
         Z2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736854262; x=1737459062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=IlJnWPKIU/ykqyn8iPtMjBQkFZysxWYpE025KZ1FXzCi1BMWkK73Asb8eLj8cXYtkx
         6BIgzAJ0pCkIS4SpKvJfmROVqaPCiyUd0pw8IPFRAGkX6P7KrsnvtTM/ZyaOvFiPoyT9
         8hLDyZsDEKyI/XdAgDO+2wTfc6yIiA8OriSO1SBQGyhUrINwdz+BWOTlAactZ5PDciw+
         dMyRl8IeeJMTKxyRrPsef/e0f2nw88xo9IzSdAdPxuxGM7Bj7VoOt5+qBjHJAZzTOPO8
         moeUa0LJ0jV2hllXPtwUz6rCdgdRbVgBsJTWhzGEFEE8tQ/Bwv27XLQyNMcwmSDXrUT1
         lUkw==
X-Gm-Message-State: AOJu0YxtglG5NkqCoRP33Zt4wi/gysH33uNl3JwRbTUWrPVLKx8sonKW
	4oTH0NPsE0khLMg2XpmSyTzbhFYeTAyKhqVLSWgKidu6iYq0gV0W
X-Gm-Gg: ASbGnctktHP9l0YH8k6Sw9Dfwg+GVpSgalZHe7rZ6wplHKzKIyZPTicxyxZ/bGGU9DK
	vXvasDDUE4SHtDWth1ee+g3vYuTjgpC9o2nshIJTIgOrISm1J+Exk32nztjlF42XB3tmV9ZdgMC
	6dpEDpaRv4Y5cKitoA5yOHpgh9MEw6gJrIzK1Oirg5vCmgvfPUYdeulaS90Lq/87lz1P3uMq8tp
	D52U/QWsUZamUoIuaw1riuzim+awbTBy2cJJ86jGIJzv5oRs5Nj46IsmaL/Sz0Cwa+dmjOpgKLc
	FCmpEatGI3NUOgJTKRDB5EwSpgCK
X-Google-Smtp-Source: AGHT+IGXnPXUgjJlh0MYremwfJy6xH6bFlnytH9bj/gAX+3RKKaTQVPdMfHtdh9wvc2EvbF19aSUtQ==
X-Received: by 2002:a05:6a00:4603:b0:728:e745:23cd with SMTP id d2e1a72fcca58-72d21f113a1mr37843067b3a.3.1736854261808;
        Tue, 14 Jan 2025 03:31:01 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d405489e2sm7239338b3a.32.2025.01.14.03.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 03:31:01 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id B06C9E1AB4E; Tue, 14 Jan 2025 20:30:58 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v6 01/13] x86/um: clean up elf specific definitions
Date: Tue, 14 Jan 2025 20:30:39 +0900
Message-ID: <2d70a0ed79ee0a0bef80ad4790063f4833dd9bed.1736853926.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1736853925.git.thehajime@gmail.com>
References: <cover.1736853925.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_033102_928314_C2F47892 
X-CRM114-Status: GOOD (  10.03  )
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

The file arch/x86/um/asm/module.h is equivalent to the definition of
asm-generic.  Thus this commit cleans up to use it.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/Kbuild |  1 +
 arch/x86/um/asm/module.h   | 24 ------------------------
 2 files changed, 1 insertion(+), 24 deletions(-)
 delete mode 100644 arch/x86/um/asm/module.h

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 428f2c5158c2..04ab3b653a48 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
+generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
diff --git a/arch/x86/um/asm/module.h b/arch/x86/um/asm/module.h
deleted file mode 100644
index a3b061d66082..000000000000
--- a/arch/x86/um/asm/module.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_MODULE_H
-#define __UM_MODULE_H
-
-/* UML is simple */
-struct mod_arch_specific
-{
-};
-
-#ifdef CONFIG_X86_32
-
-#define Elf_Shdr Elf32_Shdr
-#define Elf_Sym Elf32_Sym
-#define Elf_Ehdr Elf32_Ehdr
-
-#else
-
-#define Elf_Shdr Elf64_Shdr
-#define Elf_Sym Elf64_Sym
-#define Elf_Ehdr Elf64_Ehdr
-
-#endif
-
-#endif
-- 
2.43.0


