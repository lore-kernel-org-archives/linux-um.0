Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyFFZ-0006bq-MR for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 11:08:17 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AyF36-0003sP-2n for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 10:55:24 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [PATCH] fix writing into /dev/kmem
References: <20040229023636.GB8272@ccure.user-mode-linux.org>
	<200402291325.40644.blaisorblade_spam@yahoo.it>
	<200403020131.i221VAM9025692@ccure.user-mode-linux.org>
In-Reply-To: <200403020131.i221VAM9025692@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403021941.52257.blaisorblade_spam@yahoo.it>
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
Date: Tue, 2 Mar 2004 19:41:52 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

Alle 02:31, marted=EC 2 marzo 2004, Jeff Dike ha scritto:
> blaisorblade_spam@yahoo.it said:
> > This patch is like the one for the read from /dev/kmem (i.e. the one
> > fixing  the panic when one does "cat /dev/kmem": you can reproduce
> > this panic on  Uml2.6): it makes it behave like /dev/mem (man 4 mem is
> > indeed helpful!). So  it is basically not *the right way*.
>
> Well, if you look at read_kmem, the thing that it reads is physical memory
> plus kernel virtual memory.  I.e. /dev/kmem is /dev/mem + the kernel
> virtual memory areas.

No, I do not agree (and man 4 mem agrees with me; I've quoted it below). As=
=20
you later say after reading the code (which contains The Truth), the addres=
s=20
passed to /dev/kmem as already been __va'ed. I.e., if those devices were=20
array we could say:

 /dev/kmem[ __va (address) ] =3D=3D /dev/mem [ address ];

> Addmittedly, I don't see how x86 gets away with dereferencing address 0

Well, physical address 0 does exist, for /dev/mem; /dev/kmem instead return=
s=20
-EFAULT (try cat /dev/kmem), because copy_to_user returns a fault state.
Actually, 0 is derefereced, and the CPU throws an exception; but thanks to =
the=20
__extable section and "search_exception_table", that exception is "caught".=
=20
Read Documentation/exception.txt. I.e., copy_to_user actually checks both t=
he=20
"to" and "from" addresses.

Instead, in UML skas mode, possibly because the process VMA's are not mappe=
d=20
in the kernel thread, the page tables for the user are checked by hand (by =

um_virt_to_phys); but the check is done only for the userspace address (i.e=
.=20
the "to" address for copy_to_user; everything applies even to copy_from_use=
r,=20
of course).

In tt mode it uses actually exception, even if they are coded by hand witho=
ut=20
using __extable (I see a flag here, probably set while catching SIGSEGV).

So, probably (to check), the kernel panic would happen only in tt mode.

Anyway, here comes that copy_{to,from}_user are buggy. Since fixing those=20
would have a good performance hit (to test, but that will probably be=20
sensitive; Documentation/exception.txt says exactly this, because most=20
programs have no bug so checking the page tables has a big cost) and klogd =

would not work anyway, add an XXX comment, add it on your TODO and make=20
/dev/kmem always return -EFAULT, as a workaround; or make it check the=20
address with maybe_map (and #ifdef the change; even other archs have=20
arch-specific code there).

> but I don't see what's wrong with my fixes.
[From below]
> The only out that I can see is that readers of kmem are supposed to pass =
in
> kernel virtual addresses, 0xc0000000 and up.
Yes, this is the reality.

So, __va(p) will overflow. That has *actually* happened (in fact I studied =

what I say in these mails when someone got a fault if he loaded the LVM=20
modules). In fact, in the read_mem there is a check against the overflow:
       if (p >=3D end_mem)
                return 0;

Well, I said you to read mem(4), you didn't, so I quote:

       Mem  is  a character device file that is an image of the main memory=
 of
       the computer.  It may be used, for example, to examine (and even pat=
ch)
       the system.

       Byte  addresses  in  mem  are interpreted as *physical* memory=20
addresses.
[...]
       The file kmem is the same as mem, except that the kernel virtual mem=
ory
       rather than physical memory is accessed.

In fact, see this:

# cat /dev/kmem
cat: /dev/kmem: Bad address

> > To read the physical address  0x1with /dev/kmem, you are supposed to
> > read 0xc0000001; so with that patch  any proper user of /dev/kmem will
> > overflow p.
>
> 0xa0000001, actually, which is what __va does.

Well, on *i386* that is 0xc0000001; since klogd is built with i386 kernel=20
headers, it will use those.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
