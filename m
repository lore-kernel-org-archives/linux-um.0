Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzMXs-0007gh-6l for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:16:52 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzMXp-0007nD-Vr
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 15:16:52 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
Message-ID: <20060119000851.GB5534@ccure.user-mode-linux.org>
References: <20060116171447.GA15932@suse.de> <20060118130403.GA21457@suse.de>
	<20060118143742.GB5154@ccure.user-mode-linux.org>
	<200601181743.04311.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601181743.04311.blaisorblade@yahoo.it>
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
Date: Wed, 18 Jan 2006 19:08:51 -0500
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Olaf Hering <olh@suse.de>

On Wed, Jan 18, 2006 at 05:42:56PM +0100, Blaisorblade wrote:
> What about this? Inserting an asm volatile clobbering all unsaved registers 
> (what I thought for long time)? 

The gcc doc is somewhat confusing.  I read your description as saying
that locals may be totally smashed to random numbers (and the first
sentence in the gcc description implies that as well).  However, the
example they give is a pathological case where a local may have one of
two (well-defined) values, and it's not defined which of those two
well-defined values it will end up with.

> Or taking the libc implementation and suiting 
> it for our use, solving the above problem?

Yuck.  But how big is it?

Another possibility is to do the magic wakeup thing we do with
mconsole stack, and have it tell us what it registers are.  Not sure
if that's any better.

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
