Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA51C71155
	for <linux-um@archiver.kernel.org>; Fri, 20 Jun 2025 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zf9eZNGS/J7cqsYhd+Ez8QubB3SKjLSoDlWDiWnAjOA=; b=F53zK1gnKH9TH+IXlEtZRinCm2
	Q48XV9iFZqgs50o/eDOHlYf9b//MEDTacw/YW+VweaiTqNXhoIjihUp1sK9+bW0UlhlJAY0LfXsFt
	SXPEvC8eNaiBCYOrq0Co6BxQ8pfFp5kAgXPch39dETuAaSRNC0xLmz3hX3WGpWhmiCPwE4AEgA2m9
	lWaFZ7HdYYp7+FmnrTgRN/A5Ru8tH1++b4fAysRDjagxymB0H0ih3H+AkYfuiyO//JmmLe1C848W9
	4BY1u/TVqn8zCdADi1kouWfCWCkaAysRrdanqrfOiLFTTX1D4hU30NsvDDba9/WKZkA9Xh99cWgOg
	a+EsrHdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSd0P-0000000FtYG-1HMG;
	Fri, 20 Jun 2025 14:46:13 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uScxT-0000000FsrE-2Evm
	for linux-um@lists.infradead.org;
	Fri, 20 Jun 2025 14:43:12 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750430588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf9eZNGS/J7cqsYhd+Ez8QubB3SKjLSoDlWDiWnAjOA=;
	b=hb5o0dc5GvKPdYV2/5l5iL+pdghzJ2cRGQIbp7KrHSBtdO/MvYQA9hh0euy5xWrNs0MPpg
	RJU0iL6518QlFrA1pAP7KYd/L+m8HX1RZQSqEWaVhhxDWnphvEtVas/jU/v33PqkNo4p/w
	40jWxyWIXW6IBniJKMlSY3cetMBiJcGrOnGX2Xs2vHEHEUTXEVlDpZytucx+jIxnwveFTq
	BZJA1eQMDblJv1+5SDfDNEMJchkbmNGr27nSwY6VaSoVmE9guI6vTlXJWRplUxCfPC/7ww
	RlS3OC5noZq6jer3COwBLhR0eLTaieuys/mBmz0Ws3fNPoPKuu/Is+R12ktaFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750430588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf9eZNGS/J7cqsYhd+Ez8QubB3SKjLSoDlWDiWnAjOA=;
	b=GK+xBRhvIL3VuhN/qjyFnX59zi7Ek/5vSo7O6W52qAcr05hqeOrgmxcBFIwe5uMC0oARw/
	vIV++n1IzWc76PCQ==
To: Petr Mladek <pmladek@suse.com>, Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Jason
 Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
In-Reply-To: <aExBo-8cVOy6GegR@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz>
Date: Fri, 20 Jun 2025 16:49:07 +0206
Message-ID: <84y0tmiidg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_074311_714606_351C734F 
X-CRM114-Status: GOOD (  35.44  )
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

On 2025-06-13, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
>> index fd12efcc4aeda8883773d9807bc215f6e5cdf71a..72de12396e6f1bc5234acfdf=
6dcc393acf88d216 100644
>> --- a/kernel/printk/nbcon.c
>> +++ b/kernel/printk/nbcon.c
>> @@ -1147,7 +1147,7 @@ static bool nbcon_kthread_should_wakeup(struct con=
sole *con, struct nbcon_contex
>>  	cookie =3D console_srcu_read_lock();
>>=20=20
>>  	flags =3D console_srcu_read_flags(con);
>> -	if (console_is_usable(con, flags, false)) {
>> +	if (console_is_usable(con, flags, false, consoles_suspended)) {
>
> The new global console_suspended value has the be synchronized the
> same way as the current CON_SUSPENDED per-console flag.
> It means that the value must be:
>
>   + updated only under console_list_lock together with
>     synchronize_rcu().
>
>   + read using READ_ONCE() under console_srcu_read_lock()

Yes.

> I am going to propose more solutions because no one is obviously
> the best one.

[...]

> Variant C:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Remove even @flags parameter from console_is_usable() and read both
> values there directly.
>
> Many callers read @flags only because they call console_is_usable().
> The change would simplify the code.
>
> But there are few exceptions:
>
>   1. __nbcon_atomic_flush_pending(), console_flush_all(),
>      and legacy_kthread_should_wakeup() pass @flags to
>      console_is_usable() and also check CON_NBCON flag.
>
>      But CON_NBCON flag is special. It is statically initialized
>      and never set/cleared at runtime. It can be checked without
>      READ_ONCE(). Well, we still might want to be sure that
>      the struct console can't disappear.
>
>      IMHO, this can be solved by a helper function:
>
> 	/**
> 	 * console_srcu_is_nbcon - Locklessly check whether the console is nbcon
> 	 * @con:	struct console pointer of console to check
> 	 *
> 	 * Requires console_srcu_read_lock to be held, which implies that @con m=
ight
> 	 * be a registered console. The purpose of holding console_srcu_read_loc=
k is
> 	 * to guarantee that no exit/cleanup routines will run if the console
> 	 * is currently undergoing unregistration.
> 	 *
> 	 * If the caller is holding the console_list_lock or it is _certain_ that
> 	 * @con is not and will not become registered, the caller may read
> 	 * @con->flags directly instead.
> 	 *
> 	 * Context: Any context.
> 	 * Return: True when CON_NBCON flag is set.
> 	 */
> 	static inline bool console_is_nbcon(const struct console *con)
> 	{
> 		WARN_ON_ONCE(!console_srcu_read_lock_is_held());
>
> 		/*
> 		 * The CON_NBCON flag is statically initialized and is never
> 		 * set or cleared at runtime.
> 		return data_race(con->flags & CON_NBCON);
> 	}

Agreed.

>    2. Another exception is __pr_flush() where console_is_usable() is
>       called twice with @use_atomic set "true" and "false".
>
>       We would want to read "con->flags" only once here. A solution
>       would be to add a parameter to check both con->write_atomic
>       and con->write_thread in a single call.

Or it could become a bitmask of printing types to check:

#define ATOMIC_PRINTING 0x1
#define NONATOMIC_PRINTING 0x2

and then __pr_flush() looks like:

if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)

>       But it might actually be enough to check is with the "false"
>       value because "con->write_thread()" is mandatory for nbcon
>       consoles. And legacy consoles do not distinguish atomic mode.

A bit tricky, but you are right.

>
>
> Variant D:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> We need to distinguish the global and per-console "suspended" flag
> because they might be nested. But we could use a separate flag
> for the global setting.
>
> I mean that:
>
>     + console_suspend() would set CON_SUSPENDED flag
>     + console_suspend_all() would set CON_SUSPENDED_ALL flag
>
> They both will be in con->flags.
>
> Pros:
>
>     + It is easy to implement.
>
> Cons:
>
>     + It feels a bit ugly.
>
>
> My opinion:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I personally prefer the variant C because:
>
>   + Removes one parameter from console_is_usable().
>
>   + The lockless synchronization of both global and per-console
>     flags is hidden in console_is_usable().
>
>   + The global console_suspended flag will be stored in global
>     variable (in compare with variant D).
>
> What do you think, please?
>
> Best Regards,
> Petr
>
>
> PS: The commit message and the cover letter should better explain
>     the background of this change.
>
>     It would be great if the cover letter described the bigger
>     picture, especially the history of the console_suspended,
>     CON_SUSPENDED, and CON_ENABLED flags. It might use info
>     from
>     https://lore.kernel.org/lkml/ZyoNZfLT6tlVAWjO@pathway.suse.cz/
>     and maybe even this link.
>
>     Also this commit message should mention that it partly reverts
>     the commit 9e70a5e109a4a233678 ("printk: Add per-console
>     suspended state"). But it is not simple revert because
>     we need to preserve the synchronization using
>     the console_list_lock for writing and SRCU for reading.

--=20
John Ogness
Linutronix GmbH | Bahnhofstra=C3=9Fe 3 | D-88690 Uhldingen-M=C3=BChlhofen
Phone: +49 7556 25 999 20; Fax.: +49 7556 25 999 99

Hinweise zum Datenschutz finden Sie hier (Information on data privacy
can be found here): https://linutronix.de/legal/data-protection.php

Linutronix GmbH | Firmensitz (Registered Office): Uhldingen-M=C3=BChlhofen |
Registergericht (Registration Court): Amtsgericht Freiburg i.Br., HRB700
806 | Gesch=C3=A4ftsf=C3=BChrer (Managing Directors): Harry Demas, Heinz Eg=
ger,
Thomas Gleixner, Yin Sorrell, Jeffrey Schneiderman

