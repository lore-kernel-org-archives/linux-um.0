Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E8fry-0003Eo-2y	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:11:50 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E8frw-0003On-Cg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 26 Aug 2005 08:11:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: madvise(DONTNEED) on tmpfs pages instead of
	/dev/anon
References: <200508102136.43763.blaisorblade@yahoo.it>
	<200508121900.26503.blaisorblade@yahoo.it>
	<20050822202402.GA27051@ccure.user-mode-linux.org>
In-Reply-To: <20050822202402.GA27051@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508261706.20923.blaisorblade@yahoo.it>
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
Date: Fri, 26 Aug 2005 17:06:20 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Rik van Riel <riel@redhat.com>, user-mode-linux-devel@lists.sourceforge.net

On Monday 22 August 2005 22:24, Jeff Dike wrote:
> On Fri, Aug 12, 2005 at 07:00:26PM +0200, Blaisorblade wrote:
> > Yes, but for the VM, there is nothing else than pagecache and swapcache
> > and swap entries. Since that call will drop them, on normal files backing
> > store will remain, on tmpfs everything will vanish!

> > Hope you'll implement this soon, if it works.

> There was a small omission in my quick analysis, which you alluded to
> above.

> It's removed from the address space, but preserved in the page cache.
Yes, yesterday I realized this point. The pagecache has one additional 
reference, which is only deleted after try_to_unmap() (the rmap function to 
detach a page from page tables) succeeds (grep try_to_unmap mm/*.c to find 
the caller).

In fact, the madvise() comment only talks about anonymous memory.

Rik, is there any hope to extend madvise() to cater for this?
> Run the test below to see this.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
