Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ApU7r-0007TJ-6v
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 07:12:07 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ApU7q-0004wv-G3
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 07 Feb 2004 07:12:06 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] 2.6 uml & CONFIG_SMP fix
References: <200402041926.39098.jeffpc@optonline.net>
In-Reply-To: <200402041926.39098.jeffpc@optonline.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402062051.54602.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 6 Feb 2004 20:51:54 +0100
Content-Transfer-Encoding: quoted-printable
To: Josef 'Jeff' Sipek <jeffpc@optonline.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 01:26, gioved=EC 5 febbraio 2004, Josef 'Jeff' Sipek ha scritto:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hello,
> 	yesterday, I finally got around to fixing the code. Right now, it
> compiles, but there are some warnings that I didn't take a look at.
> This patch makes it compile with CONFIG_SMP, nothing more.
> I tested the resulting binary, and it works well in tt (I did NOT test
> skas.)
>
> You should be able to pull the patch from
> http://kernel.bkbits.net:14690/jeffpc/uml-smp/ (I think that pulling via
> web is not working, I'll check later.)
>
> Jeff.

Without and with your patch, these warnings appear; they are some TODO need=
ed=20
to make SMP work actually.

arch/um/kernel/skas/process.c:372:2:
warning: #warning need cpu pid in switch_mm_skas

arch/um/kernel/skas/process.c:381:2:
warning: #warning need to loop over userspace_pids in kill_off_processes_sk=
as

arch/um/kernel/skas/process_kern.c:179:2:
warning: #warning Need to look up userspace_pid by cpu

arch/um/kernel/skas/process_kern.c:185:2:
warning: #warning Need to look up userspace_pid by cpu

also, at arch/um/kernel/skas/process.c:98, NR_CPUS is defined as being 1,=20
which actually disables SMP even with CONFIG_SMP enabled. If you try to=20
change NR_CPUS to more than 1, you'll probably see (I guess since you also =

need to change some other code) that:
- more "kernel thread" should appear (thus=20
- until you fix the code marked with those warning, the kernel will not wor=
k=20
well. If you don't succeed in this. For now those warning don't hurt becaus=
e=20
SMP is not *actually* enabled.

But do not directly change that: NR_CPUS in the UML kernel comes from a lot=
 of=20
different sources that assign to it different values: mainly=20
/usr/include/linux/threads.h and <source tree>/include/linux/threads.h and =

arch/um/kernel/skas/process.c. And they all disagree. I.e. kern_util includ=
es=20
"linux/threads.h", but depending on the file it is included in it includes =

the system version (/usr/include) or the kernel version - and this cannot=20
change. Please fix that - copy the relevant lines from <source=20
tree>/include/linux/threads.h to kern_util.h.

> diff -Nru a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> - --- a/arch/um/kernel/irq.c	Tue Feb  3 21:48:38 2004
> +++ b/arch/um/kernel/irq.c	Tue Feb  3 21:48:38 2004
> @@ -584,7 +584,7 @@
>  					unsigned long count, void *data)
>  {
>  	int irq =3D (long) data, full_count =3D count, err;
> - -	cpumask_t new_value;
> +	cpumask_t new_value, tmp;
>
>  	if (!irq_desc[irq].handler->set_affinity)
>  		return -EIO;

That was removed because without CONFIG_SMP that is unused. So, give a look=
 at=20
arch/i386/kernel/irq.c and move the #ifdef CONFIG_SMP to the outer location=
=20
(so to be around the whole irq_affinity_write_proc + the other similar=20
stuff). If you have the time, there is a lot of other code to resync in tho=
se=20
two files. Even moving the Uml specific stuff to another file and make the =

i386 work for both arch's (with proper #ifdef's, and remembering that it wa=
s=20
*mostly copied*) would be very nice probably (there is a trick in the=20
Makefiles to symlink files from other archs, like in the header you symlink=
).

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
