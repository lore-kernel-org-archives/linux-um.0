Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ea4WQ-0005Xw-P0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 20:58:50 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ea4WP-0007y3-Iw
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Nov 2005 20:58:51 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Making UML Single Threader
References: <200511061723.32848.rob@landley.net>
	<200511082118.58614.rob@landley.net>
	<20051110041818.GD15002@ccure.user-mode-linux.org>
In-Reply-To: <20051110041818.GD15002@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511092258.36708.rob@landley.net>
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
Date: Wed, 9 Nov 2005 22:58:36 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Wednesday 09 November 2005 22:18, Jeff Dike wrote:
> On Tue, Nov 08, 2005 at 09:18:58PM -0600, Rob Landley wrote:
> > 1) Is there any documentation on SKAS0's design?  (A couple things
> > floated by, but it was piecemeal and I didn't have the necessary
> > context.)
>
> There was a big message when I first announced it.

Rummage rummage rummage...  January diary entry mentions that blaisorblade 
asked "a while back"...

This would appear to be your announcement:
http://sourceforge.net/mailarchive/message.php?msg_id=10171422

(Wow, sourceforge's mailing list archives are almost as difficult to use as 
their download mirror system.  That takes _effort_.)

> Also, the changelog on 
> that patch was fairly comprehensive, so you can dig that out of git or
> an LKML archive or somewhere.

Rummage rummage rummage...
http://seclists.org/lists/linux-kernel/2005/Jul/0182.html

> > 3) What can -tt mode still do that -skas0 can't?  (Something about
> > running under gdb, was it?)
>
> SMP is about it.
>
> On nice process names with skas0, that might not be too possible with stack
> randomization.

Randomization in the host, or randomization in UML?

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
