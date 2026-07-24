Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E41C5321B
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 21:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PYxzL0mvl2MBP8UV+sEeKYg3MnhCJIzvXa3uKTG5u+Q=; b=HSG+/cDjiDUkcvjfGny7Vsmr4b
	xJtSgauNnEwW+oxjdFLKDrlBKWgG3x84JhgFXXYcucLYp00vlgIZvZbpy1/l2RmExlL6GfZbBWbdp
	RA2nQ/m6RNrq/Y3Eg1hFg3qkDw5I6cXc/094O7xgQ99fia1h/5elP8ZO1AwTnRdhI2AKH9jipzwka
	D0gpA/i6QSdo4kM5sFolQxXA/Px1C94xU6yuUA8Z39uZPjl3xRpJyJ/pTySuz0PeqCCACyUJ5kgKQ
	W7qLqkAClHwQgBRgY1RNU3ABwKXe5PlZuccUbWr1NSzCSM7uN3aLxw0ceqABWTB9mZs1wWnJ4u4Je
	z897yFuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe4-0000000HGkh-2FqW;
	Fri, 24 Jul 2026 21:41:28 +0000
Received: from lpdvsmtp12.broadcom.com ([192.19.144.207] helo=relay.smtp-ext.broadcom.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnNe0-0000000HGhA-3b05
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 21:41:27 +0000
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id DE90DC0003EC;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com DE90DC0003EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1784929281;
	bh=X6hKdn2YSvvafi2mgHuWo3wbqEvQXzvfO9b69Ah5G9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DxCwqt8vSB7LG+I6lGoGHH4diBONgRG14vAGZqmLx/sDE2y/bzZpJZuJQXPl92jia
	 btTEYJTDmKtEnmEfVE6FW6jI/EaMJA3o9YKu+yUrE2ydL4qO/9eYWzqPKImBoiuq2t
	 +mtQSbMwsHkgxKnp4A+nP9nM/T/cwbRlc5Hbe+Ew=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 7A579AD0;
	Fri, 24 Jul 2026 14:41:21 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
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
	Tiwei Bie <tiwei.btw@antgroup.com>,
	linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML)),
	linux-kernel@vger.kernel.org (open list),
	linux-kselftest@vger.kernel.org (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	kunit-dev@googlegroups.com (open list:KERNEL UNIT TESTING FRAMEWORK (KUnit)),
	bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH stable 6.12 2/9] um: Set parent death signal for winch thread/process
Date: Fri, 24 Jul 2026 14:41:12 -0700
Message-Id: <20260724214119.1066665-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
References: <20260724214119.1066665-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_144124_995838_64215970 
X-CRM114-Status: GOOD (  10.90  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

commit fdb2ecd35d327a1fc6bba69b97f85b494e1f4b6b upstream

The winch "thread" is really a separate process. Using prctl to set
PR_SET_PDEATHSIG ensures that this separate thread will be killed if the
UML kernel itself dies unexpectedly and does not perform proper cleanup.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Link: https://patch.msgid.link/20240919124511.282088-5-benjamin@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/um/drivers/chan_user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/um/drivers/chan_user.c b/arch/um/drivers/chan_user.c
index a66e556012c4..1434114b2f34 100644
--- a/arch/um/drivers/chan_user.c
+++ b/arch/um/drivers/chan_user.c
@@ -10,6 +10,7 @@
 #include <signal.h>
 #include <termios.h>
 #include <sys/ioctl.h>
+#include <sys/prctl.h>
 #include "chan_user.h"
 #include <os.h>
 #include <um_malloc.h>
@@ -161,6 +162,8 @@ static __noreturn int winch_thread(void *arg)
 	int count;
 	char c = 1;
 
+	prctl(PR_SET_PDEATHSIG, SIGKILL);
+
 	pty_fd = data->pty_fd;
 	pipe_fd = data->pipe_fd;
 	count = write(pipe_fd, &c, sizeof(c));
-- 
2.34.1


