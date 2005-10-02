Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EMDXV-0006XP-2Y	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 16:46:41 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EM10D-0002D8-8V
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 02 Oct 2005 03:23:33 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] a question about sigsetjmp() in copy_from/to_user()
References: <3524bf1f050927070645b999bd@mail.gmail.com>
	<200509291409.28067.blaisorblade@yahoo.it>
	<20051002010315.GA4778@localhost.localdomain>
In-Reply-To: <20051002010315.GA4778@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510021223.15115.blaisorblade@yahoo.it>
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
Date: Sun, 2 Oct 2005 12:23:14 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Sunday 02 October 2005 03:03, Jeff Dike wrote:
> On Thu, Sep 29, 2005 at 02:09:27PM +0200, Blaisorblade wrote:
> > Again, that page is not bad. There is no page yet for this address, and
> > the host won't allocate one for now.

> It is bad in the sense that, unless some space is freed on that mount, a
> reference to the page will always fault.
Sorry, any reference will fault, unless it is done on a allocated present 
page, which the UML kernel freed but the host didn't. And remember, btw, 
you've planned to make this impossible...
> > Ok, this makes a bit of sense, even if IMHO it doesn't work, I now see
> > your point (but I still insist with what said above).

> Explain why it doesn't work.
Below.
> > However, even a dirtied page could be "bad", if it has been swapped. If
> > we're getting a SIGBUS, it meant that it didn't succeed in freeing any
> > memory.

> No it can't.  A swapped page still counts as occupying space in the
> filesystem. If a page was successfully allocated, then accesses to it will
> always succeed, even if it needs to be swapped in.

Sorry, Jeff, which page are you going to evict? It can be a dirty page. Unless 
you mean that since that page is still accounted in the FS, Linux will leave 
a RAM page free to allow it to be re-read, while still swapping the page.

You didn't obviously mean this absurdity (why swap it in first place), but I 
don't catch what's missing to you.

> > And, frankly, unless the UML ram file is kept on ramfs (which is
> > RAM-only), it can be swapped (both for disk-based filesystem and for
> > tmpfs). So, I don't think what you suggest could work.

> Swapping makes no difference.
Realoding pages means freeing RAM to leave place to them.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
