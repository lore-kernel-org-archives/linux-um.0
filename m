Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJK6T-0006LN-L9	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 17:10:49 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJK6S-0000iP-4v
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 17:10:49 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509241603.53845.blaisorblade@yahoo.it>
	<Pine.LNX.4.61.0509250103240.30315@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0509250103240.30315@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241910.26031.rob@landley.net>
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
Date: Sat, 24 Sep 2005 19:10:25 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Blaisorblade <blaisorblade@yahoo.it>

On Saturday 24 September 2005 18:14, Henrik Nordstrom wrote:
> On Sat, 24 Sep 2005, Blaisorblade wrote:
> > init= doesn't take argument, yes, but IIRC unhandled arguments are
> > automatically passed to init, like unhandled assignment are passed in
> > env. vars. Or not?
>
> Right. Seems to work just fine even if somewhat confusing...
>
>     sh init=/bin/ctty
> or
>     init=/bin/ctty sh
>
> is the same thing..
>
> Regards
> Henrik

But does ctty give you a controlling terminal on that sh?  I just tried it 
again (./linux rootfstype=hostfs rw LD_ASSUME_KERNEL=2.4.1 
init=/path/to/ctty /bin/sh) and it didn't still give me a controlling 
terminal.

I.E. this isn't a solution for me because in the context I care about, it 
doesn't work.

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
