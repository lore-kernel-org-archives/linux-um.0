Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B740CC77B7C
	for <linux-um@archiver.kernel.org>; Tue, 24 Jun 2025 11:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5eEk+aF+pt0MvEUwqDpSXabyNiN3Qdyl9X0CVlT8PCA=; b=n2YX2FULRjjn/Hw2CTNa91H7pW
	HsrI6aleyxYyHiWkaBuxW28PREs88OFmvlbzpVpc0ESTaIjM8D63NcB7p4/xIy7vOXOZAynaUs1WW
	YpWIhHEufQoRNeK+Do1nrzXwMUU5b7KM7Yt/eDVRRh8qtvR/+iuvn6Rbo9W91lTZRyw9FNAnSigzj
	8f4h3lVOJ+G82i3Z9JHabzztdmTFQu3B44OoCF58jgrgsgxqRAo7HNsqFx8id3xE/V4SvtGPzinxi
	lCacEN373lN3JQVwi5Vhvdck53fmfBiBZYdnpRGMIPwsnI6ZoAOOxRcXb5KD7PxzuJCpGAd8hPyIb
	SAGhFwRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU29h-00000005T5G-2lk8;
	Tue, 24 Jun 2025 11:49:37 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU1S1-00000005O5U-1O59
	for linux-um@lists.infradead.org;
	Tue, 24 Jun 2025 11:04:30 +0000
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750763066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eEk+aF+pt0MvEUwqDpSXabyNiN3Qdyl9X0CVlT8PCA=;
	b=QYALeI+wDWqdBcwoiCZT1gW13kZ0aWUTJAiRv5eh24JUe0U9MCzVDV71qbKcJEx8oDqHiL
	OXwAdfdvdF/diXvlbh8URTt5TzWvTQhqVtnQheBVZ9jGaOscKmRkIr5JQ5/aBxmfeXjrgj
	JExpQURBdHLkh1O0cglLYOty2dkpagdb8/D5sSy5v4SvOVCr1n9LAkduV6Lfau4uCW3UcY
	03pvnvXuyhL8EjsMe69F/RQCrvQFaldkgAEfcchAE6GBiu0j284+9FXRSD89SBHuUEusm6
	aSzZLEvID0iLevu9ODhbRcNDdAvhyEDmMYalCMdUVZk3uk1DNXtTFgDkYOCIsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750763066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eEk+aF+pt0MvEUwqDpSXabyNiN3Qdyl9X0CVlT8PCA=;
	b=b0nCeoNQlxtkF/VATw84CXoUW5gF8S9AJRZCXj3wuKZzjUykZsiuJ6FQYpbQlla9ns5vhy
	D23fvPgwu8aY34AQ==
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Jason Wessel <jason.wessel@windriver.com>, Daniel
 Thompson <danielt@kernel.org>, Douglas Anderson <dianders@chromium.org>,
 Richard Weinberger <richard@nod.at>, Anton Ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 2/7] printk: Use consoles_suspended flag when
 suspending/resuming all consoles
In-Reply-To: <aFpkQHwNCslbKSP6@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-2-f427c743dda0@suse.com>
 <aExBo-8cVOy6GegR@pathway.suse.cz> <84y0tmiidg.fsf@jogness.linutronix.de>
 <aFpkQHwNCslbKSP6@pathway.suse.cz>
Date: Tue, 24 Jun 2025 13:10:25 +0206
Message-ID: <84wm919z9i.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_040429_507848_13036D68 
X-CRM114-Status: GOOD (  14.71  )
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

On 2025-06-24, Petr Mladek <pmladek@suse.com> wrote:
>> > Variant C:
>> > ==========
>> >
>> > Remove even @flags parameter from console_is_usable() and read both
>> > values there directly.
>> >
>> > Many callers read @flags only because they call console_is_usable().
>> > The change would simplify the code.
>> >
>> > But there are few exceptions:
>> >
>> >    2. Another exception is __pr_flush() where console_is_usable() is
>> >       called twice with @use_atomic set "true" and "false".
>> >
>> >       We would want to read "con->flags" only once here. A solution
>> >       would be to add a parameter to check both con->write_atomic
>> >       and con->write_thread in a single call.
>> 
>> Or it could become a bitmask of printing types to check:
>> 
>> #define ATOMIC_PRINTING 0x1
>> #define NONATOMIC_PRINTING 0x2
>> 
>> and then __pr_flush() looks like:
>> 
>> if (!console_is_usable(c, flags, ATOMIC_PRINTING|NONATOMIC_PRINTING)
>
> I like this. It will help even in all other cases when one mode is needed.
> I mean that, for example:
>
>    console_is_usable(c, flags, ATOMIC_PRINTING)
>
> is more self-explaining than
>
>    console_is_usable(c, flags, true)

After I wrote that suggestion, I decided that the naming is not
good. There is always confusion about what "atomic printing" means. For
that reason the parameter was changed to "use_atomic". Basically we are
specifying which callback to use and not the purpose. It is a bit tricky
because legacy consoles do not have an atomic callback, i.e. the
parameter only has meaning for nbcon consoles.

Perhaps these macros would be more suitable:

#define NBCON_USE_ATOMIC 0x1
#define NBCON_USE_THREAD 0x2

or

#define NBCON_USE_WRITE_ATOMIC 0x1
#define NBCON_USE_WRITE_THREAD 0x2

or

#define NBCON_ATOMIC_CB 0x1
#define NBCON_THREAD_CB 0x2

or

#define NBCON_ATOMIC_FUNC 0x1
#define NBCON_THREAD_FUNC 0x2

Hopefully that gives Petr enough ideas that he can come up with good
naming. ;-)

John

