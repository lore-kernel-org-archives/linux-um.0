Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C4Yhy-0006Xo-IT for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 22:39:58 -0700
Received: from brown.brainfood.com ([146.82.138.61]
	helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1C4Yhx-0006mK-4m for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Sep 2004 22:39:58 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] Current state of UML
In-Reply-To: <413D4366.5020902@pobox.com>
Message-ID: <Pine.LNX.4.58.0409070039100.1556@gradall.private.brainfood.com>
References: <200408190301.i7J30xek004150@ccure.user-mode-linux.org>
	<200408251746.53523.blaisorblade_spam@yahoo.it>
	<413B76DB.5010600@pobox.com>
	<200409061956.34557.blaisorblade_spam@yahoo.it>
	<413D3BC8.1050902@pobox.com>
	<Pine.LNX.4.58.0409070002220.1556@gradall.private.brainfood.com>
	<413D4366.5020902@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Tue, 7 Sep 2004 00:39:23 -0500 (CDT)
To: Jeff Garzik <jgarzik@pobox.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tue, 7 Sep 2004, Jeff Garzik wrote:

> Adam Heath wrote:
> > Sounds like a syslog bug, that should have been fixed long ago.
>
> Perhaps...  strace running inside UML host seems to stop at nanosleep,
> of all places:

Oh, well that sounds like something else.  Probably a uml problem.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
