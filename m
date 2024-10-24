Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F4CE8E87
	for <linux-um@archiver.kernel.org>; Thu, 24 Oct 2024 14:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9F+/gG2/NpWN+fSAPQ0vZiXCLF44MabL2VbrE4Rm4ys=; b=1C5tiYNjRlN9n5VHlQtTLd3rbw
	BSshKAaMOlYgHkwCFAphCS4mma8Lt9WBVKUy8g3golVtIetLYbNXTYmO6AOGwNycfSsxAuKlBfjxh
	ID+BdSgqP3AJiY3hCKQb1H1viU+I2hFLGzWTdQyRaUL5Ljz4olWakGqkGP2U0+Js9ALPUxago3ffZ
	/1z4JBDRz6F7Myzi97tk9/RrBsBtzD2mIU+59OC7sAOU7paDZOsCN64+8es+dOK3DLThYyfPvdOLo
	CY2KKVXvOHr5EZ/l7P36LYssogPYt9wMN+nQJM5rp+gH8s4StjWghN0RIBU9Y0dB4qXkMPn6FUgTb
	5HWtb7Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3z1B-00000000mKf-0gRh;
	Thu, 24 Oct 2024 14:40:53 +0000
Received: from out0-196.mail.aliyun.com ([140.205.0.196])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3ypO-00000000jVh-3WJD
	for linux-um@lists.infradead.org;
	Thu, 24 Oct 2024 14:28:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1729780118; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=9F+/gG2/NpWN+fSAPQ0vZiXCLF44MabL2VbrE4Rm4ys=;
	b=QvUxdWEaSQG+z/jptVsDJeHzvQUcjB/UYjI7cESZc+AvCXGGWhpPNt41b+kENqfJRzhNNSphLXDNuPRq0Qcr1H42/kUO/W5x+BeOXxpqz55vo7seKpbBkkKCSFL0qYeE15dIkG3NH4ydC9eXU5fXUie5p1cUZjlZvJr/3BQ6bUM=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZreBt-P_1729780117 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Oct 2024 22:28:37 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 4/4] um: Use os_set_pdeathsig helper in winch thread/process
Date: Thu, 24 Oct 2024 22:28:28 +0800
Message-Id: <20241024142828.2612828-5-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
References: <20241024142828.2612828-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_072843_471697_3F6D8308 
X-CRM114-Status: UNSURE (   7.36  )
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

Since we have a helper now, let's switch to using it. It will make
the code slightly more consistent.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
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


