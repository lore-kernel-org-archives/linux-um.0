Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6sOD-0000Hr-2A for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 08:41:57 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6sOA-0002Fd-Q8
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Feb 2006 08:41:57 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060208164301.GC5240@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
	<20060207185707.GB6841@ccure.user-mode-linux.org>
	<a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
Subject: [uml-devel] Re: [PATCH 2/8] UML - Define jmpbuf access constants
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
Date: Wed, 8 Feb 2006 11:43:01 -0500
To: Ulrich Drepper <drepper@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Feb 07, 2006 at 11:23:42AM -0800, Ulrich Drepper wrote:
> If you need this
> functionality, implement it yourself.  setjmp is most likely overkill
> anyway.

OK, I'll roll my own version.

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
