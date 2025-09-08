Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF79CA1013
	for <linux-um@archiver.kernel.org>; Mon,  8 Sep 2025 07:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IhbcDKWpbNrOR3ICEZaJcaRbm70PW/6iqA4XJ8AQ6wM=; b=Nx9MVBGCc5io0RuRkk6oXVuLT9
	dSIWvPrz/x9wf4GXVdXDJ7S54rYJcHimxCr5Lh83gVFIFtPBx3SA6oEHtB/iROXlEobZD+8acnrl0
	CRH2q4quDdJzs1N7SNli1fMBqeIPyIvasY2oBQCkS3E3YgSwecvto30hZ/AJgXs2p6Y4gvYT29YKS
	qmQSxg+0VLRIMM6lYQnLzrdQliE2kUI6q0ormJ78eqSBYtDI384j5O9kTFDUW9+UZIkuZ9BL13jJd
	UjpvfLA4kxgr55mHepvUrAQqtBPH8QGuPFxcj/B6htEnJCsL5WwhFgFQltrvj+7htIbYDKjYZ127j
	17bTOBTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvVwE-0000000FAQa-2Joo;
	Mon, 08 Sep 2025 07:05:18 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uvVuw-0000000FA1o-0OYX
	for linux-um@lists.infradead.org;
	Mon, 08 Sep 2025 07:03:59 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757315021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IhbcDKWpbNrOR3ICEZaJcaRbm70PW/6iqA4XJ8AQ6wM=;
	b=T14s/DqT8UKIsnqD1SRuvSrT7ywshgCc+Lu6DEbwdCc9Jtwd2hqHDJvmqDI8+CqYPAf7XI
	Ma+U2KQsFubeQNFe/Lj+EAfJHJxD+ExjHRrJdl33gIQFLL1dYlDlL7VJqi3gPKpFjzYxCO
	exzAWgA1o/gxQ6SCPyOmNUseMGgT6p664qZH7VDjQArsnWxNV5O6tgqVAOcol0x51d2/3t
	UFPBKH4ufzGsGRLsU61jLFxlMJbR0LPKG+Sy1DvSjKGWWK41gu81TkFpa0cC+G5EEH7Q3q
	Wvn6rR7S+FhZpLOLcaBFShNLNPA3LSaAnhHXSWKIJGhaNHErTFc0c4drWILFsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757315021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IhbcDKWpbNrOR3ICEZaJcaRbm70PW/6iqA4XJ8AQ6wM=;
	b=XJlTahcZb0JBKv8BvMirOZtutmNlkeWd250m89bfGyGH/udvw2jGHsU64XPkJRxnyHTDIe
	0kDcM6p7yXHcf/BQ==
Date: Mon, 08 Sep 2025 09:03:38 +0200
Subject: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering
 WARN()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757315020; l=2939;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0jhe+/vjvGRxpMw/BOQDCotGiq//HLdo4nHP/+YDC1k=;
 b=zMYhznVYS7837DpcO+nneTkCiRXZIbywAIYTg1rwRyg7fb7QGx4JmsY3Ug1FMRy6VD613B0a2
 Q1JiWaDY2gfBxHvXU5+l65F9FvGMkRFcGIxg88+VSI70dXKgTxycBjH
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250908_000358_268440_18AA49EE 
X-CRM114-Status: GOOD (  10.99  )
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

Various KUnit tests require PCI infrastructure to work. All normal
platforms enable PCI by default, but UML does not. Enabling PCI from
.kunitconfig files is problematic as it would not be portable. So in
commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
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
Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
---
Changes in v2:
- Rebase onto v6.17-rc1
- Pick up review from Johannes
- Link to v1: https://lore.kernel.org/r/20250627-kunit-uml-pci-v1-1-a622fa445e58@linutronix.de
---
 lib/kunit/Kconfig                           | 7 +++++++
 tools/testing/kunit/configs/arch_uml.config | 5 ++---
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index c10ede4b1d2201d5f8cddeb71cc5096e21be9b6a..1823539e96da30e165fa8d395ccbd3f6754c836e 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
 	  If unsure, the default timeout of 300 seconds is suitable for most
 	  cases.
 
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
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250626-kunit-uml-pci-a2b687553746

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


