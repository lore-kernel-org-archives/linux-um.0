Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6u1e-00010O-4x for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 10:26:46 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6u1d-0000Re-Ox
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 10:26:46 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] AoE with UML?   have a strange problem with AoE root
Message-ID: <20060208182803.GC6625@ccure.user-mode-linux.org>
References: <979918309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <979918309@web.de>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 8 Feb 2006 13:28:03 -0500
To: devzero@web.de
Cc: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net

On Sat, Feb 04, 2006 at 11:17:13AM +0100, devzero@web.de wrote:
> > On Sat, Feb 04, 2006 at 03:07:23AM +0100, roland wrote:
> > > Checking that ptrace can change system call numbers...OK
> > > Checking syscall emulation patch for ptrace...missing
> > > Checking PROT_EXEC mmap in /tmp...OK
> > > Checking for the skas3 patch in the host:
> > >   - /proc/mm...found
> > >   - PTRACE_FAULTINFO...found
> > >   - PTRACE_LDT...found
> > > UML running in SKAS3 mode
> > > ---- hangs here forever. err - why that early ? -----

BTW, is this x86_64 or i386?  Yesterday, I rediscovered how to make this 
happen on x86_64.  There's a timer loop in a driver that you get when you
enable SERIO_I8042 that never finishes on x86_64, and it causes the hang
right there.

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
