Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyIw2-0003Lj-N2 for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 15:04:22 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AyIjT-0004z2-1Y
	for User-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Mar 2004 14:51:23 -0800
Message-Id: <200403022322.i22NM8Wo003853@ccure.user-mode-linux.org>
In-Reply-To: Your message of "Tue, 02 Mar 2004 17:26:16 EST."
	<40450A08.8090608@nortelnetworks.com> 
References: <4043B42A.10803@nortelnetworks.com>
	<200403020100.i2210dM9025649@ccure.user-mode-linux.org>
	<4044A368.8050406@nortelnetworks.com>
	<200403022054.i22KslWo003006@ccure.user-mode-linux.org>
	<40450A08.8090608@nortelnetworks.com> 
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
Date: Tue, 02 Mar 2004 18:22:08 -0500
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: User-mode-linux-devel <User-mode-linux-devel@lists.sourceforge.net>

cfriesen@nortelnetworks.com said:
> #1  0xa00d03d6 in activate_fd (irq=3, fd=47, type=1,
> dev_id=0xa02309f8) at irq_user.c:230 

Why don't your line numbers match mine?  The kfree you seem to be talking
about is this:

   211   out_unlock:
   212          irq_unlock(flags);
   213          kfree(new_fd);
   214   out:

And I totally don't see a problem there.  new_fd isn't on any lists when it's
freed there.

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
