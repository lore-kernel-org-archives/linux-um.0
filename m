Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97192C7EE31
	for <linux-um@archiver.kernel.org>; Fri, 27 Jun 2025 07:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yp1Bb7DQMqlOrGPV9KEp8CAXHL0KUqLgPG1+1oS0X7o=; b=30WpBV7CP6uKE/TuHyfWtjRCWk
	oj93YT22h2ZS2Dfgh45D5EgX3THaWV2zzHguIY0YBBKrS0rZsV+41+Xx6BhPSTsbxK7XoNS7q/jg5
	ws4KWf4mHDNjMkXxQ8S7KHh8udXW/7FCr/PZesGmXgqSROxM1j4gVumJBgcca2bDGL6T9q7IdZYPz
	CjjRnxRcIpXlbyxJDdaVClz4V7agc38L1MGjDz9Td2Tdann0bsexX+iJ/jGQUTeQDPTeiHjoySc5z
	Gcp/H9W9YK3ehZo3frNpmpMD6sQbZbP/qLhn2EbmifiBgSR5OEtnwlcVUuuLAla4P48nP4co7w/Ru
	UqvVEy/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3vG-0000000DtMp-0mkl;
	Fri, 27 Jun 2025 07:54:58 +0000
Received: from galois.linutronix.de ([193.142.43.55])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uV3m1-0000000Drsn-0mpD
	for linux-um@lists.infradead.org;
	Fri, 27 Jun 2025 07:45:26 +0000
Date: Fri, 27 Jun 2025 09:45:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751010321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yp1Bb7DQMqlOrGPV9KEp8CAXHL0KUqLgPG1+1oS0X7o=;
	b=ovq2ny1Z+6Id1thNR9GHM+c+wipyFEbqN2JQFxms/iaYbf2GlX2bhyk+L+YDBclhh5619O
	vS995Rshzo3LHPk+G/21Vh4DTFx+qXiZ0fS7kHLSThRkyO935uj9+iAzaB/CVHTeinIfhu
	EL4WO5xMeiugYRqOJd7Da2hScZioPFy/vu2Ccriegt226SL8F8uJ9TAiRUj5wgkzTMG+0W
	x7BYVTez4trpXt2V8i+9RuAgGr7JjKxxCSGWuIQ8YTGXpOXfIYehpmvFTPysqXL4nVSsfE
	7glNwG4C8a++HEalNpnXSq3wt7wvBtsCz3wY9dMPEuZUHmihKcscc1sx6nQghw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751010321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yp1Bb7DQMqlOrGPV9KEp8CAXHL0KUqLgPG1+1oS0X7o=;
	b=r/6CqskiHKjHczGUt1R/WPH/N/Ek1hNktTiDJ/xAFiHOpdwRArRBu1QFYo4vlpCXFK0Oud
	IGnf0sSuGbKqMcCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>, 
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Subject: Re: [RFC 1/2] tools/nolibc: add sigaction()
Message-ID: <20250627092734-ed8973ef-444f-4996-beee-e0c4f637fc52@linutronix.de>
References: <20250626195714.2123694-1-benjamin@sipsolutions.net>
 <20250626195714.2123694-2-benjamin@sipsolutions.net>
 <20250627063347-cc3c0ad0-7b3b-4bcd-963f-729db103760f@linutronix.de>
 <f0c27ce58466d790551689b752a33fa0de6235b9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0c27ce58466d790551689b752a33fa0de6235b9.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250627_004525_369768_80C59833 
X-CRM114-Status: GOOD (  42.48  )
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

On Fri, Jun 27, 2025 at 06:46:56AM +0000, Berg, Benjamin wrote:
> On Fri, 2025-06-27 at 06:48 +0200, Thomas Weißschuh wrote:
> > On Thu, Jun 26, 2025 at 09:57:13PM +0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > In preparation to add tests that use it.
> > 
> > I tried to implement signal support in nolibc before but ran into some issues.
> > Unfortunately I don't remember the details.
> > But I guess you know more about signals than me, so let's try it again.
> > In any case this should add some tests to
> > tools/testing/selftests/nolibc/nolibc-test.c.
> > 
> > If you test it with qemu-user please be aware that there were issues around
> > SA_RESTORER up until recently [0] [1].
> 
> Oh, is there a convenient way to cross-compile for various
> architectures and run them using qemu?
> 
> So far I only tried x86/x86_64.

We have a script for that in the nolibc testsuite:

$ cd tools/testing/selftests/nolibc/
$ ./run-tests.sh -p -m user
i386:          225 test(s): 222 passed,   3 skipped,   0 failed => status: warning
x86_64:        225 test(s): 222 passed,   3 skipped,   0 failed => status: warning
arm64:         225 test(s): 222 passed,   3 skipped,   0 failed => status: warning
...

"-p" downloads a bunch of toolchains from kernel.org
"-m user" uses qemu-user. "-m system", or no "-m" at all would build a kernel and use qemu-system.
"-l" will use llvm/clang instead of gcc (only use with "-m user").

Actual tests are in nolibc-test.c.

> > 
> > [1] https://lore.kernel.org/qemu-devel/20250202-riscv-sa-restorer-v1-1-6f4bf814a1dd@t-8ch.de/
> > [0] https://lore.kernel.org/qemu-devel/mvmed060xc9.fsf@suse.de/
> > 
> > > 
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > ---
> > >  tools/include/nolibc/nolibc.h |  3 +++
> > >  tools/include/nolibc/signal.h | 34 ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 37 insertions(+)
> > > 
> > > diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> > > index c199ade200c2..29e37a755aba 100644
> > > --- a/tools/include/nolibc/nolibc.h
> > > +++ b/tools/include/nolibc/nolibc.h
> > > @@ -92,6 +92,9 @@
> > >  #ifndef _NOLIBC_H
> > >  #define _NOLIBC_H
> > >  
> > > +/* So that we do not get compatibility types/defines */
> > > +#define __KERNEL__
> > 
> > Could you explain this more?
> > 
> > The user may have included kernel UAPI headers already before including nolibc,
> > so it doesn't really work.
> 
> Maybe we should just set it in the CFLAGS directly then?

We also don't control the CFLAGS the user is using.

> Honestly, I am not entirely sure how you are supposed to do it
> correctly. The thing is, if I do not set __KERNEL__, then I get the old
> compatibility defines and types from asm/signal.h.
> 
> And, I do not see an alternative way. It would not be safe to avoid the
> include entirely and if you try that you are also missing the
> SA_RESTORER define for the proper "struct sigaction" definition to be
> correct.
> 
> The best alternative I see would be copying the proper definitions into
> the architecture specific header. That would also be ugly, as one would
> need to do a "struct sigaction" -> "struct nolibc_rt_sigaction"
> conversion internally. But, that would have the advantage that nolibc
> works outside of the kernel tree.

I think we need to do something like this.
Luckily the real mess seems to be only on x86.

> Even if all this is ugly, I would prefer that over using the
> compatibility sigaction syscall instead of rt_sigaction.

As an alternative, you are not forced to use nolibc for the KUnit UAPI
framework. You can depend on CONFIG_CC_CAN_LINK_STATIC=y and use "-static" for
the toolchains "real" libc.
Not that I want to discourage you from contributing to nolibc, though.

> > > +
> > >  #include "std.h"
> > >  #include "arch.h"
> > >  #include "types.h"
> > > diff --git a/tools/include/nolibc/signal.h b/tools/include/nolibc/signal.h
> > > index ac13e53ac31d..fa52119e577f 100644
> > > --- a/tools/include/nolibc/signal.h
> > > +++ b/tools/include/nolibc/signal.h
> > > @@ -14,6 +14,7 @@
> > >  #include "arch.h"
> > >  #include "types.h"
> > >  #include "sys.h"
> > > +#include <linux/signal.h>
> > >  
> > >  /* This one is not marked static as it's needed by libgcc for divide by zero */
> > >  int raise(int signal);
> > > @@ -23,4 +24,37 @@ int raise(int signal)
> > >  	return sys_kill(sys_getpid(), signal);
> > >  }
> > >  
> > > +/*
> > > + * sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
> > > + */
> > > +
> > > +#ifdef SA_RESTORER
> > > +__attribute__((naked))
> > 
> > __attribute__((naked)) is not supported everywhere.
> 
> One can just drop it. It just felt it was cleaner as we really just
> want to set the register and do the syscall without modifying the
> stack.

If it works without, also good.
If you want you can also use __nolibc_has_attribute(naked) from compiler.h.

<snip>

