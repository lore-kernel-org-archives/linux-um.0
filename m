Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMWC7-0000EF-LG for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:18:41 -0800
Received: from nemesis.fprintf.net ([66.134.112.218])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMWC5-0004ro-Vl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Feb 2007 13:18:39 -0800
From: Daniel Gryniewicz <dang@gentoo.org>
In-Reply-To: <fccbad840702281309s58f19fb5q26a8c33cc9613fae@mail.gmail.com>
References: <fccbad840702281309s58f19fb5q26a8c33cc9613fae@mail.gmail.com>
Date: Wed, 28 Feb 2007 16:15:32 -0500
Message-Id: <1172697332.12367.36.camel@athena.fprintf.net>
Mime-Version: 1.0
Subject: Re: [uml-devel] Sources into UML guest
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: "Felipe T." <ftroncos007@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, 2007-02-28 at 18:09 -0300, Felipe T. wrote:
> Hello:
> I need to install a program into a UML Kernel, this program needs
> Kernel Sources (Sebek 3) but I don't know how compile this sources. In
> the Host I used ARCH=um  but if I do the same into guest, get a errors
> when  do make for the sebek program because doesn't find some .h. For
> this reason I compile (into guest) without ARCH=um and make sebek it's
> ok. But I get a error when use insmod (error with the format module),
> I think for the difference between vermagic values. Someone has some
> idea 

When I've needed to do this, I just mounted the rootfs into my host
(when the UML isn't running, of course) and copied the built kernel
source directory into the rootfs.  Then, inside the UML, everything
works correctly.

Daniel


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
