Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A264CAC593
	for <linux-um@archiver.kernel.org>; Mon, 15 Sep 2025 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RYTqmsy1+Guedq8m0YcFaDt6GQMWVHQr59/YfD5k5D0=; b=hmCbkRzdx/x/6PhqrQTJn7PTL8
	dfv5gSBaBfe7i1Q/ZMaQW52I09NDXx5Zv8L+2CHvC5g0dRIsLoaljCic6XE6eYZsgl9+3cQGnZoKc
	CNEId6axemubL0GLAImqKBAelKVdwhy/ZkMYRJgTu8SnlQ08rO/zy7kezQWIp/1XPU5wA3xnbPTqD
	6zQmCt4Jl733VtXhukUKDUAyp7wzH6MGfaJM5o3/vEyrAJLa9kuo5oTaqzyKw+Lxayf7Vst1Hw66b
	mvwykNH7qePymaZdvK3dc5wXTsT6NgBqYIqdArBDbZzAtvTxtCAlPc025mQzI9BgQhhYRoh2MgXgC
	cDJcFryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7I2-00000003t3X-25I9;
	Mon, 15 Sep 2025 11:22:34 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy7Hz-00000003t2y-2rpZ
	for linux-um@lists.infradead.org;
	Mon, 15 Sep 2025 11:22:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1757935349;
	bh=PAjPq3B9hFsEN5lR0jqdf5nTliy719TlSkE9VoU8j1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uC8/kR9yUQYP9rdbOXkUUWIRWOw/+cuscUruXfycZIBb4nIxRFFyytWPe66rF4GJQ
	 3zWg0+E8oknvA0qXFTkA8NtV9zNm8VM4PdmFnYB8iqAqk0STf82TW29Z+kTF5foEXm
	 mxrWBqGZjm3nmHZ41T39VlnwoxfMzrzYSmrma0m0=
Date: Mon, 15 Sep 2025 13:22:29 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: "Berg, Benjamin" <benjamin.berg@intel.com>
Cc: "w@1wt.eu" <w@1wt.eu>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "tiwei.btw@antgroup.com" <tiwei.btw@antgroup.com>, 
	"acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 9/9] um: switch ptrace FP register access to nolibc
Message-ID: <0c8abee7-8987-45da-b168-0bf7d78d9184@t-8ch.de>
References: <20250915071115.1429196-1-benjamin@sipsolutions.net>
 <20250915071115.1429196-10-benjamin@sipsolutions.net>
 <5502ceaf-0b40-4961-b9ba-0c5e63498778@t-8ch.de>
 <8d6ee835fae809aa2703c51b8443878446245cfb.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d6ee835fae809aa2703c51b8443878446245cfb.camel@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250915_042231_874664_19EB945D 
X-CRM114-Status: GOOD (  31.62  )
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

On 2025-09-15 11:09:40+0000, Berg, Benjamin wrote:
> On Mon, 2025-09-15 at 11:07 +0200, Thomas Weißschuh wrote:
> > On 2025-09-15 09:11:15+0200, Benjamin Berg wrote:
> > > From: Benjamin Berg <benjamin.berg@intel.com>
> > > 
> > > The registers.c file only contain the routines for floating point
> > > register access in ptrace mode and initial size detection. The file can
> > > be moved over to nolibc by replacing the ptrace libc call with a simple
> > > wrapper that does a direct syscall.
> > > 
> > > Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> > > ---
> > >  arch/x86/um/os-Linux/Makefile    |  5 ++++-
> > >  arch/x86/um/os-Linux/registers.c | 22 ++++++++--------------
> > >  2 files changed, 12 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/arch/x86/um/os-Linux/Makefile b/arch/x86/um/os-Linux/Makefile
> > > index 77a308aaa5ec..d37320430822 100644
> > > --- a/arch/x86/um/os-Linux/Makefile
> > > +++ b/arch/x86/um/os-Linux/Makefile
> > > @@ -3,10 +3,13 @@
> > >  # Licensed under the GPL
> > >  #
> > >  
> > > -obj-y = registers.o mcontext.o
> > > +obj-y = mcontext.o
> > >  
> > >  obj-$(CONFIG_X86_32) += tls.o
> > >  
> > >  USER_OBJS := $(obj-y)
> > >  
> > > +obj-y += registers.o
> > > +NOLIBC_OBJS := registers.o
> > > +
> > >  include $(srctree)/arch/um/scripts/Makefile.rules
> > > diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> > > index eb1cdadc8a61..55bce0d3f5d2 100644
> > > --- a/arch/x86/um/os-Linux/registers.c
> > > +++ b/arch/x86/um/os-Linux/registers.c
> > > @@ -6,18 +6,20 @@
> > >  
> > >  #include <errno.h>
> > 
> > Given that you are explicitly disabling errno support for nolibc, is
> > this include necessary?
> 
> I think it is technically correct as we do need ENODEV and ENOMEM to be
> defined. Not that we actually need the include if we pull in nolibc.h.

Yes, indeed.

> Considering we would never build against libc, should we maybe just do
> an explicit nolibc.h include and rely on it pulling in the rest
> automatically? That seems a bit weird to me, but as-is we will never
> notice when we forget an include.

Your choice. nolibc will always include itself fully transitively in any
case. So you won't notice a missing include that way either. The
different headers mostly exist to structure the nolibc sources
themselves and to let the application code look normal.
I would go with normal includes.

> > >  #include <stdlib.h>
> > > -#include <sys/ptrace.h>
> > > +#include <linux/ptrace.h>
> > >  #ifdef __i386__
> > >  #include <sys/user.h>
> > >  #endif
> > >  #include <longjmp.h>
> > >  #include <sysdep/ptrace_user.h>
> > > -#include <sys/uio.h>
> > > +#include <linux/uio.h>
> > 
> > It looks fairly trivial to add sys/uio.h to nolibc.
> > Only 'struct iovec' (already provided by the UAPI) and readv()/writev()
> > are necessary.
> > 
> > >  #include <asm/sigcontext.h>
> > >  #include <linux/elf.h>
> > >  #include <registers.h>
> > >  #include <sys/mman.h>
> > >  
> > > +#define my_ptrace(...) my_syscall4(__NR_ptrace, __VA_ARGS__)
> > 
> > Why not add sys/ptrace.h to nolibc and then use sys_ptrace()?
> 
> Honestly, I just got a bit lazy at that point and this was a reasonable
> proof that mixing nolibc with libc works fine.

Fair enough :-)

> You are absolutely right
> that it would be better to add this to nolibc.
> 
> > In general I'm not a fan of the my_syscall() naming scheme and would
> > like to change this in nolibc itself, so having fewer external users
> > would be nice.
> 
> How about adding a sys_syscall macro? That would match the naming
> scheme of the other functions. Then, once all users are ported, one can
> simply change the my_ prefix to __nolibc_.

sys_syscall() looks weird. Personally I would have gone with _syscall().
Let's just sidestep the issue for now by adding sys_ptrace() to nolibc.

(...)

