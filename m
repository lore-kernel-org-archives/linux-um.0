Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bp8uN-00055m-OM for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 10:05:03 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.34) id 1Bp8uN-0007p8-9R
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Jul 2004 10:05:03 -0700
Message-Id: <200407261802.i6QI2wfL001824@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [alydar@users.sourceforge.net: Bug#260111:
	user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0 for
	NET4.0"] 
In-Reply-To: Your message of "Sun, 18 Jul 2004 15:40:35 PDT."
	<20040718224035.GT4090@mizar.alcor.net> 
References: <20040718224035.GT4090@mizar.alcor.net> 
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
Date: Mon, 26 Jul 2004 14:02:58 -0400
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

mdz@debian.org said:
> Bug#260111: user-mode-linux: upgrade hangs at "NET4: Linux TCP/IP 1.0
> for NET4.0" 

This resembles the GHz bug, except that one is fixed.  If someone could get
a stack trace from the last call to schedule(), that would be a help.

There is some sort of a deadlock on a semaphore, and I'd like to know which
one it is.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
