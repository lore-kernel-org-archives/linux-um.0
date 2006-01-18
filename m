Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ez1s4-0000a4-VJ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 17:12:20 -0800
Received: from mail.kroah.org ([69.55.234.183] helo=perch.kroah.org)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ez1s3-0001nm-J0
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 Jan 2006 17:12:20 -0800
From: Greg KH <greg@kroah.com>
Message-ID: <20060118011200.GA28086@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] Re: [PATCH 1/9] uml: avoid sysfs warning on hot-unplug
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
Date: Tue, 17 Jan 2006 17:12:00 -0800
To: akpm@osdl.org, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

> From: Jeff Dike <jdike@addtoit.com>, Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> Define a release method for the ubd and network driver so that sysfs doesn't
> complain when one is removed via:

What?  No.  The kernel is complaining for a reason, don't try to
out-smart it.

> 
> host $ uml_mconsole <umid> remove <dev>
> 
> Done by Jeff around January for ubd only, later lost, then restored in his tree
> - however I'm merging it now since there's no reason to leave this here.
> 
> We don't need to do any cleanup in the new added method, because when hot-unplug
> is done by uml_mconsole we already handle cleanup in mconsole infrastructure,
> i.e.  mc_device->remove (net_remove/ubd_remove), which is also the calling
> method.

Huh?  You have 2 different release functions for the same object?  And
how do you know which one is correct?  That does not sound right at all.

Please fix this correctly.

thanks,

greg k-h


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
