Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AGUYG-0002ud-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 02 Nov 2003 18:34:44 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AGUYF-0002JG-6k
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 02 Nov 2003 18:34:43 -0800
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id hA32MDD03173
	for <user-mode-linux-devel@lists.sourceforge.net>; Sun, 2 Nov 2003 21:22:13 -0500
Message-Id: <200311030241.hA32f9gX002520@ccure.karaya.com>
Subject: Re: [uml-devel] Partitioning scheme for ubd's 
In-Reply-To: Your message of "Sun, 02 Nov 2003 11:15:01 PST."
             <20031102.111506.-2022799.0.mcmechanjw@juno.com> 
References: <20031102.111506.-2022799.0.mcmechanjw@juno.com> 
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
Date: Sun, 02 Nov 2003 21:41:09 -0500
To: James W McMechan <mcmechanjw@juno.com>
Cc: blaisorblade_spam@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

mcmechanjw@juno.com said:
> 1) well the device names are at least internally consistent. and there
> are some devices like blah0p1 already. also the proposed scheme for
> dealing with devices above 26 is currently a mess, hdaa hdaaa, since
> with the last patch set I was using I had 400 disks mounted...
> mounting /dev/ubdpa1 ick... we only need one disk controller for a
> effectively unlimited of disk drives which could be called c0dXpY if
> desired...

I think everything understands ubd[a-h][0-9], and that's the way normal people
should refer to them.  I just haven't updated the docs to reflect that.

Having said that, I like the current naming for huge numbers of disks.

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
