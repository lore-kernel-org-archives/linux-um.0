Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ezesy-0005CM-0A for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 10:51:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ezesw-0002Mi-0z
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 19 Jan 2006 10:51:52 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH 8/8] uml: avoid "CONFIG_NR_CPUS undeclared"
	bogus error messages
Message-ID: <20060119194356.GA8670@ccure.user-mode-linux.org>
References: <20060118235132.4626.74049.stgit@zion.home.lan>
	<20060118235522.4626.2825.stgit@zion.home.lan>
	<20060119042104.GC8265@ccure.user-mode-linux.org>
	<200601191601.31805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601191601.31805.blaisorblade@yahoo.it>
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
Date: Thu, 19 Jan 2006 14:43:56 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 19, 2006 at 04:01:28PM +0100, Blaisorblade wrote:
> Gerd Knorr in his tty patch, instead, used forward declarations, like:
> 
> struct task_struct; 
> 
> what about that?

I don't think so.  At least when you use void *, you are using a type
that's not incorrect.  In userspace code, those task_structs start
referring to host task_structs, which is definitely very wrong.

> Those functions probably should be moved anyway because they're
> useless there

Yeah.

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
