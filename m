Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3C1C7115A
	for <linux-um@archiver.kernel.org>; Thu, 19 Jun 2025 01:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=; b=MUQKprZPEiHvVOxe6gl9uAkOIB
	jQVOnDKbJ9W3P9tDRGrLBjneAcjgPqeqPtIarHi5zf+tM8LpU4aw7sKWZ63L64yZIVrJTCwRPtjMB
	NQXi+5gzEs1oQYE3A82iwuGz7QaUSHgr1bSZGojxCFuvxvkBFqQhKgaZJ8Ec3XEqHRCBI2m8+7ahA
	3zv3Rl+B3v2UsofC3W6bITBBie2I429PF9YgxyWriLnf7vJTwOuvGoX4fp+IBQKTeryGwuCUDLZwv
	B/K4sWE8h3HcHYualFLhGJCJZ854+mItG94PCpAxpLsiC0Y7Au7mx/6m1vVHFEgmP4kLXLdUElFiU
	u+EtH5xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i6-0000000Bgm8-1Iw5;
	Thu, 19 Jun 2025 01:04:58 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uS3i4-0000000BgkQ-0485
	for linux-um@lists.infradead.org;
	Thu, 19 Jun 2025 01:04:57 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2360ff7ac1bso1921225ad.3
        for <linux-um@lists.infradead.org>; Wed, 18 Jun 2025 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750295095; x=1750899895; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=OcSTUwBxB2UFdYSLjA33cLQBth9dVkXxTH44YOTyTQDS3i7ttpx768Rppwmj7Cths1
         21JKf5zPzkP0b/lZdCf4EnOReRCFaWMwkd1tQ9omkvAtIy045pGHSmuphRsEzt8ar6kt
         nirGdAvPdARofMeS1/cUGvz8nsMV2VLw2O3u0EmhrBahppIcDcS+2/zCE+YwLVzeMjtC
         JZkxYX+c29Cuoz0IZaklEF9fYEq/kaLnjCLXAQH1gq8AwO/seUUYGbWMpqRODkiaYlxe
         wTP9OQUUSxkPUyy1svX8AhIWnVS5fiyrY2rOAd5/uFoeGMGRxKGqoCq6X4Rjt3q7x7t6
         Aizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750295095; x=1750899895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=V2GBwfzuY+BMnurB7PyL68Cb08K0kMfmQ63g4tGC6g8WgGv3URvF0+lcbmSb4ich4B
         UufR6cw8ElwNKxZfKNyOSxaaNBDCToUGMk7KCO1su0z8suacrw3E7XcUPuF4LdC7/c3c
         Y8qQZ9w1Fc7yoStjBvIzfUXzqPbYHvP4Nchl0v+5yvAFtoiEHLNVOANiiH5dkIbtZG/R
         SmTO5nxGiB5g+Vw4H8fwh22pgWlMQIRoPZQLI1LpUhb2sv1uhlL7AplnAluTPseEY0RJ
         6kS25o255cIY2+U5c0FXpBmR1P4xV58TWSsxOCPhXQ+apGKoEX6fZ+L/nouiE788bU0T
         0moQ==
X-Gm-Message-State: AOJu0YwtSOvLY7GH7P5Shsk5LHt+R+UnFroiBoLg/muvEaeB89ZXd/8A
	W2XsySVF4+sJoZ98IfaIXfaBNg6wKks/1P29Qj5v3pEMHfw6yAP4jNL6
X-Gm-Gg: ASbGncvZREmreWhzU+7mT6qm4LloliQLavA/c2Pc/EKrQcPYQtca52N2XNf2F/lYraY
	xqPXB7ZctnFUCK8KaXRZUusHpOtsKDX6z4RfRQ/a0RkSISau1G49unzq10CkdU+6iQiBb8oskbT
	BjOxTYS6YCz4kApABPUVhe5fkst711zDYCzrPCCth2aI6rQWYMWjQ2k3WCyI4MgPBG23HlVcxCT
	F1Wj9egMXeN0vVtLlhR5zmqa+PE4irTNd5sRr1IjMPLpy2FZd4wY9F/ea0poSGiDDNdjn+UlN7l
	c/GqprYfgOsl/8GJqCHc7/UJ+wUMHBIOpKeoPXnfPTRt79nGZVcs+YHWNKZlPUeocFUpFeL2T+i
	74rbsTHwlhtEecZH77grFfmCsdkNfMjB4
X-Google-Smtp-Source: AGHT+IFO1wmuMVt89YrBHlfn8kGYjqnEwLyl+KVA4zvbu8jubm0FHxst9cUWZDZj06afHE//hnBCAw==
X-Received: by 2002:a17:902:dacf:b0:235:e76c:4353 with SMTP id d9443c01a7336-2366b16e8edmr259851315ad.51.1750295095410;
        Wed, 18 Jun 2025 18:04:55 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2369843f99dsm36389375ad.185.2025.06.18.18.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 18:04:54 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 7F349ED653C; Thu, 19 Jun 2025 10:04:53 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/13] um: nommu: a work around for MMU dependency to PCI driver
Date: Thu, 19 Jun 2025 10:04:14 +0900
Message-ID: <dce1cc8330469cca3f3e451885b7d230be57b143.1750294482.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1750294482.git.thehajime@gmail.com>
References: <cover.1750294482.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_180456_052950_DA50C2BD 
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


