Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AJ1qR-0001b9-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 09 Nov 2003 18:31:59 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AJ1qP-0004xv-Hp
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 09 Nov 2003 18:31:58 -0800
Received: from ccure.user-mode-linux.org (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hAA2Io119843
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 9 Nov 2003 21:18:51 -0500
Message-Id: <200311100239.hAA2dcxD013077@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] redefinition of `struct ptrace_faultinfo' with uml-2.4.22-4 + skas3 
In-Reply-To: Your message of "Wed, 17 Sep 2003 00:44:31 BST."
             <87brtkuwm8.fsf@amaterasu.srvr.nix> 
References: <87brtkuwm8.fsf@amaterasu.srvr.nix> 
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
Date: Sun, 09 Nov 2003 21:39:38 -0500
To: Nix <nix@esperi.demon.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

nix@esperi.demon.co.uk said:
> This has come up before on the lists (first report in late 2002), and
> nobody's ever come up with preprocessed source. Until now. 

This is nasty because the UML tree has to assume that the i386 tree doesn't
have ptrace_faultinfo in it.  Since you applied the host skas patch to your
UML tree, that assumption is broken.

So, for now, I would say that you shouldn't try to build both host kernels and
UML kernels from a tree which has that patch in it.

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
