Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiPXK-0003vC-LO for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 21:02:14 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EiPXJ-00035V-9t
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 21:02:14 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Testing requested - [PATCH] Fixing SKAS0 compilation
	problem / TT mode bug report
Message-ID: <20051203055429.GA17426@ccure.user-mode-linux.org>
References: <200511272159.38069.blaisorblade@yahoo.it>
	<200511291728.56515.blaisorblade@yahoo.it>
	<20051129175556.GA14058@ccure.user-mode-linux.org>
	<200512020118.27879.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512020118.27879.blaisorblade@yahoo.it>
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
Date: Sat, 3 Dec 2005 00:54:29 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 02, 2005 at 01:18:27AM +0100, Blaisorblade wrote:
> I want to add the int3 too - that's the only way to be deterministically 
> sure that GCC doesn't use %ebp after the unmap.

Well, my current patch branches to the int3.  gcc will have to be pretty
imaginative to involve ebp in a branch.

> Yes, mostly.... there is also the problem with hardened toolchains (two 
> different reports), which makes inline syscalls bleach (hardened toolchains 
> use PIE code and need to have %EBX reserved for GOT/PLT handling), but I 
> currently I do not consider fixing it before I can reproduce it.

Yeah, I encountered this in a different context.

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
