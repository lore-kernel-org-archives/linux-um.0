Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BJbGC-0006O0-4a for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:12 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BJbGA-0006MF-O2 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Apr 2004 09:53:10 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] patch for 2.6.6-rc1
References: <Pine.LNX.4.58.0404162157280.29213@boston.corp.fedex.com>
	<Pine.LNX.4.58.0404211409570.2147@boston.corp.fedex.com>
	<08bf01c427fb$86cb9520$2000000a@schlepptopp>
In-Reply-To: <08bf01c427fb$86cb9520$2000000a@schlepptopp>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200404301545.10555.blaisorblade_spam@yahoo.it>
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
Date: Fri, 30 Apr 2004 15:45:10 +0200
Content-Transfer-Encoding: quoted-printable
To: roland <for_spam@gmx.de>, Jeff Chua <jeff98@silk.corp.fedex.com>
Cc: UserModeLinux <user-mode-linux-devel@lists.sourceforge.net>

Alle 01:51, gioved=EC 22 aprile 2004, roland ha scritto:
> hi jeff,
> sorry, but it still doesn`t work for me.
> i tried both kernel 2.6.6-rc1 and 2.6.6-rc2 sources to compile a guest
> kernel.
>
> i have attached a log from what i have done - errors are at the end.

Please post the arch/um/kernel/config.c file the build produced, which gave=
=20
the error. The change to the "QUOTE" line is to be analyzed. The other pers=
on=20
("gboutwel" <gboutwel@praize.com>) having problems had not this one because=
=20
he did not reach this step.

I've finally seen what it does:

-QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/g =
;=20
$$config =3D~ s/\n/\\n"\n"/g ; while(<STDIN>) { $$_ =3D~ s/CONFIG/$$config/=
;=20
print $$_ }'
+QUOTE =3D 'my $$config=3D`cat $(TOPDIR)/.config`; $$config =3D~ s/"/\\"/g =
;=20
$$config =3D~ s/\\n/\\\n"\\n"/g ; while(<STDIN>) { $$_ =3D~ s/CONFIG/$$conf=
ig/;=20
print $$_ }'

the change is from:

$$config =3D~ s/\n/\\n"\n"/g

to:

$$config =3D~ s/\\n/\\\n"\\n"/g

probably because the PERL code needs to be quoted once more.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g.=20
Take an Oracle 10g class now, and we'll give you the exam FREE.=20
http://ads.osdn.com/?ad_id149&alloc_id=8166&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
