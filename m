Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G15lA-00077i-Sq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 11:18:00 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G15l9-0008LM-BV
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 11:18:00 -0700
Date: Thu, 13 Jul 2006 14:17:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060713181754.GA5343@ccure.user-mode-linux.org>
References: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
	<20060713012421.b59f05d4.akpm@osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060713012421.b59f05d4.akpm@osdl.org>
Subject: Re: [uml-devel] [PATCH 1/5] UML - Fix ZONE_HIGHMEM compilation error
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 13, 2006 at 01:24:21AM -0700, Andrew Morton wrote:
> >  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
> 
> I spy an ARRAY_SIZE().

Yup, I did an ARRAY_SIZE pass a while ago, but I missed that somehow,
and some grepping shows there are a bunch more.

> Maybe this is an rc1-mm1 fix?  Did Christoph's patches break UML, perhaps??

Yes, it's this bit in mmzone.h:
    #ifdef CONFIG_HIGHMEM
	/*
	 * A memory area that is only addressable by the kernel through
	 * mapping portions into its own address space. This is for example
	 * used by i386 to allow the kernel to address the memory beyond
	 * 900MB. The kernel will set up special mappings (page
	 * table entries on i386) for each page that the kernel needs to
	 * access.
	 */
	ZONE_HIGHMEM,
    #endif

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
