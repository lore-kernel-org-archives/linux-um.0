Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ALSAC-0004b7-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 11:02:24 -0800
Received: from snowman.net ([66.93.83.236] helo=relay.snowman.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1ALS9b-0002LN-Lb
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 16 Nov 2003 11:01:48 -0800
Received: from ns.snowman.net (ns.snowman.net [10.10.0.2])
	by relay.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id hAGJ1etg014500
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 14:01:41 -0500
Received: from ns.snowman.net (localhost [127.0.0.1])
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) with ESMTP id hAGJ1cOu012723
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 16 Nov 2003 14:01:38 -0500
Received: from localhost (localhost [[UNIX: localhost]])
	by ns.snowman.net (8.12.10/8.12.10/Debian-1) id hAGJ1c5X012721
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 16 Nov 2003 14:01:38 -0500
From: "Laurence J. Lane" <ljlane@nontoxic.org>
Subject: Re: [uml-devel] arch/um/sys-i386/bugs.c compile error
Message-ID: <20031116190137.GA23060@absolom.libra.net>
References: <20031115211955.GA4221@absolom.libra.net> <20031115223329.GA24455@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115223329.GA24455@wavehammer.waldi.eu.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 16 Nov 2003 14:01:37 -0500
To: user-mode-linux-devel@lists.sourceforge.net

On Sat, Nov 15, 2003 at 11:33:29PM +0100, Bastian Blank wrote:

> > I get the same arch/um/sys-i386/bugs.c compile error on
> > 2.6.0-test9-1-um and 2.4.22-6-um. Anyone have an idea of what
> > causes the error?

> debian unstable with linux-kernel-headers (2.6.0)?

> i get this message since they do that change.

Right. I'll investigate there. Thanks.


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
