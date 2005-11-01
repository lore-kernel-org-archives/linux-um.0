Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWxid-00063J-Ku for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 07:06:35 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1EWxia-0001Ha-11
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Nov 2005 07:06:35 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 9/10] UML - Big memory fixes
References: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
In-Reply-To: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511011611.09532.blaisorblade@yahoo.it>
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
Date: Tue, 1 Nov 2005 16:11:04 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Monday 31 October 2005 05:39, Jeff Dike wrote:
> A number of fixes to improve behavior when large physical memory sizes
> are specified:
>     libc files need -D_FILE_OFFSET_BITS=64 because there are unavoidable
> uses of non-64 interfaces in libc
>     some %d need to be %u
>
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Jeff, please always make patch and ChangeLog match. Yes, it matters - when it 
doesn't happen there's always something bad going on.

> Index: linux-2.6.14/arch/um/kernel/mem.c
> ===================================================================
> --- linux-2.6.14.orig/arch/um/kernel/mem.c	2005-10-28 12:58:12.000000000
> -0400 +++ linux-2.6.14/arch/um/kernel/mem.c	2005-10-30 19:29:04.000000000
> -0500 @@ -235,7 +235,7 @@ void paging_init(void)
>  	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++)
>  		zones_size[i] = 0;
>  	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
> -	zones_size[2] = highmem >> PAGE_SHIFT;
> +	zones_size[3] = highmem >> PAGE_SHIFT;
>  	free_area_init(zones_size);

What's this? It's IMHO invalid. free_area_init() intereprets these values with 
include/linux/mmzone.h: ZONE_* constants.

Why those are not used here it's a nice question.

I think this came up because there's (in -mm) Andi Kleen created a new zone 
(ZONE_DMA32) for devices using 32-bit only DMA - but it seems it's not in 
mainline).  (I don't know if that patch is in -mm actually, but I guess it 
from this patch content).

Actually, since MAX_NR_ZONES is 3, and we are assigning to zones_size[3],
we're corrupting data:

        unsigned long zones_size[MAX_NR_ZONES], vaddr;

Don't drop the patch however, I'm fixing all this up.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
