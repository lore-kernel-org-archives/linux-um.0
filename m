Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Fd9Vb-0001DA-1o for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2006 10:26:59 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Fd9VT-00029f-OW
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 08 May 2006 10:26:57 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Integer overflows in new AIO ubd driver
Message-ID: <20060508172648.GA4911@ccure.user-mode-linux.org>
References: <1143398965.11224.146.camel@localhost.localdomain>
	<20060327153832.GB3666@ccure.user-mode-linux.org>
	<1143474452.11224.150.camel@localhost.localdomain>
	<20060329193324.GC4940@ccure.user-mode-linux.org>
	<1143666989.7192.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143666989.7192.9.camel@localhost.localdomain>
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
Date: Mon, 8 May 2006 13:26:48 -0400
To: Gerd Stolpmann <info@gerd-stolpmann.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Mar 29, 2006 at 11:16:27PM +0200, Gerd Stolpmann wrote:
> Almost:
> 
> iozone -i 0 -i 1 -r 64k -s 5G -e -f /Data/testfile -U /Data
> 
> i.e. record size is 64K, and there is a umount/mount between the
> runs. /Data is an ext3 filesystem with 4k block size, on a 20 G
> partition.
> 
> > And it runs fine here.
> 
> For me it runs fine only the first time I call it. The next time UML
> locks up.
> 
> Can I do something to find out more details?

I've been playing with this, and iozone can't make UML do anything
bad.  Is this the only scenario you have?

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
