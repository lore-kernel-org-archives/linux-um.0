Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6Y0H-00023b-Jv for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 10:55:53 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6Y0G-0000Jt-E6
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2006 10:55:53 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060207185707.GB6841@ccure.user-mode-linux.org>
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	<a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
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
Date: Tue, 7 Feb 2006 13:57:07 -0500
To: Ulrich Drepper <drepper@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Feb 07, 2006 at 09:37:13AM -0800, Ulrich Drepper wrote:
> I assume you have your own setjmp implementation and are not using the
> libc version?

Nope, that would be the next step if this turned out to be untenable,
which I guess it is.

> If you don't then there is a problem.  There is a good reason why the
> constants are removed: you couldn't use the values anyway.  Your don't
> have the information to "decrypt" them.  

You're actually encrypting them somehow?  How?  And why?

Is there a reason there can't be an API for looking at the contents of
a jmp_buf?

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
