Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AoStf-0002XW-Jw
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 11:41:15 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AoSte-0006HF-Uv
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 04 Feb 2004 11:41:15 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Hang on boot with 2.6.*
References: <1075921947.7569.7.camel@wopr.tektonic.net>
In-Reply-To: <1075921947.7569.7.camel@wopr.tektonic.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200402042042.09932.blaisorblade_spam@yahoo.it>
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
Date: Wed, 4 Feb 2004 20:42:09 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Matt Ayres <matta@tektonic.net>

Alle 20:12, mercoled=EC 4 febbraio 2004, Matt Ayres ha scritto:
> Hi,
>
> I'm still fairly new to UML so perhaps this is a known issue and there
> is a simple workaround.
>
> I've tried 2.6.1-1um, 2.6.0-1um, 2.6.0-test9-1um, Ingo's A7 combo patch,
> and Blaisorblade's v8 patches for 2.6.0.  On every single one whenever I
> try to boot it just hangs when it should be starting init (aka. After
> "Mounted devfs on /dev").
>
> So it's obvious it's probably not a kernel problem and is user error on
> my part.  I noticed with problem with 2.4.23-1um with the RTC/high mhz
> bug, however I disabled RTC in the kernel configs and still had this
> problem, not to mention the older kernels did not have this problem.
You mean that for 2.4 you get only 2.4.22-?um working and only if you disab=
le=20
UML-rtc?

> Has anyone had this problem and can offer a tip on what I am possibly
> doing wrong? Host is 2.4.24.

Which versions worked+ which is your command line+ post initial messages+ h=
ave=20
you got skas on the host? Is the filesystem ok? Is there inside the=20
filesystem something not ok (I especially think about a NPTL-enabled glibc)?
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
