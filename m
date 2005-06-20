Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkVC9-0006mU-8y	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 15:56:45 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DkVC4-0006Ys-IO	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 20 Jun 2005 15:56:45 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH 6/8] UML - Kill some useless vmalloc tlb
	flushing
References: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
In-Reply-To: <200506201851.j5KIpKPr008499@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506210101.17338.blaisorblade@yahoo.it>
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
Date: Tue, 21 Jun 2005 01:01:16 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org

On Monday 20 June 2005 20:51, Jeff Dike wrote:
> There is absolutely no reason to flush the kernel's VM area during a
> tlb_flush_mm.
>
> This results in a noticable performance increase in the kernel build
> benchmark.
Andrew: hold off this one, definitely.

Jeff: Have you verified this with both modules enabled and iptables (a vmalloc 
user) compiled modularly? Maybe even non-modular iptables will trigger the 
bug but let's go for sure.

This situation killed a conceptually similar patch in 2.4.24-2um (which did 
apply until 2.6.11):

diff -puN arch/um/kernel/skas/tlb.c~optimization-unstable 
arch/um/kernel/skas/tlb.c
--- UmWorklinux-2.4.24/arch/um/kernel/skas/tlb.c~optimization-unstable  
2004-07-02 13:45:07.057643968 +0200
+++ UmWorklinux-2.4.24-paolo/arch/um/kernel/skas/tlb.c  2004-07-02 
13:45:14.098573584 +0200
@@ -132,7 +132,9 @@ void flush_tlb_range_skas(struct mm_stru

 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
+#if 0
        flush_tlb_kernel_vm_skas();
+#endif
        fix_range(mm, 0, host_task_size, 0);
 }

Given that:

void flush_tlb_kernel_vm_skas(void)
{
        flush_tlb_kernel_range_skas(start_vm, end_vm);
}

and flush_tlb_kernel_range_skas was renamed to _common, I argue that this 
patch is exactly the same one and will have the same bad effect.

> Signed-off-by: Jeff Dike <jdike@addtoit.com>
>
> Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
> ===================================================================
> --- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-06-20
> 11:54:56.000000000 -0400 +++
> linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-06-20 12:11:00.000000000 -0400
> @@ -76,7 +76,6 @@ void flush_tlb_mm_skas(struct mm_struct
>                  return;
>
>          fix_range(mm, 0, host_task_size, 0);
> -        flush_tlb_kernel_range_common(start_vm, end_vm);
>  }
>
>  void force_flush_all_skas(void)

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
