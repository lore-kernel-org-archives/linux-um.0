Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BRbCd-0006hl-MO for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 11:26:35 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BRbCd-0003M3-1y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 May 2004 11:26:35 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] RE: [uml-user] UML on 64-Bit AMD
References: <IFEIKNDOLFNCKMGAENCFGEPBCDAA.Anthony_Brock@ous.edu>
In-Reply-To: <IFEIKNDOLFNCKMGAENCFGEPBCDAA.Anthony_Brock@ous.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200405222029.00065.blaisorblade_spam@yahoo.it>
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
Date: Sat, 22 May 2004 20:29:00 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Anthony Brock <Anthony_Brock@ous.edu>

Alle 08:26, luned=EC 17 maggio 2004, Anthony Brock ha scritto:
> I apologize if I am posting to the wrong group. However, troubleshooting a
> compile doesn't seem appropriate for the user list...
Well, it is normally; this however is good here since 64-bits AMD is someth=
ing=20
really interesting.

> Given problems with compiling the "evaluation" of UML in 64-bit mode (on a
> 64-bit AMD host), I tried to compile a 32-bit version so we could start
> playing. The results are not initially promising. First, it failed to
> compile due to a missing Makefile-x86_64. So I modified the base Makefile
> to assume a subarch of i386:
>
> diff Makefile.orig Makefile
> 131c131,132
> <                                 -e s/s390x/s390/ -e s/parisc64/parisc/ )
> ---
>
> >                                 -e s/s390x/s390/ -e s/parisc64/parisc/ \
> >                                 -e s/x86_64/i386/ )

Would you post the version of your host kernel and of your patch?

Probably, however, the kernel headers in /usr/include/asm are those for=20
x86_64. The first solution I see is to rename /usr/include/asm away, and th=
en=20
create a symlink from /usr/include/asm to <linux kernel=20
sources>/include/asm-i386. Use a kernel source tree similar to the one of t=
he=20
machine, since /usr/include/linux should match at least a bit; don't mix 2.=
4=20
and 2.6. Maybe you need to replace even the /usr/include/linux directory th=
e=20
same way.

After compiling UML, you should switch to the old headers - i.e. delete the=
=20
symlink and move the headers folders in the old place.

If this does not work, would you check if at=20
http://www.user-mode-linux.org/~blaisorblade/ you can find something useful=
?=20
If you did the patch well (and I think yes), it is compiling a 32-bit UML, =

which should work. Maybe you are using a 2.6.6 host kernel, which does not =

work with 2.6.4 patch.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
