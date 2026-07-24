Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB411C53219
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vm6qrfAkUPzhXJJ3UQsdZbiqgLQjnmrnzxHKnAesp/c=; b=km8JFb+IuusuWUuGnVNGaPrSDU
	EAqZA+qkNbIYJo9e6ysQsxfWV8GibXLSba/jnxnJjXmQY2RTAtFt3y+mUq1MrapsGW9Hzc2gK1dJO
	dOJpNCULW7yHH0P5zdNy4y06x6StWfR5ArSaLOfp7kn9S/l25ocxMRkb4bJNSUJIY8+BjSxn+fBMx
	AJga4R3AeMuuRHBnaf7u9w9uIliXj5dTdARJQUUMbmV/gXzkc4QTXUYc6FEeBVuDByZfeQu9DVouW
	dRSO1Gei+LysLLjoiYIHOVXVo0wchQK6opkeOTVp5+08e63sXqVdbpJ2/EFDoE14GyWnLE/Cg04st
	fMmq1pDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe4-0000000HGkT-1QNg;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from lpdvsmtp11.broadcom.com ([192.19.166.231] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGh4-3EnB
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:26 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E1CE6C0000E0;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E1CE6C0000E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=QHfTE5bRcdLZyxMFDgb7aIpXRPUd7y2ghLn7Xo3L0Zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZetw17MNfDTmcMCyWhrDsMrGlDm+5hpAZVnHCWCdi1hjm8ADC5sWofvUbnfzcbqN
	 9EANnpQoIB1kVXwciOa0qq+1SYrCtaczU5rAeWonKGeP4uud9DCpGt5AQH9/2qDWPD
	 VijDBnUb7x77DO1OMJMiuO7WgvBRQEuu80BM48c8=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id B1E98ACD;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Tiwei Bie <tiwei.btw@antgroup.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <david@davidgow.net>,
	Rae Moar <raemoar63@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 3/9] um: Use os_set_pdeathsig helper in winch thread/process
Date: Fri, 24 Jul 2026 14:41:13 -0700
Message-Id: <20260724214119.1066665-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144124_855393_A94D88DC 
X-CRM114-Status: GOOD (  11.27  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

commit 42b8b00c8ab1ac18fccde3f29ee589626a561ea7 upstream

Since we have a helper now, let's switch to using it. It will make
the code slightly more consistent.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
Link: https://patch.msgid.link/20241024142828.2612828-5-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/chan_user.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index 1434114b2f34..35f9beeb19b3 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -10,7 +10,6 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
-#include <sys/prctl.h>
 #include "chan_user.h"
 #include <os.h>
 #include <um_malloc.h>
@@ -162,7 +161,7 @@ static __noreturn int winch_thread(void *arg)
 	int count;
 	char c = 1;
 
-	prctl(PR_SET_PDEATHSIG, SIGKILL);
+	os_set_pdeathsig();
 
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
-- 
2.34.1


