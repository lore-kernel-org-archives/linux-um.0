Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1SyPoO-00027m-Il
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 16:05:44 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SyPoI-0004TL-UN
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Aug 2012 16:05:44 +0000
Message-ID: <501FEB4A.3060909@nod.at>
Date: Mon, 06 Aug 2012 18:05:30 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <20120806153728.GC25078@cs.unibo.it>
In-Reply-To: <20120806153728.GC25078@cs.unibo.it>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7531698082654123926=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [patch] 3.6rc1 tracehook
To: user-mode-linux-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============7531698082654123926==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1DFD53699478C4C5B54E6292"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DFD53699478C4C5B54E6292
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 06.08.2012 17:37, schrieb Renzo Davoli:
> ---
> diff -Naur linux-3.6-rc1/arch/um/include/asm/ptrace-generic.h linux-3.6=
-rc1.tracehook/arch/um/include/asm/ptrace-generic.h
> --- linux-3.6-rc1/arch/um/include/asm/ptrace-generic.h	2012-08-03 01:38=
:10.000000000 +0200
> +++ linux-3.6-rc1.tracehook/arch/um/include/asm/ptrace-generic.h	2012-0=
8-06 14:43:01.000000000 +0200
> @@ -37,7 +37,7 @@
> =20
>  extern int arch_copy_tls(struct task_struct *new);
>  extern void clear_flushed_tls(struct task_struct *task);
> -extern void syscall_trace_enter(struct pt_regs *regs);
> +extern int syscall_trace_enter(struct pt_regs *regs);
>  extern void syscall_trace_leave(struct pt_regs *regs);
> =20
>  #endif
> diff -Naur linux-3.6-rc1/arch/um/include/shared/kern_util.h linux-3.6-r=
c1.tracehook/arch/um/include/shared/kern_util.h
> --- linux-3.6-rc1/arch/um/include/shared/kern_util.h	2012-08-03 01:38:1=
0.000000000 +0200
> +++ linux-3.6-rc1.tracehook/arch/um/include/shared/kern_util.h	2012-08-=
06 14:43:40.000000000 +0200
> @@ -57,7 +57,6 @@
>  extern unsigned long to_irq_stack(unsigned long *mask_out);
>  extern unsigned long from_irq_stack(int nested);
> =20
> -extern void syscall_trace(struct uml_pt_regs *regs, int entryexit);
>  extern int singlestepping(void *t);
> =20
>  extern void segv_handler(int sig, struct siginfo *unused_si, struct um=
l_pt_regs *regs);
> diff -Naur linux-3.6-rc1/arch/um/kernel/ptrace.c linux-3.6-rc1.tracehoo=
k/arch/um/kernel/ptrace.c
> --- linux-3.6-rc1/arch/um/kernel/ptrace.c	2012-08-03 01:38:10.000000000=
 +0200
> +++ linux-3.6-rc1.tracehook/arch/um/kernel/ptrace.c	2012-08-06 14:45:07=
=2E000000000 +0200
> @@ -163,7 +163,7 @@
>   * XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
>   * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
>   */
> -void syscall_trace_enter(struct pt_regs *regs)
> +int syscall_trace_enter(struct pt_regs *regs)
>  {
>  	audit_syscall_entry(HOST_AUDIT_ARCH,
>  			    UPT_SYSCALL_NR(&regs->regs),
> @@ -173,9 +173,9 @@
>  			    UPT_SYSCALL_ARG4(&regs->regs));
> =20
>  	if (!test_thread_flag(TIF_SYSCALL_TRACE))
> -		return;
> +		return 0;
> =20
> -	tracehook_report_syscall_entry(regs);
> +	return tracehook_report_syscall_entry(regs);
>  }
> =20
>  void syscall_trace_leave(struct pt_regs *regs)
> diff -Naur linux-3.6-rc1/arch/um/kernel/skas/syscall.c linux-3.6-rc1.tr=
acehook/arch/um/kernel/skas/syscall.c
> --- linux-3.6-rc1/arch/um/kernel/skas/syscall.c	2012-08-03 01:38:10.000=
000000 +0200
> +++ linux-3.6-rc1.tracehook/arch/um/kernel/skas/syscall.c	2012-08-06 14=
:46:35.000000000 +0200
> @@ -18,23 +18,24 @@
>  	long result;
>  	int syscall;
> =20
> -	syscall_trace_enter(regs);
> +	if (syscall_trace_enter(regs) =3D=3D 0)
> +	{
> +		/*
> +		 * This should go in the declaration of syscall, but when I do that,=

> +		 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
> +		 * children at all, sometimes hanging when bash doesn't see the firs=
t
> +		 * ls exit.
> +		 * The assembly looks functionally the same to me.  This is
> +		 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
> +		 * in case it's a compiler bug.
> +		 */
> +		syscall =3D UPT_SYSCALL_NR(r);
> +		if ((syscall >=3D NR_SYSCALLS) || (syscall < 0))
> +			result =3D -ENOSYS;
> +		else result =3D EXECUTE_SYSCALL(syscall, regs);
> =20
> -	/*
> -	 * This should go in the declaration of syscall, but when I do that,
> -	 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
> -	 * children at all, sometimes hanging when bash doesn't see the first=

> -	 * ls exit.
> -	 * The assembly looks functionally the same to me.  This is
> -	 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
> -	 * in case it's a compiler bug.
> -	 */
> -	syscall =3D UPT_SYSCALL_NR(r);
> -	if ((syscall >=3D NR_SYSCALLS) || (syscall < 0))
> -		result =3D -ENOSYS;
> -	else result =3D EXECUTE_SYSCALL(syscall, regs);
> -
> -	PT_REGS_SET_SYSCALL_RETURN(regs, result);
> +		PT_REGS_SET_SYSCALL_RETURN(regs, result);
> +	}
> =20
>  	syscall_trace_leave(regs);

Hmm, is it a good idea to call syscall_trace_leave() in any case?
E.g. if syscall_trace_enter() fails for whatever reason...

Thanks,
//richard


--------------enig1DFD53699478C4C5B54E6292
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQH+tKAAoJEN9758yqZn9ezhAH/0GhtbImiZUTrsDCCfe/ViKd
x4a/wsdLqlXOGP9hERWt0rqjl5mEmqqR2Ef5yv5uHi/l1Up3sVfsBslhcU+O1TVI
UDUIseAFatnKz7lJREGHPB079eyAMP9n7PDXloNV9CRd5wfzsb//Tl9+oH9KptOH
gYOfX6Qry9w2DevmHtr/CNcuyUh5jX/UOn6VOFjvxO3AjABDKyGkUVmDA1XRTuzf
EqoOErNCbgnqe1m6qMeOSQhDpAh9xTWQe3pj42e3MYBjopDdj7N5azKpqD+V99eg
yMtRCosqyU23W+DSexl9qIyQM7tKKSdWH5ZzgSa9zWGtmN/oJOWAMewjv227mDU=
=yOjr
-----END PGP SIGNATURE-----

--------------enig1DFD53699478C4C5B54E6292--


--===============7531698082654123926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============7531698082654123926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============7531698082654123926==--


