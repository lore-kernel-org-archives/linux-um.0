Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AbPd0-0007cA-BL
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 11:34:06 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AbPcz-00055k-PQ
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 30 Dec 2003 11:34:05 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML + skas
References: <20031230183331.GB2845@carpediem.epita.fr>
In-Reply-To: <20031230183331.GB2845@carpediem.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312302008.11815.blaisorblade_spam@yahoo.it>
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
Date: Tue, 30 Dec 2003 20:08:11 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:33, marted=EC 30 dicembre 2003, jeremie le-hen ha scritto:
> Hi all,

> I have just subscribed to this list because I found a strange bug while
> compiling an UML within an SKAS'd host.  Here is the problem :
>
> (my host is a 2.4.23 kernel with the SKAS patch released on 2002/11/11)

> After preprocessing the process.c file, I found that
> `struct ptrace_faultinfo' and `struct ptrace_ldt' were first defined
> in file `/usr/include/asm/ptrace.h' and then in
> `arch/um/include/skas_ptrace.h'.
> Since `/usr/include/asm/' is a symlink
> in  `/usr/src/linux/` which in turn points to my kernel source,

Making /usr/include/asm a symlink into kernel sources is a very bad thing; =
if=20
your distro did this it's not your fault, but recent distros don't do this =

from ages (neither RedHat nor Mandrake, at least, for what I saw).

>
> This is *exactly* the same content as `arch/um/include/skas_ptrace.h'.
> From what I googled, it seems to be a known bug.  But it think it would
> not be very difficult to make some #define protection around theses
> structures to prevent from changing the destination of `/usr/src/linux/'
> to a source without the SKAS patch applied.

Yes, it wouldn't not hard.
But you should not use the same source tree to apply both patches. I think =

this is explained very clearly and that the patches are not meant to be=20
compatible. Also, in that way you easily get into problems because=20
include/asm points to asm-i386 and is not updated to point to asm-um.

Also, if you make /usr/include/asm (this holds also for /usr/include/linux)=
 a=20
symlink into kernel sources, that is not good.

And I don't think that any update to the host patch will ever be made=20
available, since Jeff Dike is making ready the SKAS 4 patch.

--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
