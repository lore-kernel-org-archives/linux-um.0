Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp6pg-0000zH-4B for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:52:04 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bp6pe-0002af-By for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 07:52:02 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [patch] Re: [uml-devel] Kallsyms on UML
References: <20040726002724.GA11374@kevlar.burdell.org>
	<200407261618.33778.blaisorblade_spam@yahoo.it>
	<200407262140.50298.a_mulyadi@telkom.net>
In-Reply-To: <200407262140.50298.a_mulyadi@telkom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200407261654.24484.blaisorblade_spam@yahoo.it>
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
Date: Mon, 26 Jul 2004 16:54:24 +0200
Content-Transfer-Encoding: quoted-printable
To: a_mulyadi@telkom.net, Sonny Rao <sonny@burdell.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Alle 16:40, luned=EC 26 luglio 2004, Mulyadi Santosa ha scritto:
> hello
>
> > Yes, exactly. (It is not matter of EXPORT_SYMBOL, you're right).
>
> Thanks for correcting me :-)

> BTW, why vmlinux might miss the stack trace? is it just because it missed
> kallsysms?
The 2 patches handle the two problems:
1) Kallsyms didn't work (the .tmp_kallsyms were empty because=20
arch/um/kernel/vmlinux.lds.S did not set _stext and _sinittext, which are=20
used by the kallsyms tool)

2) The UML dump_stack() version didn't use the kallsyms facilities.

> > However, on any 2.6 UML, run cat /dev/kmem (which will panic, the fix is
> > known but yet to submit) and say if you can get the stacktrace. For some
> > reason, I cannot (even if dump_stack() is invoked); nothing is printed.
> > Seems like the printk() are lost (maybe some tricks with bust_spinlock()
> > are needed).
>
> BTW, interesting to read tricks to beat lost printk, Paolo....can you sha=
re
> your trick to defeat it? Just using bust_spinlock? or....just crazy
> idea...force console/tty flush?
Well, in the patch I tried to use bust_spinlock(), but it didn't work. I ha=
ve=20
just a raw idea of what it does, but I followed the panic() code. It could =

even be a console/tty flush, maybe, but I don't know to what those words=20
translate. Or maybe even moving machine_halt() to later, somehow (which is =

called by the UML function panic_exit(), grep for it).

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_idG21&alloc_id=10040&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
