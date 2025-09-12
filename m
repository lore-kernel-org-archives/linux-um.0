Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 406AFCAC593
	for <linux-um@archiver.kernel.org>; Fri, 12 Sep 2025 23:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lfbdyh7LZJFSoGiMjoTbUql5vPlkYLJxEsX0Qs2RYRI=; b=OkmVQqH8uZ0LKkI1erWDX8PxLF
	vh883pYJPBeKyfGnwVuZN6mYZOBUhIy2DZ7I7VR8WtdCooF1s0cncmN0fes0HcwRY7yOPA3bpKNHA
	fvVjkatF61iTncgpPGJBoBOPGSYEnCmRlMI/9cIHnTdVSUDUtKarVwJnZ1EM95woksH9zG+g1Q3Ri
	vzhTXFo1gug78aVqsPoyl6AFOlWY2gZ96OYHigEDjWHnnOMFbbr9GGlnBPNafI1YFT35BvbbgS9L8
	02sktGzgXDepJV1HP7YJKNFEi309L+UmliiYdbd+vQin2GI2EnwtGGt2g5LGDySYM1tNBSeR61mSt
	zI+GMYOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCu0-0000000C0vB-04aF;
	Fri, 12 Sep 2025 23:10:00 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxCtw-0000000C0qF-1jfY
	for linux-um@lists.infradead.org;
	Fri, 12 Sep 2025 23:09:58 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-7724df82cabso2607097b3a.2
        for <linux-um@lists.infradead.org>; Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718595; x=1758323395; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lfbdyh7LZJFSoGiMjoTbUql5vPlkYLJxEsX0Qs2RYRI=;
        b=MvLWlYoz2davFSCdTWO9K++PrKK+nAE6sGpKpnFDtfzF1PyfPDtrXhl9E8oTRmuvf8
         WgJbiw0rZiy0cIpW//IhtBGPgtRl22ff+3lvLbwtmIs0vTkp2v3KowxI3u3TMl1Optu0
         qyQxF/qfR400ZRFISwM8IT9HFDswu8aOBB7LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718595; x=1758323395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfbdyh7LZJFSoGiMjoTbUql5vPlkYLJxEsX0Qs2RYRI=;
        b=RgJU6mzZZLuSZI5ve74ZEUL1n2M5+pjrMRs4Y9ydTWC3TKb0dhVQ+mh22h4HTP99tV
         X+Jgr4RHl3BDiueQKCRgSBZLf/qMOjVhTkXikKIrv1mXJ95jKdqSuuUJ+HET9lUAUPLz
         Vth6WfZXdcLkClkkrBzLoopAMg8oreBpgylJnRDSR4TQAJmc7zuOWP++6g7hU+eb/MuY
         U7tLdjDcQeyTUzAogmg7s0cq6MRu39OIDb5svvutHXT9Nj3KbezF/exXWzC9Gsr4gMlk
         +8dfM1WuwH+Hi3pP0ALKtu5oGx0h9c5iouAfenwp0UYkoGwTXHDbO/o1d9Zv9SPZXg/Q
         kQlA==
X-Forwarded-Encrypted: i=1; AJvYcCUiB0XHTNotdqzQ+KuZkqqVFxdGu3wPO1sZca9Jh63eZQGBjYodN8EWmehwvKLP7xRQtwuU3LFoaQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxNK3zU4fkpH7rSAdrbxSekHgVUx4cxwyHbB3UMDF1Or9Ml/OAq
	ihF2sVYLGWjMtcLl4W7hHdAen3TXvQieh/j6joCHo6S03BqQy27zRXte6DLgb9a+Gg==
X-Gm-Gg: ASbGncu96sJjyXAcb9HPd+zKTK8Cadq6qdCCLfjZ1SZUcqIRi4QfEOTsruezMqVj3Cy
	r8Uc05+fDlxHPhVt4FYdHQGhYjp5agoDExE7Fv96HwAZTpRGG0WOM/ldq1697uIEuwJz7+YeYKf
	1+C60mutuuSzaFAO3ycEAVpB+8961uC7JBIdiPsGoc+zp7uJdIJR1JUgw6wYF0bjqyQgJIqbSEg
	0blIKWv+TF8uiqNGJy/Nvwu92ly3Rq9CCJ57sGVc0eW2J3d/GwuQB99zTJ1UEfxmVg98CQPfajx
	ksouQfzXlEKAGVbB45Dfmpih1okLhAuDqs2Ob6MozvOqBsMqtb6CfD3XJbleOwr6jdRll515KkA
	nBOAGx+MjMdrZ2FoW2pTVmHmkUZmOTvhewteZzKl0vMv/HuqWKPaumPOJrbVy8pD6eTg12A==
X-Google-Smtp-Source: AGHT+IGftUvGS13nUHO5sPbO5aRdKW/iBhC0or62cpjUOnYlYwK3legDnb+L5xeL8qmZu3rVdhxD6Q==
X-Received: by 2002:a05:6a20:3ca8:b0:24c:48f3:3fd2 with SMTP id adf61e73a8af0-2602a792dccmr5869556637.24.1757718595630;
        Fri, 12 Sep 2025 16:09:55 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a35b7b53sm5716718a12.7.2025.09.12.16.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:55 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/4] PCI: Add KUnit tests for FIXUP quirks
Date: Fri, 12 Sep 2025 15:59:33 -0700
Message-ID: <20250912230208.967129-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250912_160956_481953_E67AB307 
X-CRM114-Status: GOOD (  19.80  )
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

The PCI framework supports device quirks via a series of macros and
linker sections. This support previously did not work when used in
modules. Add a basic set of tests for matching/non-matching devices.

Example run:

  $ ./tools/testing/kunit/kunit.py run 'pci_fixup*'
  [...]
  [15:31:30] ============ pci_fixup_test_cases (2 subtests) =============
  [15:31:30] [PASSED] pci_fixup_match_test
  [15:31:30] [PASSED] pci_fixup_nomatch_test
  [15:31:30] ============== [PASSED] pci_fixup_test_cases ===============
  [15:31:30] ============================================================
  [15:31:30] Testing complete. Ran 2 tests: passed: 2
  [15:31:30] Elapsed time: 11.197s total, 0.001s configuring, 9.870s building, 1.299s running

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/Kconfig      |  11 +++
 drivers/pci/Makefile     |   1 +
 drivers/pci/fixup-test.c | 197 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/pci/fixup-test.c

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 9a249c65aedc..a4fa9be797e7 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -68,6 +68,17 @@ config PCI_QUIRKS
 	  Disable this only if your target machine is unaffected by PCI
 	  quirks.
 
+config PCI_FIXUP_KUNIT_TEST
+	tristate "KUnit tests for PCI fixup code" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on PCI_DOMAINS_GENERIC
+	default KUNIT_ALL_TESTS
+	help
+	  This builds unit tests for the PCI quirk/fixup framework. Recommended
+	  only for kernel developers.
+
+	  When in doubt, say N.
+
 config PCI_DEBUG
 	bool "PCI Debugging"
 	depends on DEBUG_KERNEL
diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
index 67647f1880fb..ade400250ceb 100644
--- a/drivers/pci/Makefile
+++ b/drivers/pci/Makefile
@@ -20,6 +20,7 @@ endif
 
 obj-$(CONFIG_OF)		+= of.o
 obj-$(CONFIG_PCI_QUIRKS)	+= quirks.o
+obj-$(CONFIG_PCI_FIXUP_KUNIT_TEST) += fixup-test.o
 obj-$(CONFIG_HOTPLUG_PCI)	+= hotplug/
 obj-$(CONFIG_PCI_ATS)		+= ats.o
 obj-$(CONFIG_PCI_IOV)		+= iov.o
diff --git a/drivers/pci/fixup-test.c b/drivers/pci/fixup-test.c
new file mode 100644
index 000000000000..54b895fc8f3e
--- /dev/null
+++ b/drivers/pci/fixup-test.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google, Inc.
+ */
+
+#include <kunit/device.h>
+#include <kunit/test.h>
+#include <linux/cleanup.h>
+#include <linux/pci.h>
+
+#define DEVICE_NAME		"pci_fixup_test_device"
+#define TEST_VENDOR_ID		0xdead
+#define TEST_DEVICE_ID		0xbeef
+
+#define TEST_CONF_SIZE		4096
+static u8 *test_conf_space;
+
+#define test_readb(addr)	(*(u8 *)(addr))
+#define test_readw(addr)	le16_to_cpu(*((__force __le16 *)(addr)))
+#define test_readl(addr)	le32_to_cpu(*((__force __le32 *)(addr)))
+#define test_writeb(addr, v)	(*(u8 *)(addr) = (v))
+#define test_writew(addr, v)	(*((__force __le16 *)(addr)) = cpu_to_le16(v))
+#define test_writel(addr, v)	(*((__force __le32 *)(addr)) = cpu_to_le32(v))
+
+static int test_config_read(struct pci_bus *bus, unsigned int devfn, int where,
+			    int size, u32 *val)
+{
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where + size > TEST_CONF_SIZE)
+		return PCIBIOS_BUFFER_TOO_SMALL;
+
+	if (size == 1)
+		*val = test_readb(test_conf_space + where);
+	else if (size == 2)
+		*val = test_readw(test_conf_space + where);
+	else if (size == 4)
+		*val = test_readl(test_conf_space + where);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int test_config_write(struct pci_bus *bus, unsigned int devfn, int where,
+			     int size, u32 val)
+{
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (where + size > TEST_CONF_SIZE)
+		return PCIBIOS_BUFFER_TOO_SMALL;
+
+	if (size == 1)
+		test_writeb(test_conf_space + where, val);
+	else if (size == 2)
+		test_writew(test_conf_space + where, val);
+	else if (size == 4)
+		test_writel(test_conf_space + where, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops test_ops = {
+	.read = test_config_read,
+	.write = test_config_write,
+};
+
+static struct pci_dev *hook_device_early;
+static struct pci_dev *hook_device_header;
+static struct pci_dev *hook_device_final;
+static struct pci_dev *hook_device_enable;
+
+static void pci_fixup_early_hook(struct pci_dev *pdev)
+{
+	hook_device_early = pdev;
+}
+DECLARE_PCI_FIXUP_EARLY(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_early_hook);
+
+static void pci_fixup_header_hook(struct pci_dev *pdev)
+{
+	hook_device_header = pdev;
+}
+DECLARE_PCI_FIXUP_HEADER(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_header_hook);
+
+static void pci_fixup_final_hook(struct pci_dev *pdev)
+{
+	hook_device_final = pdev;
+}
+DECLARE_PCI_FIXUP_FINAL(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_final_hook);
+
+static void pci_fixup_enable_hook(struct pci_dev *pdev)
+{
+	hook_device_enable = pdev;
+}
+DECLARE_PCI_FIXUP_ENABLE(TEST_VENDOR_ID, TEST_DEVICE_ID, pci_fixup_enable_hook);
+
+static int pci_fixup_test_init(struct kunit *test)
+{
+	hook_device_early = NULL;
+	hook_device_header = NULL;
+	hook_device_final = NULL;
+	hook_device_enable = NULL;
+
+	return 0;
+}
+
+static void pci_fixup_match_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
+
+	/* Minimal configuration space: a stub vendor and device ID */
+	test_writew(test_conf_space + PCI_VENDOR_ID, TEST_VENDOR_ID);
+	test_writew(test_conf_space + PCI_DEVICE_ID, TEST_DEVICE_ID);
+
+	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
+	bridge->ops = &test_ops;
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_host_probe(bridge));
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	KUNIT_ASSERT_PTR_NE(test, NULL, pdev);
+
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_enable_device(pdev));
+	KUNIT_EXPECT_PTR_EQ(test, pdev, hook_device_enable);
+}
+
+static void pci_fixup_nomatch_test(struct kunit *test)
+{
+	struct device *dev = kunit_device_register(test, DEVICE_NAME);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, dev);
+
+	test_conf_space = kunit_kzalloc(test, TEST_CONF_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_PTR_NE(test, NULL, test_conf_space);
+
+	/* Minimal configuration space: a stub vendor and device ID */
+	test_writew(test_conf_space + PCI_VENDOR_ID, TEST_VENDOR_ID + 1);
+	test_writew(test_conf_space + PCI_DEVICE_ID, TEST_DEVICE_ID);
+
+	struct pci_host_bridge *bridge = devm_pci_alloc_host_bridge(dev, 0);
+
+	KUNIT_ASSERT_PTR_NE(test, NULL, bridge);
+	bridge->ops = &test_ops;
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_host_probe(bridge));
+
+	struct pci_dev *pdev __free(pci_dev_put) =
+		pci_get_slot(bridge->bus, PCI_DEVFN(0, 0));
+	KUNIT_ASSERT_PTR_NE(test, NULL, pdev);
+
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_early);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_header);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_final);
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+
+	KUNIT_EXPECT_EQ(test, 0, pci_enable_device(pdev));
+	KUNIT_EXPECT_PTR_EQ(test, NULL, hook_device_enable);
+}
+
+static struct kunit_case pci_fixup_test_cases[] = {
+	KUNIT_CASE(pci_fixup_match_test),
+	KUNIT_CASE(pci_fixup_nomatch_test),
+	{}
+};
+
+static struct kunit_suite pci_fixup_test_suite = {
+	.name = "pci_fixup_test_cases",
+	.test_cases = pci_fixup_test_cases,
+	.init = pci_fixup_test_init,
+};
+
+kunit_test_suite(pci_fixup_test_suite);
+MODULE_DESCRIPTION("PCI fixups unit test suite");
+MODULE_LICENSE("GPL");
-- 
2.51.0.384.g4c02a37b29-goog


