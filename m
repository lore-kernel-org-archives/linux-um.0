Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1ta7-0005oD-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 13:16:19 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1ta5-0008HC-Kr
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 23 Sep 2003 13:16:18 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h8NK7Ej29427
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 16:07:15 -0400
Message-Id: <200309232016.h8NKGNaK003251@ccure.karaya.com>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm 'not found' 
In-Reply-To: Your message of "Mon, 22 Sep 2003 05:49:41 EDT."
             <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> 
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de>  <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> 
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
Date: Tue, 23 Sep 2003 16:16:23 -0400
To: Rod Moffitt <rodlist@rod.info>
Cc: user-mode-linux-devel@lists.sourceforge.net

rodlist@rod.info said:
> However /proc/mm does exist (it's 0222) on the machine. 

It should look like this (111):

% ls -l /proc/mm
--w--w--w-    1 root     root            0 Sep 23 16:02 /proc/mm

Side from that, I have no idea what's going on.  Unlike /dev, entries in
/proc don't exist unless there's something in the kernel behind them.

> I tried patching stock kernels including 2.4.19, 20, 21 and 22 and the
> same thing occurs on all of them. I understand there might be some
> tweaking needed for the later kernels, however I was under the
> impression that this patch was meant for a stock 2.4.19. 

Something else is wrong.  Dunno what, though.

				Jeff



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
