Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B4753-00085m-7w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 15:37:41 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B474y-0001ox-3N for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 15:37:36 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] /dev/kmem panic in SKAS mode
In-Reply-To: <200403182017.52188.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0403190013140.32344-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
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
Date: Fri, 19 Mar 2004 00:37:28 +0100 (CET)
Content-Transfer-Encoding: quoted-printable
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 18 Mar 2004, BlaisorBlade wrote:

> Alle 11:38, marted=EC 16 marzo 2004, Henrik Nordstrom ha scritto:
> > There seems to be some kind of vm addressing related issue in SKAS mode.
> > This time related to reading of /dev/kmem.
>=20
> If you are not using 2.6.4, do it and it should disappear. If not, probab=
ly he=20
> applied the patch we discussed after the release (but I'm almost sure thi=
s is=20
> not the case).

Silly me forgot to mention what UML kernel I am using. Due to various=20
reasons I have to stick to a 2.4 UML kernel.

  UML Kernel: 2.4.25
  UML patch: Current CVS

> At least, search the archives since I and Jeff discussed it (search for=20
> "[PATCH] fix writing into /dev/kmem" and my answers; the patch in the 1st=
=20
> message is wrong).

Found the thread, but not sure what needs to be changed. On the 4/3 Jeff
mentioned the fault_catcher and some wrapping of the guts in copy_user to
fix this problem, but no code ;-)

> We understood that copy_from_user should check also for invalid addresses=
 in=20
> kernel space (the i386/anything one does this check implicitly, the TT mo=
de=20
> too). In skas mode he cannot rely on SIGSEGV so it checks pagetables by h=
and,=20
> but not for the kernel. In the case below it's copy_to_user that does not=
=20
> check the from address, but it's the same anyway.

Sounds promising.

Anyway, for now I can live without klogd in this environment, but it would
be nice to have this issue fixed. Is this problem planned to be fixed in
the 2.4 tree, or only the 2.6 tree?

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
