Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BrkJm-0004kk-0f for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 14:26:02 -0700
Received: from amsfep12-int.chello.nl ([213.46.243.18]
	helo=amsfep20-int.chello.nl)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BrkJl-0000VZ-Cw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Aug 2004 14:26:01 -0700
Received: from anakin.of.borg ([62.205.101.209]) by amsfep20-int.chello.nl
	(InterMail vM.6.00.05.02 201-2115-109-103-20031105) with ESMTP
	id <20040802212553.OHVX8597.amsfep20-int.chello.nl@anakin.of.borg>
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 2 Aug 2004 23:25:53 +0200
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.12.11/8.12.11/Debian-5) with ESMTP id
	i72LPmRl001506 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 2 Aug 2004 23:25:48 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.12.11/8.12.11/Debian-5) with ESMTP id
	i72LPlqF001503 for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 2 Aug 2004 23:25:48 +0200
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <Pine.LNX.4.58.0408021210420.23627@anakin>
Message-ID: <Pine.LNX.4.58.0408022324120.23627@anakin>
References: <Pine.LNX.4.58.0408021210420.23627@anakin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: gdkfb
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
Date: Mon, 2 Aug 2004 23:25:47 +0200 (CEST)
To: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On Mon, 2 Aug 2004, Geert Uytterhoeven wrote:
>   - On my Athlon XP (2.6.7+SKAS host, config based on the Debian
>     kernel-image-2.6.7-1-k7 config), it crashed very early until I enlarged the
>     stack sizes (STACKSIZE) of the gdkfb threads.  However, even then the
>     update thread still hangs somewhere after the initial repaint. Userland
>     libraries are exactly the same as on the laptop. Strange...

BTW, is there a way to check how much stack a thread really needs? I
tried poisoning the stack with 0xdeadbeef during initializating, but it
looks like clone() will clear it to all zeroes, since afterwards gdb
found zeroes only.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
