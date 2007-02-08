Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HFFVS-0000xh-PX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 12:04:35 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HFFVP-0004IE-QT
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 12:04:34 -0800
Date: Thu, 8 Feb 2007 14:57:11 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070208195711.GA6607@ccure.user-mode-linux.org>
References: <E1HFEIB-0000nJ-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1HFEIB-0000nJ-00@dorka.pomaz.szeredi.hu>
Subject: Re: [uml-devel] UML hang with 100% CPU
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Feb 08, 2007 at 07:46:47PM +0100, Miklos Szeredi wrote:
> It boots fine, then usually just after logging in and before starting
> the shell (but sometimes after the shell started) it gets into some
> loop.  Looking at the strace shows that two processes are
> sending/receiving single '\0' bytes on some sockets endlessly.
> 
> Does this ring a bell?

No, it doesn't.  This is a strace on the host, I take it?

Can you get backtraces from the processes?

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
