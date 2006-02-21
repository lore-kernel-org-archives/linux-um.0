Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FBfpf-0001mG-AX for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 14:18:07 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FBfpc-0002kK-Ef
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 21 Feb 2006 14:18:07 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Build error in arch/um/os-Linux/aio.c with today's
	2.6.16-rc4 patch set
Message-ID: <20060221221915.GA7096@ccure.user-mode-linux.org>
References: <6FC4416DDE56C44DA0AEE67BC7CA43710D0A76F9@zrc2hxm2.corp.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6FC4416DDE56C44DA0AEE67BC7CA43710D0A76F9@zrc2hxm2.corp.nortel.com>
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
Date: Tue, 21 Feb 2006 17:19:15 -0500
To: John Dykstra <jdykstra@nortel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, Feb 21, 2006 at 01:53:20PM -0600, John Dykstra wrote:
> It appears to me that the kernel tree will not build with the 2.6.16-rc4
> patch set I downloaded today, if HAVE_AIO_ABI is not defined.  
> 
> finish_aio_26() is referenced in arch/um/os-Linux/aio.c, but is not
> defined.  It looks like a stub was omitted.

Fixed, thanks.

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
