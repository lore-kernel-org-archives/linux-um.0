Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74929C47422
	for <linux-um@archiver.kernel.org>; Wed, 24 Jan 2024 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tU4Z4t/2NS4caT3RGgWYDQgyBGqG98yW2kj9Gr7ff08=; b=NOa5kM9zuDAGMmJ/d9bxx75TT/
	S4AMF5AmzRaWSUOIMvQdbUZtkqqSl+lJf3BKJaItrxk++dho0Z1di3h/32+YQ3exOq+SeTevcDREN
	KaVUVZgRT06pHRzKScvtxSBrEOH05Dmq4o9gzUfYSqsIUIOWLhpNfFNg3+hZTaXlCRLBj2X3mJxYd
	fMLNg4KmeeK/A3IP3EE7M1fR+z20L2dRK4/hViPVhdU7jlXMWHO2povjcZypcTlh+FAREEAhCQO40
	ttU1sgD7tn1aOQkxuvBMIEy+dFyQNgdRoPReGvzET8dMLl7aGbsdvlHZynGc22urmTKgjBmVGRkKP
	2foCeSwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeH6-003gJd-35;
	Wed, 24 Jan 2024 14:30:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSeH4-003gIL-1L
	for linux-um@lists.infradead.org;
	Wed, 24 Jan 2024 14:30:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D6DFE61D72;
	Wed, 24 Jan 2024 14:30:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25F7C433C7;
	Wed, 24 Jan 2024 14:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706106641;
	bh=0HoOYdpY7mCqkF6yX9oqUlAHYhcdLh1Mqx9QVhuN/ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gI/1pZ6Jw1+6+8ZEDraUy+obWC1dm6ZL8an85f28LrbInsklXcwLXz9tWQuu/jv8x
	 cxm3dKF4UBRVqU3uq/lAfFfQOfVlkLvpVlM+fRX0exHQm4wJQH/RGoJ1DNdekZTjJW
	 FvfITnYKFIoJnwO9jKynTIUwPoRzmPwzZLQsv0R9UlJzq7lfxLz7A9GeQ4/wwM7f4q
	 fq3vC+RLEZHMCaX4JcnaJosioA6CQu2HwTM+xu2gyuMT9+WiN94pYobKFttYb8PDQp
	 1qiSx/rUVcpAwGjxNVIIz5Sz1+DjBuz9cHUvUixb2XYdQhkur3EGocRpBl10Kgoear
	 zfvAIJUlPE1mQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Vincent Whitchurch <Vincent.Whitchurch@axis.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 5/9] um: time-travel: fix time corruption
Date: Wed, 24 Jan 2024 09:30:08 -0500
Message-ID: <20240124143024.1284046-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124143024.1284046-1-sashal@kernel.org>
References: <20240124143024.1284046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_063042_542477_57548CFF 
X-CRM114-Status: GOOD (  14.97  )
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

[ Upstream commit abe4eaa8618bb36c2b33e9cdde0499296a23448c ]

In 'basic' time-travel mode (without =inf-cpu or =ext), we
still get timer interrupts. These can happen at arbitrary
points in time, i.e. while in timer_read(), which pushes
time forward just a little bit. Then, if we happen to get
the interrupt after calculating the new time to push to,
but before actually finishing that, the interrupt will set
the time to a value that's incompatible with the forward,
and we'll crash because time goes backwards when we do the
forwarding.

Fix this by reading the time_travel_time, calculating the
adjustment, and doing the adjustment all with interrupts
disabled.

Reported-by: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/kernel/time.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index fddd1dec27e6..3e270da6b6f6 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -432,9 +432,29 @@ static void time_travel_update_time(unsigned long long next, bool idle)
 	time_travel_del_event(&ne);
 }
 
+static void time_travel_update_time_rel(unsigned long long offs)
+{
+	unsigned long flags;
+
+	/*
+	 * Disable interrupts before calculating the new time so
+	 * that a real timer interrupt (signal) can't happen at
+	 * a bad time e.g. after we read time_travel_time but
+	 * before we've completed updating the time.
+	 */
+	local_irq_save(flags);
+	time_travel_update_time(time_travel_time + offs, false);
+	local_irq_restore(flags);
+}
+
 void time_travel_ndelay(unsigned long nsec)
 {
-	time_travel_update_time(time_travel_time + nsec, false);
+	/*
+	 * Not strictly needed to use _rel() version since this is
+	 * only used in INFCPU/EXT modes, but it doesn't hurt and
+	 * is more readable too.
+	 */
+	time_travel_update_time_rel(nsec);
 }
 EXPORT_SYMBOL(time_travel_ndelay);
 
@@ -568,7 +588,11 @@ static void time_travel_set_start(void)
 #define time_travel_time 0
 #define time_travel_ext_waiting 0
 
-static inline void time_travel_update_time(unsigned long long ns, bool retearly)
+static inline void time_travel_update_time(unsigned long long ns, bool idle)
+{
+}
+
+static inline void time_travel_update_time_rel(unsigned long long offs)
 {
 }
 
@@ -720,9 +744,7 @@ static u64 timer_read(struct clocksource *cs)
 		 */
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
 		    !time_travel_ext_waiting)
-			time_travel_update_time(time_travel_time +
-						TIMER_MULTIPLIER,
-						false);
+			time_travel_update_time_rel(TIMER_MULTIPLIER);
 		return time_travel_time / TIMER_MULTIPLIER;
 	}
 
-- 
2.43.0


