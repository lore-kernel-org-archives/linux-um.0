Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJDyB-0000UV-4d	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:37:51 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJDy5-0005AD-QL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Sep 2005 10:37:51 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<Pine.LNX.4.61.0509232229090.14136@filer.marasystems.com>
	<200509241603.53845.blaisorblade@yahoo.it>
In-Reply-To: <200509241603.53845.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241237.33867.rob@landley.net>
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
Date: Sat, 24 Sep 2005 12:37:33 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 24 September 2005 09:03, Blaisorblade wrote:
> On Friday 23 September 2005 22:31, Henrik Nordstrom wrote:
> > On Fri, 23 Sep 2005, Blaisorblade wrote:
> > > So in this case he should use init=/sbin/ctty sh, right?
> >
> > But you can't.. init= takes a single path to the binary to use, no
> > arguments.
>
> init= doesn't take argument, yes, but IIRC unhandled arguments are
> automatically passed to init, like unhandled assignment are passed in env.
> vars. Or not?

Unhandled name=value arguments are used to set environment variables, and 
rather a lot of arguments are intercepted as kernel flags.  Even if whatever 
was left was sent to init, I'd feel a little funny about trusting it.  (This 
is more a job for initramfs.)

But the more fundamental problem is that I tried ctty from the pid 1 command 
shell in the UML instance, and it didn't make any difference I could spot.

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
