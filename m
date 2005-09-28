Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKaqB-0000TR-CW	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:15:15 -0700
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKaq7-0000kf-Mb
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Sep 2005 05:15:15 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Review needed for ubd fixes
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509222251.31918.blaisorblade@yahoo.it>
	<20050927181218.GA28937@ccure.user-mode-linux.org>
In-Reply-To: <20050927181218.GA28937@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509281414.32622.blaisorblade@yahoo.it>
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
Date: Wed, 28 Sep 2005 14:14:32 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tuesday 27 September 2005 20:12, Jeff Dike wrote:
> Attached is my current set of I/O patches.  It's significantly different,
> and simpler, than my previous set.

> Now, there is no sleeping while running the queue, so the spinlock is never
> dropped, and all of the extra synchronization is gone.
Very, very nice.

What about the early removal of the request from the queue, before being sure 
we can complete it (sorry for not reading carefully everything below, I'm 
going to have lunch and afterwards back to study).
> o_direct adds O_DIRECT support to UML and makes the ubd driver use it.
>
> aio-errors makes submit_aio_24 return -errno instead of -1.
Reorder o_direct at the end - no time to read them yet, but guess that more 
intrusive goes at the end. And I'm not sure whether merging o_direct so late 
in 2.6.14 is nice (even if you've tested the full patch set, and without 
o_direct the thing makes less sense).

Let's hope for the better, but next time the debug should be done *before* 
merging, ok? Even because, for instance, if (say) the patch was ready for 
2.6.14 and merged into 2.6.15, I could have released a test tree against 
2.6.14 (maybe I could do this now).
> I've given this a bunch of testing and it has survived overnight kernel
> build loops on both x86 and x86_64.

> The attached patches are against 2.6.14-rc2.
Please, send them to Andrew for -mm, and say "2.6.14 can't go without them, 
but they might need further review".

And ask Jens Axboe if it can give a look to them (this time it's less 
necessary, since there are less dirty tricks).
> 			Jeff

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
