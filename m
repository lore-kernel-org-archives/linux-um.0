Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EEADl-0007j4-Ja	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:37:01 -0700
Received: from pfepc.post.tele.dk ([195.41.46.237])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EEADk-0003YF-9y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Sep 2005 11:37:01 -0700
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20050910183825.GA22348@mars.ravnborg.org>
References: <20050910174452.907256000@zion.home.lan>
	<20050910174627.569839000@zion.home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050910174627.569839000@zion.home.lan>
Subject: [uml-devel] Re: [patch 2/7] i386 / uml: add dwarf sections to static
	link script
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
Date: Sat, 10 Sep 2005 20:38:25 +0200
To: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 10, 2005 at 07:44:54PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> Inside the linker script, insert the code for DWARF debug info sections. This
> may help GDB'ing a Uml binary. Actually, it seems that ld is able to guess
> what I added correctly, but normal linker scripts include this section so it
> should be correct anyway adding it.
> 
> On request by Sam Ravnborg <sam@ravnborg.org>, I've added it to
> asm-generic/vmlinux.lds.s. I've also moved there the stabs debug section,
> used the new macro in i386 linker script and added DWARF debug section to
> that.
Thanks!
Acked-by: Sam Ravnborg <sam@ravnborg.org>

	Sam


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
