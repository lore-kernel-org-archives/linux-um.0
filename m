Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <inguin@gmx.de>) id 1LOZwH-0004Ze-Hm
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 15:51:53 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LOZwE-00028o-2Z for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 15:51:53 +0000
Message-ID: <4973500A.2000509@gmx.de>
Date: Sun, 18 Jan 2009 16:51:38 +0100
From: Ingo van Lil <inguin@gmx.de>
MIME-Version: 1.0
References: <200901130159.04389.rob@landley.net>
In-Reply-To: <200901130159.04389.rob@landley.net>
Subject: Re: [uml-devel] Does 2.6.28 UML work for anyone else?
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

Rob Landley schrieb:

> Can anyone else reproduce building ARCH=um with the attached .config, and then 
> going:
> 
> $ ./vmlinux rw init=/bin/sh rootfstype=hostfs
[...]
> Kernel panic - not syncing: Segfault with no mm
[...]
> Segmentation fault

Works fine on my Fedora 9 machine. I used the "mini.conf" script you
posted yesterday, not the attached config file. The built kernel wasn't
very useful, obviously, but at least it managed to run a shell.

The default config (make defconfig) also works flawlessly. It boots the
FC5 image from the UML homepage without problems.

Cheers,
Ingo

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
