Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bni0q-00026g-Pj for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:09:48 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bni0q-0006F3-7l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Jul 2004 11:09:48 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <20040704105632.DC0B378A@zion.localdomain>
	<200407131757.i6DHvZGu003047@ccure.user-mode-linux.org>
In-Reply-To: <200407131757.i6DHvZGu003047@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200407221752.42186.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] Re: [patch 1/1] Fix malloc-use-vmalloc
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
Date: Thu, 22 Jul 2004 17:55:45 +0200
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 19:57, marted=EC 13 luglio 2004, Jeff Dike ha scritto:

> This isn't exactly right.  In the case that a buffer was allocated by
> kmalloc (through malloc), but freed when the system is coming down, and
> kmalloc is no longer operating, then you just want to do nothing. It would
> be very bad to try to free it using libc free.
>
> So, what I did is this:
>
> 	if((addr >=3D uml_physmem) && (addr <=3D high_physmem)){
> 		if(CAN_KMALLOC())
> 			kfree(ptr);
> 	}
> 	else if((addr >=3D start_vm) && (addr <=3D end_vm)){
> 		if(CAN_KMALLOC())
> 			vfree(ptr);
> 	}
> 	else __real_free(ptr);

1) I think that the intervals don't include high_physmem and end_vm, so we =

should have addr < ... instead of addr <=3D.

2) Also, even worse, it seems ok until you read your comment. During the bo=
ot,=20
if random values are in the vars (and it's so until kmalloc_ok is turned on=
)=20
we can have malloc()ed memory thought of as kmalloc()ed or vmalloc()ed one,=
=20
and then leaked.

3) Solution to 2): if I am right about thing #1, then it should be enough t=
o=20
set end_vm and high_physmem to 0 at startup (they are global vars, so it's =

already true), once there are the < instead of <=3D. And don't say in the=20
comment that memory regions are not initialized.

Any comment? I need this to send the patch to Andrew Morton for 2.6-mm
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
