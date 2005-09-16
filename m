Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGN5T-0006lK-7s	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 13:45:35 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGN5Q-0001eq-UK
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Sep 2005 13:45:35 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] UML compile errors for 2.6.10 kernel
Message-ID: <20050916174431.GA6194@ccure.user-mode-linux.org>
References: <838f7c5005091513317a6166c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838f7c5005091513317a6166c0@mail.gmail.com>
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
Date: Fri, 16 Sep 2005 13:44:31 -0400
To: ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 15, 2005 at 04:31:19PM -0400, ashwin tanugula wrote:
> Hi,
> I got the following errors when I tried to compile a 2.6.10 kernel. What 
> should I do to fix this?
> 
> make: *** No rule to make target `arch/um/include/sysdep-ppc/sc.h', needed 
> by `arch/um/util'. Stop.

You could perhaps look at arch/um/sys-{i386,x86_64}/util/mk_sc.c and
see about reproducing that for ppc.

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
