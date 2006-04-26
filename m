Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FYppz-0002Po-S7 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:38:11 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FYppy-0003aT-Hm
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 26 Apr 2006 12:38:11 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060426183848.GA9269@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org>
	<20060418125728.GA26554@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060418125728.GA26554@elf.ucw.cz>
Subject: [uml-devel] Re: [RFC] PATCH 3/4 - Time virtualization :
	PTRACE_SYSCALL_MASK
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
Date: Wed, 26 Apr 2006 14:38:48 -0400
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Apr 18, 2006 at 02:57:28PM +0200, Pavel Machek wrote:
> Same here... and perhaps you can use __get_bit/__set_bit? (this
> applies to few more places).

I did the bit-mashing by hand because I couldn't tell from a quick
look at the code whether __get_bit/__set_bit had any limitations that
I might exceed (i.e. nr needs to be < 256).

> Are you going to fix non-i386, too?

Probably, but I have other things to fix first.

				Jeff


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
