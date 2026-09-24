Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6767C9830E
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 13:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LXhkZx3qXSt4RIcWqOXHXDpBVY2//E53keeVSQmDCeo=; b=G4Pz5yqC3u5+hg2EhHgrVguiMU
	9nJfoLibr1rCSM7ExDYYTBmp6+HofA/b6TvWQ43rADmxCN9DyKYX0NVUjJ0Bfx9X8d6TVL69chW5k
	cK/za9eaYl/rauqFIdO8oX53idA9Q8v437VhPo5lvX9fYAXZjtbd8X71cjBgYJPmTlGZnhbhN6c67
	Yk1k23Sga1OIy6sdu0KVQ7jWDNQEXZARhF3dnzCuDVUG4lxUWuYzs7UQWJS6UmGW+OFjss0afMztt
	SeQkuOxKCWzqWs5RTo6uutlt/Qr9X1shQW7/3/Obeuxw3uW94B80m2sPqg1JCqkgjnuKj8Gg2vyJm
	GI/Pga+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9jic-0000000B7P2-06TD;
	Thu, 24 Sep 2026 13:42:34 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9jiZ-0000000B7O3-3ZCl
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 13:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=LXhkZx3qXSt4RIcWqOXHXDpBVY2//E53keeVSQmDCeo=; t=1790257351; x=1791466951; 
	b=ecw7efgteo5CYJb4opN7gfcFyePHmUYxeh9pLzM8fblhf7u3diz4vayS1fvC1RTsiM64dyu63yU
	+thvEhkgoAi+/xEVuf+Pa2xAxRSoucXtkeZBBS+Mevp+FUeAzMgKr793ltcUu8547f2kdAwx+/vEG
	002EH05jEqzAGhVo9jK5SEsMNxMxD9+bz8agDufqI5AcAmYPPd5sEehSHSbnXrfZHr7Aw2/DoZkdq
	u4WaMYIi81wmnhN8bszkJIXUoWvLNaC+l0VhEfM7vAs5rvnsmlo8e8bv96oL8/tppTUC41m+FJSTd
	ERbD1Ho5GwQBjpL81T79h9OnzZqaknDjO1Eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__ECDSA_SECP256R1_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1x9jiU-000000094dy-2eOF;
	Thu, 24 Sep 2026 15:42:26 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] um: time-travel: fix sched_yield() behaviour
Date: Thu, 24 Sep 2026 15:42:24 +0200
Message-ID: <20260924134223.1672004-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_064231_889542_7D320E6B 
X-CRM114-Status: GOOD (  12.27  )
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

From: Johannes Berg <johannes.berg@intel.com>

Just incrementing tt_extra_sched_jiffies can make this
drift enough to hit the softlockup detector, e.g. with
ping using sched_yield() in a loop to measure short
intervals. Make the simulation actually pass time, this
requires going to the external scheduler but actually
makes this sort of thing behave much better and avoids
the soft lockup.

Fixes: 887c5c12e80c ("um: work around sched_yield not yielding in time-travel mode")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/kernel/skas/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index bc117733e8ef..914b90af42ed 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -35,12 +35,13 @@ void handle_syscall(struct uml_pt_regs *r)
 	/*
 	 * If no time passes, then sched_yield may not actually yield, causing
 	 * broken spinlock implementations in userspace (ASAN) to hang for long
-	 * periods of time.
+	 * periods of time. Advance the time-travel clock a bit so sched_yield()
+	 * in a loop (like ping does for small intervals) also works correctly.
 	 */
 	if ((time_travel_mode == TT_MODE_INFCPU ||
 	     time_travel_mode == TT_MODE_EXTERNAL) &&
 	    syscall == __NR_sched_yield)
-		tt_extra_sched_jiffies += 1;
+		time_travel_ndelay(1000);
 
 	if (syscall >= 0 && syscall < __NR_syscalls) {
 		unsigned long ret;
-- 
2.55.0


