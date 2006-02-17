Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FA8tB-0003I0-KB for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 08:55:25 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FA8t9-0001Jw-8o
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 17 Feb 2006 08:55:25 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060217165635.GA5712@ccure.user-mode-linux.org>
References: <Pine.LNX.4.64.0602170009160.4626@sparrow>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602170009160.4626@sparrow>
Subject: [uml-devel] Re: 2.6.16-rc2 x86_64; Jeff's uml patch tar doesn't apply
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
Date: Fri, 17 Feb 2006 11:56:35 -0500
To: William Stearns <wstearns@pobox.com>
Cc: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Feb 17, 2006 at 12:19:07AM -0500, William Stearns wrote:
> 	The uml patch tar file at 
> http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.16-rc2/patches.tar 
> should apply to 2.6.16-rc2, but when I try to apply it I get:

I just tried that -
	made a rc2 tree
	grabbed my current tarball from the UML site
	applied it

I got a couple of offsets (which shouldn't have been there), but it
applied and is currently building OK.

I submit to you that perhaps your tree is not quite the cleanest
2.6.15-rc2 :-)

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
