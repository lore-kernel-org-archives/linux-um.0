Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDRnu-0004us-4H for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 10:34:34 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BDRnt-000803-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Apr 2004 10:34:33 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] openswan @ missing symbols strstr & memset
References: <1081875793.19343.90.camel@develbox>
In-Reply-To: <1081875793.19343.90.camel@develbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Message-Id: <200404131947.02463.blaisorblade_spam@yahoo.it>
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
Date: Tue, 13 Apr 2004 19:47:02 +0200
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 19:03, marted=EC 13 aprile 2004, Nikola Ciprich ha scritto:
> Hello, I was trying to get openswan working under UML, module compiles
> fine, but trying to load it fails with complaint about unresolved symbol
> memset and strstr
> I've found that those symbols are exported in i386 ksyms, but not in uml
> ksyms, so I've created little patch (enclosed), and everythink seems to
> work well.

> I'd like to ask, if my solution is 'clean' and if yes,
Yes, it is clean (just it should go inside user_syms.c), but IIRC it has be=
en=20
applied to late 2.4 & 2.6 UML kernels (I could be wrong). Check against=20
latest version and if it is not there (look inside user_syms.c) send the=20
patch, after making the change in user_syms.c, to Jeff Dike.

Bye
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
