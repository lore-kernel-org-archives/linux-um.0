Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1By6MV-0005AW-Ax for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:11:07 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1By6MU-00010Y-M9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Aug 2004 03:11:07 -0700
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] ubd_kern.c: spin_lock already locked by
	drivers/block/ll_rw_blk.c
References: <20030611091956.GA32752@alinoe.com>
In-Reply-To: <20030611091956.GA32752@alinoe.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200408192057.37295.blaisorblade_personal@yahoo.it>
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
Date: Thu, 19 Aug 2004 20:57:37 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Carlo Wood <carlo@alinoe.com>, Jeff Dike <jdike@addtoit.com>

Alle 11:19, mercoled=EC 11 giugno 2003, Carlo Wood ha scritto:
> Running 2.5.69 as uml, I get the following during boot:
>
> ...
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
>  /dev/ubd/disc0:arch/um/drivers/ubd_kern.c:383:
> spin_lock(arch/um/drivers/ubd_kern.c:a01b6940) already locked by
> drivers/block/ll_rw_blk.c/1002 drivers/block/ll_rw_blk.c:1004:
> spin_unlock(arch/um/drivers/ubd_kern.c:a01b6940) not locked unknown
> partition table
>  /dev/ubd/disc1:arch/um/drivers/ubd_kern.c:383:
> spin_lock(arch/um/drivers/ubd_kern.c:a01b6940) already locked by
> drivers/block/ll_rw_blk.c/1002 drivers/block/ll_rw_blk.c:1004:
> spin_unlock(arch/um/drivers/ubd_kern.c:a01b6940) not locked unknown
> partition table
> arch/um/drivers/ubd_kern.c:383:
> spin_lock(arch/um/drivers/ubd_kern.c:a01b6940) already locked by
> drivers/block/ll_rw_blk.c/1002 drivers/block/ll_rw_blk.c:1004:
> spin_unlock(arch/um/drivers/ubd_kern.c:a01b6940) not locked
> arch/um/drivers/ubd_kern.c:383:
> spin_lock(arch/um/drivers/ubd_kern.c:a01b6940) already locked by
> drivers/block/ll_rw_blk.c/1002 drivers/block/ll_rw_blk.c:1004:
> spin_unlock(arch/um/drivers/ubd_kern.c:a01b6940) not locked
> arch/um/drivers/ubd_kern.c:383:
> spin_lock(arch/um/drivers/ubd_kern.c:a01b6940) already locked by
> drivers/block/ll_rw_blk.c/1002 drivers/block/ll_rw_blk.c:1004:
> spin_unlock(arch/um/drivers/ubd_kern.c:a01b6940) not locked VFS: Mounted
> root (ext2 filesystem) readonly.
> ...
>
> This is with kernel debugging on, of course.
>
> Because it mentions files in arch/um/*, it must be a problem
> with the uml.
In fact, yes, it's a UML problem. I'm going to solve this. No, I'm not craz=
y,=20
the problem is still here (the line numbers are different, but probably is =

the same). As a side note, to get this you need CONFIG_SMP=3Dn and=20
CONFIG_DEBUG_SPINLOCK=3Dy. If you enable CONFIG_SMP, you actually don't get=
 the=20
debug messages, only the deadlock. Also, to get *this* messages you need to=
=20
be using synchronous mode. I recommend *NOT* enabling=20
CONFIG_BLK_DEV_UBD_SYNC, but using instead the ubd=3Dsync option (which is =
the=20
same thing, but selectable at runtime).

**And no, using the 's' ubd0s=3D... is not the same thing; the second just =
means=20
"use O_SYNC", while the first means "always use O_SYNC, and also don't star=
t=20
the ubd I/O thread".
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
