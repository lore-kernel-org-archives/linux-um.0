Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EiPd9-00044i-0t for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 21:08:15 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1EiPd8-0005Xj-Ju
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Dec 2005 21:08:15 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Is there an easy way to do a stack dump on UML?
Message-ID: <20051203060030.GB17426@ccure.user-mode-linux.org>
References: <200512021412.21539.rob@landley.net>
	<200512030359.32894.blaisorblade@yahoo.it>
	<200512022144.20730.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512022144.20730.rob@landley.net>
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
Date: Sat, 3 Dec 2005 01:00:30 -0500
To: Rob Landley <rob@landley.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Fri, Dec 02, 2005 at 09:44:20PM -0600, Rob Landley wrote:
> I've never used mconsole.  Never needed it before.
> 
> Perhaps if I attach to a serial console instead of stdio I can send sysrq that 
> way...

No.  Just think a little.  Banging on the SysRq key on your keyboard can't
do anything but send SysRq to the host.

SysRq for a virtual machine has to be an out-of-band thing wrt the host.  For
UML, that's mconsole.

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
