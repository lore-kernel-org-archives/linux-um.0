Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FacSv-0008Bj-KO for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 10:45:45 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FacSv-0003gA-O2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 10:45:45 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1FacSu-0001Ji-A4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 01 May 2006 10:45:45 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [PATCH 0/6] UML - Small patches for 2.6.17
Message-ID: <20060501164625.GB4592@ccure.user-mode-linux.org>
References: <200604281601.k3SG11MJ007510@ccure.user-mode-linux.org>
	<20060428165534.6067f5aa.akpm@osdl.org>
	<200604291641.19864.blaisorblade@yahoo.it>
	<20060429084430.27ea0d91.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060429084430.27ea0d91.akpm@osdl.org>
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
Date: Mon, 1 May 2006 12:46:25 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Sat, Apr 29, 2006 at 08:44:30AM -0700, Andrew Morton wrote:
> Lindent doesn't do a terribly good job, and one ends up having to perform a
> lot of manual fixups.  Perhaps as many as are presently needed.

We are doing style cleanups as code is changed - this is slow, but I
think this is the best way to go, as it is fairly unobtrusive and
doesn't create any merge barriers.

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
