Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110C5CAC5A8
	for <linux-um@archiver.kernel.org>; Sun, 21 Sep 2025 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jLJuxKB/PPgDic7rB4z6F9PG20pfktyXJQHHD419PVM=; b=o3W/5lU//p2f2pZGS632gT7Qzc
	qtxganGAXrkPrlRDsQuJhk9d29rFiNK4V397ais/OKw6lHr0KlXxfnsS1IYtDT/+tLOSSxp5COAEl
	AcXsQUadnZJFf2KByEYWCEVSpnONKntOIeWk6v8yLGHq+vTkWdwFNWio19TZCHSGIgiL+36KXnTDF
	cdBm8aRfhm3Ldk8jp4v1R1irVXY7nqBYmjVckpi7HXaoX94HZGq7bZCoLgPKI7yG4r/vMAq2VEnGK
	P+gOBEPEbILjy1Gz4SXPvzBSOiCESUl7whwDQpjrBuYed1tqH6r2Ou8IGNO7VL5mkQIiAej/PFwzS
	zF8K+gEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0FIW-000000074at-1H7C;
	Sun, 21 Sep 2025 08:19:52 +0000
Received: from mta1.formilux.org ([51.159.59.229])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0FIT-000000074Zk-1cfV
	for linux-um@lists.infradead.org;
	Sun, 21 Sep 2025 08:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1758442787; bh=jLJuxKB/PPgDic7rB4z6F9PG20pfktyXJQHHD419PVM=;
	h=From:Message-ID:From;
	b=uOjdlXkb4h5eCFeMT4fMig8ZEDmQ2dOZSazY6P5NlAnTrN9FOxideYmLGTYRW2zkX
	 HqUSp8kuIjzAEOcJqcfvS0xm3JcgKN5wFqrs/b6SrgnPUCoSUHC8rUVubzXQ5nbelX
	 Pmb8vlnIAWWRtT6gPbWLJgGYcFX/Xm/0jkFzeTD0=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 71BEDC072E;
	Sun, 21 Sep 2025 10:19:47 +0200 (CEST)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 58L8Jlt9016845;
	Sun, 21 Sep 2025 10:19:47 +0200
Date: Sun, 21 Sep 2025 10:19:47 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Benjamin Berg <benjamin@sipsolutions.net>, linux-um@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Benjamin Berg <benjamin.berg@intel.com>
Subject: Re: [PATCH v2 10/11] tools/nolibc: add ptrace support
Message-ID: <20250921081947.GC16684@1wt.eu>
References: <20250919153420.727385-1-benjamin@sipsolutions.net>
 <20250919153420.727385-11-benjamin@sipsolutions.net>
 <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eced0e2b-8fb3-490f-bcbe-40a72e430db7@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250921_011949_709599_C51EE4BF 
X-CRM114-Status: GOOD (  16.73  )
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

On Sat, Sep 20, 2025 at 11:27:19AM +0200, Thomas Weißschuh wrote:
> > +/*
> > + * long ptrace(int op, pid_t pid, void *addr, void *data);
> > + *
> > + * However, addr may also be an integer in some cases.
> 
> This comment is a bit confusing. It reads like it can be an integer as
> in 'int' datatype. But the kernel expects an integer compatible with
> 'void *', so 'unsigned long'. I think we can drop the comment.

Or if the point is to insist that void* is not strictly required, a
comment might as well say "types for addr and data are ignored and
will be cast to void*". But given that the man page indicates two
void*, I think that callers are expected to cast ints to void* in
any case, and if so maybe indeed not saying anything about it would
be better.

> > + */
> > +static __attribute__((unused))
> > +long sys_vptrace(int op, pid_t pid, va_list args)
> > +{
> > +	return my_syscall4(__NR_ptrace, op, pid,
> > +			   va_arg(args, void *), va_arg(args, void *));
> > +}
> > +
> > +static __attribute__((unused))
> > +ssize_t sys_ptrace(int op, pid_t pid, ...)
> 
> ptrace(2) does not document addr and data to be optional.
> While it does acknowledge the fact that it is variadic on glibc,
> users are still recommended to always supply all arguments.
> I'd prefer to keep it simple and avoid the va_list.

The man indeed says they are *ignored*, not optional. I agree then that
it would be better not doing simpler than the standard and have to roll
back later. Let's just pass unused arguments to the system.

Thanks,
Willy

