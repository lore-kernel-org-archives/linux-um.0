Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KIPJm-0000R6-N0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jul 2008 07:46:22 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KIPJm-0007Zn-2G
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jul 2008 07:46:22 -0700
Date: Mon, 14 Jul 2008 10:46:12 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080714144612.GA5751@c2.user-mode-linux.org>
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
Subject: Re: [uml-devel] 2.6.25 uml kernel crashes when it calls down() on	a
	semaphore with zero counter
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jiaying Zhang <jiayingz@google.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, Jul 14, 2008 at 05:06:49PM +0800, Jiaying Zhang wrote:
> The 2.6.24 kernels are OK, but I have seen this problem with all of the
> 2.6.25 kernels I have tried. There have been a lot of changes between
> 2.6.24 kernels and 2.6.25 kernels. I am not sure which one may lead
> to this problem.

So bisect it.

> Looks like the problem happens when __down_interruptible is called.
> I checked the semaphore passed to __down_interruptible under gdb
> and found it was corrupted:
> (gdb) f 18
> #18 __down_interruptible (sem=0x9f68d08) at include/linux/list.h:50
> 50              prev->next = new;
> (gdb) p sem
> $15 = (struct semaphore *) 0x9f68d08
> (gdb) p *sem
> $16 = {count = {counter = -268435295}, sleepers = 4, wait = {lock =
> {raw_lock = {<No data fields>}}, task_list = {
>       next = 0x9f68d5c, prev = 0x18124}}}
> 
> But the semaphore looks correct before calling down_interruptible:

What's the problem with debugging this, then?  You step through the
code starting when the semaphore is good and see exactly when it gets
corrupted.

				Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
