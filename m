Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ9iQ-0003Lx-1S for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:57:58 -0700
Received: from mailfe05.swip.net ([212.247.154.129] helo=swip.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ9iO-0002fh-ER for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:57:57 -0700
From: Alexander Nyberg <alexn@dsv.su.se>
In-Reply-To: <20050425191253.B9FE045EBB@zion>
References: <20050425191253.B9FE045EBB@zion>
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <1114459067.983.22.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [uml-devel] Re: [patch 1/1] uml: fix handling of no fpx_regs
	[critical, for 2.6.12]
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 25 Apr 2005 21:57:47 +0200
Content-Transfer-Encoding: quoted-printable
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, aleidenf@bigpond.net.au

m=E5n 2005-04-25 klockan 21:12 +0200 skrev blaisorblade@yahoo.it:
> From: Andree Leidenfrost <aleidenf@bigpond.net.au>, Paolo 'Blaisorblade' =
Giarrusso <blaisorblade@yahoo.it>
>=20
> Fix the error path, which is triggered when the processor misses the fpx =
regs
> (i.e. the "fxsr" cpuinfo feature). For instance by VIA C3 Samuel2. Tested=
 and
> obvious, please merge ASAP.
>=20
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
>=20
>  linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c |    7 ++++---
>  1 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff -puN arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_regs_handl=
ing arch/um/os-Linux/sys-i386/registers.c
> --- linux-2.6.12/arch/um/os-Linux/sys-i386/registers.c~uml-fix-no_fpx_reg=
s_handling	2005-04-25 21:03:11.000000000 +0200
> +++ linux-2.6.12-paolo/arch/um/os-Linux/sys-i386/registers.c	2005-04-25 2=
1:08:07.000000000 +0200
> @@ -105,14 +105,15 @@ void init_registers(int pid)
>  		panic("check_ptrace : PTRACE_GETREGS failed, errno =3D %d",
>  		      err);
> =20
> +	errno =3D 0;
>  	err =3D ptrace(PTRACE_GETFPXREGS, pid, 0, exec_fpx_regs);
>  	if(!err)
>  		return;
> +	if(errno !=3D EIO)
> +		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> +		      errno);

Looks like you mean "if (err !=3D EIO)" here


>  	have_fpx_regs =3D 0;
> -	if(err !=3D EIO)
> -		panic("check_ptrace : PTRACE_GETFPXREGS failed, errno =3D %d",
> -		      err);
> =20
>  	err =3D ptrace(PTRACE_GETFPREGS, pid, 0, exec_fp_regs);
>  	if(err)





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id=14396&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
