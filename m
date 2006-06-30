Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FwKy7-00005e-56 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 08:31:43 -0700
Received: from smtp109.plus.mail.re2.yahoo.com ([206.190.53.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FwKy3-0001v5-1O
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jun 2006 08:31:43 -0700
Date: Fri, 30 Jun 2006 17:31:28 +0200
Message-ID: <20060630153128.GA4951@portableric>
References: <20060522212649.GA4946@portableric>
	<20060629153516.GA8610@ccure.user-mode-linux.org>
MIME-Version: 1.0
In-Reply-To: <20060629153516.GA8610@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] Task Size Init cleanup
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2000757022=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
From: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

--===============2000757022==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by nerdnet.nl id
	k5UFW0DD021609

On Thu, Jun 29, 2006 at 11:35:16AM -0400, Jeff Dike wrote:
> On Mon, May 22, 2006 at 11:26:49PM +0200, tyler@agat.net wrote:
> > I was looking at the code of the UML and more precisely at the functi=
ons
> > set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
> > functions take a paramater (arg) which is not used : the function is
> > always called with the value 0.
> >=20
> > I suppose that this value might change in the future (or even can be
> > configured), so I added a constant in mem_user.h file.
> >=20
> > Also, I rounded CONFIG_HOST_TASk_SIZE to a 4M.
>=20
> What I have in my tree is below.  Can I get a Signed-off-by for it
> from you so I can send it to mainline?
>=20
> 				Jeff
>=20
>=20
> Index: linux-2.6.16-rc-mm/arch/um/include/mem_user.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/include/mem_user.h	2006-06-11 14:27=
:37.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/include/mem_user.h	2006-06-11 14:52:53.0=
00000000 -0400
> @@ -44,6 +44,7 @@ struct iomem_region {
>  extern struct iomem_region *iomem_regions;
>  extern int iomem_size;
> =20
> +#define DEFAULT_HOST_TASK_SIZE			0
>  #define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 << 22)=
 - 1))
> =20
>  extern unsigned long host_task_size;
> Index: linux-2.6.16-rc-mm/arch/um/kernel/skas/mem.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/kernel/skas/mem.c	2006-06-11 14:27:=
37.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/kernel/skas/mem.c	2006-06-11 14:52:53.00=
0000000 -0400
> @@ -9,14 +9,14 @@
>  #include "mem_user.h"
>  #include "skas.h"
> =20
> -unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_ou=
t,=20
> +unsigned long set_task_sizes_skas(unsigned long *host_size_out,
>  				  unsigned long *task_size_out)
>  {
>  	/* Round up to the nearest 4M */
> -	unsigned long top =3D ROUND_4M((unsigned long) &arg);
> +	unsigned long top =3D ROUND_4M((unsigned long) &host_size_out);
> =20
>  #ifdef CONFIG_HOST_TASK_SIZE
> -	*host_size_out =3D CONFIG_HOST_TASK_SIZE;
> +	*host_size_out =3D ROUND_4M(CONFIG_HOST_TASK_SIZE);
>  	*task_size_out =3D CONFIG_HOST_TASK_SIZE;
>  #else
>  	*host_size_out =3D top;
> @@ -24,16 +24,5 @@ unsigned long set_task_sizes_skas(int ar
>  		*task_size_out =3D top;
>  	else *task_size_out =3D CONFIG_STUB_START & PGDIR_MASK;
>  #endif
> -	return(((unsigned long) set_task_sizes_skas) & ~0xffffff);
> +	return ((unsigned long) set_task_sizes_skas) & ~0xffffff;
>  }
> -
> -/*
> - * Overrides for Emacs so that we follow Linus's tabbing style.
> - * Emacs will notice this stuff at the end of the file and automatical=
ly
> - * adjust the settings for this buffer only.  This must remain at the =
end
> - * of the file.
> - * -------------------------------------------------------------------=
--------
> - * Local variables:
> - * c-file-style: "linux"
> - * End:
> - */
> Index: linux-2.6.16-rc-mm/arch/um/kernel/tt/mem.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/kernel/tt/mem.c	2006-06-11 14:27:37=
.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/kernel/tt/mem.c	2006-06-11 14:52:53.0000=
00000 -0400
> @@ -24,22 +24,11 @@ void before_mem_tt(unsigned long brk_sta
>  #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x200000=
00)
>  #define START (CONFIG_TOP_ADDR - SIZE)
> =20
> -unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out,=
=20
> +unsigned long set_task_sizes_tt(unsigned long *host_size_out,
>  				unsigned long *task_size_out)
>  {
>  	/* Round up to the nearest 4M */
> -	*host_size_out =3D ROUND_4M((unsigned long) &arg);
> +	*host_size_out =3D ROUND_4M((unsigned long) &host_size_out);
>  	*task_size_out =3D START;
> -	return(START);
> +	return START;
>  }
> -
> -/*
> - * Overrides for Emacs so that we follow Linus's tabbing style.
> - * Emacs will notice this stuff at the end of the file and automatical=
ly
> - * adjust the settings for this buffer only.  This must remain at the =
end
> - * of the file.
> - * -------------------------------------------------------------------=
--------
> - * Local variables:
> - * c-file-style: "linux"
> - * End:
> - */
> Index: linux-2.6.16-rc-mm/arch/um/kernel/um_arch.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/kernel/um_arch.c	2006-06-11 14:28:5=
2.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/kernel/um_arch.c	2006-06-28 13:07:29.000=
000000 -0400
> @@ -374,7 +374,7 @@ int linux_main(int argc, char **argv)
> =20
>  	printf("UML running in %s mode\n", mode);
> =20
> -	uml_start =3D CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas=
, 0,
> +	uml_start =3D CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas=
,
>  				     &host_task_size, &task_size);
> =20
>  	/*
> Index: linux-2.6.16-rc-mm/arch/um/include/skas/mode_kern_skas.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/include/skas/mode_kern_skas.h	2006-=
06-11 14:27:37.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/include/skas/mode_kern_skas.h	2006-06-11=
 14:52:53.000000000 -0400
> @@ -29,7 +29,7 @@ extern void flush_tlb_mm_skas(struct mm_
>  extern void force_flush_all_skas(void);
>  extern long execute_syscall_skas(void *r);
>  extern void before_mem_skas(unsigned long unused);
> -extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_=
size_out,
> +extern unsigned long set_task_sizes_skas(unsigned long *host_size_out,
>  					 unsigned long *task_size_out);
>  extern int start_uml_skas(void);
>  extern int external_pid_skas(struct task_struct *task);
> Index: linux-2.6.16-rc-mm/arch/um/include/tt/mode_kern_tt.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.16-rc-mm.orig/arch/um/include/tt/mode_kern_tt.h	2006-06-1=
1 14:27:37.000000000 -0400
> +++ linux-2.6.16-rc-mm/arch/um/include/tt/mode_kern_tt.h	2006-06-11 14:=
52:53.000000000 -0400
> @@ -30,7 +30,7 @@ extern void flush_tlb_mm_tt(struct mm_st
>  extern void force_flush_all_tt(void);
>  extern long execute_syscall_tt(void *r);
>  extern void before_mem_tt(unsigned long brk_start);
> -extern unsigned long set_task_sizes_tt(int arg, unsigned long *host_si=
ze_out,
> +extern unsigned long set_task_sizes_tt(unsigned long *host_size_out,
>  				       unsigned long *task_size_out);
>  extern int start_uml_tt(void);
>  extern int external_pid_tt(struct task_struct *task);
>=20

Well my signoff would be :
Signed-off-by: Tyler <tyler@agat.net>
I guess :)

Thx,


--=20
tyler
tyler@agat.net


=09

=09
	=09
_________________________________________________________________________=
__=20
Yahoo! Mail r=E9invente le mail ! D=E9couvrez le nouveau Yahoo! Mail et s=
on interface r=E9volutionnaire.
http://fr.mail.yahoo.com



--===============2000757022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============2000757022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============2000757022==--
