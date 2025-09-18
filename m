Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC81CAC59A
	for <linux-um@archiver.kernel.org>; Thu, 18 Sep 2025 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=; b=1znr3ZbOE9tzcYV7ll7CMIL1kY
	4Q3uyfNGmq74fOW0k1UTJo7cKoAzQlCyjdTuAb5Wbp5tgup7hZAc+Gx4OFSaYWQlUbTqP+9fQvY2O
	znAW5eJc3kA6wGRhKzKNbGnYocA0lKxcTz/yHj+DV2CnDA/9MFSMwWG8FtH8Y0F+WC0DE/75eAbrY
	iv0QpHShXrECv3g3TIszVUEyPA0z7E0AmfAQ888mesLw1Cw75gwcc3d/7iV++l9aTg8WtvfnRPLcn
	y/93zb8fA4PVlleu0Bc0TlvJ+VYBeExhPtAyXyaKrtnhSc6ZSMMrnzFTXMexHh5W4O+6c8HBUAW0h
	bvr230rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70p-0000000GIOj-3cHz;
	Thu, 18 Sep 2025 05:16:55 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uz70k-0000000GIJp-1E0L
	for linux-um@lists.infradead.org;
	Thu, 18 Sep 2025 05:16:52 +0000
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-32dc6616f7dso355491a91.1
        for <linux-um@lists.infradead.org>; Wed, 17 Sep 2025 22:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172610; x=1758777410; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=G/wkmXasdAWWAmCbfxBRBlWvzUyYpvz+Hernnk//IrLVQjjHl76Ke/g/U6vEvQcQ8P
         ajhUIZ8dFQnJ0iHYugTNvdmVbJiu9f6XIHtl14Ltmz8sF/OTMjxtkFhqZzRtKrC+xBx/
         jX994JU3HtdaxMOHM2ERq5gvC7UPvJXS92IWgQTK8NKDJLXrQ7nmIZsQn4bELQo9gFMY
         R9TCVMOMANzshHCh6HOPTxj0asrTSf+kivhBxZhD3hGdQkWitYzU49VDfwWWZXWKVuRJ
         cyXXKvHf4pLgEo1703S+Nn4+7MngVl1+bL0Zog512XT9WvLOz2RnHCyi3mGMa+t6H6UG
         LpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172610; x=1758777410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL9evNGVpzgjwGis6FRx6Ny95Jmdu1Zd+5bgNtHIJLs=;
        b=thBSntf5/SL+Qf6QjMxEFoOvJ5pmrGWtRIkLzDy1lp5IYVEYe0Ale14v2FZS6II7BJ
         kq0TsPiiWdHBXMGxjRSG9IJrqLK/oL2ojPwcZ9Cd60vxHQaR5RXaGMYEZ3p7KBWU1TEN
         U2Bp7t51BEjnfoDxUazSdfVNE89wA3593WTI9N3wWvTFLz7spCWmUcvK98m/KlKNyYxh
         OgatsaBunn0aBOP+zZHLhHziPmsy9weCFiQgJx/sZk/Kl6X26Y0QkXY7t1lpU+0PyP68
         +rMm69jgngSb2vpclsM3uh+T00lgwiHOx9/np8XZEx1G2upHT3XzLFzMGcygw7LImdE4
         SO1w==
X-Gm-Message-State: AOJu0Yz3CucC8f8Ewc75EAfU02nf7SMbgu/qvSFFzc/TkaCUUaWpmbw3
	I3qwD0R9wTq3qN7ZmJZgR5I5ScBFgLGmrT5Rho9fm4suB2h+P/UEfTzz
X-Gm-Gg: ASbGncuvCQb1NufgESxQxSmPc2agRwLsx/0EjvyYdeeW6KFbG4+NpwnkVCwe5hcWESK
	x5ByvZbHBG8Qr2vHwShx6H5ttWdWWgciNP9SDJFv5P8y1jVnxki75D5eeso56sJquPyZbRwksn4
	TW1A8T6h2qJavuZzOWxqDISr5qVyPC+HrhDcHZ0dDHWRCWJEJPUiifTXIl13WaVQn11vDqF9bro
	YtsHaJZr3/p+zwRc91TfDV+gsVM+vbRrAdTLwXf8Y/LaqFnZ1Pz7Blf+ABkJHT9zhl4SP8ZnCHM
	oHOPMgaI5u20uSuCJpYWONOTeoMEULz91MO7kx4/aCC/mw2SSMKKykh0E1q7WILlZmqWm5D0GAo
	kUOdMRt4qlcwr1AybLV+pT3GcIGYOI62LODxrt1I9Gqim8/COtKYjfm5QkbR2X8o+4IgAMZ6cOb
	J6hPWw0zkKen0=
X-Google-Smtp-Source: AGHT+IFwiCIUby5Al7WTn2I/DIUnBMJmg3jISswUhPnLRV817OVMwAQnC20DwIBS9SCeb7OC9m1+7w==
X-Received: by 2002:a17:90b:4c12:b0:32b:7d2f:2ee7 with SMTP id 98e67ed59e1d1-32ee3ebecf9mr5669955a91.13.1758172609515;
        Wed, 17 Sep 2025 22:16:49 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064edb8sm1208854a91.7.2025.09.17.22.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:48 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 82C191061EF7; Thu, 18 Sep 2025 14:16:47 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 11/14] um: nommu: a work around for MMU dependency to PCI driver
Date: Thu, 18 Sep 2025 14:16:04 +0900
Message-ID: <3cdc0df9917b2acdd718dc2587ae1bddb9258b06.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_221650_346452_9D8ABD8D 
X-CRM114-Status: GOOD (  13.20  )
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


