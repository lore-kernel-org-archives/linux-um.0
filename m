Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04CA0E77180
	for <linux-um@archiver.kernel.org>; Sun,  8 Dec 2024 10:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=; b=cSDGqD4uKziYzqtf/covdz7Wbh
	fReNtO+UjG3VtMUaHeP/iH4sIUWWsFP6o49zq5PULdIumU9okvSgPEadeSxwJfTCfckvQKP07/fzy
	S3bFLsc9RE116bsWS0VwdmejQSFk5gp0RYV+HNcycRkySFOCrQdtN30RZAAvipaES8cSoexvTIU5b
	+7OnvMFwLj9UrDOmjsNdD9/c6Fzpalgsqp7imOfRhmkIYc3/2JHjHsCr8t8ceYNEDM3xyBH1s2M5D
	5w1bwkDj0YH3M/FmtXHnkGuKCk1YHwoDDvG9Wkd6cxcF5VGxwaf8dpRo3NxMsHmISZt8Bd1WxCoCt
	DNqhRT7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKR-000000057R2-2ajQ;
	Sun, 08 Dec 2024 10:15:55 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKEKO-000000057QB-3zIH
	for linux-um@lists.infradead.org;
	Sun, 08 Dec 2024 10:15:54 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-215770613dbso22016435ad.2
        for <linux-um@lists.infradead.org>; Sun, 08 Dec 2024 02:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733652952; x=1734257752; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=JlNe+jpdCgs/4+yEI6+u3sbxMmFJbvHB/SsWNjwkffTmJCTY3pabx+dBLRQiSKvfGZ
         Kdi7SAJjAKw+Eesy23sMt2QRNuYfUlPcey7CjQ5r7mPyjkUAXnLsMSrsa2BvM0Ke4rsh
         UO/vcouFJyeD4k23L5jrE//sgrPdghhfcT0M1OeGBSExZ1SG/S9tPoCU6v0YMDV4Unkb
         LTV0qgEj4IfMy8KwIq3+jHOjyNfug/njIrVQFR23s6Zh3MCjGwb9AZqJLpuZFSBDTI3d
         iNna2GROEI+FNDlbY4WpeykhewHR7FVizUwcnvhcZrkr5Rrdkj3u7Kml4v4VB2p78b1c
         OfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733652952; x=1734257752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=OkAEm164Ym6lZGws3TpseAuhbzH7VXu1j+tvuEeYa2oBvh4H4m7ZogaRBWqJNt/710
         cIbASs0/o8lv+x563rqN0JAkLK+JG0GF0V0awRUy3EccgiYL5QHzXmEC1R1iI2ZHTCyD
         9lw5w572yCebubEGa4DFblK5QXCtbOm2LNEqtrlUGx2LakmRsYqxgxer2cxgacau9oVM
         rGa5fzu3GVPhD/yUCJuy0EMB6fPVPnytooXIEJL36OMl19ZWUziRIo/0BqG5A6U1RPzp
         uOqRyNt5DYr5/U+2GGSWbNqlv4KH+A9+60jbNxWJw10e0IWbKzUBjgz/Ukktg2FtjkCU
         sbWA==
X-Gm-Message-State: AOJu0YwZfC+RY1G7+XXja2U1GTVPk7fuNPUa58VrHpV9OCPbLdtt7ik3
	2+D53a4qwmFeMjzuMnfoyUB3+pIJDVWZXbObYj5avYXwCai53pCL
X-Gm-Gg: ASbGncv/1o5jmZCgZnq1xKV1NADHIrggrpW3SLqIi4cDsvT567nlJDbTLT7cGxaPPDy
	6Lsehbuw6ZLvW27IUYuodCkD/SlLoWNVEhoPaa694NSiWzAU5JCUskIjaMT5ZyU1llb7CemPYT8
	fzVmjlyfnsipUSIOGVL4Ca08rOvcnpNZgccnALrdpHquRCKzlb5O4tlYaatIrYOM0xU/8MGwHkQ
	m1tuPttert4K0Y9J0IKYUUeaNKEWS+RNhw4J4Rv1OicJwHqBhNq0UACVbpitVy5GBGrRA6TRz2y
	SGU1P6sjmIUqwNwy25lJ
X-Google-Smtp-Source: AGHT+IHPgzpaRYoV8uL+qhcSXJZPXKUA9DjnxEPFLORKu1Clrvu9SnP3mJMb3QRy/x/kjBkFLFcctQ==
X-Received: by 2002:a17:902:c94a:b0:215:4a31:47d4 with SMTP id d9443c01a7336-21614dcbdcemr103448915ad.56.1733652952045;
        Sun, 08 Dec 2024 02:15:52 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e5f172sm54234005ad.69.2024.12.08.02.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 02:15:51 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id D03E6DDB020; Sun,  8 Dec 2024 19:15:49 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v4 01/13] x86/um: clean up elf specific definitions
Date: Sun,  8 Dec 2024 19:15:28 +0900
Message-ID: <19a81a341d5e43499307b170c6cc6f3ee0ff9299.1733652929.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733652929.git.thehajime@gmail.com>
References: <cover.1733652929.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_021553_021263_443415EB 
X-CRM114-Status: UNSURE (   9.52  )
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


