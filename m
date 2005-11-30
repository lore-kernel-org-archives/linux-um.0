Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EhINi-0000c7-QB for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 19:11:42 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EhINi-0005WT-5e
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 19:11:42 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] testing of 2.6.14/2.6.15-rc amd64 guests
Message-ID: <20051130040409.GC21268@ccure.user-mode-linux.org>
References: <1133311286.13162.74.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1133311286.13162.74.camel@localhost.localdomain>
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
Date: Tue, 29 Nov 2005 23:04:09 -0500
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Nov 30, 2005 at 12:41:26AM +0000, Antoine Martin wrote:
> * The same kernel compiled here using hardened GCC:
> gcc (GCC) 3.4.4 (Gentoo Hardened 3.4.4-r1, HTB-3.4.4-1.00, ssp-3.4.4-1.0, pie-8.7.8)
> gives the same error reported earlier for x86 guests:
> the guest exits after spinning for a while on signals:
> rt_sigprocmask(SIG_SETMASK, NULL, [WINCH], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [ALRM VTALRM IO], NULL, 8) = 0
> rt_sigprocmask(SIG_UNBLOCK, [ALRM VTALRM IO], [ALRM VTALRM WINCH IO], 8) = 0
> rt_sigprocmask(SIG_BLOCK, [], NULL, 8)  = 0
> (that's in skas mode)

Can you gdb the thing and get a stack trace from the SIGBUS (I'm guessing this
is the same thing as the previous message where you had a strace log showing
SIGBUS happening)?

				Jeff


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
