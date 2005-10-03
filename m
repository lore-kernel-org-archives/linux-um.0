Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMVMb-0007ea-Ly	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:37 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EMVMb-0004dZ-8O
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 03 Oct 2005 11:48:37 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200510021223.15115.blaisorblade@yahoo.it>
	<20051002183123.GC26063@ccure.user-mode-linux.org>
In-Reply-To: <20051002183123.GC26063@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510032035.55254.blaisorblade@yahoo.it>
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
Date: Mon, 3 Oct 2005 20:35:54 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Sunday 02 October 2005 20:31, Jeff Dike wrote:
> On Sun, Oct 02, 2005 at 12:23:14PM +0200, Blaisorblade wrote:
> > Sorry, any reference will fault, unless it is done on a allocated present
> > page, which the UML kernel freed but the host didn't. And remember, btw,
> > you've planned to make this impossible...

> You are not making any sense t me here.

/dev/anon - when the UML kernel frees a page, we ask the host to free it too.

> > Sorry, Jeff, which page are you going to evict? It can be a dirty page.
> > Unless you mean that since that page is still accounted in the FS, Linux
> > will leave a RAM page free to allow it to be re-read, while still
> > swapping the page.

> Swapped pages are accounted in the FS all the time and there's obviously
> no dedicated page left free for them when they are next pulled in.  All
> disk-based filesystems account pages that are on disk and not in memory.
> tmpfs is no different, except that its disk is the swap partition.
Exactly what I knew...

However, I was in error...

I just saw that filling the disk, or tmpfs, is rather different than going 
OOM. OOM causes SIGKILL, while SIGBUS (as you correctly said) comes from full 
disk/partition, or filled disk quota. I only checked tmpfs, but that gives at 
least a feeling.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
