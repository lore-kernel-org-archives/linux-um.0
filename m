Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGUfM-0003w5-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 18:42:04 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AGUfL-0003OQ-Mw
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 18:42:04 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA32TYD03271
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 2 Nov 2003 21:29:34 -0500
Message-Id: <200311030248.hA32mUgX002550@ccure.karaya.com>
Subject: Re: [uml-devel] [patch] change ubd names 
In-Reply-To: Your message of "Thu, 30 Oct 2003 17:29:02 +0100."
             <20031030162902.GE19575@bytesex.org> 
References: <20031030155757.GA19575@bytesex.org>  <20031030162902.GE19575@bytesex.org> 
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
Date: Sun, 02 Nov 2003 21:48:30 -0500
To: Gerd Knorr <kraxel@bytesex.org>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

kraxel@bytesex.org said:
> This patch ....

Mostly, I like these.  But you are going to have to maintain the skas fix
yourself.  I've got skas4 working, which fixes all known issues with skas3,
including the patchability problems.  So, I'm not doing anything with skas3
any more.

If you think you can push that fixmap fix to Linus/Andrew, go right ahead.
Strictly speaking, that's not a UML fix.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
