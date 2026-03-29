Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD5B10D148A
	for <linux-um@archiver.kernel.org>; Sun, 29 Mar 2026 03:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3wXPqz9uSdsbBV+gvFYDHL1AfaHwYaDG2Fl9a3n4ruA=; b=uFmL3pu9ww8pKjT2MRTQHNkrLG
	QvfHvWO3CTwsw6In9HPocgraM1O53sjOzNzBQCZ/QiihcEYDRR8Ts3mDFWkNXLYn5akwfLip/2jHT
	/zAnWqa6j9Gb8TKFuoPGEEHHlfQPDbLKCsJOxz+gZv77BDxeyg8/ufeBowRMgnhalCpRLty4m4EHj
	12z01+hXmCQhyGg8d8Z0Q1fhhTm4bGmzna6wEEVrT1Cmgc8GkGf+P49utLYrv2o/B/P5mq9YDTbfE
	OC8RK/q45+g7eR4AgMMbwAK2ToXey7u1V6FCAwF6CbDutvpG1lTgMvAsWHu+FWOGERI8bK6Ua2yaY
	WSeDbCjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6gXH-00000009VgR-19Rq;
	Sun, 29 Mar 2026 03:09:59 +0000
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6gXC-00000009Vef-13YU
	for linux-um@lists.infradead.org;
	Sun, 29 Mar 2026 03:09:57 +0000
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAAXvWj6l8hpnOd8Cw--.20596S2;
	Sun, 29 Mar 2026 11:09:47 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: akpm@osdl.org,
	sergeh@kernel.org,
	clg@fr.ibm.com,
	linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH] um: mconsole: use bounded version string formatting
Date: Sun, 29 Mar 2026 11:09:46 +0800
Message-ID: <20260329030946.32410-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowAAXvWj6l8hpnOd8Cw--.20596S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rKF1fCFW7trykGFyDZFb_yoWkCrcEv3
	4aqwn5Gayftr18Xr1DA39Iy3y0yws8Kr4kta1ktFWfAw1rurs7uFZ0vr1qgw1UXw48WFn3
	C347AryjkryUGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoq2MUU
	UUU
X-Originating-IP: [111.196.245.197]
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260328_200954_678345_DD3CB4C0 
X-CRM114-Status: UNSURE (   6.65  )
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

mconsole_version() formats several UTS strings into a fixed 256-byte local buffer with sprintf() and no length bound.

Use snprintf() so the version reply stays within the local buffer.

Fixes: e9ff3990f08e ("[PATCH] namespaces: utsname: switch to using uts namespaces")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/um/drivers/mconsole_kern.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index e2a9e8879f58..18d0ec15557c 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -106,9 +106,9 @@ void mconsole_version(struct mc_request *req)
 {
 	char version[256];
 
-	sprintf(version, "%s %s %s %s %s", utsname()->sysname,
-		utsname()->nodename, utsname()->release, utsname()->version,
-		utsname()->machine);
+	snprintf(version, sizeof(version), "%s %s %s %s %s",
+		 utsname()->sysname, utsname()->nodename, utsname()->release,
+		 utsname()->version, utsname()->machine);
 	mconsole_reply(req, version, 0, 0);
 }
 
-- 
2.50.1 (Apple Git-155)


