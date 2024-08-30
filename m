Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8F3CA1005
	for <linux-um@archiver.kernel.org>; Fri, 30 Aug 2024 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OjRIodtRv7xl6NM9Aiu0uvHXUVQZiYl6aAIuCQA1KaA=; b=VDhLrRPITZu/uzl9aA4Aw3tuct
	bQIIy4RTkQgRJEzQFQDl0pWzz1uh9LJXmfCaBgVqrCwIH0T/g2N1pPQXu/6TTSWedw06RGsl2u2+l
	+B3Yx3mYnjyPQ3EPySLp63mw023Syj/rqxZNAhF56KWM3mGJl8s2Y/wtW4KAjK3sZxEOGDDkXPyVG
	E/zo9pLdcX8JmVPIee+YOhwnwtdxIERGFh3vPqnrFWShh/eSS1+xOFenCB1V+WHsoRR1aJbhYaTkc
	diqfFglImL0SA8esw+0uKQpAQSuEE1u29Syep44FNrdFdc/dMZLihNY2LQ2rRz86EsPymJaK53V4p
	ZDI+2S/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk3ib-00000006quJ-0tNn;
	Fri, 30 Aug 2024 15:39:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk3iZ-00000006qts-34pz
	for linux-um@bombadil.infradead.org;
	Fri, 30 Aug 2024 15:39:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=OjRIodtRv7xl6NM9Aiu0uvHXUVQZiYl6aAIuCQA1KaA=; b=bT5s4ShhA3ZqpP3uV1xw6DzYzM
	cRQS1hwojNSQPLVOQAXxvr6SZbpz112srt8vnTVua1LuZRiY/zWOINgXZZ82JTu2qHGzMPdJnkDmf
	p5ILkWCb/iYsG/b8DJ2QMb9I5llQhEdeNpj284jKldQT/8GSbUgbNn1rspk7QiB1Ml5WdkCaY++Ku
	01Mizi1sOJBq/9gMAnClbn+SsUiQyyFAHPK4VexX03w05RBNEjDXb2CUU/88srX+ODfMl49uss6ye
	trBTaIQ7hDj3ejQ/MOSKGle4tEAHL4ky3tUreQraNGcDJT+l2mvtJDIKlNvDqWKiQEzA/soc5ehAm
	9nlzPSpg==;
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sk3iU-0000000Bi7j-0536
	for linux-um@lists.infradead.org;
	Fri, 30 Aug 2024 15:39:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=OjRIodtRv7xl6NM9Aiu0uvHXUVQZiYl6aAIuCQA1KaA=; t=1725032350; x=1726241950; 
	b=pVg3G2tg78eVOiz4QM+uPgSQw+jD3tr6BcfWmYImh7bVlTvHBcMO6Pdz70mNmryD102zFO/JkPO
	vomUoDvQR3y2UCwUrnWwN1ms3hm77/GQmVnTr/5PEpkPvJGxBCsiKCnlxzlaDt99lHLIGDDPNT8s8
	tAuBvtuBS46DOjik1H9KpZOvTqULP540QmpBP4JaPj9pMrGi1A6qxuvI3L/lvfvbVI/oRJAL6iVF0
	yxdLJoL/VMxWh6vZvOysSm/Q2IrBMfOt8OU24QrjTqiyoZ2ir4HRYA3taQFf5vov/3b5Yb28l65hm
	Iyoq3ACXk8A5lW0r48CSOTVFjWAuO53VsuFg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1sk3iM-0000000Bhhe-37qz;
	Fri, 30 Aug 2024 17:39:07 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: add RCU syscall hack for time-travel
Date: Fri, 30 Aug 2024 17:38:25 +0200
Message-ID: <20240830153825.1466691-1-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240830_163914_439997_50DB0783 
X-CRM114-Status: UNSURE (   9.44  )
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

In time-travel mode userspace can do a lot of work without any time
passing. Unfortunately, this can result in OOM situations as the RCU
core code will never be run.

Work around that by kicking the RCU using rcu_sched_clock_irq. So
behave to the RCU code as if a clock tick happened every syscall.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>

---

This patch is on top of "um: fix time-travel syscall scheduling hack"
---
 arch/um/kernel/skas/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index b09e85279d2b..4b4ab8bf8a0c 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -19,6 +19,21 @@ void handle_syscall(struct uml_pt_regs *r)
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	int syscall;
 
+	/*
+	 * This is a "bit" of a hack. But in time-travel mode userspace can do
+	 * a lot of work without any time passing. Unfortunately, this can
+	 * result in OOM situations as the RCU core code will never be run.
+	 *
+	 * Work around that by kicking the RCU using rcu_sched_clock_irq. So
+	 * behave to the RCU code as if a clock tick happened every syscall.
+	 */
+	if (time_travel_mode == TT_MODE_INFCPU ||
+	    time_travel_mode == TT_MODE_EXTERNAL) {
+		local_irq_disable();
+		rcu_sched_clock_irq(1);
+		local_irq_enable();
+	}
+
 	/* Initialize the syscall number and default return value. */
 	UPT_SYSCALL_NR(r) = PT_SYSCALL_NR(r->gp);
 	PT_REGS_SET_SYSCALL_RETURN(regs, -ENOSYS);
-- 
2.46.0


