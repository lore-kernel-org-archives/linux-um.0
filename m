Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B4C001DD
	for <linux-um@archiver.kernel.org>; Fri,  3 Nov 2023 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:In-Reply-To:References:Message-ID
	:MIME-Version:Subject:Date:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nvo52F5Oz+XqkKxCmGVEAm1/XszYpXexaW2hIwcBRUs=; b=ygqaKGas9k9z93
	tF0fZ8N4NmC/zIbDDVOBbZ+lQsW/rBhOgd3jWo8zwtaupXFEYIVd0wxdfkRKoY4TP8FPXMfeZ/49m
	3WkbmdxXn3bLrHx/z/E2f80zqCaSEVg8djRo4VgYzXv5QtS43uBK4qJC8wITsHu8acGvKDAkI/u7+
	sdZWfce9YrSdmS9T3pXJ2l/HwXz8M24QeTOSkBmg/5b3p+2K4TJBUB0hIXb1mvVau4pWd92E+ZblM
	D26QWtlRIaxpbqJ+CCnCXbv5i2kJ16ELGx3zMqlJ/TyAZMLnOTFGPOhBZy1E0rpVYHo1qpxd8Pp0b
	qUp1fD0NfjBiwjrhMH2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFa-00Bnrm-1h;
	Fri, 03 Nov 2023 16:42:26 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyxFU-00BnjT-2d
	for linux-um@lists.infradead.org;
	Fri, 03 Nov 2023 16:42:24 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 03 Nov 2023 16:42:07 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1699029727; bh=aVhHRRFi+roZCFzfRif/entxEHKD2Wu3EPB4vC2Fv2k=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 ILOxrMrrntgLUPsWYgPxEvTNzmvMMU30/uxyp75Xmlws9Pw/Y777/nRyfR+pP1ciO3cS0/kSEo0Aeif7D183Dw==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1699029727; bh=aVhHRRFi+roZCFzfRif/entxEHKD2Wu3EPB4vC2Fv2k=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 rwcldXZ3o6CHgV/Zo5FvCNMRvZXj3woC5Y6SAU41M9hl0aCvG3Oxyyb3pCuQ08VDYBN+51cR7HaXbzMsiILuQO9Gt7HKZUy9UjVcmK7UA7Vwpi1C3bd8JBV+di1QwVXzQdavWALGP8HYjGJGulJL79MSUSeUD958VMojpTCi2MM=
Received: from mininet-experimente.amd.e-technik.uni-rostock.de (139.30.201.3)
 by mail1.uni-rostock.de (139.30.22.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 3 Nov 2023 17:41:58 +0100
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Date: Fri, 3 Nov 2023 16:41:48 +0000
Subject: [PATCH RFC 10/11] um: Delay timer_read only in possible busy loops
 in TT-mode
MIME-Version: 1.0
Message-ID: <20231103-bb-timetravel-patches-v1-10-e2c68efcf664@uni-rostock.de>
References: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
In-Reply-To: <20231103-bb-timetravel-patches-v1-0-e2c68efcf664@uni-rostock.de>
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, Benjamin Beichler
	<benjamin.beichler@uni-rostock.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699029716; l=3006;
 i=benjamin.beichler@uni-rostock.de; s=20231103; h=from:subject:message-id;
 bh=U+S9ZFID575adxUoR7nXfmTvoTFGOo9vbLnuDpXNq3U=;
 b=KsPJf9v+osCd4P3+G4T2EeNtysH6oSBKFDd5ZJB3Cvhf3GdDgXXw8cC/dyFbiG8uEdYBbLypq
 6mZkrWi3097AEE292WxRPp8KzlSZ3OjY7uL/A4ZYS5IicM3x02zLb+c
X-Developer-Key: i=benjamin.beichler@uni-rostock.de; a=ed25519;
 pk=fla2/IRwqFWH5W+fACqQyDu/mTc6mEcSPQtqb/SoX8o=
X-Originating-IP: [139.30.201.3]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: DDFAF6668E80B109A175BE4BD83D2C08DC79089DF2C85FF663D492029D1D369A2000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_094221_153762_AB674213 
X-CRM114-Status: GOOD (  17.59  )
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

Some userspace programs use the current timestamp as a looping condition
(directly or indirectly), which can lead to infinite loops in TT-mode
since the timestamp doesn't change until the next time step.

Commit 065038706f77 ("um: Support time travel mode") introduced a
workaround by always inserting a time step when the current timestamp is
read. However, this introduces delays, even in cases where such a loop
doesn't exist, for example, in filesystem code that updates access
timestamps.

This slows down external TT-mode as more simulation roundtrips are
required, and it unnecessarily affects the determinism and accuracy of
the simulation.

This patch attempts to detect potential busy loops by identifying the
currently executed syscall that would return a timestamp. If 10
consecutive calls at the same timestamp occur, the timer_read is
delayed.

Since the patch does not consider the PID of the caller, it might be
fooled by legitimate processes that take a single timestamp. However,
the result is no worse than the original behavior.

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/kernel/time.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index f76237cfc1ea..1782f1ed140e 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -22,6 +22,7 @@
 #include <linux/time-internal.h>
 #include <linux/um_timetravel.h>
 #include <shared/init.h>
+#include <asm/syscall-generic.h>
 
 #ifdef CONFIG_UML_TIME_TRAVEL_SUPPORT
 enum time_travel_mode time_travel_mode;
@@ -721,6 +722,27 @@ static irqreturn_t um_timer(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static const int suspicious_busy_loop_syscalls[] = {
+	36, //sys_getitimer
+	96, //sys_gettimeofday
+	201, //sys_time
+	224, //sys_timer_gettime
+	228, //sys_clock_gettime
+	287, //sys_timerfd_gettime
+};
+
+static bool suspicious_busy_loop(void)
+{
+	int i;
+	int syscall = syscall_get_nr(current, task_pt_regs(current));
+
+	for (i = 0; i < ARRAY_SIZE(suspicious_busy_loop_syscalls); i++) {
+		if (suspicious_busy_loop_syscalls[i] == syscall)
+			return true;
+	}
+	return false;
+};
+
 static u64 timer_read(struct clocksource *cs)
 {
 	static unsigned long long last_timer_read;
@@ -742,11 +764,12 @@ static u64 timer_read(struct clocksource *cs)
 		if (last_timer_read != time_travel_time) {
 			last_timer_read = time_travel_time;
 			consecutive_calls_at_same_time = 0;
-		} else {
+		} else if (suspicious_busy_loop()) {
 			consecutive_calls_at_same_time++;
 		}
 		if (!irqs_disabled() && !in_interrupt() && !in_softirq() &&
-		    !time_travel_ext_waiting && consecutive_calls_at_same_time > 10)
+		    !time_travel_ext_waiting && consecutive_calls_at_same_time > 10 &&
+		    suspicious_busy_loop())
 			time_travel_update_time(time_travel_time +
 						TIMER_MULTIPLIER,
 						false);

-- 
2.34.1



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
