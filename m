Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9F0C48BF5
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u/K2UbrRzkgVk4riGXSfup+vELgVKWGstZ9M4ptKJIw=; b=nTisj/CUVQTZTFbcVjh/A2CMEl
	bcczj9pYPaA0N1VlI49rQhHI38nm32eZVc1H2yjjY9eRD2fo3Lbc9Dne2oqmxyNjzY4Hyn+918jNZ
	9mHVdbgjQkzdxsmUmT5Y74OtRLkN0TtugEVTTCqJPpnks965u3BdpHfUgPLNR5CScu5qAgBzc9pGn
	fbApPzuSVHMnf3RZT77nzIpelVDiKcF2shR+GWB0In9ljOXtk+jew5YXvQO0w+4Kkcbn/jJuwp759
	I5XYaLM9bhDWYyzsPqc453fPTaWdYoMxjD774VGYCbQw724ZRI4HDOlvp8Ig+VofCdhjgShhhe3qU
	zvmChcrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb9A1-00000004M61-3uVp;
	Sat, 17 Feb 2024 01:06:33 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99X-00000004Lhd-2tK5;
	Sat, 17 Feb 2024 01:06:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1AC64CE0E73;
	Sat, 17 Feb 2024 01:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBD9C433F1;
	Sat, 17 Feb 2024 01:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131958;
	bh=XYeu3I7lleinGqco1HjcUCLcHTbSZ73GuzXfX4TQXmw=;
	h=From:To:Cc:Subject:Date:From;
	b=PcUiJwYxnDE+rKcJSARsAYYXXhQqmiAGSPyBcn7kTAHoHf57qbuk/sAnm/DM0k35g
	 KAkza6Ctke1ZP6ZRs5/oWZxbQc1jDBKLfFGtETphQj5EFJl5Q9RTA6cYsGFN7pOD8i
	 rgX1jH/pHSb9Y8Q07vQncUARwWo4LJBV/ifU7Ibpb4vZquazg8/JtiBQaHIXChTqaP
	 +lr5cjiofJD1UAMz7Ru12iOankJ6GV1XA5neOb2wOgScXFdh1tBdXN+L0FbbYeRNCz
	 eu+0avQ1ADa/7W94e/Oci8lyLQzL6PLOWlW9tvRBnZXBMGqA7u+kkjIpDBfKCP80xK
	 6pu2BIHAFzxNQ==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 0/7] of: populate of_root node if bootloader doesn't
Date: Fri, 16 Feb 2024 17:05:49 -0800
Message-ID: <20240217010557.2381548-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170604_111807_02D807CA 
X-CRM114-Status: GOOD (  11.55  )
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

Arch maintainers, please ack/review patches.

This is a resend of a series from Frank last year[1]. I worked in Rob's
review comments to unconditionally call unflatten_device_tree() and
fixup/audit calls to of_have_populated_dt() so that behavior doesn't
change.

I need this series so I can add DT based tests in the clk framework.
Either I can merge it through the clk tree once everyone is happy, or
Rob can merge it through the DT tree and provide some branch so I can
base clk patches on it.

Changes from v3 (https://lore.kernel.org/r/20240202195909.3458162-1-sboyd@kernel.org):
 * Made OF_UNITTEST depend on OF_EARLY_FLATREE
 * Made OF_EARLY_FLATREE depend on absence of arches that don't call
   unflatten_device_tree()
 * Added of_ prefix to dtb_ prefixed KUnit tests
 * Picked up tags

Changes from v2 (https://lore.kernel.org/r/20240130004508.1700335-1-sboyd@kernel.org):
 * Reorder patches to have OF changes largely first
 * No longer modify initial_boot_params if ACPI=y
 * Put arm64 patch back to v1

Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
 * x86 patch included
 * arm64 knocks out initial dtb if acpi is in use
 * keep Kconfig hidden but def_bool enabled otherwise

Changes from Frank's series[1]:
 * Add a DTB loaded kunit test
 * Make of_have_populated_dt() return false if the DTB isn't from the
   bootloader
 * Architecture calls made unconditional so that a root node is always
   made

Frank Rowand (2):
  of: Create of_root if no dtb provided by firmware
  of: unittest: treat missing of_root as error instead of fixing up

Stephen Boyd (5):
  of: Always unflatten in unflatten_and_copy_device_tree()
  um: Unconditionally call unflatten_device_tree()
  x86/of: Unconditionally call unflatten_and_copy_device_tree()
  arm64: Unconditionally call unflatten_device_tree()
  of: Add KUnit test to confirm DTB is loaded

 arch/arm64/kernel/setup.c    |  3 +-
 arch/um/kernel/dtb.c         | 14 ++++----
 arch/x86/kernel/devicetree.c | 24 +++++++-------
 drivers/of/.kunitconfig      |  3 ++
 drivers/of/Kconfig           | 14 ++++++--
 drivers/of/Makefile          |  4 ++-
 drivers/of/empty_root.dts    |  6 ++++
 drivers/of/fdt.c             | 64 +++++++++++++++++++++++++++---------
 drivers/of/of_test.c         | 57 ++++++++++++++++++++++++++++++++
 drivers/of/platform.c        |  3 --
 drivers/of/unittest.c        | 16 +++------
 include/linux/of.h           | 25 ++++++++------
 12 files changed, 168 insertions(+), 65 deletions(-)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/empty_root.dts
 create mode 100644 drivers/of/of_test.c

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


