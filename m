Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BC3C433FE
	for <linux-um@archiver.kernel.org>; Fri, 21 Oct 2022 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bhn6MpSZXFDXPUHA+M/b28nwlLzpH5P7pGgltDnJBLk=; b=nau3z/3QLxg/am
	s6aaKVk5WZawV5HOVbmQvvRl2eTeoNNmzTRWOydCWBZAshg0RRyC2YQpx7DVyxFdbwRUhOgI1YTN5
	Bw6lKLrweckkGaAL0PZ5jGWgx/cxK1g7ZXYa7+4nzDMQt5e9N3XdWxFa+NCeG23NCMXiFeINtWRaG
	2f82LNXrN9LcHnkeE+FacaDH7evGYwt9NWhgkpvQQ7wdqwR9oYu2LZ5/I+9Sn3mGF1GXIzwrR4o8y
	8VO/4lNLv9AdugGB2R0J/VFx4K6wlp8xUx/Tw9mLUrR2XN0+pxYkI3zkZSsba/Y1Rc24qOst7uhpI
	9S2NnjlXAh+MOrzARGog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltRT-008cAP-4R; Fri, 21 Oct 2022 14:56:11 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oltRQ-008c9i-GP
	for linux-um@lists.infradead.org; Fri, 21 Oct 2022 14:56:09 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id BBCD421ABC;
	Fri, 21 Oct 2022 14:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1666364164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f1SvQMXi10r+rqaqtdwYHyeOxYLEtVGhID9W890ELfQ=;
	b=rWuQYy5ekQHJwfeXZGz4uX4PxDIIgxv0+pb4rsYn/WNu8BYJ4dwxshLkJph917IL6rEVfC
	pGSjFdhqLOqOZeyHJMkLW3Yc+CVyaOn9cqbhS/iYyoFtGJ2InyQqVwOrPs7Nd0hzob1N8L
	4m0PnAefcnJ0HdHHsFZDE62o8+6qP18=
Received: from suse.cz (unknown [10.100.201.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id 55FCB2C141;
	Fri, 21 Oct 2022 14:56:04 +0000 (UTC)
Date: Fri, 21 Oct 2022 16:56:03 +0200
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Meyer <thomas@m3y3r.de>, linux-um@lists.infradead.org
Subject: Re: [PATCH printk v2 20/38] um: kmsg_dumper: use srcu console list
 iterator
Message-ID: <Y1KzA0Avz08iW6l5@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-21-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-21-john.ogness@linutronix.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221021_075608_710614_7EBE96EB 
X-CRM114-Status: GOOD (  23.29  )
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

On Wed 2022-10-19 17:01:42, John Ogness wrote:
> Rather than using the console_lock to guarantee safe console list
> traversal, use srcu console list iteration.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  arch/um/kernel/kmsg_dump.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/um/kernel/kmsg_dump.c b/arch/um/kernel/kmsg_dump.c
> index 3a3bbbb22090..44a418dec919 100644
> --- a/arch/um/kernel/kmsg_dump.c
> +++ b/arch/um/kernel/kmsg_dump.c
> @@ -16,20 +16,17 @@ static void kmsg_dumper_stdout(struct kmsg_dumper *dumper,
>  	struct console *con;
>  	unsigned long flags;
>  	size_t len = 0;
> +	int cookie;
>  
>  	/* only dump kmsg when no console is available */

I agree that it is perfectly fine to use RCU here. The previous
code was just a best effort. The kdump was done without console_lock()
so that the console might get available in the meantime.

I guess that it is not a big deal. The dumper is called typically only
during panic() where new consoles are not added.

> -	if (!console_trylock())
> -		return;
> -
> -	for_each_console(con) {
> +	cookie = console_srcu_read_lock();
> +	for_each_console_srcu(con) {
>  		if (strcmp(con->name, "tty") == 0 &&
>  		    (console_is_enabled(con) || (con->flags & CON_CONSDEV))) {

This is slightly more racy than the previous code. Only one console
could have CON_CONSDEV. It might be moved to another console when the
list is manipulated. As a result, rcu walk might see zero, one, or two
consoles with this flag unless the flag is moved carefully.

Anyway, this check does not match the comment and does not make much
sense to me. It is true that CON_CONSDEV flag is used only for
registered consoles. But messages are printed on the console only
when CON_ENABLED flag is set.

IMHO, we should check only console_is_enabled() here.

Adding Thomas Meyer and Richard Weinberger <richard@nod.at> into Cc.
Thomas added this check in the commit e23fe90dec286cd77e90
("um: kmsg_dumper: always dump when not tty console") and
Richard pushed it.

>  			break;
>  		}
>  	}
> -
> -	console_unlock();
> -
> +	console_srcu_read_unlock(cookie);
>
>  	if (con)
>  		return;

Best Regards,
Petr

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
