Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AWKyY-0001QJ-8U
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:35:22 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.24)
	id 1AWKyW-0005ML-D4
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 16 Dec 2003 11:35:20 -0800
Message-Id: <200312161950.hBGJoVkS002972@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] uml-patch-2.4.22-7 
In-Reply-To: Your message of "16 Dec 2003 18:50:53 +0100."
             <1071597053.2150.9.camel@mancillotti.retesintesi.net> 
References: <200312161653.hBGGrDkS002312@ccure.user-mode-linux.org>  <1071597053.2150.9.camel@mancillotti.retesintesi.net> 
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
Date: Tue, 16 Dec 2003 14:50:31 -0500
To: marco ancillotti <mancillotti@interfree.it>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

mancillotti@interfree.it said:
> so there's better performance in tt mode when using highmem ? 

Ironically, tt mode is faster than skas mode when you have a lot of highmem
in use.  skas mode is slowed down that much.

I'm thinking of ways of improving that.  The current plan is to make kmap/kunmap
do reads and writes instead of mmap/munmap in skas mode.  That will exchange
I/O for the tlb flushing.  We'll see how much difference that makes.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
