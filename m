Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ1qR-0001bA-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 18:31:59 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ1qP-0005Z3-JS
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 18:31:58 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hAA2Io119842
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 21:18:51 -0500
Message-Id: <200311100239.hAA2daxD013066@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] skas & /proc/mm in the host kernel, yet /proc/mm 'not found' 
In-Reply-To: Your message of "Sun, 28 Sep 2003 16:45:28 BST."
             <87fzig533b.fsf@amaterasu.srvr.nix> 
References: <200309182037.h8IKbMEk028815@hongkong.cs.nmsu.edu> <20030919095020.294F93BCE4@home.petschge.de> <20030920173518.521B03BCE7@home.petschge.de> <Pine.LNX.4.58.0309220535000.28187@crystal.nuked.org> <200309232016.h8NKGNaK003251@ccure.karaya.com> <Pine.LNX.4.58.0309232330340.28187@crystal.nuked.org> <200309241619.h8OGJwaK006019@ccure.karaya.com>  <87fzig533b.fsf@amaterasu.srvr.nix> 
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
Date: Sun, 09 Nov 2003 21:39:36 -0500
To: Nix <nix@esperi.demon.co.uk>
Cc: Rod Moffitt <rodlist@rod.info>, user-mode-linux-devel@lists.sourceforge.net

nix@esperi.demon.co.uk said:
> Kernel panic: init_new_context_skas - new_mm failed, errno = -24 

This is EMFILE - Too many open files

Do you have a disgustingly low file limit, or was UML opening an immense number
of files?  Looking at /proc/<pid>/fd for a UML pid would be informative.

> hppfs_open : failed to open a socket in 'proc/uptime/r', err = 1 

This is likely the same thing, just the errno return was botched.

				Jeff



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
