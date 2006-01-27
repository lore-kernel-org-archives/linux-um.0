Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F2dK0-0007iS-N1 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2006 15:48:04 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F2dK0-0004Sj-Em
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 27 Jan 2006 15:48:04 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] [PATCH] slight UML config simplification.
Message-ID: <20060127234916.GA9998@ccure.user-mode-linux.org>
References: <200510081837.26059.rob@landley.net>
	<20060127180858.GA6360@ccure.user-mode-linux.org>
	<200601271637.17770.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601271637.17770.rob@landley.net>
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
Date: Fri, 27 Jan 2006 18:49:16 -0500
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, Jan 27, 2006 at 04:37:17PM -0600, Rob Landley wrote:
> Understood.  Is there any way to autodetect this at runtime?

Not sure, that would be nice.

It would have to look at its own maps and figure out that two pages mapped
at the top of memory are the stub pages of the outer UML.  That seems a bit
ad-hoc to me.

Although maybe we could just say that any two pages there (as long as they
are not stack) cause the stub pages to be relocated simply to avoid a
collision.  Here, we're not explicitly looking for an outer UML, just pages
that we are about to stomp on.

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
