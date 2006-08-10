Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GBDgU-0005YN-3c for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 09:47:02 -0700
Received: from waste.org ([66.93.16.53])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GBDgS-00053L-Lv
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Aug 2006 09:47:02 -0700
Date: Thu, 10 Aug 2006 11:45:48 -0500
From: Matt Mackall <mpm@selenic.com>
Message-ID: <20060810164548.GS6908@waste.org>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
	<20060810020922.GO6908@waste.org>
	<20060810042216.GA7754@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060810042216.GA7754@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH] UML - support checkstack
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
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, Joern Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Aug 10, 2006 at 12:22:16AM -0400, Jeff Dike wrote:
> On Wed, Aug 09, 2006 at 09:09:22PM -0500, Matt Mackall wrote:
> > On Wed, Aug 09, 2006 at 02:15:24PM -0400, Jeff Dike wrote:
> > > Make checkstack work for UML.  We need to pass the underlying architecture
> > > name, rather than "um" to checkstack.pl.
> > 
> > Does this do the right thing with something like Voyager?
> 
> SUBARCH has a different meaning here.  For UML, it's the underlying,
> host, architecture, not a variant architecture like Voyager.

Right, so it sounds like this breaks Voyager. Which I think means we
ought to pass ARCH and SUBARCH and do the right thing inside
checkstack.

-- 
Mathematics is the supreme nostalgia of our time.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
