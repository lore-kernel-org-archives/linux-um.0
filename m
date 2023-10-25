Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0922CC0032E
	for <linux-um@archiver.kernel.org>; Wed, 25 Oct 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=y3bbN6Uhyf5JVRPQpyf/PmIsX5yffi8c/FtddrL0rhw=; b=JKKvuk8tQQsD/Y
	SDweqfKM5UVpfiC8uH1h38gNB6afnmz4HIWC0GEAyn8kS3I88sRisgFh6PGFVfn3bjJ55eDtAqwdo
	coXwrlWQsh3q/0oSnb/bthK9X2J4xux16h5dULnmRRPdKUpCFLZm6QUxVcE19vTtVWCU1MiTe5FYb
	mykFkhG/URQI8t7vzeelVT+CJBfw6HLEoU3gaps3hw2pCJrfQXe3FN8xuo4pUwm3X6v8TDeOvIhLk
	gDbSiagYe3Pf7Gii+NieBRdn2xD7+3138PVyVMuR+2PmjPhpC5yZvQj3Oa7l65+OVSsExg+d9TyYi
	c1RAQKpvXXfX0TPrSivg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvkd1-00D5x3-0t;
	Wed, 25 Oct 2023 20:37:23 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvkcy-00D5wg-0K
	for linux-um@lists.infradead.org;
	Wed, 25 Oct 2023 20:37:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+vGrATod5sJjARfcB9N7/Dr5znL/6KrfUMSeGAjuEG4=; t=1698266238; x=1699475838; 
	b=AIJM93Rcc1vDzJ6lPxkiEOfJ/ANIAisEiBjsjfqLToa9PsyV7moua0SoAD4VZ/PTB+LJm9xMf8Y
	8e92qG8FIuBUt+BYsyFOLVC9EeSQk9Ivp+PvNtv5eVHXqtcb1OXlU+e5G0/VIkaFOs5L4Y+9Uzxq0
	+7+2QZfqbVYG0vVq0QHuIG5aUaEqTRMey4zBRhf2Fp+3I5RbjkISBscmYxztIiBIocJTtNDKH9zbZ
	N3SFu4/pU9+lXCO44sa7rcQU+cUEkxQdGVTAtbA0RurldoBjXe89RDLtnW97N4QKMM7/1QG70ONok
	OoYVeP2ddaHJ/CbVabcJklVaOxdnFLyJ1Phg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvkcs-00000002iOj-0moi;
	Wed, 25 Oct 2023 22:37:14 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Subject: [PATCH] um: time-travel: fix time corruption
Date: Wed, 25 Oct 2023 22:37:11 +0200
Message-ID: <20231025223710.400baeaebf4d.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_133720_142306_6DB6B02F 
X-CRM114-Status: GOOD (  14.68  )
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

From: Johannes Berg <johannes.berg@intel.com>

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
---
 arch/um/kernel/time.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index 8ff46bc86d09..c549c959a030 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -46,7 +46,8 @@ static u16 time_travel_shm_id;
 static struct um_timetravel_schedshm *time_travel_shm;
 static union um_timetravel_schedshm_client *time_travel_shm_client;
 
-static void time_travel_set_time(unsigned long long ns)
+#define  time_travel_set_time(ns) _time_travel_set_time(ns, __LINE__)
+static void _time_travel_set_time(unsigned long long ns, unsigned int line)
 {
 	if (unlikely(ns < time_travel_time))
 		panic("time-travel: time goes backwards %lld -> %lld\n",
@@ -551,9 +552,29 @@ static void time_travel_update_time(unsigned long long next, bool idle)
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
 
@@ -687,7 +708,11 @@ static void time_travel_set_start(void)
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
 
@@ -839,9 +864,7 @@ static u64 timer_read(struct clocksource *cs)
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
2.41.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
