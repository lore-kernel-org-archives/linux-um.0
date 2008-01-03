Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JAPcV-0007vJ-PH for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jan 2008 04:56:23 -0800
Received: from fxip-0047f.externet.hu ([88.209.222.127]
	helo=pomaz-ex.szeredi.hu)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JAPcU-0001Ok-38
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jan 2008 04:56:23 -0800
In-reply-to: <20080102220519.GA10137@c2.user-mode-linux.org> (message from
	Jeff Dike on Wed, 2 Jan 2008 17:05:19 -0500)
References: <E1JA7m0-0007nP-Fi@pomaz-ex.szeredi.hu>
	<20080102200621.GB8847@c2.user-mode-linux.org>
	<E1JAAZt-0008F8-An@pomaz-ex.szeredi.hu>
	<20080102220519.GA10137@c2.user-mode-linux.org>
Message-Id: <E1JAPc5-00011g-JJ@pomaz-ex.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 03 Jan 2008 13:55:57 +0100
Subject: Re: [uml-devel] UML woes in 2.6.24-rc6-mm1
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: jdike@addtoit.com
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> > 32bit UML, 64bit host, config attached.
> 
> Hadn't tried that, but that works here too.
> 
> I'll see if your config reproduces it.
> 
> > Can't reproduce with plain -rc6.
> 
> Feel like bisecting -mm1?

This is the one: uml-runtime-detection-of-host-vmsplit-on-i386.patch

The relevant log line (both for successful and failed boots):

Locating the top of the address space ... 0xffc00000

Miklos


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
