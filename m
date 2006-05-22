Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FiC0c-0001rB-AB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 08:07:50 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FiC0c-0007Hf-9r for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 08:07:50 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FiC0a-0003xz-QL
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 May 2006 08:07:50 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Problem in compiling without optimisations
Message-ID: <20060522150812.GA4325@ccure.user-mode-linux.org>
References: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d8380130605220711u536aa04aud8db4e4bbbb146e@mail.gmail.com>
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
Date: Mon, 22 May 2006 11:08:12 -0400
To: Nikola Knezevic <laladelausanne@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, May 22, 2006 at 04:11:11PM +0200, Nikola Knezevic wrote:
> Hi all,
> When I change Makefile to have -O0 instead of -O2, this is what I get
> after make ARCH=um:

I don't think the kernel will build at all with -O0.

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
