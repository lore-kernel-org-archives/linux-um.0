Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AsoOR-0006Mc-Ps
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:26:59 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1AsoFB-0003pb-Sg
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 16 Feb 2004 11:17:26 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Diagnosed and repeatable kernel mode panic in schedule() for 2.6!
References: <200402151911.11890.blaisorblade_spam@yahoo.it> <20040216095335.GA27377@elte.hu>
In-Reply-To: <20040216095335.GA27377@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200402162025.24853.blaisorblade_spam@yahoo.it>
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
Date: Mon, 16 Feb 2004 20:25:24 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@elte.hu>

Alle 10:53, luned=EC 16 febbraio 2004, Ingo Molnar ha scritto:
> * BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:
> > While searching the archives, I noticed that this command:
> >
> > while /bin/true ; do /bin/true ; done
> >
> > Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397
> > Kernel panic: kernel BUG at kernel/exit.c:793!
>
> can you reproduce this crash even if you boot up UML via init=3D/bin/bash?
Yes (test with the same binary):
bash-2.05b# while /bin/true; do /bin/true; done
Kernel panic: Kernel mode fault at addr 0x1f, ip 0x400d1397

However, I discovered that an old 2.6.0 kernel works well. I think that had=
=20
2.6.0-test9 patch; so I think that this is related with the NET: Registered=
=20
... hang, which was solved with the same patch. That does not happen on=20
different compilation env.s, but I think that is random: a crazy pointer=20
failing in different places.
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id438&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
