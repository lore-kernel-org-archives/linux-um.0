Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KJwxd-0000wB-1j for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:53:53 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KJwxZ-0003el-LM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 18 Jul 2008 13:53:52 -0700
Date: Fri, 18 Jul 2008 16:53:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080718205342.GE13572@c2.user-mode-linux.org>
References: <5df78e1d0807030053x8a9bfabo582ea78e74b2c65b@mail.gmail.com>
	<20080703135639.GA8262@c2.user-mode-linux.org>
	<5df78e1d0807031806s74c13c84idadc62c1d1e0e93b@mail.gmail.com>
	<5df78e1d0807091925q64c0121fk3d33c37df8d80d18@mail.gmail.com>
	<20080710170210.GB18429@c2.user-mode-linux.org>
	<5df78e1d0807140206m43291128t32f1489177ad6e3d@mail.gmail.com>
	<20080714144612.GA5751@c2.user-mode-linux.org>
	<5df78e1d0807160252j1b610c41la1a2f5092ae04be7@mail.gmail.com>
	<5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5df78e1d0807162155t594936c9qe5bc1616fae97f77@mail.gmail.com>
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

On Thu, Jul 17, 2008 at 12:55:09PM +0800, Jiaying Zhang wrote:
> The patch below solves the 2.6.25 uml crash problem for me. Looks like the
> problem should be away in 2.6.26 kernel because down_interruptible has
> changed to the C code since 2.6.26. But I got kernel panic while booting
> the 2.6.26 kernel :(.
> 
> --- linux-2.6.25.4/lib/semaphore-sleepers.c     2008-05-15
> 23:00:12.000000000 +0800
> +++ linux-2.6.25.4-new/lib/semaphore-sleepers.c 2008-07-17
> 12:20:47.000000000 +0800
> @@ -48,12 +48,12 @@
>   *    we cannot lose wakeup events.
>   */
> 
> -void __up(struct semaphore *sem)
> +asmregparm void __up(struct semaphore *sem)
>  {
>         wake_up(&sem->wait);
>  }

You continue to ignore a few important facts:

    1 - There are a ton of semaphores in UML
    2 - They all work, except for yours
    Therefore, a patch which changes all semphores across all
architectures for which asmregparam has meaning can't possibly be the
correct fix.

However, you might have treated this as an important clue, and looked
at whether your broken semaphore has a different set of declarations
in force than those in the rest of the kernel.

   	      	       Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
