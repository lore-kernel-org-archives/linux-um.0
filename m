Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOk1E-0002tC-5o	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:51:48 -0700
Received: from wumpus.mythic-beasts.com ([212.69.37.9] ident=Debian-exim)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOk1G-0006OW-NY
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:51:52 -0700
From: Chris Lightfoot <chris@ex-parrot.com>
Subject: Re: [uml-devel] UBD performance
Message-ID: <Nrn3QE48asne.DeHnFPPg9WBURzpIZbOgOA@sphinx.mythic-beasts.com>
References: <z/jPSbKkgHHL.jbObjJNOGZsiVW/jm0lNOg@sphinx.mythic-beasts.com>
	<20051009184542.GC4901@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051009184542.GC4901@ccure.user-mode-linux.org>
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
Date: Sun, 9 Oct 2005 23:51:28 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, Oct 09, 2005 at 02:45:42PM -0400, Jeff Dike wrote:
> On Sat, Oct 08, 2005 at 05:32:10PM +0100, Chris Lightfoot wrote:
> > Jeff Dike also has an AIO reimplementation of UBD in the
> > works, but I haven't had a chance to look at it yet.
> 
> Why don't you look at UML with the AIO stuff applied?  It's pretty certain 
> that the one-at-a-time pseudo-AIO gives you close to synchronous
> performance when you have a lot of IO.  The AIO work is intended to
> fix that, and if it doesn't, I like to know why.
> 
> If you do want to play with the current stuff, I think you can wash
> out the effects of the pseudo-AIO stuff by slowing down the host and
> having it do symchronous I/O.  If there is still a major difference
> between UML and the host, it would be interesting to know why.

OK, here are the previous results comparing the AIO
implementation (using the code in the rc7 patches from
2005-08-26 and the ubd patches from 2005-09-17) with the
existing and my implementations:
    http://ex-parrot.com/~chris/tmp/20051009/host-vs-uml-io-results-2.png
On this task (random seeks + random synchronous writes)
AIO helps a little bit but not very much.

(TBH I'm surprised that the AIO code shows so little
improvement. The kernel does report that it's using 2.6
host AIO, so it is using the new version. Obviously
issuing the writes segment-by-segment is non-ideal but I'm
surprised it's this bad. Could I be missing some
configuration step?)

-- 
``I won't let you in until you explain the ending of the movie.''
  (unknown US immigration officer, to Arthur C. Clarke, 1969)


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
