Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A6cmY-0006Ix-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 06 Oct 2003 14:20:42 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A6cmV-0003mK-39
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 06 Oct 2003 14:20:39 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h96LAUj06612
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 6 Oct 2003 17:10:30 -0400
Message-Id: <200310062122.h96LMZGj020769@ccure.karaya.com>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm 'not found' 
In-Reply-To: Your message of "Wed, 24 Sep 2003 12:47:16 EDT."
             <Pine.LNX.4.58.0309241245150.27930@crystal.nuked.org> 
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de> <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> <200309232016.h8NKGNaK003251@ccure.karaya.com> <Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org> <200309241619.h8OGJwaK006019@ccure.karaya.com>  <Pine.LNX.4.58.0309241245150.27930@crystal.nuked.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Mon, 06 Oct 2003 17:22:35 -0400
To: Rod Moffitt <rodlist@rod.info>
Cc: user-mode-linux-devel@lists.sourceforge.net

rodlist@rod.info said:
> If the host is OK, what possibly in the UML kernel configuration,
> besides the obvious enabling of SKAS mode, is needed for SKAS and
> procmm to work? 

That should be it.  I don't know what else could be required.  I'd need to
see this for myself to figure out what's happening.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
