Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Amc3l-00066e-KK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jan 2004 09:04:01 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1Amc3j-0006Pm-47
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jan 2004 09:03:59 -0800
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] O_DIRECT (was: Swapping directly to host swap area?)
Message-ID: <20040130172727.GD2751@ccure.user-mode-linux.org>
References: <Pine.LNX.4.44.0401251827030.2766-100000@sparrow>
	<200401280439.i0S4dMZw005517@ccure.user-mode-linux.org>
	<20040128140122.GM17709@shell.blacknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040128140122.GM17709@shell.blacknet.de>
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
Date: Fri, 30 Jan 2004 12:27:27 -0500
To: bock@blacknet.de, ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Wed, Jan 28, 2004 at 03:01:22PM +0100, Goetz Bock wrote:
> But could we get this as an option for all ubd devices?
> (I'm using Logical Volumes as base for ubd devices, and have no swap on
>  my hosts)

It would be an option for all ubd devices (and it couldn't be otherwise, since
the driver can't distinguish between swap and non-swap devices).

However, it only seems useful for swap devices since you probably want other
I/O cached on the host.

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
