Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93598C47DB3
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 00:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=esmLFoWEc7Lg06NBgO9C+HiyLZmtELGcj84DcSOPhKA=; b=IIhuplGqtiqT0o/1j7Na8LUEyz
	n1/CYkaa1aOgib9djc8SqmuVhB6KycmvRi3ENc18MKrdUnMjIzNGd0/kFBPgDhxEnWtVJzXOE+uoU
	HKE4zwx95wtFOY5+IyN/GcnNPkXi0TbPIA1wCLM+ibjXFwcjxJideuuWTi7Ep3ZghIITBwxuh8aPB
	OxrK9FIRZ3MnqoW8eD1bNs8pBEXlrh6hXXg62aEF8K9uT0sCzrgAoz6p7NZPKv7rXq1nFmXgMh4zb
	xT+Oy/ig7QGQ2Yc6i1Aa2Pvj7B393n6U6ietrZf+jLBjAZUdzQbbecjhK8oPxVStpVkOwdo3wjdN0
	l1s2mBSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFZ-0000000EjTU-496N;
	Tue, 30 Jan 2024 00:45:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFU-0000000EjNo-1OVI;
	Tue, 30 Jan 2024 00:45:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 04F846238C;
	Tue, 30 Jan 2024 00:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABDE5C433C7;
	Tue, 30 Jan 2024 00:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575510;
	bh=YC1N2oEpGjCqkxBB/gMBX4M8pPLAjOZSUACvgMPf924=;
	h=From:To:Cc:Subject:Date:From;
	b=EsVITYj953c4uFFFHZ/frw0EiUtZbrrMp+OVQxWbuOaE0N+CeP+uTVtvg0d1HkPbE
	 dx1xjZuEYidzlqTiWFRGj+SkA/+U6udg9PcDME4tGk23K49tCxu8OA9a+i/MJUELpx
	 zfgr06iNdTvvKa6poZRHyUzhaW+YgG3/JsUivUtxPgA0NlbZAhvfIincnmBqraRYq+
	 Ym3kNoML2p6zAT5oQeRN8l7wcJqsH6fONUx2p6UMhh+ytFbKacXcsGSL9RW1n+KEnP
	 3q3EOAXhUglqEegusNEH88D8ltv1cC/T02mXvBhkKWFf4BK6DTvW1m58/9L/m3VxHY
	 ryyDMU5hgXARw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Gow <davidgow@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: [PATCH v2 0/7] of: populate of_root node if bootloader doesn't
Date: Mon, 29 Jan 2024 16:44:59 -0800
Message-ID: <20240130004508.1700335-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_164512_485101_A638DB49 
X-CRM114-Status: GOOD (  14.24  )
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

Changes from Frank's series[1]:
 * Add a DTB loaded kunit test
 * Make of_have_populated_dt() return false if the DTB isn't from the
   bootloader
 * Architecture calls made unconditional so that a root node is always
   made

Changes from v1 (https://lore.kernel.org/r/20240112200750.4062441-1-sboyd@kernel.org):
 * x86 patch included
 * arm64 knocks out initial dtb if acpi is in use
 * keep Kconfig hidden but def_bool enabled otherwise

Frank Rowand (2):
  of: Create of_root if no dtb provided by firmware
  of: unittest: treat missing of_root as error instead of fixing up

Stephen Boyd (5):
  arm64: Unconditionally call unflatten_device_tree()
  um: Unconditionally call unflatten_device_tree()
  x86/of: Unconditionally call unflatten_and_copy_device_tree()
  of: Always unflatten in unflatten_and_copy_device_tree()
  of: Add KUnit test to confirm DTB is loaded

 arch/arm64/kernel/setup.c    |  7 +++--
 arch/um/kernel/dtb.c         | 14 +++++-----
 arch/x86/kernel/devicetree.c | 24 +++++++++--------
 drivers/of/.kunitconfig      |  3 +++
 drivers/of/Kconfig           | 11 +++++++-
 drivers/of/Makefile          |  4 ++-
 drivers/of/empty_root.dts    |  6 +++++
 drivers/of/fdt.c             | 52 +++++++++++++++++++++++++-----------
 drivers/of/of_test.c         | 48 +++++++++++++++++++++++++++++++++
 drivers/of/platform.c        |  3 ---
 drivers/of/unittest.c        | 16 +++--------
 include/linux/of.h           | 25 ++++++++++-------
 12 files changed, 151 insertions(+), 62 deletions(-)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/empty_root.dts
 create mode 100644 drivers/of/of_test.c

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Gow <davidgow@google.com>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


