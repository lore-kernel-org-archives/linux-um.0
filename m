Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGwV7-0007iq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 04 Nov 2003 00:25:21 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.24)
	id 1AGwV6-0007XW-Q7
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 04 Nov 2003 00:25:20 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Subject: Re: [uml-devel] [patch] change ubd names
Message-ID: <20031104083746.GB407@bytesex.org>
References: <20031030155757.GA19575@bytesex.org> <20031030162902.GE19575@bytesex.org> <200311030248.hA32mUgX002550@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311030248.hA32mUgX002550@ccure.karaya.com>
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
Date: Tue, 4 Nov 2003 09:37:46 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: uml devel <user-mode-linux-devel@lists.sourceforge.net>

> Mostly, I like these.  But you are going to have to maintain the skas fix
> yourself.  I've got skas4 working, which fixes all known issues with skas3,
> including the patchability problems.  So, I'm not doing anything with skas3
> any more.

Fine.

> If you think you can push that fixmap fix to Linus/Andrew, go right ahead.
> Strictly speaking, that's not a UML fix.

Well, the block #ifdef'ed out comes from the -test9 uml patch ...

  Gerd

-- 
You have a new virus in /var/mail/kraxel


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
