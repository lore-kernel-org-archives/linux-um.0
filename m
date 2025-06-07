Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426C4C61CE8
	for <linux-um@archiver.kernel.org>; Sat,  7 Jun 2025 02:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mX7Kpvr3d8Igbqg1Pi5Y0v9vR933SOfz9K97ZuvSH2o=; b=1yaXVrNKnJfAow7PBMUkRG0EJ3
	LVby5SomDcIsxNT0sC5TBfOZ4h7OG2OHquiW2zklmMb8svYCL8Bw0hR2MvLZ2GefPyXNr/xtr1S80
	9CG0DuXqkXErTqnUKi+P+lfKEs7Ch5FmxKyUa6ouc/FZ/b4je6DaPiLeTyUml/qIm6sX6Fwr3sGY3
	nlrky/bqMXi4c7lvFjF4w6HaJm2EoEe29xgGZWLsJL82E8l14q8gVAM+ZoG1QbfrYKNho72GeDoZn
	6FP90Bn4v/q6bKYAIt+xAwhHdX7ysCNL/0LvAucJBEMWeTmLwCQvq1+LsVwJ3o4J+ytpp4Tqw8NZt
	RQj0F67A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhH-00000001GcS-00eA;
	Sat, 07 Jun 2025 02:54:15 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNjhD-00000001GbD-43J6
	for linux-um@lists.infradead.org;
	Sat, 07 Jun 2025 02:54:13 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3a36e090102so1641655f8f.2
        for <linux-um@lists.infradead.org>; Fri, 06 Jun 2025 19:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749264850; x=1749869650; darn=lists.infradead.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX7Kpvr3d8Igbqg1Pi5Y0v9vR933SOfz9K97ZuvSH2o=;
        b=ST5zFqs0j7ZbtPYKuIqlKOQuyRNmiO9JEAEbrtT6OlXCr/6ne+pj3oBrP/f5Pcv3f2
         oJjd/FsM7UAvUpxAgjNGXQb4IVL7Th9BWAiM2py4Y5I4Xjws/2dKfkgYWJPmxEbWKxXV
         MZpdRYeVkNxqd7nmBc/OL7UjVDxQoFeEoUPw6qC4tRQFybeDF9E51ORajicmlRb+cNuF
         omlos2p/aSOqDpGLz/7ZOWejeF4H1KDYLXLhrC5iR8vS1VFr4VZq/uKBGg1bXYHEDouJ
         Z4w2ujasIpA3D0kljpyfuGgUoN0vxcdgkFp1ictgMqP6pW+N7CID0u1wXhf6TwDqZnCq
         TdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749264850; x=1749869650;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX7Kpvr3d8Igbqg1Pi5Y0v9vR933SOfz9K97ZuvSH2o=;
        b=l9eeXDeWItIVRFnkuY2dYLBCm5mKfTiT5e49dESLqQuMAYTONrXay8KktwlxG+L1ak
         ZK1gZz6h4WCaLUB8TmQBHXhtaZeAfoQMW5pZXuSwYqp1FG/dcd4t+pmHleUZEMMpsHbx
         jxtGv4n3RFFdYoof5MyRGVVvx9uc+nySXt8i0c5ZRyyTL0EOSgCtE0R/gaGEMZJVTooU
         d1GgySfOIDSvrah8uGObhDPjWPBbyq88Dxp5LI5OMjbJGqyCpzUV/mMNEmtCfeAZaMCO
         YKWKFLkWdZ5iAdMBhARXcpxJdC76IlBZfRexXf7WBmqI/xrvsMLzEfMN6ale24JzM+Oc
         9Dgw==
X-Forwarded-Encrypted: i=1; AJvYcCXWKo5blBGjxtHnST17lJycTkMVNNtPkSwPzsjSwTXjRWEUbt/3cbo4/KUuZTzhwS6aszVyrblzgg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyOXMURs+uvP3wDwlYKKc807164WtMHraSX1axBq1BRQK01ccRS
	pzzZ8YsXE6fIjasUErIMkO+DtF2i5H7p4HeqGvWFubXgypRn+mFfSjGPS/u2QusXMWc=
X-Gm-Gg: ASbGncunage83dbDjeNTzdftfXBWsav8sbrZyGbMov0VsqVzynQ8ZCqpu8cuvDVK3m/
	1jkUnzMbp6VPCuWrR7XrJymBrLTRGD3QREEdl1WYRm8IM1XO01ckU7DWgLWBZqN+y68sIdYP+eM
	/bMLFd7Y0GQWtVZfZA/vPZUS+Qz2WVopU4t5aGI43WHZjmKVTUnMR2M4kQwoxeihA/BjBu5kHdE
	DE21v+y7j7yd1+YLDk6LcZXn94vFUUOVhsbfOgIdIoNUTufwZ0TpXnUgZ8nbhFv1qOGmalVeZ97
	uyeUHbS90GvGvC2RLgvZUkLm/W2+kV1yQrarw4YFDNxHN45PPqa+MRUZyrmUyEgi49KwjQ==
X-Google-Smtp-Source: AGHT+IHTkyMEV1xuLGonC7LtgR95ygfYX+hJ/eUxGPUUwzB9N83jBsaILJv4Qv7aHZROQ6yhMrIkHQ==
X-Received: by 2002:a05:6000:188f:b0:3a4:f7dc:8a62 with SMTP id ffacd0b85a97d-3a531453ce7mr4234829f8f.0.1749264850369;
        Fri, 06 Jun 2025 19:54:10 -0700 (PDT)
Received: from [127.0.0.1] ([2804:5078:80f:b600:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-530e6429475sm2005465e0c.45.2025.06.06.19.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 19:54:09 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Fri, 06 Jun 2025 23:53:44 -0300
Subject: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
In-Reply-To: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
To: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749264832; l=6242;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=1gk8U8A9Tp8dYd1sZPBSwCndj58kUaiYwQ9Z81qrFXo=;
 b=wvHq6UkjGv8LUZFpyT85kU4YEf7UvDpnRljGGj2r3IAnPOf6zps3o5cncvffNGYqnHhCIQTlN
 5oFz1z/ahtlC5MWr0tDhAmLDLFHk/lTOiZuZ/P7/OtnsVSS6Dx7AMqH
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250606_195412_014606_29E9DE3E 
X-CRM114-Status: GOOD (  16.04  )
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

Instead of update a per-console CON_SUSPENDED flag, use the console_list
locks to protect this flag. This is also applied to console_is_usable
functions, which now also checks if consoles_suspend is set.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/internal.h |  7 ++++++-
 kernel/printk/nbcon.c    |  8 ++++----
 kernel/printk/printk.c   | 23 ++++++++++-------------
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 48a24e7b309db20fdd7419f7aeda68ea7c79fd80..752101904f44b13059b6a922519d88e24c9f32c0 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -118,8 +118,12 @@ void nbcon_kthreads_wake(void);
  * which can also play a role in deciding if @con can be used to print
  * records.
  */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic, bool consoles_suspended)
 {
+	if (consoles_suspended)
+		return false;
+
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -212,6 +216,7 @@ extern bool have_boot_console;
 extern bool have_nbcon_console;
 extern bool have_legacy_console;
 extern bool legacy_allow_panic_sync;
+extern bool consoles_suspended;
 
 /**
  * struct console_flush_type - Define available console flush methods
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, false)) {
+	if (console_is_usable(con, flags, false, consoles_suspended)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);
 
@@ -1206,7 +1206,7 @@ static int nbcon_kthread_func(void *__console)
 
 		con_flags = console_srcu_read_flags(con);
 
-		if (console_is_usable(con, con_flags, false))
+		if (console_is_usable(con, con_flags, false, consoles_suspended))
 			backlog = nbcon_emit_one(&wctxt, false);
 
 		console_srcu_read_unlock(cookie);
@@ -1584,7 +1584,7 @@ static void __nbcon_atomic_flush_pending(u64 stop_seq, bool allow_unsafe_takeove
 		if (!(flags & CON_NBCON))
 			continue;
 
-		if (!console_is_usable(con, flags, true))
+		if (!console_is_usable(con, flags, true, consoles_suspended))
 			continue;
 
 		if (nbcon_seq_read(con) >= stop_seq)
@@ -1795,7 +1795,7 @@ void nbcon_device_release(struct console *con)
 	 */
 	cookie = console_srcu_read_lock();
 	printk_get_console_flush_type(&ft);
-	if (console_is_usable(con, console_srcu_read_flags(con), true) &&
+	if (console_is_usable(con, console_srcu_read_flags(con), true, consoles_suspended) &&
 	    !ft.nbcon_offload &&
 	    prb_read_valid(prb, nbcon_seq_read(con), NULL)) {
 		/*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6d3cf488f4261a3dfd8809a5ab7164b218238c13..658acf92aa3d2a3d1e294b7e17e5ee96d8169afe 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -241,7 +241,7 @@ int devkmsg_sysctl_set_loglvl(const struct ctl_table *table, int write,
 /**
  * console_list_lock - Lock the console list
  *
- * For console list or console->flags updates
+ * For console list, console->flags and consoles_suspended updates
  */
 void console_list_lock(void)
 {
@@ -383,6 +383,8 @@ bool other_cpu_in_panic(void)
  */
 static int console_locked;
 
+bool consoles_suspended;
+
 /*
  *	Array of consoles built from command line options (console=)
  */
@@ -2755,16 +2757,13 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void console_suspend_all(void)
 {
-	struct console *con;
-
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	pr_flush(1000, true);
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	consoles_suspended = true;
 	console_list_unlock();
 
 	/*
@@ -2779,14 +2778,12 @@ void console_suspend_all(void)
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
-	struct console *con;
 
 	if (!console_suspend_enabled)
 		return;
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+	consoles_suspended = false;
 	console_list_unlock();
 
 	/*
@@ -3214,7 +3211,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 				continue;
 
-			if (!console_is_usable(con, flags, !do_cond_resched))
+			if (!console_is_usable(con, flags, !do_cond_resched, consoles_suspended))
 				continue;
 			any_usable = true;
 
@@ -3604,7 +3601,7 @@ static bool legacy_kthread_should_wakeup(void)
 		if ((flags & CON_NBCON) && (ft.nbcon_atomic || ft.nbcon_offload))
 			continue;
 
-		if (!console_is_usable(con, flags, false))
+		if (!console_is_usable(con, flags, false, consoles_suspended))
 			continue;
 
 		if (flags & CON_NBCON) {
@@ -4165,7 +4162,7 @@ static int unregister_console_locked(struct console *console)
 
 	if (!console_is_registered_locked(console))
 		res = -ENODEV;
-	else if (console_is_usable(console, console->flags, true))
+	else if (console_is_usable(console, console->flags, true, consoles_suspended))
 		__pr_flush(console, 1000, true);
 
 	/* Disable it unconditionally */
@@ -4445,8 +4442,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 * that they make forward progress, so only increment
 			 * @diff for usable consoles.
 			 */
-			if (!console_is_usable(c, flags, true) &&
-			    !console_is_usable(c, flags, false)) {
+			if (!console_is_usable(c, flags, true, consoles_suspended) &&
+			    !console_is_usable(c, flags, false, consoles_suspended)) {
 				continue;
 			}
 

-- 
2.49.0


