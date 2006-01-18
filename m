Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EzDd3-0002jI-81 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 05:45:37 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EzDd1-00046p-HT
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 18 Jan 2006 05:45:37 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] arch/um/include/kern_util.h:35: error:
	'CONFIG_NR_CPUS' undeclared
Message-ID: <20060118143742.GB5154@ccure.user-mode-linux.org>
References: <20060116171447.GA15932@suse.de>
	<200601170222.59415.blaisorblade@yahoo.it>
	<20060117202411.GA27124@suse.de> <20060118130403.GA21457@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118130403.GA21457@suse.de>
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
Date: Wed, 18 Jan 2006 09:37:42 -0500
To: Olaf Hering <olh@suse.de>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Wed, Jan 18, 2006 at 02:04:04PM +0100, Olaf Hering wrote:
> These definitions are gone from glibc 2.4, has to be fixed in uml.

Yeah, we knew that was going to be fragile.  Needs fixing.

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
