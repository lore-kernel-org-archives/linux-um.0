Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DEHVY-0006ge-DE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 17:51:36 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DEHVT-00067d-Ft for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 Mar 2005 17:51:36 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
References: <20050322162121.4295D2125C@zion>
	<4241A2C0.2050206@fujitsu-siemens.com>
In-Reply-To: <4241A2C0.2050206@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503240250.38153.blaisorblade@yahoo.it>
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
Date: Thu, 24 Mar 2005 02:50:37 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Wednesday 23 March 2005 18:09, Bodo Stroesser wrote:
> blaisorblade@yahoo.it wrote:
> > Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s
> > doing that (i.e. i386 and x86_64).
>
> IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion
> on #uml).
Hmm, makes sense, but this is to benchmark well... I remember from early 
discussions on 2.6 scheduler that using sched_yield might decrease 
performance (IIRC starve the calling application).

Also, that call should be put inside the idle loop, not for cpu_relax, which 
is very different, since it is used (for instance) in kernel/spinlock.c for 
spinlocks, and in such things. The "Pause" opcode is explicitly recommended 
(by Intel manuals, I don't recall why) for things like spinlock loops, and 
using yield there would be bad.

> S390 does something similar using a special DIAG-opcode that 
> gives permission to zVM, that another Guest might run.

> On a host running many UMLs, this might improve performance.
>
> So, I would like to have the small patch below (it's not tested, just an
> idea).

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
