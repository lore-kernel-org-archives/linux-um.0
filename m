Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19xsNu-0004vA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 11:11:07 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19xsNt-0001OP-N6
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 12 Sep 2003 11:11:06 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8CI2Oj14060
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 12 Sep 2003 14:02:40 -0400
Message-Id: <200309121809.h8CI9Be4003196@ccure.karaya.com>
Subject: Re: [uml-devel] Re: 2.6.0 uptime bug 
In-Reply-To: Your message of "Thu, 11 Sep 2003 19:44:30 +0200."
             <20030911180344.A96963BCE4@home.petschge.de> 
References: <20030911180344.A96963BCE4@home.petschge.de> 
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
Date: Fri, 12 Sep 2003 14:09:11 -0400
To: petschge@web.de
Cc: user-mode-linux-devel@lists.sourceforge.net

petschge@gmx.de said:
> Ok 2.6.0-test5 gives the correct uptime on i386 and the wrong huge
> uptime as uml.

That being the case, there's a bug in UML somewhere which needs fixing.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
