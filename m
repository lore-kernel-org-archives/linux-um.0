Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EIsL0-0003aS-4w	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:31:58 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EIsKy-0002kT-Oz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 11:31:58 -0700
Received: from localhost.localdomain (grelber.thyrsus.com [192.168.1.31])
	by grelber.thyrsus.com (8.13.1/8.13.1) with ESMTP id j8NK18ns014848
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 23 Sep 2005 16:01:09 -0400
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Any way to give /dev/console a controlling TTY?
References: <200509231135.27882.rob@landley.net>
In-Reply-To: <200509231135.27882.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509231331.47282.rob@landley.net>
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
Date: Fri, 23 Sep 2005 13:31:47 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Friday 23 September 2005 11:35, Rob Landley wrote:
> I'm the strange guy using UML via the stdio console, ala:
>
> ./linux rootfstype=hostfs MEM=48m rw init=/bin/sh LD_ASSUME_KERNEL=2.4.1
>
> And it would be very nice if ctrl-c would work with that.  I tried
> commenting out the "!noctty &&" test in line 1872, 

Of drivers/char/tty_io.c, that is 

> but it didn't make any 
> difference.
>
> Anybody see an obvious way to make /dev/console a controlling TTY?
>
> Rob

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
