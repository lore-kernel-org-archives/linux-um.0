Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A20Qz-00026m-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 20:35:21 -0700
Received: from solar.nuked.org ([66.11.174.19])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1A20Qy-000448-GP
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 20:35:20 -0700
From: Rod Moffitt <rodlist@rod.info>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm
 'not found' 
In-Reply-To: <200309232016.h8NKGNaK003251@ccure.karaya.com>
Message-ID: <Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org>
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu>
 <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de>
  <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> 
 <200309232016.h8NKGNaK003251@ccure.karaya.com>
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
Date: Tue, 23 Sep 2003 23:35:43 -0400 (EDT)
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

> It should look like this (111):
>
> % ls -l /proc/mm
> --w--w--w-    1 root     root            0 Sep 23 16:02 /proc/mm

--w--w--w- == 222
--x--x--x- == 111

   > touch test
   > chmod 222 test
   > ls -l test
   --w--w--w-

> Side from that, I have no idea what's going on.  Unlike /dev, entries in
> /proc don't exist unless there's something in the kernel behind them.

I agree that the host is probably correct, therefore the problem has to be
with the UML kernel. What are the config options that if missing, would
cause such an error?

Thanks,

- Rod

--
                         ___  ____  ___    _      ___
 Rod Moffitt            / _ \/ __ \/ _ \  (_)__  / _/__
 http://rod.info       / , _/ /_/ / // / / / _ \/ _/ _ \
 rodANTISPAM@rod.info /_/|_|\____/____(*)_/_//_/_/ \___/
 ========================================================
 ~ Where loved ones are remembered: http://memoriam.org ~


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
