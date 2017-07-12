Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dVN9h-0004KD-Bk
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 19:18:37 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dVN9f-0001aq-PK
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2017 19:18:37 +0000
References: <c99c3170-53a6-4038-9033-5a3680b1e5db@email.android.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <261315a5-f93a-9c1a-cfca-bd41f5b20dc6@nod.at>
Date: Wed, 12 Jul 2017 21:18:26 +0200
MIME-Version: 1.0
In-Reply-To: <c99c3170-53a6-4038-9033-5a3680b1e5db@email.android.com>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH] um: v3: Fix FP register size for
 XSTATE/XSAVE
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Thomas Meyer <thomas@m3y3r.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

Thomas,

Am 12.07.2017 um 17:11 schrieb Thomas Meyer:
> Am 10.07.2017 9:06 nachm. schrieb Richard Weinberger <richard@nod.at>:
> 
>     Thomas,
> 
>     Am 10.07.2017 um 00:33 schrieb Thomas Meyer:
>     > Hard code max size. Taken from
>     > https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h
>     >
>     > v3: use static fp_regs for get_skas_faultinfo
>     >
>     > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
>     > ---
>     >  arch/um/os-Linux/skas/process.c  |  7 ++++---
>     >  arch/x86/um/os-Linux/registers.c | 18 ++++++++++++------
>     >  arch/x86/um/user-offsets.c       |  2 +-
>     >  3 files changed, 17 insertions(+), 10 deletions(-)
>     >
>     > diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
>     > index 03b3c4cc7735..b5fdef795985 100644
>     > --- a/arch/um/os-Linux/skas/process.c
>     > +++ b/arch/um/os-Linux/skas/process.c
>     > @@ -88,12 +88,13 @@ void wait_stub_done(int pid)
>     > 
>     >  extern unsigned long current_stub_stack(void);
>     > 
>     > +static unsigned long skas_faultinfo_fpregs[FP_SIZE];
>     > +
> 
>     Uhmm, are you sure that this does not race with other userspace() instances?
> 
> Oh, is it really possible that a task gets schedule while we are in userspace signal handling from ptrace?

I hoped that you'd double check. ;)
From my knowledge it is not possible, but this code was not written by me and UML internal
semantics are more than tricky.
Let's postpone this patch for -rc2 and check again.

> Another question: when malloc a memory area in userspace: when does a userspace process end in userspace function!? Where would you free the malloced memory?

It ends via handle_trap() when userspac does an exit syscall.
I agree this is tricky to catch and needs more effort.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

