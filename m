Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AiMJR-0006en-5r for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:26:37 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AiMJQ-00034y-KX
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 18 Jan 2004 15:26:36 -0800
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040118234824.GA21046@ccure.user-mode-linux.org>
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
	<20040117195137.GB7405@ccure.user-mode-linux.org>
	<20040118134935.GA10490@elte.hu> <20040118135856.GA10747@elte.hu>
	<20040118140400.GA11109@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118140400.GA11109@elte.hu>
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
Date: Sun, 18 Jan 2004 18:48:24 -0500
To: Ingo Molnar <mingo@elte.hu>
Cc: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Sun, Jan 18, 2004 at 03:04:00PM +0100, Ingo Molnar wrote:
> ah, found it. This command-line used to work:
> 
>  ./linux ubd0=/tmp/uml.img root=/dev/ubd0 mem=64m init=/bin/bash umid=uml1
> 
> but now it has to be /dev/ubd/0, not /dev/ubd0.

You shouldn't need any root= any more if you are booting from ubd0.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
