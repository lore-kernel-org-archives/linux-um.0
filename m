Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZW42-0005Yt-LQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:11:14 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EZW41-0007F1-21
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 08 Nov 2005 08:11:14 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<91A93A3A-FE83-4002-A004-E8FD4AFBAA3C@stanford.edu>
	<200511080109.06999.rob@landley.net>
In-Reply-To: <200511080109.06999.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511081713.14783.blaisorblade@yahoo.it>
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
Date: Tue, 8 Nov 2005 17:13:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Can Sar <csar@stanford.edu>

On Tuesday 08 November 2005 08:09, Rob Landley wrote:
> On Monday 07 November 2005 23:13, Can Sar wrote:
> > Hi,
> >
> > I am trying to make a 1 thread version of UML that does not need to
> > be able to support user level programs.

> Why?

He may well be running Valgrind or something similar (Valgrind doesn't like us 
using clone(), even if it accepts fork()).

Ah, btw, given his address, I wonder if he's related at all with some project 
like "Stanford Checker" or a relative of it.

> Did you ever read Rik van Reil's list of the dumbest patches he's ever
> seen? This is the first entry in the list:
>
> http://www.surriel.com/potm/apr2001.shtml

Sorry I don't see your point, Rob - it's a really different thing.

> Define "port".  (Have you looked at mmu-less linux?  Are you saying you
> haven't got a timer interrupt and can't fake up some kind of green-threads
> approach like people managed to do under _DOS_?)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
