Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wlAB-0005rn-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 09 Sep 2003 09:16:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wlA8-00020v-TF
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 09 Sep 2003 09:16:17 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h89G8Rj12312
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 9 Sep 2003 12:08:27 -0400
Message-Id: <200309091616.h89GG72J003645@ccure.karaya.com>
Subject: Re: [uml-devel] Re: 2.6.0 uptime bug 
In-Reply-To: Your message of "Sat, 06 Sep 2003 21:07:08 +0200."
             <20030906190708.56B8C3BCE4@home.petschge.de> 
References: <200309041706.03045.petschge@gmx.de> <20030905151952.6EBFC3BCE4@home.petschge.de>  <20030906190708.56B8C3BCE4@home.petschge.de> 
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
Date: Tue, 09 Sep 2003 12:16:07 -0400
To: "Patrick \"Petschge\" Kilian" <petschge@web.de>
Cc: User-mode-linux-devel@lists.sourceforge.net

petschge@web.de said:
> I have a patch which gives the correct uptime. I don't know what the
> patch  breaks so please post any problems you have. 

Have you been able to figure out whether this is also a problem for other
ports?  Your patch suggests that it is, and if it is, then you should send
it to LKML so it can be fixed in mainline.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
