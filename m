Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHOel-0004Gi-8h	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 09:38:15 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EHOei-0006FA-TV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Sep 2005 09:38:15 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Waiting for data on host FD
Message-ID: <20050919162612.GA5125@ccure.user-mode-linux.org>
References: <432E7091.8090403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432E7091.8090403@gmail.com>
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
Date: Mon, 19 Sep 2005 12:26:12 -0400
To: Victor Condino <un1tz3r0@gmail.com>
Cc: UML Developer Mailing List <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Sep 19, 2005 at 04:02:25AM -0400, Victor Condino wrote:
> So my question is: what is the right way to go about waiting for host
> I/O to become available on a givel FD? It seems from looking at the uml
> drivers that um_request_irq is used to request notification of various
> asynchronous events from the host. 

This is the right way to do it.

> If this can be used for waiting until
> an fd is available for read or write, how? I tried looking around for
> some code that uses um_request_irq for read/write, but couldn't seem to
> find any.

Just register the same fd twice, once for read and once for write.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
