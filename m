Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1At8NB-0008PH-JH
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 17 Feb 2004 08:47:01 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1At8Cf-0007Wy-3q
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 17 Feb 2004 08:36:09 -0800
Message-Id: <200402171710.i1HHAYMM002541@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Re: Segfault of UML-TT on FC1 
In-Reply-To: Your message of "Mon, 16 Feb 2004 19:32:30 GMT."
             <Pine.LNX.4.58.0402161916440.8742@vega.dur.ac.uk> 
References: <20040215232525.7c2f38a8.zaitcev@redhat.com> <Pine.LNX.4.58.0402160248320.3114@devserv.devel.redhat.com>  <Pine.LNX.4.58.0402161916440.8742@vega.dur.ac.uk> 
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
Date: Tue, 17 Feb 2004 12:10:34 -0500
To: M A Young <m.a.young@durham.ac.uk>
Cc: Ingo Molnar <mingo@redhat.com>, Pete Zaitcev <zaitcev@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

m.a.young@durham.ac.uk said:
> The remaining issue which the final part addresses is that a later
> routine that reserves area to act as physical memory still assumes the
> areas are adjacent, and you get a random amount less memory reserved
> than you expect (something like 16M), and this might not leave you
> with enough memory to use.

The space is non-zero even on a non-exec-shield system, probably because some
mallocing has pushed the brk across a page boundary.  So I changed it to add
memory only if it's > 1M, and also added a printf saying what's happening.

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
