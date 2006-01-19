Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzQkY-0003pC-9A for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 19:46:14 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzQkW-0004Yl-VW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 19:46:14 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: Needed arch_copy_tls? Not done by dup_task_struct?
Message-ID: <20060119043821.GD8265@ccure.user-mode-linux.org>
References: <200601182053.31322.blaisorblade@yahoo.it>
	<20060118233846.GA5534@ccure.user-mode-linux.org>
	<200601190039.30094.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601190039.30094.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 23:38:21 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 19, 2006 at 12:39:29AM +0100, Blaisorblade wrote:
> Could you unapply 
> 
> patches/tls/uml-add-tls-support-debug-check-never-works
> 
> and verify it works correctly however? I want that to work :-) !

Sill seems OK.

> Ok, don't think anything changed for now. I'm changing things however, so 
> please stick modification in different patches so we merge easily.

Yeah, I'm leaving yours alone and keeping my changes in their own patches.

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
