Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vN12-0000eQ-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 13:17:08 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19vN10-0005vk-KJ
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 13:17:08 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h85K9bj04382
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 5 Sep 2003 16:09:38 -0400
Message-Id: <200309052012.h85KCUjh001314@ccure.karaya.com>
Subject: Re: [uml-devel] Creating virtual consoles on the fly 
In-Reply-To: Your message of "Thu, 04 Sep 2003 11:00:54 PDT."
             <10C160F5A03A0942A1A87B658784CA6A0976D2@gummo.domain.trailerparc.com> 
References: <10C160F5A03A0942A1A87B658784CA6A0976D2@gummo.domain.trailerparc.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Fri, 05 Sep 2003 16:12:30 -0400
To: Michael Talyansky <michaelt@doublewidesoft.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

michaelt@doublewidesoft.com said:
> If I run /sbin/mingetty with a new console tty (say, ttys/2), the
> virtual console xterm does come up, but then mingetty terminates, and
> no login process is run for the new console. Could someone tell me
> what am I doing wrong? 

Have you tried putting an entry in inittab and kill -1 1?  I've tried running
getty from the command like in the past, and IIRC it wasn't happy about that.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
