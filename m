Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CoOxa-0008H6-P6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 08:33:34 -0800
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]
	helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41) id 1CoOxZ-0001c7-5f
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Jan 2005 08:33:34 -0800
Message-Id: <200501111855.j0BIt7Wi003586@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] kernel BUG at net/ipv4/tcp_output.c:277! 
In-Reply-To: Your message of "Tue, 11 Jan 2005 00:49:13 CST."
	<063e01c4f7a9$aabaf790$0201a8c0@hawk> 
References: <063e01c4f7a9$aabaf790$0201a8c0@hawk> 
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
Date: Tue, 11 Jan 2005 13:55:06 -0500
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

caker@theshore.net said:
> kernel BUG at net/ipv4/tcp_output.c:277! 
> Kernel panic - not syncing: BUG! 

A bit of googling turns up
	http://kerneltrap.org/node/4119

making this look like a generic kernel bug.

			Jeff



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
