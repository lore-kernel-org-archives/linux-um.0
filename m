Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274FE8FDD8
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTPebJjNeKwkChbLQ9kmEHnfHiLVqL0OXrUmcfcwYxQ=; b=1G+g7V6mHzThn9GiI8ehUsathr
	/SDpLB94Td1VQWqP1MIQHZsH1P62gpgARV8VgHD2+pPxx6wAnTaVen0vP5FAZY0h/TIq3/GLgpzjX
	rT7+yKHLmpEhH6AcGK8rsU7UVlhsp8dX7pPChAuu8AnN8aGKf6kqC2owiINaPBOF3wC8C5P7mBb3c
	qtNY8DgZcgXfNVmh7vJvb68S/7m6UW6Zn+SThwOrA7EN6sEh1AanqmAZJ2YSjfojYQKE7aygH7AHR
	qUPsOy9B3rZIpT8pr8r+0HhowvzuCbVFvheGX+a0U+2Mea781PzX8JX8H0mn5YkViL6gZ2kY3p4mj
	JvNnXnVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTEW-00000001vWq-29MN;
	Sat, 27 Dec 2025 12:17:20 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTES-00000001vU4-3wPT
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:17:19 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59143315e9.2
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837835; x=1767442635; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uTPebJjNeKwkChbLQ9kmEHnfHiLVqL0OXrUmcfcwYxQ=;
        b=XWKvXps/+ZHxYZ9b2SagNAG0YEC3KKr4mxS/W1nQVaempb20VMWEkOTQgFx8JKQMkF
         OHxN/jV5lGhFJKK0wsJfCAG6+pMuarwt4vr+3myE8nIcrkiRrJ5upUOoktFAqx4rxbuY
         sfQDv440nPQrctFmqv/bGkRHnGWLSEDOKZzCB2EtL3UsDy/z2/5KLpXQ4M6Mf7uX5iAK
         SNXqCwl50PTK5O5HzHyi1PMjRjpuXhx0CMEsthDdbatlCHMj7DNbkLEv5MpFdj6HThSE
         yVxPkSab6Hp2Drsnl/Ye0yUUtAacPwkxW4RO8FqQ7+Zf6pnsHAXffvty4CQsuZlMdkrn
         IrLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837835; x=1767442635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uTPebJjNeKwkChbLQ9kmEHnfHiLVqL0OXrUmcfcwYxQ=;
        b=LjN6oAnij3/hxDr1mqUKtKMfNPvi5RSY8yREcpTFs/Ml3y2AIlXMmQjAeD4k8O6bBR
         rl+4zGtotja3GT9X6AaKbMwicHeZ++g8Pq4Ku5JbFBf16U0EptX+NE07LMqBHrPYvzVE
         2I8Nli1C93IlXPZTtMXxzTi29QWz9JSFq9djl1owjRPah7zIO/n7sdFT076FFG4WltuR
         Nw/ivn04emZ2bc3WOY03hoiYhYcWjl85vdb+5T/VLWcUZyRulTTHV5NpGGR5edXW9pTL
         kLG9Iz0oqWlmKmTgJ+ONKAeP1e15GNUstRP8mUZGtmReX/m4z8ADjngPZ/M/8Rb2GwSF
         huXQ==
X-Gm-Message-State: AOJu0Yyae6cM/KDbEiL8KqPbpwPf4oEHoTKpQXz2FwwNknh2zoLabJ3x
	MAun1S/tpaZyWNXDwDLEeO6ac1ZIp0V9TWFIV7dlGOW0i31d2Y7GkzMLvuGZmcKOfYo=
X-Gm-Gg: AY/fxX7xlgxBr/K9uhmi3RRg2UXrPwIsAGxmSFlOz3QbKOG6mXNVDwO+WhMYaTdrGSX
	CthneY/ZqH5Q6dgqyqLiHmLrYTxOO+/zYF9dhgLlj3fLbjCT+EJ408X9pMc4Bc8I9S/NbZtv6hc
	A3cnqsg8ch0bUhVvLJ16r6QQX82ZvhxToYYZotYc6e+tQLTBRzpWImtZG6E4w/9BUq9sFpE/brN
	olCqlCtAPqGhKOyoGuawPQBSCBGjU5aeAH1BmjiV1V7GgFrdoZiRiIzJM1TpXgiAwYs5yCjiyX7
	OHvxR1BMh8zRI22UjsPs46acpnlmF7+O4cUl2+R6Ntyp/4JtacagJi68tiXcgpKHDOcFly6nLpi
	EjL+o2mdH9p6a0ldy91GnBbQu10/8Mj4iRK+WFCvNzNSS/Zl8du7z31AO8h4CqcWBk5cW24zLfF
	sHpGJbT1M8/fsztvK2Ppw=
X-Google-Smtp-Source: AGHT+IGwp3EjluLXDesoC0JEyXRGphsbQ8YoWlvkj2Od8DQXEn5G/ySQT/x4pqGRl4etLgLjbGQKkA==
X-Received: by 2002:a05:600c:1912:b0:477:89d5:fdac with SMTP id 5b1f17b1804b1-47d1959f714mr329425925e9.31.1766837835139;
        Sat, 27 Dec 2025 04:17:15 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:14 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:10 -0300
Subject: [PATCH 03/19] printk: Drop flags argument from console_is_usable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=9456;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=vcl36sWudeP+4+BFFAGNAn9YWtzCJyjmd2BzAWTnD/U=;
 b=iD+souMtKfrrqeYTmzgK7GoB+YnYwBZz+b3u1u3z79Hjhj/LyjffFTb6T+KYy3fwP+rT9y9HK
 hjNxNGyaArtAX5IV24Lh1tykQ434DvLfReICQgaATUhSR+uxoFOqy3O
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041717_038151_3C4EFF2F 
X-CRM114-Status: GOOD (  18.86  )
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

The flags argument was also used to check if CON_NBCON was set, but their
usage was fixed in the last commit. All current users are reading the
variable just to call console_is_usable.

By calling console_srcu_read_flags inside console_is_usable makes the
code cleaner and removes one argument from the function.

Along with it, create a variant called __console_is_usable that can be
used under console_list_lock(), like unregister_console_locked.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/kernel/kmsg_dump.c |  3 +--
 include/linux/console.h    | 25 +++++++++++++++++--------
 kernel/debug/kdb/kdb_io.c  |  4 +---
 kernel/printk/nbcon.c      | 15 ++++-----------
 kernel/printk/printk.c     | 20 +++++++-------------
 5 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
index 8ae38308b67c..ca80232cfa2a 100644
--- a/arch/um/kernel/kmsg_dump.c
+++ b/arch/um/kernel/kmsg_dump.c
@@ -31,8 +31,7 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
 		 * expected to output the crash information.
 		 */
 		if (strcmp(con->name, "ttynull") != 0 &&
-		    console_is_usable(con, console_srcu_read_flags(con),
-				      NBCON_USE_ATOMIC)) {
+		    console_is_usable(con, NBCON_USE_ATOMIC)) {
 			break;
 		}
 	}
diff --git a/include/linux/console.h b/include/linux/console.h
index dd4ec7a5bff9..648cf10e3f93 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
 				  struct nbcon_write_context *wctxt);
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
-/*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
- */
-static inline bool console_is_usable(struct console *con, short flags,
+/* Variant of console_is_usable() when the console_list_lock is held. */
+static inline bool __console_is_usable(struct console *con, short flags,
 				     enum nbcon_write_cb nwc)
 {
 	if (!(flags & CON_ENABLED))
@@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
 	return true;
 }
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con,
+				     enum nbcon_write_cb nwc)
+{
+	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -719,7 +726,9 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
-static inline bool console_is_usable(struct console *con, short flags,
+static inline bool __console_is_usable(struct console *con, short flags,
+				       enum nbcon_write_cb nwc) { return false; }
+static inline bool console_is_usable(struct console *con,
 				     enum nbcon_write_cb nwc) { return false; }
 #endif
 
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index d6de512b433a..642eab746577 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -589,9 +589,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		short flags = console_srcu_read_flags(c);
-
-		if (!console_is_usable(c, flags, NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index f0f42e212caa..f0659c1e50ed 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1164,7 +1164,6 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
 	bool ret = false;
-	short flags;
 	int cookie;
 
 	if (kthread_should_stop())
@@ -1183,8 +1182,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 
 	cookie = console_srcu_read_lock();
 
-	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, NBCON_USE_THREAD)) {
+	if (console_is_usable(con, NBCON_USE_THREAD)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1209,7 +1207,6 @@ static int nbcon_kthread_func(void *__console)
 		.ctxt.prio	= NBCON_PRIO_NORMAL,
 	};
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	short con_flags;
 	bool backlog;
 	int cookie;
 
@@ -1249,9 +1246,7 @@ static int nbcon_kthread_func(void *__console)
 		 */
 		cookie = console_srcu_read_lock();
 
-		con_flags = console_srcu_read_flags(con);
-
-		if (console_is_usable(con, con_flags, NBCON_USE_THREAD))
+		if (console_is_usable(con, NBCON_USE_THREAD))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
@@ -1645,12 +1640,10 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
-
 		if (!console_is_nbcon(con))
 			continue;
 
-		if (!console_is_usable(con, flags, NBCON_USE_ATOMIC))
+		if (!console_is_usable(con, NBCON_USE_ATOMIC))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1904,7 +1897,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	printk_get_console_flush_type(&ft);
-	if (console_is_usable(con, console_srcu_read_flags(con), NBCON_USE_ATOMIC) &&
+	if (console_is_usable(con, NBCON_USE_ATOMIC) &&
 	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index bd0d574be3cf..b03ffc23c27c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3191,7 +3191,6 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
 		u64 printk_seq;
 		bool progress;
 
@@ -3203,9 +3202,8 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags,
-				       do_cond_resched ? NBCON_USE_THREAD
-						       : NBCON_USE_ATOMIC))
+		if (!console_is_usable(con, do_cond_resched ? NBCON_USE_THREAD
+							    : NBCON_USE_ATOMIC))
 			continue;
 		any_usable = true;
 
@@ -3394,7 +3392,7 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank) {
@@ -3434,7 +3432,7 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if (!console_is_usable(c, console_srcu_read_flags(c), NBCON_USE_ATOMIC))
+		if (!console_is_usable(c, NBCON_USE_ATOMIC))
 			continue;
 
 		if (c->unblank)
@@ -3621,7 +3619,6 @@ static bool legacy_kthread_should_wakeup(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
-		short flags = console_srcu_read_flags(con);
 		u64 printk_seq;
 
 		/*
@@ -3632,7 +3629,7 @@ static bool legacy_kthread_should_wakeup(void)
 		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, NBCON_USE_THREAD))
+		if (!console_is_usable(con, NBCON_USE_THREAD))
 			continue;
 
 		if (console_is_nbcon(con)) {
@@ -4203,7 +4200,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags, NBCON_USE_ATOMIC))
+	else if (__console_is_usable(console, console->flags, NBCON_USE_ATOMIC))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4430,7 +4427,6 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
-	short flags;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -4477,14 +4473,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (con && con != c)
 				continue;
 
-			flags = console_srcu_read_flags(c);
-
 			/*
 			 * If consoles are not usable, it cannot be expected
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, NBCON_USE_ANY))
+			if (!console_is_usable(c, NBCON_USE_ANY))
 				continue;
 
 			if (console_is_nbcon(c)) {

-- 
2.52.0


