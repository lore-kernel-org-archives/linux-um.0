Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EM8yV-0005Wu-Bo	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:54:15 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EM8yT-0006Ns-Kc
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 11:54:15 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
Message-ID: <20051002183123.GC26063@ccure.user-mode-linux.org>
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200509291409.28067.blaisorblade@yahoo.it>
	<20051002010315.GA4778@localhost.localdomain>
	<200510021223.15115.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510021223.15115.blaisorblade@yahoo.it>
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
Date: Sun, 2 Oct 2005 14:31:23 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Sun, Oct 02, 2005 at 12:23:14PM +0200, Blaisorblade wrote:
> Sorry, any reference will fault, unless it is done on a allocated present 
> page, which the UML kernel freed but the host didn't. And remember, btw, 
> you've planned to make this impossible...

You are not making any sense t me here.

> Sorry, Jeff, which page are you going to evict? It can be a dirty page. Unless 
> you mean that since that page is still accounted in the FS, Linux will leave 
> a RAM page free to allow it to be re-read, while still swapping the page.

Swapped pages are accounted in the FS all the time and there's obviously
no dedicated page left free for them when they are next pulled in.  All 
disk-based filesystems account pages that are on disk and not in memory.
tmpfs is no different, except that its disk is the swap partition.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
