Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ADDGy-00025L-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 18:31:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1ADDEl-00052s-0g
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 24 Oct 2003 18:29:03 -0700
Received: from ccure.karaya.com (lakshmi.solana.com [127.0.0.1])
	by lakshmi.solana.com (8.11.2/8.9.3) with ESMTP id h9P1HKj18223
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 24 Oct 2003 21:17:21 -0400
Message-Id: <200310250134.h9P1YQaK004079@ccure.karaya.com>
Subject: Re: [uml-devel] Problem with UML cross compilation 
In-Reply-To: Your message of "Sun, 19 Oct 2003 22:28:25 +0200."
             <20031019202825.GA10810@callisto.yi.org> 
References: <20031018183128.GA22119@callisto.yi.org> <200310191716.h9JHGZdb011736@ccure.karaya.com>  <20031019202825.GA10810@callisto.yi.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Oct 2003 21:34:26 -0400
To: Dan Aloni <da-x@gmx.net>
Cc: User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

da-x@gmx.net said:
> Okay, so you say that a cross build procedure would need a one-time
> stage where the person would generate the arch_headers at the host and
> then manually copy the generated outputs back to the build host?
> Sounds difficult, but people who are attempting cross builds are
> probably smart enough to understand this, so it's good. 

Yeah, plus maybe a message at the end saying where the headers are located
and where they need to be copied to.

> Then, make arch_headers ARCH=um at the target will skip everything but
>  running the helpers, packing their outputs to a .tar.gz, and
> something like make install_arch_headers ARCH=um CROSS_COMPILE=[..] at
> the host  will install those at the right spots in the tree with the
> given prefix in CROSS_COMPILE. 

At this point, I'd be happy with something that just generates the headers
and leaves them in the tree somewhere.  Once that works, we can think about
packaging them up nicely for copying over to the build host.

				Jeff



-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
