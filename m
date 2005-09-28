Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKf6L-0006b5-Ck	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:48:13 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKf6B-00045D-R8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 09:48:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509281414.32622.blaisorblade@yahoo.it>
	<20050928155405.GA12888@ccure.user-mode-linux.org>
In-Reply-To: <20050928155405.GA12888@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281847.21078.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 18:47:20 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Wednesday 28 September 2005 17:54, Jeff Dike wrote:
> On Wed, Sep 28, 2005 at 02:14:32PM +0200, Blaisorblade wrote:
> > Very, very nice.

> > Let's hope for the better, but next time the debug should be done
> > *before* merging, ok? Even because, for instance, if (say) the patch was
> > ready for 2.6.14 and merged into 2.6.15, I could have released a test
> > tree against 2.6.14 (maybe I could do this now).

> I thought I did.  AIO had been in my tree forever with no apparent
> problems.
We're not currently getting a lot of testing on that. Apart the really current 
issue of the page not uptodate, users mostly ran that because of x86_64 
support, which is now reliable in mainline.

In fact, the SKAS0 compiler-dependant bug (the asm code was popping a fixed 
number of words, which was wrong with different compiler) only came out on 
the tree I released against 2.6.12...
> I recently started running 24 hour/day stress tests on UML, and 
> that turned up some problems.  People turning on spinlock debugging turned
> up the sleeping while atomic problem.  And me staring at the code as a
> result of that turned up the possible deadlock.

> > And ask Jens Axboe if it can give a look to them (this time it's less
> > necessary, since there are less dirty tricks).

> Yeah.  This still needs some work.  I need to deal with the bitmap array
> properly.

> 				Jeff

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
