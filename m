Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiDXA-0006kK-Ps for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 06:04:12 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiDXA-0002pW-D8 for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 06:04:12 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040118140400.GA11109@elte.hu>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
	<20040117195137.GB7405@ccure.user-mode-linux.org>
	<20040118134935.GA10490@elte.hu> <20040118135856.GA10747@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118135856.GA10747@elte.hu>
Subject: [uml-devel] Re: uml-patch-2.6.1-1: VFS: Cannot open root device
	"ubd0" or unknown-block(0, 0)
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
Date: Sun, 18 Jan 2004 15:04:00 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net


>  VFS: Cannot open root device "ubd0" or unknown-block(0,0)
>  Please append a correct "root=" boot option
>  Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)

ah, found it. This command-line used to work:

 ./linux ubd0=/tmp/uml.img root=/dev/ubd0 mem=64m init=/bin/bash umid=uml1

but now it has to be /dev/ubd/0, not /dev/ubd0.

	Ingo


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
