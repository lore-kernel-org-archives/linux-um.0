Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AaJOL-0000xM-2F
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 10:42:25 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AaJFx-0006cW-Sf
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 27 Dec 2003 10:33:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] UML build system: patch ready
References: <200312241943.37474.blaisorblade_spam@yahoo.it> <Pine.LNX.4.58.0312261606480.18690@boston.corp.fedex.com> <1072468270.6872.13.camel@laptop-linux>
In-Reply-To: <1072468270.6872.13.camel@laptop-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200312271933.17194.blaisorblade_spam@yahoo.it>
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
Date: Sat, 27 Dec 2003 19:33:17 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 20:51, venerd=EC 26 dicembre 2003, Nigel Cunningham ha scritto:
> On Fri, 2003-12-26 at 21:12, Jeff Chua wrote:
> > arch/um/sys-i386/bugs.c ...
> > 	//line 110
> > 	struct modify_ldt_ldt_s ldt;
> >
> > 	//line 117
> > 	err =3D modify_ldt(1, &ldt, sizeof(ldt));
> >
> >
> > It looks that modify_ldt_ldt_s is not defined anywhere

There is only one definition in the asm/ldt.h header: only the struct name =
has=20
changed between 2.4 and 2.6. This is the only problem. Rename that struct a=
nd=20
you're done.

> > and modify_ldt()
> > cannot be found.
That is only a warning: in fact this function's prototype has never had a=20
declaration in system headers.

> If you can get this sorted out (and tell me how), I may be able to get
> software suspend [a bit closer to] working under UML. The lack of
> support for modifying ldts was where I blocked when I briefly looked at
> it a while ago.

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
