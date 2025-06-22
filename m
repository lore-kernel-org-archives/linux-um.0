Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8A9C8300E
	for <linux-um@archiver.kernel.org>; Sun, 22 Jun 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=; b=izODhl2U9gcldn3YyZf+1wNCAR
	cGAmyOH+jnL2NKgg+lGEjgdr25Wpx1jRrSiZOrDCvS9ct9fYzzA1E3rOzaUiEaOR5v7dCc61fWm86
	3ZbnCzvOw0Ading3rAbCUtDPtJJ/OeTWaJ5/rduQYNiOVzqzvGm2SE/IoAb/NQ8tZ8Ed1kgkiCbnS
	9ImTneeZNylfG7pOXnDNCq7wdHCoDo0LUVOgR+jbU0vKox+JetXrvLo/eRai2UCs8GDCa1jduBeyh
	YXem9bwGksJlzN4bRymvInvXZdKTsXNLhlMCQtPsyI/24+Ai3BC8i0piYny1wsBBqjfHoPIrup+Sq
	3xI0rjPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSKI-00000001F6b-1L0x;
	Sun, 22 Jun 2025 21:34:10 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTSJo-00000001EwF-0Pst
	for linux-um@lists.infradead.org;
	Sun, 22 Jun 2025 21:33:41 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso2621077b3a.2
        for <linux-um@lists.infradead.org>; Sun, 22 Jun 2025 14:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750628019; x=1751232819; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=BT0GZSFnAaO41me+df2iI7J3Rm173pQMalEUR8jRO08WXo3c0yc0KlhS1f3/gwoehl
         8yiUisPLSw/4NRvlDYj5vtnlH6cvdn1pK5MkE/cemtZXP4uTH0SN+L7VP638mMMLkqFi
         biIQ+xPEcTnAxe4zBe9IGD4jHXI/nRInHhOBdvvXcDW4FyBDcZaZacVywfgEodpAbLmj
         ohH9mGCl4uBt/ieEom17y4Z0Nhy+6kEy1gEjJQRfnCO9jF2cZ+XNOwj4Bkx2QQdbzQ20
         Tj7i36TO7yyOPfcswmmvZu55Cf+UyaL+TItPSlebIQXj7fey0VvQK+dh3Y8bs4d4GCgV
         kAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750628019; x=1751232819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=ZvjUhb9u+dsKHBLek3rblSYzYjvGC3yvQwHAeBrSKlSlA2sWAc2ldVyor1YsyiwPFW
         QamV3IjuIRsD4FWpixlXcHGQ/rUIbnE52ZPEpaxYgUMICHz+Ac87EePgAIdZ8995EjQz
         n3Ydt4GRGPLjx5dVlipMg3eHlnt98CWjY/BpgpwqcYEW2jRrMFfr/+j9VihYBTQB0vzK
         I+I4O8vk5g/1ZNgvNc/tvq2AwSYFUtnfJ9sGhs/R2GHS+0GZYZ7fo/hbDybC7BJM8qIq
         mqHzT8MZyu9X5MMdCdubkl5Y5QURs1bd67jiQrP7S/BfPABhMLany9/wP4vdnaKN88R7
         wE0g==
X-Gm-Message-State: AOJu0YzSnZn6K3FHm+OP52xL4sP8cIzDkEVhJ9M9/nWg1CujR0OpsIQV
	QwUaddCvbi0FibKA28I4dNYH2lguqLpeLpWfSa/q6O2ZoZPPa7DL4JWi
X-Gm-Gg: ASbGncstbuY2yPn0G3VyGIJ6hM8NQCF5G7kJiuMAXM0h5F/IEOC3Gr5lqrFeu8X0O6l
	9MiMdAjbPunWUlwk77L1DQ+FM5Ax/LJEWX5VnOwH3t/1pSy5ubXLpntStHrklulD3CVjlsoJRQX
	GrRREm2qpQt2UXRBsIUk3kL3i1wtk2M99IG+ibHTMB43I/2s2Qa/clMp0RPFbf669s5ZLmhQiCy
	VWqGur3fhog1/pXvCiwQ+uKkmRplYiK33cFxsLEp2yg07oyoCYeMv/CkCKeJqsi6h2EU4yGv2IW
	sWM0oGbsTGID7eaJDY8PmDSkzhYsUsrL/cCWYOrlHBDwhZe3KDJI3UfIs5BXj/S/sVFPHzhIp7j
	0ZgfRb9L+iD3wjMCY/8UzHjjWueTPkDuV
X-Google-Smtp-Source: AGHT+IHnCoh0OAe4axWmL20FoXf5VObbkWOWaaYc43C4lAvRwQcH0SlNZZ/I60fw+XEGmY114DRcGQ==
X-Received: by 2002:a05:6a00:238c:b0:746:2a0b:3dc8 with SMTP id d2e1a72fcca58-7490dac586emr14075135b3a.17.1750628019333;
        Sun, 22 Jun 2025 14:33:39 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a6c8c80sm6802898b3a.177.2025.06.22.14.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 14:33:38 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id A45F3EF1EB8; Mon, 23 Jun 2025 06:33:36 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 10/13] um: nommu: a work around for MMU dependency to PCI driver
Date: Mon, 23 Jun 2025 06:33:08 +0900
Message-ID: <b7c74ee793ac4a5c301ebca27f8d58990625638b.1750594487.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750594487.git.thehajime@gmail.com>
References: <cover.1750594487.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250622_143340_137020_A04A0050 
X-CRM114-Status: GOOD (  12.65  )
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

The commit 8fe743b5eba0 ("PCI: Add CONFIG_MMU dependency") restricts the
PCI base driver to depend on MMU.  While nommu UML _can_ implement PCI
drivers over PCI devices (e.g., virtio-pci), the current nommu UML
doesn't implement it.

But without PCI drivers kunit complains as config for kunit
(arch_uml.config) defines the dependency to PCI drivers.

This commit fixes the issue of this compile failures when building PCI
drivers with nommu UML.  In particular, the fix is to undefine the
constant PCI_IOBASE to be able to bypass pci_unmap_iospace() call.

When we will support PCI drivers for nommu UML, we will refactor this
code.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/asm/dma.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/um/include/asm/dma.h b/arch/um/include/asm/dma.h
index fdc53642c718..643d74555671 100644
--- a/arch/um/include/asm/dma.h
+++ b/arch/um/include/asm/dma.h
@@ -4,6 +4,19 @@
 
 #include <asm/io.h>
 
+/**
+ * now the PCI core driver depends on CONFIG_MMU in linus tree, nommu
+ * UML cannot build with PCI but without PCI kunit doesn't build due
+ * to the dependency to the CONFIG_VIRTIO_UML.
+ *
+ * This is a workaround to silence build failures on kunit, which is
+ * valid until nommu UML supports PCI drivers (e.g., virtio-pci) in a
+ * future.
+ */
+#ifndef CONFIG_MMU
+#undef PCI_IOBASE
+#endif
+
 extern unsigned long uml_physmem;
 
 #define MAX_DMA_ADDRESS (uml_physmem)
-- 
2.43.0


