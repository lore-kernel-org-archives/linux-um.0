Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuHGv-0006mf-Mj for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:29:17 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1AuHAt-0006so-O1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 20 Feb 2004 12:23:03 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] new skas3 patch ready for 2.4.25
References: <40338C1B.1070800@meisterwerk.net>
In-Reply-To: <40338C1B.1070800@meisterwerk.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200402202125.58574.blaisorblade_spam@yahoo.it>
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
Date: Fri, 20 Feb 2004 21:25:57 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Patrick Moor <uml@meisterwerk.net>, Ali Campbell <ali@alicampbell.org.uk>

Alle 17:00, mercoled=EC 18 febbraio 2004, Patrick Moor ha scritto:
> hello
>
>  >patching file arch/i386/kernel/ldt.c
>  >Hunk #1 FAILED at 24.
>
> i could manually correct this one
>
>  >patching file arch/i386/kernel/process.c
>  >Hunk #1 FAILED at 551.
>  >Hunk #2 FAILED at 568.
>  >...
>  >patching file include/asm-i386/processor.h
>  >Hunk #1 FAILED at 436.
>
> but these two i couldn't fix.
> ("copy_segments" function seems to be gone)

Yes, it went away, so a new skas patch must be built. I have one (tested) a=
t=20
http://www.user-mode-linux.org/~blaisorblade/

However, what is good is that things seems to be more similar to 2.6 (the=20
inserted code comes straight from 2.6, even in the meaningless things), and=
=20
since a 2.6 skas patch exists and I know it well, I have prepared soon a=20
2.4.25 skas patch.

Also, since disabling /proc/mm lead to a compilation failure, I've replaced=
=20
the option with a message that says you cannot disable it.

Enjoy it and good bye!
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
