Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F642D116E2
	for <linux-um@archiver.kernel.org>; Thu, 27 Nov 2025 09:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M55NOPX6+5YD0B0HIxdp5eD8kEu/VA3rAyDyjjhFwp8=; b=urNU426fiWjJW0qkT2nrZTFIW3
	fGUTjAYoQhz85uSF99oWAxZi6aqlAbEQPKspEY2QyOAmkxoJV2KzJZJrgiNIwfU2QzgiMgURfcI4l
	NTLVJVm7jBmL2uzyNbVp2HkKLnRxaTtsLchYVwJPp/Cpa99cXaEObTm+QYJyCYyGexLlD72wRvabm
	7BumBgAoGppmjIubDZkAevTm7i34DdYkwKv32dKqOjywSH5yIyQ6S5Xg3/8aL5Pu+w7lozKc2jvdf
	QsTNRT7p1u/rf/q6gLI/Ue9IT4qef993XtVvHb921byo7+WL04T+PswGhS9O1EW7J8vWGVjSgLj7y
	zk7cVgGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOYd6-0000000GKDd-00GG;
	Thu, 27 Nov 2025 09:49:36 +0000
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOYd3-0000000GKD7-2G7m
	for linux-um@lists.infradead.org;
	Thu, 27 Nov 2025 09:49:35 +0000
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-b735487129fso99306366b.0
        for <linux-um@lists.infradead.org>; Thu, 27 Nov 2025 01:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764236972; x=1764841772; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M55NOPX6+5YD0B0HIxdp5eD8kEu/VA3rAyDyjjhFwp8=;
        b=NHCU0RaSu9WPpStYnoWljxkWwGtD0wPrTg3M3oKFRSdVKz3QBtFVz+vHFYp2FFIyNd
         lx/sjlYGrk8SGaNIo4fg2R1rXmTlbNar47TSH1ByMj++8Bnwqfb9qaTaRPCpBg/M0dXb
         7GTxS2DIa2OOmTgbwS9buOHSsm7ceEpTjncVWhQTA8OorfMiDStmX48L1DSC7NNM/I/8
         8742wzJIRVOOdCBRwg6QftbNBzFy9MWYSkrU07Wx56jIQ5FWOYJtQyYx8UJbQsv3MyS+
         oW8VDlJxOZ51n87nHnZdisJ1FF95Ax3JZ+OIM+YAtPmhappqdbO0+elZaT7rOqCzNV0P
         f8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764236972; x=1764841772;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M55NOPX6+5YD0B0HIxdp5eD8kEu/VA3rAyDyjjhFwp8=;
        b=gmU6JwpTgemk/k8tzQYHs8aDRPkMI62OfOUCVxukKbweRwAtcAgPFSr36+e6Y39qaN
         P3yn4fQS7SnzSclkZ+fKdpq6w48bVpRR7gSqPJ8/Bh2czOQv3UWkJeDedPhD0ShibYf/
         cGnwSa5LsdDoEvVfJdaUEcRXynUjFwsykmrOFrd1Hv2a3XKhjcDsjSfW8HIiaLoNnrrS
         BGqiuzggeHCUfxrU2WDx44PWlXaUER5N6fCMoqanihOHIIO9BS7e0+wfs7bIRBg3QcMh
         BnnvdjDARc5002cwbutGNxnJS9um+axFteLlLw9oeOjgmg6SXZSiCGFIlsvG37xLCQsV
         +5+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMtn929KDsLjDx6ER86ZAztTD1mTtE961d+dYoxhYfGiheLsr+E+MngRz/xSOAYIkfldat2lEUsw==@lists.infradead.org
X-Gm-Message-State: AOJu0YwhzmxpJdS4JtooTTaWZc1tvwJF8ne+wftDcQ8a0ODCq4rNXOsz
	chjYu6s1JHOldgmajJjzPTEEWspm7LLvVMYA/O3B/OaT74ArE5+IQaa9bF8VcQnHsV0=
X-Gm-Gg: ASbGncsIT7TrxH59PyOJKYjoLk8yi7bD55X2USINT6q23LtrRGqHDZIW3Gj+OvKvOL7
	jjFSK1E6zsx/BEhITDeLAcPR1ZG1HaIKnnSzMgJ4MJNcc0FzkdUoZ0eUhjC/Vq6ztdzSUHq7Vcp
	Hj2/bx2JexZRmHv/tMjtpoJ7n6GLCj2qqC6q8EStcy/FWmbgw8cgMbOy3McXputsGpOpHSgVcZL
	k4i8q/ZRPQOMnKMqU7gaKeDqFlGypLRPc/UX4T4/stEoeqIIHzt06cQFzpivaw7GOUiwLHn5ao2
	6kkKLvFwEZGuWWnUfv4Mn7NDn2Cs+nft0am4kg9Yug8xceqDm9Z8sUIEFhEe8bBwazHw62CWvdL
	5U+E3ArUkl8OrK2l4una3VljT27xEyC/mrKZUWNZ4V4KD6ePJtxDnFIYsljTmyST26v1gHU6Gat
	a7OOMH9xTwRdikYQ==
X-Google-Smtp-Source: AGHT+IFxlu0dGYyZ0OR2t4e3UxMOdqisZjIAo/bgT3egjX/1jqRrOdQbJ5C0zIWcx5YhoZUyiTy5Wg==
X-Received: by 2002:a17:906:2612:b0:b76:b632:1123 with SMTP id a640c23a62f3a-b76b63214demr1036789966b.42.1764236971612;
        Thu, 27 Nov 2025 01:49:31 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f5162093sm123547366b.2.2025.11.27.01.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 01:49:31 -0800 (PST)
Date: Thu, 27 Nov 2025 10:49:28 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH v2 4/4] printk: Make console_{suspend,resume} handle
 CON_SUSPENDED
Message-ID: <aSgeqM3DWvR8-cMY@pathway.suse.cz>
References: <20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com>
 <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-printk-cleanup-part2-v2-4-57b8b78647f4@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251127_014933_644069_4593644F 
X-CRM114-Status: GOOD (  34.74  )
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

On Fri 2025-11-21 15:50:36, Marcos Paulo de Souza wrote:
> Since commit 9e70a5e109a4 ("printk: Add per-console suspended state")
> the CON_SUSPENDED flag was introced, and this flag was being checked
> on console_is_usable function, which returns false if the console is
> suspended.
> 
> To make the behavior consistent, change show_cons_active to look for
> consoles that are not suspended, instead of checking CON_ENABLED.
> 
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -3554,7 +3554,7 @@ static ssize_t show_cons_active(struct device *dev,
>  			continue;
>  		if (!(c->flags & CON_NBCON) && !c->write)
>  			continue;
> -		if ((c->flags & CON_ENABLED) == 0)
> +		if (c->flags & CON_SUSPENDED)

I believe that we could and should replace

		if (!(c->flags & CON_NBCON) && !c->write)
			continue;
		if (c->flags & CON_SUSPENDED)
			continue;

with

		if (!console_is_usable(c, c->flags, true) &&
		    !console_is_usable(c, c->flags, false))
			continue;

It would make the value compatible with all other callers/users of
the console drivers.

The variant using two console_is_usable() calls with "true/false"
parameters is inspited by __pr_flush().

>  			continue;
>  		cs[i++] = c;
>  		if (i >= ARRAY_SIZE(cs))
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fed98a18e830..fe7c956f73bd 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3542,7 +3542,7 @@ void console_suspend(struct console *console)
>  {
>  	__pr_flush(console, 1000, true);
>  	console_list_lock();
> -	console_srcu_write_flags(console, console->flags & ~CON_ENABLED);
> +	console_srcu_write_flags(console, console->flags | CON_SUSPENDED);

This is the same flag which is set also by the console_suspend_all()
API. Now, as discussed at
https://lore.kernel.org/lkml/844j4lepak.fsf@jogness.linutronix.de/

   + console_suspend()/console_resume() API is used by few console
     drivers to suspend the console when the related HW device
     gets suspended.

   + console_suspend_all()/console_resume_all() is used by
     the power management subsystem to call down/up all consoles
     when the system is going down/up. It is a big hammer approach.

We need to distinguish the two APIs so that console drivers which were
suspended by both APIs stay suspended until they get resumed by both
APIs. I mean:

	// This should suspend all consoles unless it is not disabled
	// by "no_console_suspend" API.
	console_suspend_all();
	// This suspends @con even when "no_console_suspend" parameter
	// is used. It is needed because the HW is going to be suspended.
	// It has no effect when the consoles were already suspended
	// by the big hammer API.
	console_suspend(con);

	// This might resume the console when "no_console_suspend" option
	// is used. The driver should work because the HW was resumed.
	// But it should stay suspended when all consoles are supposed
	// to stay suspended because of the big hammer API.
	console_resume(con);
	// This should resume all consoles.
	console_resume_all();

Other behavior would be unexpected and untested. It might cause regression.

I see two solutions:

   + add another CON_SUSPENDED_ALL flag
   + add back "consoles_suspended" global variable

I prefer adding back the "consoles_suspended" global variable because
it is a global state...

The global state should be synchronized the same way as the current
per-console flag (write under console_list_lock, read under
console_srcu_read_lock()).

Also it should be checked by console_is_usable() API. Otherwise, we
would need to update all callers.

This brings a challenge how to make it safe and keep the API sane.
I propose to create:

  + __console_is_usable() where the "consoles_suspended" value will
    be passed as parameter. It might be used directly under
    console_list_lock().

  + console_is_usable() with the existing parameters. It will check
    the it was called under console_srcu_read_lock, read
    the global "consoles_suspend" and pass it to
    __console_is_usable().


>  	console_list_unlock();
>  
>  	/*

I played with the code to make sure that it looked sane
and I ended with the following changes on top of this patch.

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 1b2ce0f36010..fda4683d12f1 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -3552,9 +3552,8 @@ static ssize_t show_cons_active(struct device *dev,
 	for_each_console(c) {
 		if (!c->device)
 			continue;
-		if (!(c->flags & CON_NBCON) && !c->write)
-			continue;
-		if (c->flags & CON_SUSPENDED)
+		if (!__console_is_usable(c, c->flags, consoles_suspended, true) &&
+		    !__console_is_usable(c, c->flags, consoles_suspended, false))
 			continue;
 		cs[i++] = c;
 		if (i >= ARRAY_SIZE(cs))
diff --git a/include/linux/console.h b/include/linux/console.h
index 5f17321ed962..090490ef570f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -496,6 +496,7 @@ extern void console_list_lock(void) __acquires(console_mutex);
 extern void console_list_unlock(void) __releases(console_mutex);
 
 extern struct hlist_head console_list;
+extern bool consoles_suspended;
 
 /**
  * console_srcu_read_flags - Locklessly read flags of a possibly registered
@@ -548,6 +549,47 @@ static inline void console_srcu_write_flags(struct console *con, short flags)
 	WRITE_ONCE(con->flags, flags);
 }
 
+/**
+ * consoles_suspended_srcu_read - Locklessly read the global flag for
+ *				suspending all consoles.
+ *
+ * The global "consoles_suspended" flag is synchronized using console_list_lock
+ * and console_srcu_read_lock. It is the same approach as CON_SUSSPENDED flag.
+ * See console_srcu_read_flags() for more details.
+ *
+ * Context: Any context.
+ * Return: The current value of the global "consoles_suspended" flag.
+ */
+static inline short consoles_suspended_srcu_read(void)
+{
+	WARN_ON_ONCE(!console_srcu_read_lock_is_held());
+
+	/*
+	 * The READ_ONCE() matches the WRITE_ONCE() when "consoles_suspended"
+	 * is modified with consoles_suspended_srcu_write().
+	 */
+	return data_race(READ_ONCE(consoles_suspended));
+}
+
+/**
+ * consoles_suspended_srcu_write - Write the global flag for suspending
+ *			all consoles.
+ * @suspend:	new value to write
+ *
+ * The write must be done under the console_list_lock. The caller is responsible
+ * for calling synchronize_srcu() to make sure that all callers checking the
+ * usablility of registered consoles see the new state.
+ *
+ * Context: Any context.
+ */
+static inline void consoles_suspended_srcu_write(bool suspend)
+{
+	lockdep_assert_console_list_lock_held();
+
+	/* This matches the READ_ONCE() in consoles_suspended_srcu_read(). */
+	WRITE_ONCE(consoles_suspended, suspend);
+}
+
 /* Variant of console_is_registered() when the console_list_lock is held. */
 static inline bool console_is_registered_locked(const struct console *con)
 {
@@ -617,13 +659,15 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
 extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
 
 /*
- * Check if the given console is currently capable and allowed to print
- * records. Note that this function does not consider the current context,
- * which can also play a role in deciding if @con can be used to print
- * records.
+ * This variant might be called under console_list_lock where both
+ * @flags and @all_suspended flags can be read directly.
  */
-static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
+static inline bool __console_is_usable(struct console *con, short flags,
+				       bool all_suspended, bool use_atomic)
 {
+	if (all_suspended)
+		return false;
+
 	if (!(flags & CON_ENABLED))
 		return false;
 
@@ -666,6 +710,20 @@ static inline bool console_is_usable(struct console *con, short flags, bool use_
 	return true;
 }
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records. Note that this function does not consider the current context,
+ * which can also play a role in deciding if @con can be used to print
+ * records.
+ */
+static inline bool console_is_usable(struct console *con, short flags,
+				     bool use_atomic)
+{
+	bool all_suspended = consoles_suspended_srcu_read();
+
+	return __console_is_usable(con, flags, all_suspended, use_atomic);
+}
+
 #else
 static inline void nbcon_cpu_emergency_enter(void) { }
 static inline void nbcon_cpu_emergency_exit(void) { }
@@ -678,6 +736,8 @@ static inline void nbcon_reacquire_nobuf(struct nbcon_write_context *wctxt) { }
 static inline bool nbcon_kdb_try_acquire(struct console *con,
 					 struct nbcon_write_context *wctxt) { return false; }
 static inline void nbcon_kdb_release(struct nbcon_write_context *wctxt) { }
+static inline bool __console_is_usable(struct console *con, short flags,
+				       bool all_suspended, bool use_atomic) { return false; }
 static inline bool console_is_usable(struct console *con, short flags,
 				     bool use_atomic) { return false; }
 #endif
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 23a14e8c7a49..12247df07420 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -104,6 +104,13 @@ DEFINE_STATIC_SRCU(console_srcu);
  */
 int __read_mostly suppress_printk;
 
+/*
+ * Global flag for calling down all consoles during suspend.
+ * There is also a per-console flag which is used when the related
+ * device HW gets disabled, see CON_SUSPEND.
+ */
+bool consoles_suspended;
+
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map console_lock_dep_map = {
 	.name = "console_lock"
@@ -2731,8 +2738,6 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void console_suspend_all(void)
 {
-	struct console *con;
-
 	if (console_suspend_enabled)
 		pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 
@@ -2749,8 +2754,7 @@ void console_suspend_all(void)
 		return;
 
 	console_list_lock();
-	for_each_console(con)
-		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	consoles_suspended_srcu_write(true);
 	console_list_unlock();
 
 	/*
@@ -2765,7 +2769,6 @@ void console_suspend_all(void)
 void console_resume_all(void)
 {
 	struct console_flush_type ft;
-	struct console *con;
 
 	/*
 	 * Allow queueing irq_work. After restoring console state, deferred
@@ -2776,8 +2779,7 @@ void console_resume_all(void)
 
 	if (console_suspend_enabled) {
 		console_list_lock();
-		for_each_console(con)
-			console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+		consoles_suspended_srcu_write(false);
 		console_list_unlock();
 
 		/*

Best Regards,
Petr

