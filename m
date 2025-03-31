Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F04C36011
	for <linux-um@archiver.kernel.org>; Mon, 31 Mar 2025 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EySq0RpGRnjPjfZiO1DIFrP4JjQDtf0CP/IzZpcVHto=; b=Z3AQED65zWs6VLHtXKyR5/tCMO
	/V3jWYHBXFC8s6yVWBTs7SwthZNdKU5g1XXUc7bdLI23PhBZOM2BDM7EtsDIEPHEwKq0VmLXITgdc
	eK0duIkRW7gNySTiQVEmY1tUdEKfug7vNisYdNgbwJ0RjSdRasGR0ZfycMuNUndEFpX/4DJjGwrRk
	9UenuEerUvruyf0wp4N1N+SYX0kYofjUfwVcqvFEnWzVJ1Xy9O8+b4il8pnerCRohIjOdWZRcdvQV
	k6Ws0YNY/OLomdRgJdcnKQ2zqUlReky+weZdCBWoIJYpP+/glZh0inGdsnynCZmT9UB8nDFonymeI
	Y6f6ve9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzAZ1-0000000HOBm-3q0d;
	Mon, 31 Mar 2025 08:32:11 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzAYy-0000000HO9P-0lhN
	for linux-um@lists.infradead.org;
	Mon, 31 Mar 2025 08:32:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743409922; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EySq0RpGRnjPjfZiO1DIFrP4JjQDtf0CP/IzZpcVHto=;
	b=cfL3JBdEVgtpXnXYd7X7i40hzvS7Ogz1gZlEpHaFomwWL9YWrRXa4DkLML04nXMilRilbo+G8OFqacunAYoJmWnl5RrHy4BoznPDG0/C6LPmn1p7kCAkTv5Z7tdHYdByHUU4agXZ2d5T70ZbxRSrLb9RmHzf57DbIqTlIiiDJqY=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WTVlcrf_1743409912 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 16:32:01 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: richard@nod.at
Cc: anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] um: Remove duplicate arch.h header
Date: Mon, 31 Mar 2025 16:31:50 +0800
Message-Id: <20250331083150.72598-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_013208_872130_936DFD9C 
X-CRM114-Status: UNSURE (   6.25  )
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

./arch/um/kernel/trap.c: arch.h is included more than once.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=19877
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 arch/um/kernel/trap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ce073150dc20..39820bde49e6 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -16,7 +16,6 @@
 #include <kern_util.h>
 #include <os.h>
 #include <skas.h>
-#include <arch.h>
 
 /*
  * Note this is constrained to return 0, -EFAULT, -EACCES, -ENOMEM by
-- 
2.32.0.3.g01195cf9f


