Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uIqO-00036K-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 02 Sep 2003 14:37:44 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uIqN-0006KC-97
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 02 Sep 2003 14:37:43 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h82LUWj02341
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 2 Sep 2003 17:30:32 -0400
Message-Id: <200309021849.h82InoHx001633@ccure.karaya.com>
Subject: Re: [uml-devel] [PATCH] Make UML slightly quieter 
In-Reply-To: Your message of "Mon, 01 Sep 2003 16:40:45 EDT."
             <20030901204045.GA17884@alcor.net> 
References: <20030901204045.GA17884@alcor.net> 
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
Date: Tue, 02 Sep 2003 14:49:50 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

mdz@debian.org said:
> When booting UML with the 'quiet' option, most kernel messages are
> suppressed, but the skas3 and /proc/mm check messages are still
> displayed. Using printk rather than printf lets them be suppressed in
> the normal way, and didn't break anything for me. 

The problem with this is that if UML dies early and doesn't make it into the
kernel proper, printk messages will never be seen, and those messages 
potentially have debugging usefulness.

We can possibly make everyone happy by replacing those printfs with a 
uml_printf that respects the -quiet switch.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
