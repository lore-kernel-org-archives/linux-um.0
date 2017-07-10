Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dUe19-000505-Rv
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jul 2017 19:06:47 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dUe17-0003ME-TX
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jul 2017 19:06:47 +0000
References: <CAFLxGvzyMVKMmm6Xuf=myOQ+_XdndDYHv1TW8ztN5qT4i-uQsA@mail.gmail.com>
	<20170709223303.24424-1-thomas@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <57daaa1b-7bee-9b67-26db-c438a0a93987@nod.at>
Date: Mon, 10 Jul 2017 21:06:37 +0200
MIME-Version: 1.0
In-Reply-To: <20170709223303.24424-1-thomas@m3y3r.de>
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
To: Thomas Meyer <thomas@m3y3r.de>, user-mode-linux-devel@lists.sourceforge.net

Thomas,

Am 10.07.2017 um 00:33 schrieb Thomas Meyer:
> Hard code max size. Taken from
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob;f=gdb/common/x86-xstate.h
> 
> v3: use static fp_regs for get_skas_faultinfo
> 
> Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> ---
>  arch/um/os-Linux/skas/process.c  |  7 ++++---
>  arch/x86/um/os-Linux/registers.c | 18 ++++++++++++------
>  arch/x86/um/user-offsets.c       |  2 +-
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
> index 03b3c4cc7735..b5fdef795985 100644
> --- a/arch/um/os-Linux/skas/process.c
> +++ b/arch/um/os-Linux/skas/process.c
> @@ -88,12 +88,13 @@ void wait_stub_done(int pid)
>  
>  extern unsigned long current_stub_stack(void);
>  
> +static unsigned long skas_faultinfo_fpregs[FP_SIZE];
> +

Uhmm, are you sure that this does not race with other userspace() instances?

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

