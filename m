Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4546DC4706C
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Z+vJaJALI5V43EmrX5Wxb8NskSEgBni8qbj0Eg4YyDk=; b=bZwP1xu0StQeUklRR8HErhWmob
	qFs6DLMaoP6rZnrzgWOXBxhpInKrWv9nE172HFVIj9XeRyWnSQv7r0Q3+4FcWFDy88RD/kIMxEYNE
	6WanLY3QJBRniMPKCEodWIJwQ3DwYJkbfgodQFGoLVIa2qj6XhzyetCQdl3Ay6xOyxyYbf6jmqYxD
	TrAMA8SVsktWaxxAwcm+0OpX5NSOoFqaE6n6sjvPVOm2eOEncL5+u3XgzsstohkSI0VvkvJNahqVc
	pSw/VV2fF3JIxCa+RqHVRcZiXjXoaZ3HynBdRE9ybAGHKlyRN2ubQ1zBJA0ORzS8hzfZZAqXsAhRn
	JdN1WTuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONor-003ttK-1h;
	Fri, 12 Jan 2024 20:07:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONon-003tql-2t;
	Fri, 12 Jan 2024 20:07:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B168961DF5;
	Fri, 12 Jan 2024 20:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C27C433F1;
	Fri, 12 Jan 2024 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090072;
	bh=OrQw0dbMF0js5SoZCQr9kcnhmqPonHSy4cpM0zYdF2w=;
	h=From:To:Cc:Subject:Date:From;
	b=gtxcC37X2WxJ4Ag5UD09FLbJ3nEwuGIhOGOu6DNMTfRiSgUvAiRWHv3/hQyJQpxKQ
	 A1asoHh7C1ft4+IuEbfix1Gf1pt1YKCEzW7Y/XOaeNOUyUEv9ePpL23qc0FqrHzZqp
	 vT3y2v8e52od6NzaKnSki/9n/gksekczLmkQVO1HYRmwE2logou69Sl7/ae1Peys+e
	 OSjyJlHtTNAfgsEzTESnp2XR4K3Fx40Ac3xvUanMsNvTH4mh64puVDEqjC4QR9xuIS
	 4XN4firdS38espv2NzXsbmhGVx95bDBpNtKxSdI3K1VifWNRQXzOCmz+sIxI3qs3A2
	 cKz3F2pW1w9aA==
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
	Will Deacon <will@kernel.org>
Subject: [PATCH 0/6] of: populate of_root node if bootloader doesn't
Date: Fri, 12 Jan 2024 12:07:43 -0800
Message-ID: <20240112200750.4062441-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120754_034473_58181CA3 
X-CRM114-Status: GOOD (  12.28  )
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

Frank Rowand (2):
  of: Create of_root if no dtb provided by firmware
  of: unittest: treat missing of_root as error instead of fixing up

Stephen Boyd (4):
  arm64: Unconditionally call unflatten_device_tree()
  um: Unconditionally call unflatten_device_tree()
  of: Always unflatten in unflatten_and_copy_device_tree()
  of: Add KUnit test to confirm DTB is loaded

 arch/arm64/kernel/setup.c |  3 +-
 arch/um/kernel/dtb.c      | 14 +++---
 drivers/of/.kunitconfig   |  3 ++
 drivers/of/Kconfig        | 16 ++++++-
 drivers/of/Makefile       |  4 +-
 drivers/of/empty_root.dts |  6 +++
 drivers/of/fdt.c          | 57 +++++++++++++++++------
 drivers/of/of_test.c      | 98 +++++++++++++++++++++++++++++++++++++++
 drivers/of/platform.c     |  3 --
 drivers/of/unittest.c     | 16 ++-----
 include/linux/of.h        | 17 +++++--
 11 files changed, 191 insertions(+), 46 deletions(-)
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

[1] https://lore.kernel.org/r/20230317053415.2254616-1-frowand.list@gmail.com

base-commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


