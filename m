Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EYFb5-0001Tn-6D for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:24:07 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EYFb3-0001ic-3D
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Nov 2005 20:24:07 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] The web page doesn't say where to get the switch
	daemon.
Message-ID: <20051105051643.GA15683@ccure.user-mode-linux.org>
References: <200511041900.37782.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511041900.37782.rob@landley.net>
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
Date: Sat, 5 Nov 2005 00:16:43 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Nov 04, 2005 at 07:00:37PM -0600, Rob Landley wrote:
> Let's see, the uml_net link from the download page (the difference between 
> that and uml_switch is...?) links to a generic page about CVS, which isn't 
> installed on my laptop.  (Subversion is, but doesn't help here.)  Ok, a web 
> browsing link...  No tarball.  Ok, maybe it's one source file I can get and 
> compile, ala ifenslave...

Let's see.  On the downloads page, there is a utilities section which says
something about uml_switch.  Grabbing that tarball shows me a directory
called uml_router (which is probably the problem - that's the old name before
people clued me in that I hadn't really implemented a router) with something
called uml_switch.c in it.  Building that might give you something called
uml_switch.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
