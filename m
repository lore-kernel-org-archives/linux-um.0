Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZwq2-0007dS-Bh
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:37:30 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZwq1-0006iQ-QQ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 26 Dec 2003 10:37:29 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] ubd=mmap problem
References: <3FEAE023.6040908@darkman.de>
In-Reply-To: <3FEAE023.6040908@darkman.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312261936.46963.blaisorblade_spam@yahoo.it>
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
Date: Fri, 26 Dec 2003 19:36:46 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net

Alle 14:03, gioved=EC 25 dicembre 2003, Sven 'Darkman' Michels ha scritto:
> Hi there,
>
> i started uml with udb=3Dmmap, the box runs fine but today i
> noticed that the box was terminated after a nightly cron
> run inside the uml.
This first problem is a known one. Did you mount the host root with hostfs =

inside Uml? If yes, check /var/log/messages and you should see an Oops from=
=20
the host kernel. If that happens, apply on the host the patch in this threa=
d=20
on 10 Dec 2003:

[uml-devel] [PATCH] fix for: Host panic when UML reads host /dev/shm

For the second I can't help you, probably it is a still unknown bug, someon=
e=20
else will help you or post a fix.

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
