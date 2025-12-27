Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45528E8FDD8
	for <linux-um@archiver.kernel.org>; Sat, 27 Dec 2025 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhFoe+/fNVQYtucZwNZBdpwy2GyzZc29S0jBT7dXZmU=; b=TfNKMju8NSuDu9cE2l5m9KwDj0
	UXkYeTLFnqWvphiQgbSZRr6dZnhJ/xHKMEwLpcVzqhnR4JfFIpBAUOv37+gdupdRO5i9SXEDuX3or
	D2GbVWztOVBrkJMelqOCQ8vHHiGq49UaVe0mmtXSiSFshKtRvf+RntBWCunEgFgvARhBE0dL2NqkY
	zwfvu/G1G2Q5wn5JZVtKgdMIZZWUyYDcCMlUSsZOdqUqn2WPrTDbzMYsdNHJShJyFzJIstb83JHTR
	Ed+1JVuqpxOapZ6CjPfUUldACZnr697b0ismMYQ523kRWscrR963GOkocmOYzA0GdhozswQNJ6pZm
	0QWx94/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTEM-00000001vR8-3w6C;
	Sat, 27 Dec 2025 12:17:10 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZTEK-00000001vPL-07o2
	for linux-um@lists.infradead.org;
	Sat, 27 Dec 2025 12:17:10 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4779cc419b2so61961515e9.3
        for <linux-um@lists.infradead.org>; Sat, 27 Dec 2025 04:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837826; x=1767442626; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhFoe+/fNVQYtucZwNZBdpwy2GyzZc29S0jBT7dXZmU=;
        b=RhPHlBHTWOWkssXWVqSGqW6RHBruQeABJST2oN3iNrEGEgOm9Fn/SsPKtdbrQfQ55h
         pYMwfy4aXougqjTodsEKbroxXRvrddb98XyE7gc5f6BKUcweFJUikVg9K2l02XHXs4Uk
         fp6mPDjl+tShfEhGQja1l3AFEroWKRqvcUhBN6CEbX3Txpp0Y5plcetTWGAhd/qc0ToV
         58mg/q3VDFXLyB9kjMZFe/gLKMgfc/BoftQZ8HNqMfVXtR0sikMbskdVgC/h+axegRJo
         5I7wVXZiuEQ7/F0yyga/O/fq4s/iZYkY9rEbhlpfnyY1R5caMkjep/kfoG4oZjdCJdjE
         TzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837826; x=1767442626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rhFoe+/fNVQYtucZwNZBdpwy2GyzZc29S0jBT7dXZmU=;
        b=HtNeNwewyX0BONyLUOA947asixJNHs/GViz66D0Sum5HsPg/SRa79cUyvoeHrNBgge
         1Vn29N0ZZ564GKa9BYSUFHsVyjnmCD/UOdGFLLuSEx7vNjujGQaci7ITCY+lC8ouSL5p
         P1Pw9IdFYR+WnghGEnojCdY9ax4j0/hFoHw3BiFUpBaH/A9gLFHhsPsmwEbmPiGLvOd9
         Yjg9Yr6wD4fwAg0U8/LsJwnoYWEkn5mRAO9KaflyzlyYi8abK4KQQjIx0pq1ZGo+Y4iY
         IVv/lLATuXyX2xcrhXXgwbqwKNqN6/6vDCLzaV8V3EpyaMCT26Wj9K7ubZjQGO95cHMC
         L2Cg==
X-Gm-Message-State: AOJu0Ywsc95NUCMy5aGIN/cdXzArjzxOcbL//SVSzLhqJsYvXaEUPCL0
	Sp718z+Xr7sggfkY7UFHCH4F++bJUeNUueFTk9fP8HNg72sl+t3qcR0Sttm72MJNxQ8=
X-Gm-Gg: AY/fxX6xlSgP3HAFYY9Io/L4SgZmRpjtN5UsfXRWWU5XFzwcQcpHdHXQcjPE7zBtX9a
	6ETAn7lLt60FL4G3MDakzphaq6d9TSTGB6RsdtRrQ1BzuFvVyOfTbuOcfyw8vpVysQpbqn5U4gf
	oeaoI0yM2NHTZ0wj1YjcMYT1EmkEGHHt9V3hlMY8TOo4nulSVxRevIDFq2etFfa7czx7x3mXLpu
	N9n3DF3TzvJRKimyDJChHNz5H9qVivXYgV4WuGdrFVk8/jNP5LnEdUwAm6p66hNJXjHb5TSt3MY
	zgbBiRHWsKTdOUFdSWLf93Be0fAVweTthCiwW06/Y9r55iU+t32b/+Phr1R83MTuBt6ShQ/rCmW
	aEqlRMxMi4v1NvJuBwZuUMbv0AY1RCx/i0ZWgm9WFhO/CJfJUJjXwtJPk01qs6GfohmbALn4g8z
	soCwTU5HFv
X-Google-Smtp-Source: AGHT+IHT9M2beqQrZzp9xbbyJud8/h6Q+UOZtBpjbh3fLwHrPjz2pLTjAJscQz+yaZcvqZw8y6NMSQ==
X-Received: by 2002:a05:600c:3b88:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-47d19556cf7mr356539265e9.12.1766837826003;
        Sat, 27 Dec 2025 04:17:06 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:05 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:09 -0300
Subject: [PATCH 02/19] printk: Introduce console_is_nbcon
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-2-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5401;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=neUSae1tSSd9ZUIMhNnIsDOes9ZbVtbWmizb8QV3UdY=;
 b=gCYQ59/fzh5QOgA05PXMV/E/oNmzy4c9swZbzFlKNzJFERHXZDcBlPYBdYFwyrufnetFktUrT
 qugGUjzspdLDAy+AfxtSwqRvBilWtZIJfksSlShjgsgxcBNFgQvlHOk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251227_041709_063484_6248FC4D 
X-CRM114-Status: GOOD (  20.28  )
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

Besides checking if the current console is NBCON or not, console->flags
is also being read in order to serve as argument of the console_is_usable
function.

But CON_NBCON flag is unique: it's set just once in the console
registration and never cleared. In this case it can be possible to read
the flag when console_srcu_lock is held (which is the case when using
for_each_console).

This change makes possible to remove the flags argument from
console_is_usable in the next patches.

Signed-off-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h   | 27 +++++++++++++++++++++++++++
 kernel/debug/kdb/kdb_io.c |  2 +-
 kernel/printk/nbcon.c     |  2 +-
 kernel/printk/printk.c    | 15 ++++++---------
 4 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index 35c03fc4ed51..dd4ec7a5bff9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -561,6 +561,33 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
 	WRITE_ONCE(con->flags, flags);
 }
 
+/**
+ * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
+ * @con:	struct console pointer of console to check
+ *
+ * Requires console_srcu_read_lock to be held, which implies that @con might
+ * be a registered console. The purpose of holding console_srcu_read_lock is
+ * to guarantee that no exit/cleanup routines will run if the console
+ * is currently undergoing unregistration.
+ *
+ * If the caller is holding the console_list_lock or it is _certain_ that
+ * @con is not and will not become registered, the caller may read
+ * @con->flags directly instead.
+ *
+ * Context: Any context.
+ * Return: True when CON_NBCON flag is set.
+ */
+static inline bool console_is_nbcon(const struct console *con)
+{
+	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
+
+	/*
+	 * The CON_NBCON flag is statically initialized and is never
+	 * set or cleared at runtime.
+	 */
+	return data_race(con->flags & CON_NBCON);
+}
+
 /* Variant of console_is_registered() when the console_list_lock is held. */
 static inline bool console_is_registered_locked(const struct console *con)
 {
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6ffb962392a4..d6de512b433a 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -596,7 +596,7 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		if (c == dbg_io_ops->cons)
 			continue;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(c)) {
 			struct nbcon_write_context wctxt = { };
 
 			/*
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 13865ef85990..f0f42e212caa 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1647,7 +1647,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq)
 	for_each_console_srcu(con) {
 		short flags = console_srcu_read_flags(con);
 
-		if (!(flags & CON_NBCON))
+		if (!console_is_nbcon(con))
 			continue;
 
 		if (!console_is_usable(con, flags, NBCON_USE_ATOMIC))
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 5f4b84f9562e..bd0d574be3cf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3200,7 +3200,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 		 * nbcon consoles when the nbcon consoles cannot print via
 		 * their atomic or threaded flushing.
 		 */
-		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
 		if (!console_is_usable(con, flags,
@@ -3209,7 +3209,7 @@ static bool console_flush_one_record(bool do_cond_resched, u64 *next_seq, bool *
 			continue;
 		any_usable = true;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(con)) {
 			progress = nbcon_legacy_emit_next_record(con, handover, cookie,
 								 !do_cond_resched);
 			printk_seq = nbcon_seq_read(con);
@@ -3458,7 +3458,6 @@ void console_unblank(void)
 static void __console_rewind_all(void)
 {
 	struct console *c;
-	short flags;
 	int cookie;
 	u64 seq;
 
@@ -3466,9 +3465,7 @@ static void __console_rewind_all(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		flags = console_srcu_read_flags(c);
-
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(c)) {
 			nbcon_seq_force(c, seq);
 		} else {
 			/*
@@ -3632,13 +3629,13 @@ static bool legacy_kthread_should_wakeup(void)
 		 * consoles when the nbcon consoles cannot print via their
 		 * atomic or threaded flushing.
 		 */
-		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
+		if (console_is_nbcon(con) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
 		if (!console_is_usable(con, flags, NBCON_USE_THREAD))
 			continue;
 
-		if (flags & CON_NBCON) {
+		if (console_is_nbcon(con)) {
 			printk_seq = nbcon_seq_read(con);
 		} else {
 			/*
@@ -4490,7 +4487,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (!console_is_usable(c, flags, NBCON_USE_ANY))
 				continue;
 
-			if (flags & CON_NBCON) {
+			if (console_is_nbcon(c)) {
 				printk_seq = nbcon_seq_read(c);
 			} else {
 				printk_seq = c->seq;

-- 
2.52.0


