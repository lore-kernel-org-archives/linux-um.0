Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AwiXf-0001oY-5t for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 06:00:39 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Awi8y-0002mO-RW
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Feb 2004 05:35:09 -0800
Message-Id: <200402271419.i1REJtM9001977@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Crash early in boot with 2.4.25+uml-patch-2.4.24-1 
In-Reply-To: Your message of "Fri, 27 Feb 2004 02:29:41 CST."
	<200402270829.i1R8TfAX014941@hongkong.cs.nmsu.edu> 
References: <200402270829.i1R8TfAX014941@hongkong.cs.nmsu.edu> 
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
Date: Fri, 27 Feb 2004 09:19:55 -0500
To: Ross Combs <rocombs@cs.nmsu.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

rocombs@cs.nmsu.edu said:
> The boot messages look like this when it dies:
>  Checking for the skas3 patch in the host...not found
>  Checking for /proc/mm...not found
>  make_umid - mkstemp failed, errno = 13
>  tracing thread pid = 22242
>  Segmentation fault 

Copy /proc/cpuinfo into the jail.  I added a dependency on that when doing
the RTC change, but forgot to make it behave well when cpuinfo isn't available.

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
