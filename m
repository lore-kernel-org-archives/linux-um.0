Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F44BC71136
	for <linux-um@archiver.kernel.org>; Tue, 17 Jun 2025 14:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p2KqeKdW8sHhhAuKR11sOYDRX7INggsdzTxSiKJAp4M=; b=X6xXHon4rdrSJXanlkhhQykaOm
	nqkIczZeLAeDJFJUebHQi1fHiv3j27Szqj/Xy2VgYDh6SaSJf9KfX3WbFJzeBTkoAFgPaPoKqO/pt
	NkpBGUSs9kkl5olHyWLHHCHlq9XH4JkVII7gLfchE0qEifNTwX/iVdcHEFQeWkWiCrJ0GTMIGxDDv
	iX2HL0b6oCvP4ygyr1ImCdkNK9+2iFLquzILlPlnLSe/pU4WbF8zxC5oKK6JNdRUkIGiSuaVZTNuB
	+oUZYILFZEJVYYdabtCEuMRd5p9ldiqeIMX8ldVlHhM4AuhJ0Lzk1/P99MqI0s2piLIwx9Mf3ojmc
	uIP6n6/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRXJh-00000007Ynl-2Hi1;
	Tue, 17 Jun 2025 14:29:37 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRWkh-00000007R0z-10bg
	for linux-um@lists.infradead.org;
	Tue, 17 Jun 2025 13:53:28 +0000
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750168405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2KqeKdW8sHhhAuKR11sOYDRX7INggsdzTxSiKJAp4M=;
	b=Y/Op96qo4L8mSSNDtUcrmyw9IgJJt9/kUr82j104rxQ1pj1zDkXRbmISbiOssBfwBCuP5B
	dLK34sF/Dpla8W0FjYQV8blY24vGqGLDyEK3JirD+HTyfYputYXKI+CVra01qXY8V3kubG
	vAUkAICHyhBEtWWT7a0oWI0v0hDmi6iFnw9J+fv8i3y/fPZlr6gYmx76SAJrCwyWbjEuWA
	v1vNzPZfEg86DTvKkv5JHkoVeb/7/99aIjqVh3y1uREwFteNXe0IStC5MAGgqxJaRbmJmx
	//cxkGK856Z3f+XbBoVhuBakiSi50EWINyTv7QKiAP/BuOJK5EoBoP5bbNafew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750168405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p2KqeKdW8sHhhAuKR11sOYDRX7INggsdzTxSiKJAp4M=;
	b=nptp+fnKV7IzXmT8I5LxyAkorgyjHrQ0ozB3DE65mPtC50FeApxzyT/dCVv0zZqQvn+Vwq
	q17yc5BAmRUjflBg==
Date: Tue, 17 Jun 2025 15:52:55 +0200
Subject: [PATCH RFC] um: time: fix userspace detection during tick
 accounting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-uml-tick-timer-v1-1-01aab312f56b@linutronix.de>
X-B4-Tracking: v=1; b=H4sIADZzUWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0Nz3dLcHN2SzORsIJGbWqRrYZSaaGFpYmmanGymBNRUUJSallkBNjB
 aKcjNWSm2thYABqP4x2UAAAA=
X-Change-ID: 20250617-uml-tick-timer-82ea89495cc6
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Thomas Meyer <thomas@m3y3r.de>, Anton Ivanov <aivanov@brocade.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750168402; l=2406;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=NZKg4wa8vVf4B62e57Cic7zPSKwig91Ih3EmxJQLJBc=;
 b=fgLn2APrjZIegFKZhsjPGBR/Ns+aqzryNNZOjmlLlkX2tzCKF6NJkw62zHLmGYAJfU/Rw7Xeh
 1JDtQSn4TIzDPZUbXSpGDAiVNf5JQYHsrAebCOWJjnt7EKmCdtI7mDZ
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_065327_421376_4885A332 
X-CRM114-Status: GOOD (  11.28  )
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

The cpu usage timekeeping triggered by the tick credits passed time to
either the kernel or the currently running userspace process.
On UML, tick interrupts firing while userspace is running are not marked
correctly so this bookkeeping is broken and always credits the idle task.

The rootcause is the following callchain always passing user_tick=false
to account_process_tick():

um_timer()
  -> handle_irq_event()
    -> tick_handle_periodic()
      -> tick_periodic()
        -> update_process_times(user_tick=user_mode(get_irq_regs()))
          -> account_process_tick(task, user_tick=false)

As a result CPUCLOCK_VIRT does not advance,
breaking for example signal(SIGVTALRM).

The issue can be reproduced easily with the selftest
tools/testing/selftests/timers/posix_timers.c,
which hangs in the ITIMER_VIRTUAL/SIGVTALRM testcase.

Fix up the IRQ regs by correctly setting is_user in the IRQ registers.

Fixes: 2eb5f31bc4ea ("um: Switch clocksource to hrtimers")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
I'm not familiar with UML, so this is probably not the right fix.
Feel free to treat it as a bugreport instead.
---
 arch/um/kernel/time.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index ae0fa2173778f43273fd0550f77fc99bbb1c3e3a..a6c17302403aeb3170a1104117c4e713e3afdfe0 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -856,6 +856,7 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
+	struct pt_regs *regs;
 	/*
 	 * Interrupt the (possibly) running userspace process, technically this
 	 * should only happen if userspace is currently executing.
@@ -864,9 +865,13 @@ static irqreturn_t um_timer(int irq, void *dev)
 	 */
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL &&
-	    get_current()->mm)
+	    get_current()->mm) {
 		os_alarm_process(get_current()->mm->context.id.pid);
 
+		regs = get_irq_regs();
+		regs->regs.is_user = true;
+	}
+
 	(*timer_clockevent.event_handler)(&timer_clockevent);
 
 	return IRQ_HANDLED;

---
base-commit: 9afe652958c3ee88f24df1e4a97f298afce89407
change-id: 20250617-uml-tick-timer-82ea89495cc6

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


