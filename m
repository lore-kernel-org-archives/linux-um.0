Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOmgG-0003Ra-8W	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 18:42:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EOmgK-0000HW-55
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 18:42:25 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] UBD performance
Message-ID: <20051010013515.GB10677@ccure.user-mode-linux.org>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
	<20051009184542.GC4901@ccure.user-mode-linux.org>
	<Nrn3QE48asne.DeHnFPPg9WBURzpIZbOgOA@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Nrn3QE48asne.DeHnFPPg9WBURzpIZbOgOA@sphinx.mythic-beasts.com>
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
Date: Sun, 9 Oct 2005 21:35:15 -0400
To: Chris Lightfoot <chris@ex-parrot.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 09, 2005 at 11:51:28PM +0100, Chris Lightfoot wrote:
> (TBH I'm surprised that the AIO code shows so little
> improvement. The kernel does report that it's using 2.6
> host AIO, so it is using the new version. Obviously
> issuing the writes segment-by-segment is non-ideal but I'm
> surprised it's this bad. Could I be missing some
> configuration step?)

Make sure you've got the o_direct patch, and are using a 4K block filesystem.

If you're not doing O_DIRECT, then io_getevents waits - i.e. it's synchronous.

				Jeff


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
