Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArnVW-0004Jw-Nd
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 16:18:06 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArnQH-0008II-1a
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 13 Feb 2004 16:12:41 -0800
Message-Id: <200402140043.i1E0h7sq004297@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [inkblot@movealong.org: Bug#224215: incorrect /proc timestamp] 
In-Reply-To: Your message of "Sun, 11 Jan 2004 22:46:20 PST."
             <20040112064620.GU1436@alcor.net> 
References: <20040112064620.GU1436@alcor.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 13 Feb 2004 19:43:07 -0500
To: Matt Zimmerman <mdz@debian.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, 224215-forwarded@bugs.debian.org

mdz@debian.org said:
> The timestamp of /proc after mounting the proc filesystem is fixed at
> Jan 1, 1970 (likely initialized to 0 in Unix time and then never set).

This will be fixed in the next patch.  The problem was that no timer interrupts
had fired by the time /proc was first mounted, so xtime, which is used to
initialize the /proc inode times, was still 0.

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
