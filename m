Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1ron-0002AH-Fl for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 12:27:53 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.34)
	id 1C1rom-0007Ys-MA for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 30 Aug 2004 12:27:53 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <20040822040821.GA7183@tp.user-mode-linux.org>
In-Reply-To: <20040822040821.GA7183@tp.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408301722.56559.blaisorblade_personal@yahoo.it>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: sysemu
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
Date: Mon, 30 Aug 2004 20:48:45 +0200
To: Jeff Dike <jdike@sonycom.com>
Cc: LaurentVivier@wanadoo.fr, user-mode-linux-devel@lists.sourceforge.net

Alle 06:08, domenica 22 agosto 2004, Jeff Dike ha scritto:
> Call me a lamer, but I only now got around to looking at the sysemu
> patch in detail.
>
> As it stands, it can't be merged into mainline because it adds two
> instructions to the system call fast path.  This is the sort of thing
> that make Linus and others go ballistic.

> Below, see a patch which tweaks things to eliminate both problems.
> Now, PT_SCEMU is set in conjunction with PT_TRACESYS, rather than
> one or the other, but not both, being set.

> This means that the PT_TRACESYS test in entry.S covers both cases, and
> the fast path is unchanged.

> The other change was to make syscall_trace return zero or non-zero,
> according as it should run the system call or immediately return.
> This adds a line to syscall_trace and eliminates syscall_emulate.

> The updated patch is 83 lines of diff rather than the original 128.

> I've run it with a small test program, apparently successfully, with
> good speed increases.  I'm having more trouble getting a tt mode UML
> running, but I think that's a problem with the UML rather than the
> host.

> Have a look and see if it looks reasonable.

Yes, it does. You should just rename *_SCEMU to *_SYSEMU (the guest patch uses 
already *_SYSEMU, which is nicer IMHO, so let's be coherent).

While you are looking at the SYSEMU patch, could you try to understand why 
when SYSEMU is active (at least in SKAS mode, never done anything in TT mode) 
strace does not work?

I looked at it with gdb a while ago but I wasn't able to make sense from what 
I saw.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
