Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A44Nv-0005WB-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 29 Sep 2003 13:12:43 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A44Nt-0001Z0-PX
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 29 Sep 2003 13:12:42 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8QNqDj30769
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 26 Sep 2003 19:52:14 -0400
Message-Id: <200309270002.h8R02Exx003316@ccure.karaya.com>
Subject: Re: [uml-devel] Separate COW patch. 
In-Reply-To: Your message of "Fri, 26 Sep 2003 18:45:26 EDT."
             <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net> 
References: <2D4B6CD74137D4119A1100104BC6BCBF0BC585FC@dubntex006.qwest.net> 
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
Date: Fri, 26 Sep 2003 20:02:14 -0400
To: "Montgomery, Kendal L" <kendal.montgomery@qwest.com>
Cc: "'user-mode-linux-devel@lists.sourceforge.net'" <user-mode-linux-devel@lists.sourceforge.net>

kendal.montgomery@qwest.com said:
> I was wondering if there was anyone who is trying to use the COW
> filesystem in a normal linux kernel?  Is this possible, or is it tied
> exclusively to the rest of the UML patch?

I started making a standalone COW driver that would be usable in any kernel,
UML or otherwise.  The results are visible in the patch in 
arch/um/drivers/cow*.c.

I got sidetracked, but this is something that I'm going to finish up at
some point.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
