Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B5CC7EE32
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DJyHnY/AEpTF9GfMLo8k/6bfaLX6C6Q1KHLqm5XY7Ow=; b=RsZOyJIAcfFHTY
	JI2LrYVYi+D1AQmJdC8seTFQg7PM5VtIuG3ZyFMNWI+JHr/e/ZPyaSAS3CV+3GIzxyVj8pJlNAbLh
	OqSr1iBZu4JLy7NGyUPJNwLXEMYqrQMu02OPDLieW6oqEfDRRXReGPlyS9DxqsIGQ9kWh0nnlDnZT
	PICdUTk54rRxBo7pI3+y/AKPHBYAhX8lXB9Kdh9/JeCNxRY3uiGjujcM697a5/DlxygfJ28/8hH5u
	bniU9tpd/VdlJ34orlvaENw8g3l/o4FM+HrYeCTRaN7iaAzoqzK2idUCCNKJG+XKUVi2h7Pj+6W6j
	sfyCv/BLxIpE9QeV39Ow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtu-000U9I-64; Thu, 02 Mar 2023 01:38:30 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtq-000U6x-Ui
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 01:38:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 80C02B811D6;
	Thu,  2 Mar 2023 01:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EACC433D2;
	Thu,  2 Mar 2023 01:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677721103;
	bh=rKtcHDStlDpmev0wSqFyH2j1eZ3mNsvHeJTuTDd60rk=;
	h=From:To:Cc:Subject:Date:From;
	b=Oq0iRiKSGI3z/jJpMgBfNOss+Xzar8RB/Cw11ZHp3oGjPiMZ8vs68LTw4qreqA/VI
	 BpgpwOQ7uCgJEavC3zsKuuWBqfeTXaf9ydAm/THAWCV3L/MnQaQRKF4K2PxQx38FMG
	 jcAYlN7XG4iU1l4mUBLFCEkHlxhkRocvuUyFc+j6o0KrZPtq1MmHjxUqW90wYKbbFj
	 I5Uj9I+R30xd5TSwLaH39w3rJcKu8h482yW5Uh/XW/XHjBt9QXk2l5oOjQujJuMQYg
	 RXaTU21Its7pzaW8Z11gOGGd1A3RixrpdaW0goxxiLK0qu400p2dBU8NcuE0fOYvSB
	 rCqxUyZLJZKUg==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH 0/8] clk: Add kunit tests for fixed rate and parent data
Date: Wed,  1 Mar 2023 17:38:13 -0800
Message-Id: <20230302013822.1808711-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_173827_320362_84CC7DFA 
X-CRM114-Status: GOOD (  17.48  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

This patch series adds unit tests for the clk fixed rate basic type and
the clk registration functions that use struct clk_parent_data. To get
there, we add support for loading a DTB into the UML kernel that's
running the unit tests along with probing platform drivers to bind to
device nodes specified in DT.

With this series, we're able to exercise some of the code in the common
clk framework that uses devicetree lookups to find parents and the fixed
rate clk code that scans devicetree directly and creates clks. Please
review.

I Cced everyone to all the patches so they get the full context. I'm
hoping I can take the whole pile through the clk tree as they almost all
depend on each other. In the future I imagine it will be easy to add
more test nodes to the clk.dtsi file and not need to go across various
maintainer trees like this series does.

Stephen Boyd (8):
  dt-bindings: Add linux,kunit binding
  of: Enable DTB loading on UML for KUnit tests
  kunit: Add test managed platform_device/driver APIs
  clk: Add test managed clk provider/consumer APIs
  dt-bindings: kunit: Add fixed rate clk consumer test
  clk: Add KUnit tests for clk fixed rate basic type
  dt-bindings: clk: Add KUnit clk_parent_data test
  clk: Add KUnit tests for clks registered with struct clk_parent_data

 .../clock/linux,clk-kunit-parent-data.yaml    |  47 ++
 .../kunit/linux,clk-kunit-fixed-rate.yaml     |  35 ++
 .../bindings/kunit/linux,kunit.yaml           |  24 +
 arch/um/kernel/dtb.c                          |  29 +-
 drivers/clk/.kunitconfig                      |   3 +
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   6 +
 drivers/clk/clk-fixed-rate_test.c             | 296 ++++++++++++
 drivers/clk/clk-kunit.c                       | 204 ++++++++
 drivers/clk/clk-kunit.h                       |  28 ++
 drivers/clk/clk_test.c                        | 456 +++++++++++++++++-
 drivers/of/Kconfig                            |  26 +
 drivers/of/Makefile                           |   1 +
 drivers/of/kunit/.kunitconfig                 |   4 +
 drivers/of/kunit/Makefile                     |   4 +
 drivers/of/kunit/clk.dtsi                     |  30 ++
 drivers/of/kunit/kunit.dtsi                   |   9 +
 drivers/of/kunit/kunit.dtso                   |   4 +
 drivers/of/kunit/uml_dtb_test.c               |  55 +++
 include/kunit/platform_driver.h               |  15 +
 lib/kunit/Makefile                            |   6 +
 lib/kunit/platform_driver-test.c              | 107 ++++
 lib/kunit/platform_driver.c                   | 207 ++++++++
 23 files changed, 1599 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml
 create mode 100644 Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
 create mode 100644 Documentation/devicetree/bindings/kunit/linux,kunit.yaml
 create mode 100644 drivers/clk/clk-fixed-rate_test.c
 create mode 100644 drivers/clk/clk-kunit.c
 create mode 100644 drivers/clk/clk-kunit.h
 create mode 100644 drivers/of/kunit/.kunitconfig
 create mode 100644 drivers/of/kunit/Makefile
 create mode 100644 drivers/of/kunit/clk.dtsi
 create mode 100644 drivers/of/kunit/kunit.dtsi
 create mode 100644 drivers/of/kunit/kunit.dtso
 create mode 100644 drivers/of/kunit/uml_dtb_test.c
 create mode 100644 include/kunit/platform_driver.h
 create mode 100644 lib/kunit/platform_driver-test.c
 create mode 100644 lib/kunit/platform_driver.c


base-commit: c9c3395d5e3dcc6daee66c6908354d47bf98cb0c
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
