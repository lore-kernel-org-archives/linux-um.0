Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yQdu-0004MN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sat, 13 Sep 2003 23:45:54 -0700
Received: from sat.sws.net.au ([202.5.161.49] ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yQds-0000AP-UM
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Sep 2003 23:45:54 -0700
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <200309140233.h8E2X5e4007952@ccure.karaya.com>
In-Reply-To: <200309140233.h8E2X5e4007952@ccure.karaya.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309141645.37919.russell@coker.com.au>
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
Date: Sun, 14 Sep 2003 16:45:37 +1000
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sun, 14 Sep 2003 12:33, Jeff Dike wrote:
> blaisorblade_spam@yahoo.it said:
> > I'm writing a patch which adds a new command to the mconsole ones:
> > exec nomeprog args
> > which starts a new program with root privileges.
>
> My reaction to this is that you should log in and execute the command from
> the shell.
>
> > Since that thread showed that running  commands without logging in is
> > something needed
>
> OK, what's so horrible about logging in?

I've been having some problems while experimenting with boot scripts etc which 
can prevent logging in.  Having an external method of just launching a shell 
would make it a lot easier...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
