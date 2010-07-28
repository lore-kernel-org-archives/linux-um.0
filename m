Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jdike@govinda.addtoit.com>) id 1OeBzy-0006RM-IH
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2010 19:09:02 +0000
Received: from govinda.solana.com ([198.99.130.30] helo=govinda.addtoit.com)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OeBzx-0006BS-2z
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 28 Jul 2010 19:09:02 +0000
Date: Wed, 28 Jul 2010 14:49:56 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20100728184956.GA25818@c-98-229-117-200.hsd1.ma.comcast.net>
References: <AANLkTi=VnBo4uZ6UUd7WZoKYY1M2D2+YaaX9+wKmNXaK@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTi=VnBo4uZ6UUd7WZoKYY1M2D2+YaaX9+wKmNXaK@mail.gmail.com>
Subject: Re: [uml-devel] reading heap memory in kernel space .
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: ratheesh k <ratheesh.ksz@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wed, Jul 28, 2010 at 09:54:37PM +0530, ratheesh k wrote:
> I have a simple user space program .
> 
> char *ptr=(char *)malloc(100);
> strcpy(ptr , "Hi Kernel  , How are you ");
> .........
> sendmsg(...)
> ........
> 
> 
> I compiled this program  and executed on 2.6.32 user mode linux .
> when i run uml under gdb , i would like to read all memory location
> staring from ptr .( whole string ) from kernel .
> I have set some break points on some system calls ( sys_sendmsg ). gdb
> will break there and if know ptr address , should i convert to
> physical address space ? How will i do that ? how will i get
> uml_physmem value ?

Why do you want a physical address?  It's useless to a debugger.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

