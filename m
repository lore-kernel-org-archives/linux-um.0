Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArO6i-0007HX-Ag
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:10:48 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1ArO5N-0000g3-DO
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 12 Feb 2004 13:09:25 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Swapping directly to host swap area?
Message-ID: <20040212213620.GA4168@ccure.user-mode-linux.org>
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow> <200402051759.03917.blaisorblade_spam@yahoo.it> <200402110043.i1B0hOip004189@ccure.user-mode-linux.org> <200402122008.22995.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402122008.22995.blaisorblade_spam@yahoo.it>
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
Date: Thu, 12 Feb 2004 16:36:20 -0500
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 12, 2004 at 08:08:22PM +0100, BlaisorBlade wrote:
> It seems to me that the access statistics should be the same ones: I do not 
> know thoroughly the way pages are marked as active or swappable (I can check 
> in the 2.4 VM description - ask for the address) but if that depends on page 
> faulting, then, it seems to me that since guest page fault are even host page 
> fault (the UML handling of SIGSEGV is like the host handling of CPU fault 
> exceptions, right?) the statistics should be the same. 

No, they're not the same.  If a page is swapped out by the host, and then
swapped back in, that will count as a page fault on the host, but not inside
the UML.

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
