Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.12] (helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CAPqB-0005NK-A4 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Sep 2004 02:24:39 -0700
Received: from nepa.nlc.no ([195.159.31.6] ident=qmailr)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CAPqA-0001MW-FG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Sep 2004 02:24:39 -0700
Message-ID: <10383.130.67.197.34.1095931473.squirrel@130.67.197.34>
In-Reply-To: <EAC7622167479948B614F8B9AD41C505ECA54F@MAANDMBX2.ets.enterasys.com>
References: <EAC7622167479948B614F8B9AD41C505ECA54F@MAANDMBX2.ets.enterasys.com>
Subject: Re: [uml-devel] RE: [uml-user] Kernel panic: Segfault with no mm 
	&& CONFIG_DEBUG_SLAB
From: stian@nixia.no
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Date: Thu, 23 Sep 2004 11:24:33 +0200 (CEST)
To: "Tsillas, Demetrios J" <jtsillas@enterasys.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-user@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

> I have a core image now that I can browse. There's something
> very odd about the stack after the sig_handler.
> (gdb) p/x segfault_record[4]
> $24 = {address = 0x28828000, is_write = 0x2, pid = 0x11db, sp 0x40001fb4,
> is_user = 0x0}

> (gdb) down
> #6  0x080d9bf9 in segv (address=671088640, ip=135618305, is_write=0,
> is_user=0, sc=0x9310270) at trap_kern.c:149
> (gdb) p/x 671088640
> $26 = 0x28000000
>
> Address is wrong and is_write should be 0x2. It looks like the call
> stack
> from the _previous_ segfault_record.

What version of gcc do you use? And what optimize-flags do you use?
(stack-frames can't be trusted 100% with some combinations of
gcc-versions/optimize-levels.


Stian Skjelstad


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
