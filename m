Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19yZro-0005CT-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 09:36:52 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19yZro-0006Ce-3e
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 09:36:52 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19yZrn-0002Hn-00
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 14 Sep 2003 12:36:51 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19yZrn-0006ty-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 14 Sep 2003 12:36:51 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] [PATCH] Starting a command inside UML from mconsole
Message-ID: <20030914163650.GI8622@alcor.net>
References: <200309131820.45833.blaisorblade_spam@yahoo.it> <200309140233.h8E2X5e4007952@ccure.karaya.com> <20030914075927.GA977@fute.lan> <200309141350.h8EDotNu001708@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309141350.h8EDotNu001708@ccure.karaya.com>
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
Date: Sun, 14 Sep 2003 12:36:50 -0400
To: UML Devel ML <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Sep 14, 2003 at 09:50:55AM -0400, Jeff Dike wrote:

> mdz@debian.org said:
> > It's difficult to reliably automate.
> 
> Then give the UML a special console that doesn't make you log in, and just 
> gives you a root shell.

Even once you've logged in, you have to deal with things like _reliably_
detecting a shell prompt, aliases, and other nastiness that comes with an
interactive shell.

It also requires that the UML system be specially configured, at which point
there are already many other ways to do it.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
