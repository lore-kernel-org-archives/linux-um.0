Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yGO3-0002aB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 12:48:51 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yGO2-0002Tj-TX
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 12:48:51 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19yGO1-0002SY-00
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 15:48:49 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19yGO1-0006mT-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 15:48:49 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
Message-ID: <20030913194849.GX8622@alcor.net>
References: <200309131820.45833.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309131820.45833.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Sep 2003 15:48:49 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Sep 13, 2003 at 06:20:45PM +0200, BlaisorBlade wrote:

> Reason for this: time ago, someone requested how to execute a command from 
> mconsole. The discussion ended up by saying "use cad, after having changed 
> the related line in /etc/inittab". The command needed was the one to poweroff 
> the PC, but this applies generally. Since that thread showed that running 
> commands without logging in is something needed, I decided to implement it.
> 
> I'd like a discussion about this(how much interest in this there is, 
> suggestions, requests). Especially:

This is interesting.  I wrote a small client/server system for the purpose
of programmatically executing programs within UML.  It works nicely, with
the exception that it is necessary to install the server within UML in order
for it to work.  It would be nice to be able to do this with a pristine UML.

What do you do with stdin, stdout and stderr?  I connect them to a UML
serial device, which can be connected to the tty (for interactive programs)
or any other UML channel.

> - is the ability to read arguments with spaces(within quotes) needed even for 
> the program name?

I don't think this is particularly crucial; does it cause some unexpected
difficulty?

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
