Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61BC7EE2A
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 15:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MUttCkDzXycQcM+ZeLMMRCpzl+xVLbejcM6RPqzvGE4=; b=a6Xi3DWuSoFCNS8CqSKGKyYMRA
	VBbMOFuj5BSkhkPMI5ycEri5l9Xl6vOjjUseS7TM6UI9y3PUfw+hcFsJIcjLW6T3C+VkF69i99KcW
	eQ1503JmVtD+SqNw0HaHdt01TfTq/ZluOaRHHKKzySEHv7qGx2+ncdZE6suGxRFvOWd31e8MWkXHt
	D+SJO+jJ58L1JYgquUzVDhmo8ohDSUmPTdNajWtXZ49Cov3gLH3YNUj0S4yRDCUU8/sGozSqpbZ1n
	w5CEvH34DFijajENdpj72CvJ6wDKAMFjmqWHB19j+FTbWnS3ZoHjchUm88Z8MM0G0jHPDaKUObFGD
	D84Ze+4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVBG1-0000000F9HV-3v7D;
	Fri, 27 Jun 2025 15:44:53 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVAts-0000000F454-2KsW
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 15:22:01 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751037717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUttCkDzXycQcM+ZeLMMRCpzl+xVLbejcM6RPqzvGE4=;
	b=JT3cpXl9ZArMeSYMOke6l07StbVHeRVQhA3tuV4Bg8Km1Ss+9agaha2LHgTaHmJjZVcvq7
	zynPyvMlDmw05ilZOHCf9dtf3xr4HkJFzcI3RP2G6TvW5b33SvcGZaD0XFEaLAJ7j9QwSi
	2N3YMNO+gWVPMvtA3+fNEQE4ef9KkQzRypHmv3Xn7znpcpGRsJx3ZdH+2bH7ae0TnqPXIx
	nAVZSvaG21nSwzg3g1co3xgx9KE+P6pyfW4TK2ElfoQ7u1QvXN9ikTw9xipl5TcmmOs50c
	S50r8NzZ5AsS+gw1Z5JoKzuB5Txn1TtDL1zvBi4pmPZBR6hVMcN5VqhTIfrwfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751037717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MUttCkDzXycQcM+ZeLMMRCpzl+xVLbejcM6RPqzvGE4=;
	b=NnpV9FW+8h+UsSWIHT3D8wYe/35aNjAaYlU8izb9l8Z9vawRjWekkV+9RESqAKOqchAuwo
	FNUosS2NQlN+NhCw==
Date: Fri, 27 Jun 2025 17:21:51 +0200
Subject: [PATCH] kunit: Enable PCI on UML without triggering WARN()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAA63XmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMyMz3ezSvMwS3dLcHN2C5EzdRKMkMwtzU1NjcxMzJaCegqLUtMwKsHn
 RsbW1AO3c72lfAAAA
X-Change-ID: 20250626-kunit-uml-pci-a2b687553746
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751037715; l=2743;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CAGA/LC8gIjY84M23uMjgwqj01wT2Jq0hkpX/eaSid8=;
 b=Eh34OpL8RnMKtiUJyh8hWfe8gsxH8Ew5FtrA9CHeYf9PtRmtzRqr6baH8A/VTN1VurhCKzWY2
 pw8lIbXWbaFDQBo9s2+vND8RtSWFm8ymLkMXrP5yYcB5uWzM6EZRe00
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_082200_735194_27A1FBFD 
X-CRM114-Status: GOOD (  11.16  )
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

Various KUnit tests require PCI infrastructure to work.
All normal platforms enable PCI by default, but UML does not.
Enabling PCI from .kunitconfig files is problematic as it would not be
portable. So in commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y.
However CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
virtio_pcidev_init(). However there is no one correct value for
UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.

This warning is confusing when debugging test failures.

On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
used at all, given that it is completely non-functional as indicated by
the WARN() in question. Instead it is only used as a way to enable
CONFIG_UML_PCI which itself is not directly configurable.

Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
configuration option which enables CONFIG_UML_PCI without triggering
warnings or building dead code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 lib/kunit/Kconfig                           | 7 +++++++
 tools/testing/kunit/configs/arch_uml.config | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index a97897edd9642f3e5df7fdd9dee26ee5cf00d6a4..c8ca155521b2455a221ddbec3f6fc55662c83475 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -93,4 +93,11 @@ config KUNIT_AUTORUN_ENABLED
 	  In most cases this should be left as Y. Only if additional opt-in
 	  behavior is needed should this be set to N.
 
+config KUNIT_UML_PCI
+	bool "KUnit UML PCI Support"
+	depends on UML
+	select UML_PCI
+	help
+	  Enables the PCI subsystem on UML for use by KUnit tests.
+
 endif # KUNIT
diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486efff8898df79ee090 100644
--- a/tools/testing/kunit/configs/arch_uml.config
+++ b/tools/testing/kunit/configs/arch_uml.config
@@ -1,8 +1,7 @@
 # Config options which are added to UML builds by default
 
-# Enable virtio/pci, as a lot of tests require it.
-CONFIG_VIRTIO_UML=y
-CONFIG_UML_PCI_OVER_VIRTIO=y
+# Enable pci, as a lot of tests require it.
+CONFIG_KUNIT_UML_PCI=y
 
 # Enable FORTIFY_SOURCE for wider checking.
 CONFIG_FORTIFY_SOURCE=y

---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250626-kunit-uml-pci-a2b687553746

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


