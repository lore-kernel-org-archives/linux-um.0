Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BfNIN-0006d9-Iw for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:25:27 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1BfNIN-0002mC-17 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Jun 2004 11:25:27 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml crash
References: <87496858-C932-11D8-9806-000393C969F4@exse.net>
In-Reply-To: <87496858-C932-11D8-9806-000393C969F4@exse.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200406292039.00872.blaisorblade_spam@yahoo.it>
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
Date: Tue, 29 Jun 2004 20:39:00 +0200
Content-Transfer-Encoding: quoted-printable
To: Sebastian =?iso-8859-1?q?B=F6hm?= <seb@exse.net>, user-mode-linux-devel@lists.sourceforge.net

Alle 20:39, luned=EC 28 giugno 2004, Sebastian B=F6hm ha scritto:
> Hi,
>
> I applied that "[uml-devel] Patch for arch/um/kernel/trap_kern.c to fix
> bad panic"-patch, but now my easiely reproduceable mysql-server-start
> crash seems to produce an endless bt.
Well, gdb truncated the old one. This is better... and you should also "str=
ace=20
-f" mysql while starting (not the *script* which starts it, but the final=20
command; edit the script for this); I need just the last lines of the outpu=
t=20
of strace, the ones before the panic. Thanks for your help. Btw, have you a=
=20
working 2.4.24-1um UML? Or that patch is affected, too?
--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 -=20
digital self defense, top technical experts, no vendor pitches,=20
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
