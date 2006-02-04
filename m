Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F5Epd-00020R-Ib for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Feb 2006 20:15:29 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F5Epc-0000ST-4K
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 03 Feb 2006 20:15:29 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] AoE with UML?   have a strange problem with AoE root
Message-ID: <20060204041643.GA8524@ccure.user-mode-linux.org>
References: <000901c6292f$c1cd0b40$0200000a@aldipc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901c6292f$c1cd0b40$0200000a@aldipc>
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
Date: Fri, 3 Feb 2006 23:16:44 -0500
To: roland <devzero@web.de>
Cc: user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it

On Sat, Feb 04, 2006 at 03:07:23AM +0100, roland wrote:
> Checking that ptrace can change system call numbers...OK
> Checking syscall emulation patch for ptrace...missing
> Checking PROT_EXEC mmap in /tmp...OK
> Checking for the skas3 patch in the host:
>   - /proc/mm...found
>   - PTRACE_FAULTINFO...found
>   - PTRACE_LDT...found
> UML running in SKAS3 mode
> ---- hangs here forever. err - why that early ? -----

Ummm, strange...

Can you double-check that the config is the same, except for the new
AoE stuff.

Also, adding stderr=1 might give you some more output.

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
