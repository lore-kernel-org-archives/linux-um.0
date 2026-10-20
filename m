Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF36B606A319
	for <linux-um@archiver.kernel.org>; Tue, 20 Oct 2026 12:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ar5TyKWE;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q7vsOyAo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fOTN+1G5bcALtV3YwJr8MvsYqE87M4d/ceb1/BsYP3o=; b=Ar5TyKWEHgSM69BkL0u4Eb4/dk
	l11sIyorpVyR+KDfG15EkAq0PAkiXTcif3rPVhE5KipQNtDtZk2G1lzitQy1pgXi3q2WG44oZp4nT
	MXGYiUVoC5sCPjvdFF7u09heq4k35+Pze/ORvWxR5NoIMfXPZR1YVajm+CNgxp/Mg0uDUz1w3zVWs
	FiEc2KZtIzMnow3lNwqVizy3zywB8pdpINZbPiDBFCRHigMF8pNH0jDuaCBdnzvJFd1pQZ1IXSmGj
	0TDi47gSpImDj9bTrByZZx4h+2C6WHQbi+U3krffMpgqpCERAd763KQgfv0hlPPKb704eiShQwWya
	csKudODg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8WQ-00000009cir-3xlA;
	Tue, 20 Oct 2026 12:00:50 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJ8WO-00000009ciC-1Imf
	for linux-um@lists.infradead.org;
	Tue, 20 Oct 2026 12:00:49 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2e946155442so24956155ad.3
        for <linux-um@lists.infradead.org>; Tue, 20 Oct 2026 05:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792497647; x=1793102447; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fOTN+1G5bcALtV3YwJr8MvsYqE87M4d/ceb1/BsYP3o=;
        b=Q7vsOyAorKP208/0AQYaFYnLG4sI18tgXhHdao5AojNtjwrjpO6SyMqhrfBmwl0fpE
         zuMZkUOp9YLzBsDd94XibU3Ulo4Ub19tO1487eY3J9Ls4PgwJbzgQc5DxR1Ylpj8vQMr
         r0lWhpWRN5IGZL+adIuLuZlgz6mwikKw92gAfozNMf6YLchyloLFi66hygds1NC40BWh
         RxqFffkVYJwyKkbOz7a06mnYFc1dv1qEGuvj4IZfRt1auOR/Zw35FcK8CKrpCRvLkBUz
         gMPny1KFQpzidDhbFd5wRls1lc+1EjOK6i9oLZbY+WR3UScHDMbd4vwf82mgbcXJMjfb
         VfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792497647; x=1793102447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fOTN+1G5bcALtV3YwJr8MvsYqE87M4d/ceb1/BsYP3o=;
        b=eMd3gX6905JVzuXUGJUhl06Yd7+A68gmrpxlOC2uSDWlY8NEPhNP7bxtzsN9al68up
         QaJF8j0C4lYOEMC9nrqqjfzOqG5DXiNyRDRKPxv5j7KQvp8I4XyzgcwV3S3bXGkYLTeZ
         vX6OBYOYvJZK7jocMsgr1wh43HWhGpU7Rrqk1ebk3D28wJ9rzUeSoIR6TaGRIt6BvO5B
         xMwTJPrOUyfVzjRAhhPCGvOGCq3NIs2P5MkHV1X2PM3OAk2QRe37V3sa4oJQbFYMLAmo
         gpWPUz2mksFiQg54KInroMixO0Ap+otPr6avQ3bJBe2Y11baH5ghLfZcDCxHIV183f6s
         668Q==
X-Gm-Message-State: AFq9FYIycj1Cn6DULXS3/Gi3caNVSjcYg83CdjnhZ6s5zPd7mmE9GhuM
	gsYwcRkFYDJ9otEP4yOEVAiUhRoN6UWjxBCUX86u8dMlyrWawT8OfKtjY0ypIw==
X-Gm-Gg: AYBFou0nM/hui0wLLPl7DeY7hukdqzLlNoIg3XG3QD91wXIH1G5ejBk2Z0jfohKEBp5
	tWMVSC/fZzO3Qu5ADwxyqOOQ4/q7HzCMNJi93nly+o5zEvNPyWOHS8QEFa1BLu1O/GmuL1GnszH
	+3Xbisd6zLqQVfkeneC9le471XfU1O5fjDgdiDdfsREoanksfIba6AuKyhQqZLRglsvbAsWvXie
	zlLY21OryBP4il7D0nktLAoTkLMndqmV6S0Y/EEXA/iCWeJ1Gc0FGjkDS/WJHe+NYrcwYXpLM8r
	mbuBRISkdR7t8r/DaI2s0E5ReSwAKfP1gDHBXxPjMvSJjv1jZ5UYYDLbfmhjjaiAv/LMgaWB+80
	uBVcTP7WdeSseM2IdeilKBy5DYIh7Z6qjrlajdVLgYK7rdpFljHPhE9nFSx4jXFnasGhFSE81NR
	sA0Q81WhsSRZwzgHqM4PDvCjeCEZg9HcumCz0NB9fd8ELGj5Ii6JM4/eL7OgQzE0ZhqrioUDwHg
	Fid0Y86IP8+VBfuSggkOJwtWyrAukaIfKkQQCgDm7Cv66+AfV7I+ngQykbEoA0jooqk5Xo9xe3T
	B4GIxWS37EYF9bwkzrNVq6Jpt3nvGUN0fLipGCzfwMHBMTuWK38ZzzHvmzWSVkydXJ5aw5OQ
X-Received: by 2002:a17:903:298d:b0:2e8:8637:5e3 with SMTP id d9443c01a7336-2e9a6e42866mr89615945ad.34.1792497646697;
        Tue, 20 Oct 2026 05:00:46 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea145b5dabsm11436705ad.9.2026.10.20.05.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:00:45 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5BA33188920B; Tue, 20 Oct 2026 21:00:44 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: Hajime Tazaki <thehajime@gmail.com>
Subject: [PATCH] um: time-travel: account for coalesced timer expirations
Date: Tue, 20 Oct 2026 21:00:42 +0900
Message-ID: <20261020120042.3158680-1-thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_050048_400404_5790D155 
X-CRM114-Status: GOOD (  19.50  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

BASIC time-travel mode uses a host POSIX timer to limit guest CPU
execution to real CPU speed. Each SIGALRM advances the time-travel clock
before the timer IRQ is delivered. Since SIGALRM is a standard signal,
multiple expirations are not queued. If signal handling is delayed, the
timer handler accounts for only one expiration and guest CLOCK_MONOTONIC
falls behind host time. Time-based tests can then exceed their requested
runtime or hit an external timeout.

LTP's inotify09 triggers this with two synchronized loops: verify_inotify()
repeatedly adds and removes an inotify watch while the write_seek() worker
writes to and rewinds the same file. The fuzzy-sync loops keep the guest
busy during the test's 150-second runtime, delaying timer handling and
allowing expirations to coalesce.

This commit fixes BASIC mode's guest clock falling behind when host timer
expirations are coalesced with timer_getoverrun() and the periodic timer
event's expiry. The cached variable time_travel_next_event holds the
earliest generic event, which may differ from the expiry associated with
SIGALRM.
Clamp the result to the current guest time to prevent it from moving
backwards.

Without the clamp, a delayed SIGALRM could move guest time backwards.
During NOMMU TT boot, mkdir triggered this panic:

 Kernel panic - not syncing: time-travel: time goes backwards 275440000454 -> 275440000443
 CPU: 0 UID: 0 PID: 31 Comm: mkdir Not tainted 7.3.0-rc4-g8fbb61d9e37d-dirty #1 VOLUNTARY 
 Stack:
  00000000 00000000 00000001 607d92a1
  60030d6d 706d7960 706d72b0 6003cd40
  60846af0 00000000 6097b2e0 706d7338
 Call Trace:
  [<60030d6d>] ? freeze_kernel_threads+0x9d/0x9d
  [<60040229>] show_stack+0x10e/0x11a
  [<60030d6d>] ? freeze_kernel_threads+0x9d/0x9d
  [<6003cd40>] dump_stack_lvl+0x63/0x7e
  [<6003cd79>] dump_stack+0x1e/0x20
  [<6002f62a>] vpanic+0x123/0x33f
  [<6002f88d>] panic+0x47/0x47
  [<6002f846>] ? vpanic+0x33f/0x33f
  [<60040287>] time_travel_set_time+0x35/0x61
  [<600416a8>] timer_handler+0x43/0xc1
  [<60052fe6>] timer_real_alarm_handler+0x53/0x5e
  [<6003ff6e>] ? um_trace_signals_on+0x5/0x5
  [<600530cd>] unblock_signals.part.0+0xdc/0x12a
  [<603a4250>] ? blkg_destroy+0xe5/0xe5
  [<603a44d4>] ? bio_associate_blkg+0x84/0x8e
  [<6043cfeb>] ? sbitmap_find_bit+0xb8/0x147
  [<60040790>] ? arch_local_irq_save+0x26/0x2d
  [<60040fef>] ? time_travel_del_event+0x54/0x5c

Link: https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/inotify/inotify09.c
Fixes: 4b786e24ca80 ("um: time-travel: Rewrite as an event scheduler")
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 arch/um/include/shared/os.h |  1 +
 arch/um/kernel/time.c       | 21 ++++++++++++++++++---
 arch/um/os-Linux/time.c     |  5 +++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 0067c5208c4c..638dfd59c7d0 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -279,6 +279,7 @@ extern void os_idle_sleep(void);
 extern int os_timer_create(void);
 extern int os_timer_set_interval(int cpu, unsigned long long nsecs);
 extern int os_timer_one_shot(int cpu, unsigned long long nsecs);
+extern int os_timer_get_overrun(int cpu);
 extern void os_timer_disable(int cpu);
 extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index d620b6d6310a..046e21713e06 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -38,7 +38,6 @@ static unsigned long long time_travel_shm_offset;
 static LIST_HEAD(time_travel_events);
 static LIST_HEAD(time_travel_irqs);
 static unsigned long long time_travel_timer_interval;
-static unsigned long long time_travel_next_event;
 static struct time_travel_event time_travel_timer_event;
 static int time_travel_ext_fd = -1;
 static unsigned int time_travel_ext_waiting;
@@ -432,7 +431,6 @@ static void __time_travel_add_event(struct time_travel_event *e,
 
 	tmp = time_travel_first_event();
 	time_travel_ext_update_request(tmp->time);
-	time_travel_next_event = tmp->time;
 	local_irq_restore(flags);
 }
 
@@ -649,7 +647,24 @@ void time_travel_sleep(void)
 
 static void time_travel_handle_real_alarm(void)
 {
-	time_travel_set_time(time_travel_next_event);
+	unsigned long long event_time = time_travel_timer_event.time;
+	int overrun = 0;
+
+	if (time_travel_timer_event.fn == time_travel_periodic_timer)
+		overrun = os_timer_get_overrun(raw_smp_processor_id());
+
+	/* SIGALRM is not queued, so account for coalesced timer expirations. */
+	if (overrun > 0)
+		event_time += overrun * time_travel_timer_interval;
+
+	/*
+	 * A clock read may have advanced BASIC mode beyond the event while the
+	 * signal was blocked.  Never move the time-travel clock backwards.
+	 */
+	if (event_time < time_travel_time)
+		event_time = time_travel_time;
+
+	time_travel_set_time(event_time);
 
 	time_travel_del_event(&time_travel_timer_event);
 
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 13ebc86918d4..ecd6e5e183fe 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -88,6 +88,11 @@ int os_timer_one_shot(int cpu, unsigned long long nsecs)
 	return 0;
 }
 
+int os_timer_get_overrun(int cpu)
+{
+	return timer_getoverrun(event_high_res_timer[cpu]);
+}
+
 /**
  * os_timer_disable() - disable the posix (interval) timer
  * @cpu: the CPU for which the timer is to be disabled

