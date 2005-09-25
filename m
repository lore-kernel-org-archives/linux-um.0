Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EJYWo-0000fu-RP	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 08:34:58 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EJYWn-0003os-8x
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Sep 2005 08:34:58 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
	<200509231408.32522.rob@landley.net>
	<Pine.LNX.4.61.0509251423150.12255@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.61.0509251423150.12255@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509251034.44965.rob@landley.net>
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
Date: Sun, 25 Sep 2005 10:34:44 -0500
To: Henrik Nordstrom <uml@hno.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sunday 25 September 2005 07:49, Henrik Nordstrom wrote:

> The ctty program mentioned has only been truly tested from inittab. Does
> not seem to work proper when used as init= so it's probably missing some
> process group thing or similar. Did work when executed interactively from
> a init=/bin/sh shell however.

I tried it.  I did the following:

./linux rootfstype=hostfs rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1
#/path/to/ctty /bin/sh

And although it did give me a nested shell invocation, it made no difference 
that I could see as far as ctrl-c went.

> To be honest it skips quite many steps in 
> the terminal initialization compared to how getty etc opens their
> terminal.

It's obviously a quick hack or it wouldn't segfault when you ran it with no 
arguments.  I don't hold that against it.

The thing is, all the various invocation methods you've mentioned are attempts 
to give a controlling tty to something _other_ than /dev/console.  The 
various virtual terminals, for instance.  I haven't figured out how to get 
those to attach to fd:0,fd:1 so that I have ctrl-c working on stdio of the 
UML instance, so getting ctrl-c working on them doesn't help me.  (I could 
just use init.)

I can fiddle around and create an initramfs to do all sorts of complicated 
things if necessary, and probably will, but it would be nice if there was an 
easy solution...

> Regards
> Henrik

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
