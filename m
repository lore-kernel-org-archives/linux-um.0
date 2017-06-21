Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1dNf2h-0006KW-ID
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2017 12:47:31 +0000
Received: from b.ns.miles-group.at ([95.130.255.144] helo=radon.swed.at)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dNf2g-0000e9-4y
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2017 12:47:31 +0000
References: <1497923806.7300.2.camel@m3y3r.de>
	<98803c66-4a36-a95f-5a1b-51a40de7a3e6@nod.at>
	<1497948550.7300.5.camel@m3y3r.de>
	<25066617-df15-6d21-713c-1ede1e953448@nod.at>
	<1497981874.22112.20.camel@test-lenovo>
	<4d431238-28c7-3680-42f2-f7cf32acbc86@nod.at>
	<2fc7383c-852a-be3c-f934-b125fe9bdba2@nod.at>
	<1497988398.22550.5.camel@test-lenovo>
	<D352734E-E991-4338-A5B3-94E840039841@m3y3r.de>
	<CAAyZ8nrQiu3w_SyCBWLbjjbsb+_KwhFnHkK7hFMpB7UcDsBCsQ@mail.gmail.com>
	<1498038265.26879.2.camel@m3y3r.de>
From: Richard Weinberger <richard@nod.at>
Message-ID: <53cad09b-6062-7a18-310a-b7328d839ec4@nod.at>
Date: Wed, 21 Jun 2017 14:47:21 +0200
MIME-Version: 1.0
In-Reply-To: <1498038265.26879.2.camel@m3y3r.de>
Content-Language: en-US
Subject: Re: [uml-devel] um: PTRACE_SETREGSET failure with XSTATE on
 Kabylake CPU
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
To: Thomas Meyer <thomas@m3y3r.de>, Natale Patriciello <natale.patriciello@gmail.com>
Cc: "open list:USER-MODE LINUX (UML)" <user-mode-linux-devel@lists.sourceforge.net>

Thomas, Natale,

Am 21.06.2017 um 11:44 schrieb Thomas Meyer:
>> It is funny to see that this problem was firstly reported here [1] in
>> February 2017 without being considered until someone else bought a
>> new
>> laptop :)

sometimes mails/issues get lost...

> Yes, I like my new laptop :-)
> 
>> Anyway, thank you for digging into this; my temporary workaround at
>> the time was to use always the *_i387_registers functions.
> 
> Oops, there is the complete thread with the same problem. But sorry I
> don't follow uml-user, just uml-devel :-(

We really should merge these lists. ;-\

> As a quick fix you can try this:
> 
> diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
> index 00f54a91bb4b..6eac8220ab29 100644
> --- a/arch/x86/um/os-Linux/registers.c
> +++ b/arch/x86/um/os-Linux/registers.c
> @@ -30,7 +30,7 @@ int save_fp_registers(int pid, unsigned long *fp_regs)
>  
>  	if (have_xstate_support) {
>  		iov.iov_base = fp_regs;
> -		iov.iov_len = sizeof(struct _xstate);
> +		iov.iov_len = HOST_FP_SIZE * sizeof(unsigned long);
>  		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>  			return -errno;
>  		return 0;
> @@ -49,10 +49,9 @@ int restore_i387_registers(int pid, unsigned long *fp_regs)
>  int restore_fp_registers(int pid, unsigned long *fp_regs)
>  {
>  	struct iovec iov;
> -
>  	if (have_xstate_support) {
>  		iov.iov_base = fp_regs;
> -		iov.iov_len = sizeof(struct _xstate);
> +		iov.iov_len = HOST_FP_SIZE * sizeof(unsigned long);
>  		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
>  			return -errno;
>  		return 0;
> @@ -126,7 +125,7 @@ void arch_init_registers(int pid)
>  	struct iovec iov;
>  
>  	iov.iov_base = &fp_regs;
> -	iov.iov_len = sizeof(struct _xstate);
> +	iov.iov_len = HOST_FP_SIZE * sizeof(unsigned long);
>  	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
>  		have_xstate_support = 1;
>  }
> diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
> index cb3c22370cf5..9dccbbbf2fd1 100644
> --- a/arch/x86/um/user-offsets.c
> +++ b/arch/x86/um/user-offsets.c
> @@ -50,7 +50,7 @@ void foo(void)
>  	DEFINE(HOST_GS, GS);
>  	DEFINE(HOST_ORIG_AX, ORIG_EAX);
>  #else
> -	DEFINE(HOST_FP_SIZE, sizeof(struct _xstate) / sizeof(unsigned long));
> +	DEFINE_LONGS(HOST_FP_SIZE, 2688);
>  	DEFINE_LONGS(HOST_BX, RBX);
>  	DEFINE_LONGS(HOST_CX, RCX);
>  	DEFINE_LONGS(HOST_DI, RDI);
> 
> 
> a better fix would be to make the fp regs in struct uml_pt_regs dynamic
> depending on the current kernel idea of the xsave area size.

And we should consider a mechanism to save/restore the full regset only when needed.
Otherwise the context switch is even more slower.

Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

