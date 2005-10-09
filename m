Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOgHx-0001HX-J5	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 11:52:49 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOgHy-0005EQ-Hj
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 11:52:51 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] UBD performance
Message-ID: <20051009184542.GC4901@ccure.user-mode-linux.org>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
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
Date: Sun, 9 Oct 2005 14:45:42 -0400
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Oct 08, 2005 at 05:32:10PM +0100, Chris Lightfoot wrote:
> Jeff Dike also has an AIO reimplementation of UBD in the
> works, but I haven't had a chance to look at it yet.

Why don't you look at UML with the AIO stuff applied?  It's pretty certain 
that the one-at-a-time pseudo-AIO gives you close to synchronous
performance when you have a lot of IO.  The AIO work is intended to
fix that, and if it doesn't, I like to know why.

If you do want to play with the current stuff, I think you can wash
out the effects of the pseudo-AIO stuff by slowing down the host and
having it do symchronous I/O.  If there is still a major difference
between UML and the host, it would be interesting to know why.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
