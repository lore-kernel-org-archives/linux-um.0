Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eygxr-0002tY-Uw for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:52:55 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Eygxr-0006lb-PF
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 16 Jan 2006 18:52:56 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
Message-ID: <20060117034504.GG17171@ccure.user-mode-linux.org>
References: <20060116171447.GA15932@suse.de>
	<200601170222.59415.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601170222.59415.blaisorblade@yahoo.it>
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
Date: Mon, 16 Jan 2006 22:45:04 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>

On Tue, Jan 17, 2006 at 02:22:59AM +0100, Blaisorblade wrote:
> On Monday 16 January 2006 18:14, Olaf Hering wrote:
> > It picks up the libc headers instead of the 2.6.15 ones.
> Yep, that's correct, the bug is that shouldn't be using CONFIG_NR_CPUS.

No, I just fixed this.  The bug is that chan_user.c includes kern_util.h,
which is a kernel-only header.  I made a bunch of similar changes today
(os.h also included kern_util.h!).

Maybe we don't need idle_threads there anyway, but that's a separate issue.

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
