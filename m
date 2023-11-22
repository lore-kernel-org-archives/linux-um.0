Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDDCC072A2
	for <linux-um@archiver.kernel.org>; Wed, 22 Nov 2023 03:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=UrQhGfJg3VdRWbreJqkzkVzNm73iKwpZVdzwKcjdTFs=; b=45nYIrFk1eYs95
	Twd4q715esTgz+xh4w9TqVuBrKyjhXQ5W6aFTCcLk7cY2TTuo2+XA7BmrjBlzWSGxZCJapB8mdse3
	/Hv6sAwUDhYkxJY7IXwvFfq5nL0i7Zo36hzZxCbrvVC5XX+TkFLiwMmgRyQz9gfdYw3Qp8yJm1cYG
	iJEh894tcx3r/Cl+Or8y79Pu2REhzsRs5bqY9lSTL4dm8Irc8eXBpdq7AfXnALXkZznWTAq2nHMOi
	z9ik+KSeMXxyeXUWqjFOqoeYaw++UFmqupejYvmtru9nYvDZQ9NWPXJwmFx2HxrXDQ/HpeVAP9jHs
	TpQgKnP9C6AIXfDqobQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5drr-000XKL-0P;
	Wed, 22 Nov 2023 03:25:35 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5drn-000XIc-2j
	for linux-um@lists.infradead.org;
	Wed, 22 Nov 2023 03:25:33 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VwuRqSm_1700623519;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VwuRqSm_1700623519)
          by smtp.aliyun-inc.com;
          Wed, 22 Nov 2023 11:25:24 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] um: Use swap() instead of open coding it
Date: Wed, 22 Nov 2023 11:25:18 +0800
Message-Id: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231121_192532_062927_C1BAEBF8 
X-CRM114-Status: UNSURE (   7.06  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Swap is a function interface that provides exchange function. To avoid
code duplication, we can use swap function.

./arch/um/os-Linux/sigio.c:81:28-29: WARNING opportunity for swap().

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7607
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/um/os-Linux/sigio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/os-Linux/sigio.c b/arch/um/os-Linux/sigio.c
index 9e71794839e8..1eb15f3cfdc8 100644
--- a/arch/um/os-Linux/sigio.c
+++ b/arch/um/os-Linux/sigio.c
@@ -50,7 +50,7 @@ static struct pollfds all_sigio_fds;
 
 static int write_sigio_thread(void *unused)
 {
-	struct pollfds *fds, tmp;
+	struct pollfds *fds;
 	struct pollfd *p;
 	int i, n, respond_fd;
 	char c;
@@ -77,9 +77,7 @@ static int write_sigio_thread(void *unused)
 					       "write_sigio_thread : "
 					       "read on socket failed, "
 					       "err = %d\n", errno);
-				tmp = current_poll;
-				current_poll = next_poll;
-				next_poll = tmp;
+				swap(current_poll, next_poll);
 				respond_fd = sigio_private[1];
 			}
 			else {
-- 
2.20.1.7.g153144c


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
