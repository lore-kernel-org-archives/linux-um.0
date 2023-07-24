Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD23C00528
	for <linux-um@archiver.kernel.org>; Mon, 24 Jul 2023 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DXW/sNqLs5+k26UdtGQPTP5xmSnbk+WeTmanleokBU4=; b=Mi1ci9UXcPYTBl
	5fnDZfPaTXuQvhYnU+U+biKLZ/hQpx5DCNOBc2s79P8YPpwQM4DvG9HshhuEgqqZm4ZI2wzDkLwRG
	r/wXFJxEHUEX/giHmwIAyS6pVrh/f7I03EpuXCe9ZmbZ5hNNvn7deS1pC4rlpofJWgTxy0FMsyWtk
	dkSHFrNcoS41JQGYhGb9ovQxGNpmqTB5mZDrT21hjMtk1E2PXLaizGXbtTsyAfZTbLOWydZZ4DMMj
	uOGSN6GmvBWkrgXoJB7VGO2oPwxaNbcpSeDM/9/8+b0j/zuhKAofTSggEbnqblnfQahmnxaPyijUO
	3+uDgKDIuubsmmfM0EDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwbK-004cDk-18;
	Mon, 24 Jul 2023 14:31:54 +0000
Received: from mga01.intel.com ([192.55.52.88])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwbH-004cDH-0m
	for linux-um@lists.infradead.org;
	Mon, 24 Jul 2023 14:31:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690209111; x=1721745111;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+5gG+0+scvDqbfX5/L0lqS4BwovP5AcRlSaFF9Lgp1c=;
  b=Jb97P5593vz06UfVWLJ/t3MTyPy/hLTgubVt91b5iKSWEuKdDVgQ4Lme
   Yas36RxmsQGV4us6DWw4qKybgSQpple5WulnG1bwdvLvdGUY2ibWkqPJ0
   3yhvQmE/kT6i2jWB7n0ZfzSxYQq9h95v+FvtHQ0UEQpjgaIQX/Hx5BI/T
   HEwG5Rkevz2AaYEF1pm/YUXOz54ZDu/AqNEsuQMJ+zQOHLirDSyGBajjp
   k9UQ6Wwtqnb3nihnXbUdfAG4MAhrXxff1hN0m6W9Tr85xp0kPFV6SEPuK
   wdipZj0LQehWL5YMD9/4uhY2srsswDGBwjZgRbcQruST4dygwH8YZFH0N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="398362898"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="398362898"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="790986713"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="790986713"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jul 2023 07:31:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 08F591A6; Mon, 24 Jul 2023 17:31:32 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Yang Guang <yang.guang5@zte.com.cn>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] Revert "um: Use swap() to make code cleaner"
Date: Mon, 24 Jul 2023 17:31:31 +0300
Message-Id: <20230724143131.30090-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_073151_326510_B4F33053 
X-CRM114-Status: GOOD (  13.22  )
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

This reverts commit 9b0da3f22307af693be80f5d3a89dc4c7f360a85.

The sigio.c is clearly user space code which is handled by
arch/um/scripts/Makefile.rules (see USER_OBJS rule).

The above mentioned commit simply broke this agreement,
we may not use Linux kernel internal headers in them without
thorough thinking.

Hence, revert the wrong commit.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed typo (h --> c), added Reported-by tag
 arch/um/os-Linux/sigio.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 37d60e72cf26..9e71794839e8 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
-#include <linux/minmax.h>
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
@@ -51,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds;
+	struct pollfds *fds, tmp;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -78,7 +77,9 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				swap(current_poll, next_poll);
+				tmp = current_poll;
+				current_poll = next_poll;
+				next_poll = tmp;
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.40.0.1.gaa8946217a0b


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
