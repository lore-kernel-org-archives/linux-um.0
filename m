Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A2Cmz-0001Ds-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 24 Sep 2003 09:46:53 -0700
Received: from solar.nuked.org ([66.11.174.19])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A2Cmy-0003lS-12
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Sep 2003 09:46:52 -0700
From: Rod Moffitt <rodlist@rod.info>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found' 
In-Reply-To: <200309241619.h8OGJwaK006019@ccure.karaya.com>
Message-ID: <Pine.LNX.4.58.0309241245150.27930@crystal.nuked.org>
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
 <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de>
 <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org>
 <200309232016.h8NKGNaK003251@ccure.karaya.com> 
 <Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org> 
 <200309241619.h8OGJwaK006019@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 24 Sep 2003 12:47:16 -0400 (EDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> Err, right.  But I still have no idea what's happening.
>
> If the file is there, it should definitely not fail to open.
>

What kind of test can I run on the host to verify that procmm does indeed
work?

If the host is OK, what possibly in the UML kernel configuration, besides
the obvious enabling of SKAS mode, is needed for SKAS and procmm to work?

- Rod


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
