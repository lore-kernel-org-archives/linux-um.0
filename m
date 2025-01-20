Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B6DC02185
	for <linux-um@archiver.kernel.org>; Mon, 20 Jan 2025 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=; b=Qh3RaVPrytZopDmi8OGZEwEBN8
	luwgt6BImczafW78jP75AYc7Fg/hwF1tc8VBldHStq4PkZTQYvqdnxt/knXGWpl1ML9cZROl7EMYq
	geXCrXTLmdqTHEr1QMkFvi8n5ymrNxxjqYfcTlBuYYVDsjlB513W47FMenJaPD8Iu89JhvNqbIa7O
	KOLEIYs1gzLAezcfsVcU+SM6iCL9w+Gujq6GmhzrnQvD3FVazWkRxYsqtI8meQoqlI309sV/zj+G6
	ctVE6oFlz3k0l/bvmCSbzAKiURjrgcpUdT9VTgtRIh7iWXZU8e3ZnJ16DiqJnyUH+OyBXbVr5rz07
	H9YVaapA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkqz-00000004nMZ-0pMM;
	Mon, 20 Jan 2025 06:01:41 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tZkpo-00000004nBd-1EDn
	for linux-um@lists.infradead.org;
	Mon, 20 Jan 2025 06:00:30 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2ee76befe58so7075365a91.2
        for <linux-um@lists.infradead.org>; Sun, 19 Jan 2025 22:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737352828; x=1737957628; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=h/B+X7IEuJFEpA/sF/nOv7hy/3MYByeCTBVD0mtQvnGjMB1f5IHso3xi224EfIJOwo
         D6DZpRYVZfnY4aISEu0036YKU7lubxb0nv6tj7LUndijS2i0o7RaoRGOaE7spRZ56t5K
         Hn7fTWzNTEpB/uvgGXRJNwqwbTOv08+o9lDRv9gkit9UO/qYB4sGnPqpedhgAkJK0/B1
         grCGRVZsrTw1xfOIAE9KPPHq860zorRRqhK4xY1rNC+d6VIb42W20mDRX2lZxhE3OKED
         av7N650j89Fr2VHdt5TJZOetsGxNx9VK4/IDt8wT1LKHnAKviH1L6FiFM0I2z6sec7x/
         cYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737352828; x=1737957628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J6A0PvieWE1aUVMRXHIYqqGpYk2ToPavpJigmE4/rI=;
        b=D5oqWPjZRkbWLx93YzAMWlvWhAAHV2FVOSHtr8+0pgfCeAgO4SnCi/sona3xG00VZG
         Wi5Tq+H4kOPDBD2q5h87XUqeCPlIzECxu1o1Lya6Kp5ZQBfz6vZC5ZNTRadi6fmxwDwC
         9EdqAgZLeCYJgYjNowoelHfbjve4/sKGoBiaeLMQA0JOQl/YrkOAStnYxWzjigsv20PU
         BTNNJjtKmn4n9EIurgfd+QHvGbqezFfT8Js2HMSOL5TwSywzqAzMQXWhQeO8NM9upCv7
         WB4gw1qe9Eb2X0/ise32SUwWYEhLVPQkir6kU3yOTMSvkJz+6H2aGrsRkR1ZNJW4lgEN
         tTnQ==
X-Gm-Message-State: AOJu0Yw0XcTAFDXHGHwjq74qhFNFnxagsa8qCLmdcv5hpuFRI1Hf9VIu
	fceZacZalQem2UvjXiDcYlNA/jKUbYYHlJ3Ngosqnk68NF9WRmF4
X-Gm-Gg: ASbGncvnvZNxgwucgKZbIY+0FQd3jt0zgwCuhP6QE88VOp2VwufFvMxuOAUiahMrcqc
	SsQqx+i1oMbcCx7KgsVWFN5ZH8MWe2A7C0TxCDskpZvRwNTd3CoQPJCvZawRGmUtnDF6ATTXUHt
	lklRws7IASkar/hySSVQmPYjjxjE1hfQ67vsH99+vfSGSxjEchMz8aMjpbcZY8h+l85138N8kc9
	eYc7VOe9r+Tl6oVapNcj7M+bAZSzVS9RnHhzusAOu1V3iGUWDEjxlGSOaUTW8Fe4W2X7JWjqNjZ
	y4jPMS825ogQn6U+K2ozBn3JKmaxdx1Ab6GwA4UoNw==
X-Google-Smtp-Source: AGHT+IEIU/QnPcFWbyBpGGI0bOZ5U/3i7DaTp7HJ4EEaNT/w69aFNSgcq2smx1HYmV+Qydx1BCJilg==
X-Received: by 2002:a05:6a00:4fd3:b0:728:e1e3:3d88 with SMTP id d2e1a72fcca58-72daf9bec6amr17325924b3a.7.1737352827682;
        Sun, 19 Jan 2025 22:00:27 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72dabaa8948sm6136030b3a.164.2025.01.19.22.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 22:00:24 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 1EBC4E27524; Mon, 20 Jan 2025 15:00:20 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com
Subject: [PATCH v7 01/13] x86/um: clean up elf specific definitions
Date: Mon, 20 Jan 2025 15:00:03 +0900
Message-ID: <2d70a0ed79ee0a0bef80ad4790063f4833dd9bed.1737348399.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1737348399.git.thehajime@gmail.com>
References: <cover.1737348399.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250119_220028_331563_5D8E2BAC 
X-CRM114-Status: UNSURE (   9.80  )
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


