Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6M1-00056U-Sl for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:37 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1By6M1-0000l4-4e for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:10:37 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] bad panic "Kernel stack overflow" - demo exploit
References: <40E0036D.2070108@sysgo.de>
	<200407012133.16289.blaisorblade_spam@yahoo.it>
	<200407032025.52944.blaisorblade_spam@yahoo.it>
In-Reply-To: <200407032025.52944.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408142332.22142.blaisorblade_spam@yahoo.it>
Reply-To: 
Content-Type: text/plain; charset="iso-8859-15"
Content-Description: 
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
Date: Tue, 17 Aug 2004 17:40:51 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:25, sabato 3 luglio 2004, BlaisorBlade ha scritto:
> Alle 21:33, gioved=EC 1 luglio 2004, BlaisorBlade ha scritto:

About this hunk of the patch, sorry. I tested the patch well, then I added =

this part without testing, and understood this a lot of time after. Sorry. =

Since CONFIG_KERNEL_STACK_ORDER is usually 2, THREAD_SIZE becomes 16k (I've=
=20
just realized this). So this hunk is wrong. The rest works very happily.
> uml-linux-2.6.7/arch/um/kernel/process_kern.c~check_is_user_before_panic =
  =20
2004-07-03 16:41:39.473637592 +0200
> +++ uml-linux-2.6.7-paolo/arch/um/kernel/process_kern.c 2004-07-03=20
17:53:21.867574296 +0200
> @@ -165,7 +165,7 @@ int copy_thread(int nr, unsigned long cl
>  {
>         p->thread =3D (struct thread_struct) INIT_THREAD;
>         p->thread.kernel_stack =3D=20
> -               (unsigned long) p->thread_info + 2 * PAGE_SIZE;
> +               (unsigned long) p->thread_info + THREAD_SIZE;
>         return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr,=20
>                                 clone_flags, sp, stack_top, p, regs));
>  }
> _

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
