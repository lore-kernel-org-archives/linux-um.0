Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0wUj-0004gM-OR for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 01:24:25 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1G0wUi-0003uZ-DJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Jul 2006 01:24:25 -0700
Date: Thu, 13 Jul 2006 01:24:21 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20060713012421.b59f05d4.akpm@osdl.org>
In-Reply-To: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
References: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
Mime-Version: 1.0
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
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Wed, 12 Jul 2006 12:39:43 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> References to ZONE_HIGHMEM need to depend on CONFIG_HIGHMEM.
> 

There are several such references in mm/page_alloc.c

> 
> Index: linux-2.6.17/arch/um/kernel/mem.c
> ===================================================================
> --- linux-2.6.17.orig/arch/um/kernel/mem.c	2006-07-12 11:29:02.000000000 -0400
> +++ linux-2.6.17/arch/um/kernel/mem.c	2006-07-12 11:29:11.000000000 -0400
> @@ -226,7 +226,9 @@ void paging_init(void)
>  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 

I spy an ARRAY_SIZE().

>  		zones_size[i] = 0;
>  	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> +#ifdef CONFIG_HIGHMEM
>  	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
> +#endif
>  	free_area_init(zones_size);
>  

Maybe this is an rc1-mm1 fix?  Did Christoph's patches break UML, perhaps??


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
