Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6co3-0006YV-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:22:15 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6co1-0003zP-7C
	for User-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:22:13 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LC3j06710
	for <User-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:12:04 -0400
Message-Id: <200310062123.h96LNpGj020816@ccure.karaya.com>
Subject: Re: [uml-devel] tls in UML (2.6) 
In-Reply-To: Your message of "Mon, 29 Sep 2003 20:41:36 BST."
             <Pine.GSO.4.53.0309292037350.11905@altair.dur.ac.uk> 
References: <Pine.GSO.4.53.0309292037350.11905@altair.dur.ac.uk> 
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
Date: Mon, 06 Oct 2003 17:23:51 -0400
To: M A Young <m.a.young@durham.ac.uk>
Cc: User-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> Is anyone working on porting (or have already ported) the bits of tls
> (such as the get/set_thread_area syscalls) that are in 2.6 i386 to
> UML? 

I haven't yet.  This looks similar to the ldt stuff, where you have to
decide whether and how to just turn around and call get/set_thread_area
on the host.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
