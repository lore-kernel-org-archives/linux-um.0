Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AX9Ra-0000gi-M9
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:28:42 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AX9RY-0007VT-PG
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 18 Dec 2003 17:28:41 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] uml newbie skas question
Message-ID: <20031219014417.GB4945@ccure.user-mode-linux.org>
References: <20031218220922.87234.qmail@web14004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218220922.87234.qmail@web14004.mail.yahoo.com>
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
Date: Thu, 18 Dec 2003 20:44:17 -0500
To: Sam King <sam_king18@yahoo.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Dec 18, 2003 at 02:09:22PM -0800, Sam King wrote:
> What are the write_sigio_thread and winch_thread
> processes in skas mode used for?

The write SIGIO thread - until fairly recently, output SIGIO (i.e. a SIGIO
when you can write something to a device) wasn't supported by pty devices.
To work around this, and avoid losing characters when UML is spitting out
lots of stuff, I added this thread.  Its job is to wait synchronously (via
poll) until a file descriptor that it has been told to keep track of reports
that it can be written to.  At this point, it writes a character down a 
pipe (actually a socketpair) waking up the UML kernel proper, which has an
IRQ attached to the other end.

The winch threads - we need a way to receive SIGWINCH on host devices so that
they can be relayed on to whatever UML process is running on the corresponding
console.  The problem here is that only the owner of a terminal can receive
SIGWINCH, and a process can only own one terminal.  This rules out having UML
itself receive the SIGWINCHs, so these guys exist solely to own a terminal,
receive any SIGWINCHs that they emit, and interrupt UML in the same way as
the SIGIO thread.

				Jeff




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
