Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGUU1-0002SP-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 18:30:21 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AGUU0-00024l-Od
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 18:30:21 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA32HpD03097
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 2 Nov 2003 21:17:51 -0500
Message-Id: <200311030236.hA32aggX002499@ccure.karaya.com>
Subject: Re: [uml-devel] Sleeping process getting segfault signal 
In-Reply-To: Your message of "Sun, 02 Nov 2003 11:23:51 +0200."
             <200311020923.hA29Np9K029637@car.linuxhacker.ru> 
References: <Pine.GSO.4.58.0311012137370.355@altair.dur.ac.uk>  <200311020923.hA29Np9K029637@car.linuxhacker.ru> 
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
Date: Sun, 02 Nov 2003 21:36:42 -0500
To: Oleg Drokin <green@linuxhacker.ru>
Cc: m.a.young@durham.ac.uk, user-mode-linux-devel@lists.sourceforge.net

green@linuxhacker.ru said:
> Jeff: I finally hit the problem yesterday with extra debug code to
> save the sigmask. Here's what I see. (also include sigjump buffer that
> was setup later than sigprocmask was run).
>
> sigmask = {__val = {134284288

(gdb) p/x 134284288
$1 = 0x8010400

Thats SIGSEGV (the one that matters here), SIGCHLD, and SIGIO.  So, we have
to figure out how we're getting there with SIGSEGV blocked.  What's the stack
at that point?

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
