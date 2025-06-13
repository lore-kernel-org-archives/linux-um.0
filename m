Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D36E9C71136
	for <linux-um@archiver.kernel.org>; Fri, 13 Jun 2025 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IKghZF40bURJv6c1/M9CEvL/tJPBCTMeZ3wBhbe2yAU=; b=1bspnUy8lc4LSDaACLeskAW56I
	xHfYmnY4glqOFC2Ps8HZb44BraukZh+7kcILvdjWysdWP0epaJ4tMSDrwlJ1JWrKJiGrazb1F3FnM
	Aqwra+XqZwe88tgZ34kz4dgnS2n9XGf9wZumpTQvsOA54+cPoKofHIRzubmam17n2JqRRhTD5zuy9
	YTKU7UjY4httnFyXeHbdIIGSXP1uh899AdOZ65ALn839ObECA6IMJ2cahBXuuozgVSMfg8y6z71jU
	zHXoClr9GbK7YJYaAVeTkXfVTFyGAGCMBXcpS3PT+8JhVsoBkzL+4eFdqB6fbxroQdC/cbvcFVzeO
	jaeZ6swQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ7TY-0000000H4io-1bZ3;
	Fri, 13 Jun 2025 16:41:56 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ6Ch-0000000Gqmo-34CF
	for linux-um@lists.infradead.org;
	Fri, 13 Jun 2025 15:20:29 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so26431555e9.1
        for <linux-um@lists.infradead.org>; Fri, 13 Jun 2025 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749828025; x=1750432825; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKghZF40bURJv6c1/M9CEvL/tJPBCTMeZ3wBhbe2yAU=;
        b=coD+e9X8fJ+EuBAlZS4NZ67DCJaVVtiuo5UdEglXA/rfCXeJndo35NB48R08Yw+TKY
         CxJmJ2N+06mxxVAMXElEVn/KBNzvCJ4WGuqM9WMQDTKZWKmXBYHM+QzL0zdqZbsH7AKn
         bal9qKKd8ppzSe+/DweY0u60ApYQkInKNonkStNDJkMJ+W2D2hvjtR18SdOujWhfUBKX
         7SvJYuw/EUfk1TffnIAVJ8i1mLCf9p72yvWpw6uDvw7kfvTPmEK4W8QQ1abTK6sANKuR
         +aHVb3f7pxmdMqx5uzvWknmOVcFLTzT08b79kJ04e3ub76otf2zVY8USLYJrnA4orhEJ
         irSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749828025; x=1750432825;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKghZF40bURJv6c1/M9CEvL/tJPBCTMeZ3wBhbe2yAU=;
        b=E4EzoMaSyxgrUWPSwWJ5zjrlrQNMjKiueyv1Pu19SeGe7UIoUJoEhj3+DjSr7iBQEk
         v7wKquyUYoTccrkZyzzm/LBmbtPAAoYyQlHAMIq34MuAaPLHANcwi5h14yrhlXByhSZi
         aI1R3oZYkZh8GdwWiJ8DgifvX6FJ0PEzydYPAxaBEzAyA2kjZ61mSaSKzg0J81W8kD76
         pcy++8Bdy3McwPtAkhVI9tDF2RhDwkLDsXUI63ixVVQ/k6TSXKGGW7h+RhSGR+O6jA4G
         XeurlBsDACoywaF3EwNE3/iD2GKCE4qj05fxz9ZKfjXmevixmHOyrEMKPgrccWVCLGO3
         SvCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrPuG9Amr+QmXsDpFST+H3fG7563PW7kJqy5wZDOzsUkaGZsfq3z/H2Hiy7EFIT/mvCtvCefrQZw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yx0oDi6nCpVWAIjqRglLb4/rCtf4HyBDLd+NMpKa+8lb4rEfAwg
	g5p5L4dOi529GNXZDBFqeJ9jTv4CSMT4TPiH+qAmj+PKulfZD0NJn4YiGmNVOPZLv9c=
X-Gm-Gg: ASbGncu/byLHXsctSXEYrZwG+qtGDFdK2NiD3A4USwpAIbKui/Du4hvgijBBsWF2v4G
	wrXBpwfqg+7iGtO3eC6G8Bs1HADvo5F0apglX+CzUIt6aB974LWPxpAwS8UXpJJ+U2FIQ7M2MDW
	luFkfdaKmmaJ/pKpESKu2JbVKB86yB20OKYefaKuSAvBLTblj59QS4NXg9CE8XAG3beDnLV9qdc
	8oAUfAtK3ELiDxbwIPFkCLdrDMHT8mLtR/B5o6b7zIP+IRonheEGajJAc/8GvSvAwtRxX7yMaxE
	xOxj12YbnsTs7vnHqPiaTiYDnxID0nr1T8l/+8de9AjpRDFFb6cWswIqO8fIj7HV
X-Google-Smtp-Source: AGHT+IG0wPBdTWS6wVof0adSsVA4MK43CPoXzZFMCGpr9V6ukNZIjbxKLrOISAjwEQzvtDU5jyZr4A==
X-Received: by 2002:a05:6000:25eb:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3a572e2df7bmr142313f8f.26.1749828025451;
        Fri, 13 Jun 2025 08:20:25 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1691d7fsm1835856a12.69.2025.06.13.08.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 08:20:24 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:20:03 +0200
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
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
Message-ID: <aExBo-8cVOy6GegR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_082027_776622_82E57CDA 
X-CRM114-Status: GOOD (  33.12  )
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

On Fri 2025-06-06 23:53:44, Marcos Paulo de Souza wrote:
> Instead of update a per-console CON_SUSPENDED flag, use the console_list
> locks to protect this flag. This is also applied to console_is_usable
> functions, which now also checks if consoles_suspend is set.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/internal.h |  7 ++++++-
>  kernel/printk/nbcon.c    |  8 ++++----
>  kernel/printk/printk.c   | 23 ++++++++++-------------
>  3 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 48a24e7b309db20fdd7419f7aeda68ea7c79fd80..752101904f44b13059b6a922519d88e24c9f32c0 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -118,8 +118,12 @@ void nbcon_kthreads_wake(void);
>   * which can also play a role in deciding if @con can be used to print
>   * records.
>   */
> -static inline bool console_is_usable(struct console *con, short flags, bool use_atomic)
> +static inline bool console_is_usable(struct console *con, short flags,
> +				     bool use_atomic, bool consoles_suspended)
>  {
> +	if (consoles_suspended)
> +		return false;
> +
>  	if (!(flags & CON_ENABLED))
>  		return false;
>  
> @@ -212,6 +216,7 @@ extern bool have_boot_console;
>  extern bool have_nbcon_console;
>  extern bool have_legacy_console;
>  extern bool legacy_allow_panic_sync;
> +extern bool consoles_suspended;
>  
>  /**
>   * struct console_flush_type - Define available console flush methods
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf6dcc393acf88d216 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
>  	cookie = console_srcu_read_lock();
>  
>  	flags = console_srcu_read_flags(con);
> -	if (console_is_usable(con, flags, false)) {
> +	if (console_is_usable(con, flags, false, consoles_suspended)) {

The new global console_suspended value has the be synchronized the
same way as the current CON_SUSPENDED per-console flag.
It means that the value must be:

  + updated only under console_list_lock together with
    synchronize_rcu().

  + read using READ_ONCE() under console_srcu_read_lock()


I am going to propose more solutions because no one is obviously
the best one.

Variant A:
=========

Create a helper functions, similar to
console_srcu_read_flags() and console_srcu_write_flags():

Something like:

static inline bool console_srcu_read_consoles_suspended()
{
	WARN_ON_ONCE(!console_srcu_read_lock_is_held());

	/*
	 * The READ_ONCE() matches the WRITE_ONCE() when the value
	 * is modified console_srcu_write_consoles_suspended().
	 */
	return data_race(READ_ONCE(consoles_suspended));
}

static inline void console_srcu_write_consoles_suspended(bool suspended)
{
	lockdep_assert_console_list_lock_held();

	/* This matches the READ_ONCE() in console_srcu_read_consoles_suspended(). */
	WRITE_ONCE(consoles_suspended, suspended);
}

This has the drawback that most console_is_usable() callers would need
to get and pass both variables, for example:

--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -1137,6 +1137,7 @@ static bool nbcon_emit_one(struct nbcon_write_context *wctxt, bool use_atomic)
  */
 static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_context *ctxt)
 {
+	bool cons_suspended;
 	bool ret = false;
 	short flags;
 	int cookie;
@@ -1147,7 +1148,8 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	cookie = console_srcu_read_lock();
 
 	flags = console_srcu_read_flags(con);
-	if (console_is_usable(con, flags, false)) {
+	cons_suspended = console_srcu_read_consoles_suspended();
+	if (console_is_usable(con, flags, false, cons_suspended)) {
 		/* Bring the sequence in @ctxt up to date */
 		ctxt->seq = nbcon_seq_read(con);

Pros:

   + always correct

Cons:

   + not user friendly



Variant B:
==========

Do not pass @consoles_suspended as a parameter. Instead, read it
in console_us_usable() directly.

I do not like this because it is not consistent with the con->flags
handling and it is not clear why.


Variant C:
==========

Remove even @flags parameter from console_is_usable() and read both
values there directly.

Many callers read @flags only because they call console_is_usable().
The change would simplify the code.

But there are few exceptions:

  1. __nbcon_atomic_flush_pending(), console_flush_all(),
     and legacy_kthread_should_wakeup() pass @flags to
     console_is_usable() and also check CON_NBCON flag.

     But CON_NBCON flag is special. It is statically initialized
     and never set/cleared at runtime. It can be checked without
     READ_ONCE(). Well, we still might want to be sure that
     the struct console can't disappear.

     IMHO, this can be solved by a helper function:

	/**
	 * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
	 * @con:	struct console pointer of console to check
	 *
	 * Requires console_srcu_read_lock to be held, which implies that @con might
	 * be a registered console. The purpose of holding console_srcu_read_lock is
	 * to guarantee that no exit/cleanup routines will run if the console
	 * is currently undergoing unregistration.
	 *
	 * If the caller is holding the console_list_lock or it is _certain_ that
	 * @con is not and will not become registered, the caller may read
	 * @con->flags directly instead.
	 *
	 * Context: Any context.
	 * Return: True when CON_NBCON flag is set.
	 */
	static inline bool console_is_nbcon(const struct console *con)
	{
		WARN_ON_ONCE(!console_srcu_read_lock_is_held());

		/*
		 * The CON_NBCON flag is statically initialized and is never
		 * set or cleared at runtime.
		return data_race(con->flags & CON_NBCON);
	}


   2. Another exception is __pr_flush() where console_is_usable() is
      called twice with @use_atomic set "true" and "false".

      We would want to read "con->flags" only once here. A solution
      would be to add a parameter to check both con->write_atomic
      and con->write_thread in a single call.

      But it might actually be enough to check is with the "false"
      value because "con->write_thread()" is mandatory for nbcon
      consoles. And legacy consoles do not distinguish atomic mode.


Variant D:
==========

We need to distinguish the global and per-console "suspended" flag
because they might be nested. But we could use a separate flag
for the global setting.

I mean that:

    + console_suspend() would set CON_SUSPENDED flag
    + console_suspend_all() would set CON_SUSPENDED_ALL flag

They both will be in con->flags.

Pros:

    + It is easy to implement.

Cons:

    + It feels a bit ugly.


My opinion:
===========

I personally prefer the variant C because:

  + Removes one parameter from console_is_usable().

  + The lockless synchronization of both global and per-console
    flags is hidden in console_is_usable().

  + The global console_suspended flag will be stored in global
    variable (in compare with variant D).

What do you think, please?

Best Regards,
Petr


PS: The commit message and the cover letter should better explain
    the background of this change.

    It would be great if the cover letter described the bigger
    picture, especially the history of the console_suspended,
    CON_SUSPENDED, and CON_ENABLED flags. It might use info
    from
    https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
    and maybe even this link.

    Also this commit message should mention that it partly reverts
    the commit 9e70a5e109a4a233678 ("printk: Add per-console
    suspended state"). But it is not simple revert because
    we need to preserve the synchronization using
    the console_list_lock for writing and SRCU for reading.

