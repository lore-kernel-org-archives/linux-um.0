Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSnvp-00056t-QR	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 20:18:45 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DSnvo-00026C-9H	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 20:18:45 -0700
Message-Id: <200505030313.j433Djv2018124@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6 
In-Reply-To: Your message of "Mon, 02 May 2005 15:52:12 PDT."
             <20050502155212.gfil42buedk4w8w4@www.scgiservices.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 02 May 2005 23:13:45 -0400
To: Anthony Brock <brocka@sterlingcgi.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

brocka@sterlingcgi.com said:
> Is this your "stack trace"? 

Close.  What I'd really like is to get it to crash when it's running under
gdb, with a breakpoint on panic.  Then, 'bt' to gdb at that point.

That gives the true call trace, plus line number information.

> 08297488:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
> 082974b8:  [<08075e87>] sig_handler+0x17/0x20
> 08297508:  [<0806b21f>] chan_interrupt+0xf/0x130
> 08297530:  [<08064f70>] enable_mask+0x50/0x70

This tells me that chan_interrupt segfaulted, but not necessarily exactly
where, and a lot of the other stuff on the stack isn't in the true call
chain.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
