Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyGdV-0002zc-VJ for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 12:37:05 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AyGQy-0005SS-Vk
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 12:24:09 -0800
Message-Id: <200403022054.i22KslWo003006@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 02 Mar 2004 10:08:24 EST."
	<4044A368.8050406@nortelnetworks.com> 
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Re: problems with UML, issues with includes
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
Date: Tue, 02 Mar 2004 15:54:47 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

cfriesen@nortelnetworks.com said:
> Am I right in assuming that since we're hitting this it  seems to
> indicate some messed-up reference counting somewhere? 

It would appear so.

This is inside an if line->count == 0

> #4  0xa010e458 in line_open (lines=0xa02309a0, tty=0xaf1f7000, 
> opts=0xa0230920) at line.c:258

and the place that decrements line->count does this:

	if(line->count == 0)
		line_disable(line, -1);

which should ensure that the interrupt is disabled.

Could you get stack traces from activate_fd and deactivate_fd for this irq?
We need to see how the count is becoming 0 without the interrupt being turned
off.

				Jeff



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
