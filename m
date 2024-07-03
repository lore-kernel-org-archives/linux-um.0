Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BCBC2BD09
	for <linux-um@archiver.kernel.org>; Wed,  3 Jul 2024 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ukXTpZbw7wMtSzBnu8Z54HT6xBAyD3cNHDZonNi49L0=; b=XQfQAdsdzfH4PsIBZM4GLVjGH/
	sS5DDX2hckh6tr2fLR5ENGSvHfYGYVuYD40sLLCEdExcWfDUZYgzA7HLG3UF3YGP9z4QwFJvluLdN
	DkeImUyymj5QhQtoxo7IDNsGdPXWLcHBuAsbTfBYXfeDnAKV3NUBszFf+aFHWvR6ggwQJMNM3Wdq6
	CoTBv2vlhyaKdiYRsT1jZO41KEUypHL0oTJiPcSajQgzTFD09N84viKAte25KqFxTIQpvGTRA7s6m
	73I4b5jv4dVoqK8eBCj0dtzf+/1zNKVK6JrKtaXgtl8VltIGeIGfKCEW5vIIiiBhuehqPiBtIfj5E
	G0CmLQNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxkK-00000009whY-2Knp;
	Wed, 03 Jul 2024 11:01:56 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxkG-00000009wfz-18O0
	for linux-um@lists.infradead.org;
	Wed, 03 Jul 2024 11:01:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=ukXTpZbw7wMtSzBnu8Z54HT6xBAyD3cNHDZonNi49L0=; t=1720004512; x=1721214112; 
	b=OZOpsEL6mPjBwQs8AHj9Xy8aSNQ0ZA9ACHhhz3ySc3rIGbk8o9it1Rjc6jiGXzr/o2w1W2SCEIN
	6645qINi47pgeI+NRDiWqSHYOfrZNvETF4hmVDPzHcLs5JXuaTiCrI076m85NVPgSKiFqM2DERpS3
	rWWZdcafuGHH7LkAyJ9q32fuxtEVXWGKKprFITQRwbq57iGPHZEaWE9AOHz5ePCD34Phd0XBfo7WH
	0JO6TWb7H2fIPk0yVaz4Xw1z49tyLarL6Spbcry3eSdwvGkLlGDwtl7Bifg/HsL63fwfsR5s0ZPx2
	UHgzm7nQhSCbnfCN/w3XaGvWMSqYeq8rQztQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sOxkD-00000008hvi-1Cfj;
	Wed, 03 Jul 2024 13:01:49 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] um: time-travel: fix signal blocking race/hang
Date: Wed,  3 Jul 2024 13:01:45 +0200
Message-ID: <20240703110144.28034-2-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_040152_513396_019FA33E 
X-CRM114-Status: GOOD (  32.52  )
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

When signals are hard-blocked in order to do time-travel
socket processing, we set signals_blocked and then handle
SIGIO signals by setting the SIGIO bit in signals_pending.
When unblocking, we first set signals_blocked to 0, and
then handle all pending signals. We have to set it first,
so that we can again properly block/unblock inside the
unblock, if the time-travel handlers need to be processed.

Unfortunately, this is racy. We can get into this situation:

// signals_pending = SIGIO_MASK

unblock_signals_hard()
   signals_blocked = 0;
   if (signals_pending && signals_enabled) {
     block_signals();
     unblock_signals()
       ...
       sig_handler_common(SIGIO, NULL, NULL);
         sigio_handler()
           ...
           sigio_reg_handler()
             irq_do_timetravel_handler()
               reg->timetravel_handler() ==
               vu_req_interrupt_comm_handler()
                 vu_req_read_message()
                   vhost_user_recv_req()
                     vhost_user_recv()
                       vhost_user_recv_header()
                         // reads 12 bytes header of
                         // 20 bytes message
<-- receive SIGIO here <--
sig_handler()
   int enabled = signals_enabled; // 1
   if ((signals_blocked || !enabled) && (sig == SIGIO)) {
     if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
       sigio_run_timetravel_handlers()
         _sigio_handler()
           sigio_reg_handler()
             ... as above ...
               vhost_user_recv_header()
                 // reads 8 bytes that were message payload
                 // as if it were header - but aborts since
                 // it then gets -EAGAIN
...
--> end signal handler -->
                       // continue in vhost_user_recv()
                       // full_read() for 8 bytes payload busy loops
                       // entire process hangs here

Conceptually, to fix this, we need to ensure that the
signal handler cannot run while we hard-unblock signals.
The thing that makes this more complex is that we can be
doing hard-block/unblock while unblocking. Introduce a
new signals_blocked_pending variable that we can keep at
non-zero as long as pending signals are being processed,
then we only need to ensure it's decremented safely and
the signal handler will only increment it if it's already
non-zero (or signals_blocked is set, of course.)

Note also that only the outermost call to hard-unblock is
allowed to decrement signals_blocked_pending, since it
could otherwise reach zero in an inner call, and leave
the same race happening if the timetravel_handler loops,
but that's basically required of it.

Fixes: d6b399a0e02a ("um: time-travel/signals: fix ndelay() in interrupt")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: use __atomic_*() primitives, and do so consistently
---
 arch/um/os-Linux/signal.c | 118 +++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 20 deletions(-)

diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 787cfb9a0308..b11ed66c8bb0 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -8,6 +8,7 @@
 
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdbool.h>
 #include <errno.h>
 #include <signal.h>
 #include <string.h>
@@ -65,9 +66,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 
 int signals_enabled;
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
-static int signals_blocked;
-#else
-#define signals_blocked 0
+static int signals_blocked, signals_blocked_pending;
 #endif
 static unsigned int signals_pending;
 static unsigned int signals_active = 0;
@@ -76,14 +75,27 @@ static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
 	int enabled = signals_enabled;
 
-	if ((signals_blocked || !enabled) && (sig == SIGIO)) {
+#ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
+	if ((signals_blocked ||
+	     __atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) &&
+	    (sig == SIGIO)) {
+		/* increment so unblock will do another round */
+		__atomic_add_fetch(&signals_blocked_pending, 1,
+				   __ATOMIC_SEQ_CST);
+		return;
+	}
+#endif
+
+	if (!enabled && (sig == SIGIO)) {
 		/*
 		 * In TT_MODE_EXTERNAL, need to still call time-travel
-		 * handlers unless signals are also blocked for the
-		 * external time message processing. This will mark
-		 * signals_pending by itself (only if necessary.)
+		 * handlers. This will mark signals_pending by itself
+		 * (only if necessary.)
+		 * Note we won't get here if signals are hard-blocked
+		 * (which is handled above), in that case the hard-
+		 * unblock will handle things.
 		 */
-		if (!signals_blocked && time_travel_mode == TT_MODE_EXTERNAL)
+		if (time_travel_mode == TT_MODE_EXTERNAL)
 			sigio_run_timetravel_handlers();
 		else
 			signals_pending |= SIGIO_MASK;
@@ -380,33 +392,99 @@ int um_set_signals_trace(int enable)
 #ifdef UML_CONFIG_UML_TIME_TRAVEL_SUPPORT
 void mark_sigio_pending(void)
 {
+	/*
+	 * It would seem that this should be atomic so
+	 * it isn't a read-modify-write with a signal
+	 * that could happen in the middle, losing the
+	 * value set by the signal.
+	 *
+	 * However, this function is only called when in
+	 * time-travel=ext simulation mode, in which case
+	 * the only signal ever pending is SIGIO, which
+	 * is blocked while this can be called, and the
+	 * timer signal (SIGALRM) cannot happen.
+	 */
 	signals_pending |= SIGIO_MASK;
 }
 
 void block_signals_hard(void)
 {
-	if (signals_blocked)
-		return;
-	signals_blocked = 1;
+	signals_blocked++;
 	barrier();
 }
 
 void unblock_signals_hard(void)
 {
+	static bool unblocking;
+
 	if (!signals_blocked)
+		panic("unblocking signals while not blocked");
+
+	if (--signals_blocked)
 		return;
-	/* Must be set to 0 before we check the pending bits etc. */
-	signals_blocked = 0;
+	/*
+	 * Must be set to 0 before we check pending so the
+	 * SIGIO handler will run as normal unless we're still
+	 * going to process signals_blocked_pending.
+	 */
 	barrier();
 
-	if (signals_pending && signals_enabled) {
-		/* this is a bit inefficient, but that's not really important */
-		block_signals();
-		unblock_signals();
-	} else if (signals_pending & SIGIO_MASK) {
-		/* we need to run time-travel handlers even if not enabled */
-		sigio_run_timetravel_handlers();
+	/*
+	 * Note that block_signals_hard()/unblock_signals_hard() can be called
+	 * within the unblock_signals()/sigio_run_timetravel_handlers() below.
+	 * This would still be prone to race conditions since it's actually a
+	 * call _within_ e.g. vu_req_read_message(), where we observed this
+	 * issue, which loops. Thus, if the inner call handles the recorded
+	 * pending signals, we can get out of the inner call with the real
+	 * signal hander no longer blocked, and still have a race. Thus don't
+	 * handle unblocking in the inner call, if it happens, but only in
+	 * the outermost call - 'unblocking' serves as an ownership for the
+	 * signals_blocked_pending decrement.
+	 */
+	if (unblocking)
+		return;
+	unblocking = true;
+
+	while (__atomic_load_n(&signals_blocked_pending, __ATOMIC_SEQ_CST)) {
+		if (signals_enabled) {
+			/* signals are enabled so we can touch this */
+			signals_pending |= SIGIO_MASK;
+			/*
+			 * this is a bit inefficient, but that's
+			 * not really important
+			 */
+			block_signals();
+			unblock_signals();
+		} else {
+			/*
+			 * we need to run time-travel handlers even
+			 * if not enabled
+			 */
+			sigio_run_timetravel_handlers();
+		}
+
+		/*
+		 * The decrement of signals_blocked_pending must be atomic so
+		 * that the signal handler will either happen before or after
+		 * the decrement, not during a read-modify-write:
+		 *  - If it happens before, it can increment it and we'll
+		 *    decrement it and do another round in the loop.
+		 *  - If it happens after it'll see 0 for both signals_blocked
+		 *    and signals_blocked_pending and thus run the handler as
+		 *    usual (subject to signals_enabled, but that's unrelated.)
+		 *
+		 * Note that a call to unblock_signals_hard() within the calls
+		 * to unblock_signals() or sigio_run_timetravel_handlers() above
+		 * will do nothing due to the 'unblocking' state, so this cannot
+		 * underflow as the only one decrementing will be the outermost
+		 * one.
+		 */
+		if (__atomic_sub_fetch(&signals_blocked_pending, 1,
+				       __ATOMIC_SEQ_CST) < 0)
+			panic("signals_blocked_pending underflow");
 	}
+
+	unblocking = false;
 }
 #endif
 
-- 
2.45.2


