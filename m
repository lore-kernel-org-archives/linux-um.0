Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ghqyf-0000Ve-9X for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 09:12:41 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ghqya-000827-Ar
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 08 Nov 2006 09:12:41 -0800
Date: Wed, 8 Nov 2006 13:10:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20061108181025.GC5698@ccure.user-mode-linux.org>
References: <eilvlj$b5r$1@sea.gmane.org> <eioacp$m4r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eioacp$m4r$1@sea.gmane.org>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
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
To: Michael Richardson <mcr@sandelman.ca>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Nov 06, 2006 at 01:44:56PM -0800, Michael Richardson wrote:
> I've tracked this down to a number of places. It looks like the ifa->ifa_dev is not
> valid when the notification chain is called:

Can you tell me how to reproduce this, or send me a filesystem on which this
happens?

				Jeff

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
