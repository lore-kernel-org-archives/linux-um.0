Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AhvtE-0000Dp-75 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:13:48 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Ahvt4-0001j7-KG for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Jan 2004 11:13:38 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <200401111813.28744.blaisorblade_spam@yahoo.it>
	<20040113105602.43db8e99.akpm@osdl.org>
	<200401132054.i0DKsbhg003213@ccure.user-mode-linux.org>
In-Reply-To: <200401132054.i0DKsbhg003213@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200401171736.06578.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Fixmap breakage for UML for 2.6.1
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
Date: Sat, 17 Jan 2004 17:36:06 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 21:54, marted=EC 13 gennaio 2004, Jeff Dike ha scritto:
> akpm@osdl.org said:
> > Sigh.  With Linus you need to keep resending.
>
> Yeah, but after a while you start asking if it's worth it.
>
> > Yeah, OK.  But last time I had a big UML patch in -mm Christoph noted
> > that it cotained things like new blockdev drivers which wouldn't even
> > work under 2.6 and which used antiquated interfaces.  If that sort of
> > thing is still there we'd need to go through it.
Also, to send the patch in mainline you need to remove the SKAS support for=
=20
nested UML, as that code needs changes inside mm/ and will be superseeded b=
y=20
Skas4.

Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.23/2.6.0 on an i686; Linux registered user n. 292729
EOSIGN



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
