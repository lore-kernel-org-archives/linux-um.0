Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DE9MM-0008Nv-QU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 09:09:34 -0800
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DE9MK-0006g3-8m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 09:09:34 -0800
Message-ID: <4241A2C0.2050206@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
References: <20050322162121.4295D2125C@zion>
In-Reply-To: <20050322162121.4295D2125C@zion>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 23 Mar 2005 18:09:20 +0100
To: blaisorblade@yahoo.it
Cc: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it wrote:
> Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s doing
> that (i.e. i386 and x86_64).

IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion on #uml).
S390 does something similar using a special DIAG-opcode that gives permission to zVM,
that another Guest might run.

On a host running many UMLs, this might improve performance.

So, I would like to have the small patch below (it's not tested, just an idea).

		Bodo


> diff -puN include/asm-um/processor-generic.h~uml-cpu_relax include/asm-um/processor-generic.h
> --- linux-2.6.11/include/asm-um/processor-generic.h~uml-cpu_relax	2005-03-22 16:52:25.000000000 +0100
> +++ linux-2.6.11-paolo/include/asm-um/processor-generic.h	2005-03-22 16:54:41.000000000 +0100
> @@ -16,7 +16,8 @@ struct task_struct;
>  
>  struct mm_struct;
>  
> -#define cpu_relax()   barrier()
> +#include "kern.h"
> +#define cpu_relax()   sched_yield()
>  
>  struct thread_struct {
>  	int forking;


-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
