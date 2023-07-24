Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6C7C001DF
	for <linux-um@archiver.kernel.org>; Mon, 24 Jul 2023 14:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=07koaf06IkHHyj0wEX40oANixAQEyv2R4IUE+7yP6fY=; b=uVh2S6/u6qJez+
	WeTs4twxaudMhGuC9S1fyrAG02AQtRynWRpt75Mpel9RNci0KcGgY5HIkYddFJUFS0Pkv4YIqOyM+
	MUH8b2oIknQ3ZJirnA95dVMRsl3C5cr6/kCxTm+WNPSAOveAAJ6FM7J8oztjoTEuW6C8w9jHx19lw
	mbCuefkx/xRsOOmbx9W5Fdh9DyjGmTM5F+1GobfHruRZ3cFp4Fs2GrFkdzzPUqScShkYhxu5NBkhI
	5uYjcUyRCqQAgzqSS46eS+BH6p/y2CfeE9RzSaS63vT8AGtHo2tEQNumoNOJfgzUkbbuuwoFV91BH
	aCfV5inSduYmQEzQm1xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwSv-004bI6-0S;
	Mon, 24 Jul 2023 14:23:13 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNwSr-004bGb-2W
	for linux-um@lists.infradead.org;
	Mon, 24 Jul 2023 14:23:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690208589; x=1721744589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OKaORiHPT85EF1/YMUxfys0MZti+NzPzdfUSYLi2rfU=;
  b=QNd2e5f0YFnIPUSunM3Fk4/lgrdVeYsu48VC+L/QnclsRv46iHqS4uxq
   h/4wO/jGdU8BWZYcR3WjHjLTEWiXKuYrksjYbkImObYtrwDmcgnB1wkPp
   eRdDYuYpWUztdH9EmY2cspCrcydQzLdn2uPYLueAjno+xFAok61yNFbGT
   b+mbH3dd0am7Pw8w9D0rgnhW3PNdK5lEtHi0aXBf0noaNxz2VZij8rrJ5
   yNYZH4JuETghe8Akt0GiOrhCUcC5lO2DI6JjFH0G+1KLSpId/dgFMjfyd
   tHQ4WuzCq7gg41Md1rIhWpmuzb7CtypyPCIvFybl5BtDgg+yUWXkqM6/V
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357452192"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="357452192"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="755319107"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="755319107"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2023 07:23:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 77B501A6; Mon, 24 Jul 2023 17:23:12 +0300 (EEST)
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
	Yang Guang <yang.guang5@zte.com.cn>
Subject: [PATCH v1 1/1] Revert "um: Use swap() to make code cleaner"
Date: Mon, 24 Jul 2023 17:23:07 +0300
Message-Id: <20230724142307.28411-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_072309_863513_EDFE2C09 
X-CRM114-Status: GOOD (  12.84  )
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

The sigio.h is clearly user space code which is handled by
arch/um/scripts/Makefile.rules (see USER_OBJS rule).

The above mentioned commit simply broke this agreement,
we may not use Linux kernel internal headers in them without
thorough thinking.

Hence, revert the wrong commit.

Closes: https://lore.kernel.org/oe-kbuild-all/202307212304.cH79zJp1-lkp@intel.com/
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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
