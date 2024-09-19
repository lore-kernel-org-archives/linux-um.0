Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42166CE8D7D
	for <linux-um@archiver.kernel.org>; Thu, 19 Sep 2024 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdSqMY2HXYy0ubLmwxMELZOakGOMvgxmb+g1ImqOkD0=; b=OF/8c7hckBEdQokXEg+w3N0XF2
	avFYQ7DcLPhNbIDRvRsn7ieza1WKVIl7mN2SIEOwgPI8sTxGAO1qolyrB9ftCrE00jPfxMarCmaCk
	wd/NMEUS+ebAiDbzCrLnnNzdEN/yyWGRKu/IOOomh9B7VtTPyY+siMBsTin1Hz6u3BeeR89CKdbAx
	SKELu4dDCZSxBPz6Oh/5vyivII9lLyo7DV1jJzTZbT687Kq/lyREupOHLwrbzLaeiTJyX2bCUYJlg
	R5ByuU1nqTV88r06MWAfRA8sA3V4XMU3J96w3rcAuM1eARelwLE9gCEkg0y145WadmLTleKVgPKJe
	k1AxMhUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXZ-0000000AGr3-3qXl;
	Thu, 19 Sep 2024 12:45:45 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1srGXX-0000000AGoj-0ZC2
	for linux-um@lists.infradead.org;
	Thu, 19 Sep 2024 12:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zdSqMY2HXYy0ubLmwxMELZOakGOMvgxmb+g1ImqOkD0=;
	t=1726749942; x=1727959542; b=Cl6w7wpwygprnj1Wemx80Eklk1M6H/UsyDVT7HXKVWiWLRP
	yxIg7FHIaGAS5fsy6RHXoIc7U0Ccvx1/FjHp3ggg1zkRtb+ahoV95jI0XylbyRzu/9Su32DCMQ1uj
	EvlF1Ta3d+MKLgS5gvDf90iLrUZfjpqJTYFrjIcZX9h0cGgK2YtHnn1wwGKjQB+SraMDgIK1kFDra
	HwBdUlyloGFlQfx0h9vsH1wHhtqMv4Rq8lRm/ARXw4X3kiovOxmzl2HtzMvt9UN5ht33vLABrP3Ez
	Cj1178Ah0MvcDd9o0dAFUrY1uWy10mZ3UpNiUSFec2palhnVM9NZfg7HVC6d8Z5w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1srGXS-000000047AZ-2nP2;
	Thu, 19 Sep 2024 14:45:40 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v9 04/10] um: Set parent death signal for winch thread/process
Date: Thu, 19 Sep 2024 14:45:05 +0200
Message-ID: <20240919124511.282088-5-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919124511.282088-1-benjamin@sipsolutions.net>
References: <20240919124511.282088-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240919_054543_297103_66903836 
X-CRM114-Status: UNSURE (   8.67  )
X-CRM114-Notice: Please train this message.
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

The winch "thread" is really a separate process. Using prctl to set
PR_SET_PDEATHSIG ensures that this separate thread will be killed if the
UML kernel itself dies unexpectedly and does not perform proper cleanup.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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
2.46.0


