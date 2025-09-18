Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C61CAC5AA
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 07:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=; b=xb6FjcDgP7NwOAfOGX4hYZWRQV
	m3H0cDFIVAF1L9uhUgP+FxmIRKCCKk62tCO7ifacr++gNoq88yQQ4l0g2lAjzj+5lq6JFWXfLCrZT
	HCV+38NMWm6+4oE78Ipl5MhzpGlEUL5tPCa4iKZ7bVVkN4BUZm65BHgRszbCP7wp5pEVq53NczQaK
	nDEDxFzFckuEmC8A3gPZi3m8fW/2HUZex70lI/Ht0cVGeekeGwZ12Jh3+TFqUTS6ky6Bh8Z3ueZh4
	v0dK45gspu+98LK0HUErEOc3K1cxYYj7BJv2proGCnUlKLsKTA9YS9D2rnf2M2nBgAJ/vGyzePybV
	TANXvHSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Er-0000000GZFq-2Eov;
	Thu, 18 Sep 2025 07:39:33 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz9Ep-0000000GZDB-1k01
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 07:39:32 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7761bca481dso598075b3a.1
        for <linux-um@lists.infradead.org>; Thu, 18 Sep 2025 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181170; x=1758785970; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=GD3yaedNjKbG0trqbTkSET5F+6k5x7aJykjs3NCjSUTyLPCiZOpubRS8XxpyOA8PQb
         rPYuTk0KAuMYQbCJSUD26gMGJAAU+QUSPc3ppp4hU4PkadqVbQKFQozhHJr6JB15FH9i
         Y8bj8Kr5yYl4v1GSZrejFJe/GlahCa9H/jrGz2DPDt2Zj3UxDbk1Qc3Hdj5HoyvG432f
         wUL1K3cCxJ0ZmRlqoi7Vye0TyxC9H4+mlA+yYC9RbnQqSKJIOClRQqb8y/NHr+IH/I+g
         EBsyn1IUYAT235aAmvje6MBHTr2MAPbajuQUUdx6AwnVbP9aSaSllHlc7hkZc4Z8M0uB
         wpbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181170; x=1758785970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=WmSUB9e/BcxSVtHPbDnbBM2NdaxStQnKpJcxb9cDq8TjCD9pEr9qDiRymuiB8XyB38
         loi4gnTtl9Zy5b1+zV6ghozLZw4TvEMP4hOvSA2w74YkLEpmEgA4WhnwgZXSwYJrl3oV
         TAp11MDxvX3HwSTL5FFJu6J/TQ9502G4XohCCs9uAASw1sxZH2XhC4mVtdR8BcfsJhXA
         1VtUHZXTWdfQ4NHQmWmPL/+Wgr4SGI6vg4Vkba6ytXweznqNFdQshEs9GWEQJF7Pib7V
         G+xJzNMvy6+8MquQzzK8HUGhay1l3ojPLptuqLlUjS6BGYOLJHL3znlacNnrYylujXly
         9PRg==
X-Gm-Message-State: AOJu0Yxzxsee6OixbQoEz5WOklVkb7KgQYKP9CvcxneFETixY3n1h5PS
	ubl022LEVloGvxYSqkX0eFfWq9/ntZIF6wt8BHvsej/0qXdql/uYtDRK
X-Gm-Gg: ASbGncts/nfirv8LA43k+eXbCI+T6KhdgoGtH7Ia+ErlJXxlCKdWNUEpVUL4XjZc+tk
	EpxWcdz61JMKot2f1Wfe85PrBswbpJ9ZScI6ngvSHcB2xqU+qRHfbpUrgL6qkZXHk2baDrg9bZD
	crZmuu/6NC/zqydfr1sc+dZy4vcakY2IIkzCQOEXVenSv3k52Zyegnb9w6op4ID2R7j3Jq2xp0G
	1tqmMmbJezcZxjWBUJ4P84frrPo1YmBwfzTr20eQGHUhQDyiFzzL0E9iiXlb8FeDBU5WY6NvBBE
	EAaLE3NTuMLfa7Lc9XJYEVEzKJ2Q3kV4YLtD9sdlaM5VzhLyIalgrCN3yJIsE9xiOs6f18XCbnj
	SCQk1zEWna3N9HvVy7Xz45WTHRodagBm3DyVNA7WFhX9232FW7wNiKjvzIxwIT4ZP558MCPpyJn
	e9dnMWR7rz+5A=
X-Google-Smtp-Source: AGHT+IE17eaOXHncHS5hiCqILLrCGf7cFJ1Ycoy+fQzqYB1HpBN8eNLK/gt5jkFvDElEVaTnnLbYOA==
X-Received: by 2002:a05:6a00:84c:b0:771:fd01:9784 with SMTP id d2e1a72fcca58-77bf96606dcmr5439800b3a.29.1758181170538;
        Thu, 18 Sep 2025 00:39:30 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfbb79c2esm1503006b3a.2.2025.09.18.00.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:29 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 0372D106210E; Thu, 18 Sep 2025 16:39:28 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
Date: Thu, 18 Sep 2025 16:39:05 +0900
Message-ID: <4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_003931_454641_72260010 
X-CRM114-Status: GOOD (  13.25  )
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


