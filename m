Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Alh6u-0006TH-Vp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:28 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Alh6u-0002En-Ey
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Jan 2004 20:15:28 -0800
Message-Id: <200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Swapping directly to host swap area? 
In-Reply-To: Your message of "Sun, 25 Jan 2004 18:34:12 EST."
	<Pine.LNX.4.44.0401251827030.2766-100000@sparrow> 
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow> 
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
Date: Tue, 27 Jan 2004 23:39:22 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

wstearns@pobox.com said:
> When a VM needs to swap out, is there some way the UML kernel could
> send that sector directly to the host swap area instead of running its
> own swap?  

No, but this isn't the real question.

> In the current setup, the host kernel sees this as a normal
> write to an open file, caching it in the process and so not truly
> freeing up the ram for a bit. 

This is, and this could be done by setting O_DIRECT on UML swap devices.  That
way, writes go directly (and asynchronously) to the device without landing
in the cache.

With mmap in effect, this can also be done with a MADVISE_DONTNEED on the
relevant pages of the swap file.

Patches cheerfully accepted.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
