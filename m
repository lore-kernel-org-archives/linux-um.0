Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kc4p0-0006MP-8Y for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 13:55:54 -0700
Received: from jade.aracnet.com ([216.99.193.136])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kc4oz-0006Ly-1b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 13:55:54 -0700
Message-ID: <48C2EE46.2060509@BitWagon.com>
Date: Sat, 06 Sep 2008 13:55:34 -0700
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>	<alpine.DEB.1.00.0808291614430.15543@abydos.NerdBox.Net>
	<20080905163718.GA11455@c2.user-mode-linux.org>
In-Reply-To: <20080905163718.GA11455@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [PATCH 2/6] UML: Don't valgrind userspace
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
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, dkegel@google.com, linux-kernel@vger.kernel.org, jiayingz@google.com, Steve VanDeBogart <vandebo-lkml@NerdBox.Net>

Jeff Dike wrote:
> On Fri, Aug 29, 2008 at 04:15:24PM -0700, Steve VanDeBogart wrote:
>> Add a flag to tell Valgrind to run the forked child natively.  Necessary
>> because Valgrind makes additional system calls to instrumented processes,
>> which confuse UML.
> 
>> +#ifdef UML_CONFIG_VALGRIND_SUPPORT
>> +		flags |= VALGRIND_CLONE_LETGO;
>> +#endif
>> +	}
> 
> I keep forgetting that I have a really bad feeling about this:
> 
> +#define VALGRIND_CLONE_LETGO   0x80000000      /* do not track fork like childr
> en*/
> 
> This is effectively appropriating part of the kernel's ABI for
> valgrind's use.  

UML is part of the kernel, so getting a memory reference checker (valgrind)
running in UML is part of the kernel, too.  The concept of "escape from the
virtualizer" eventually occurs to more than just memory reference checkers.

> Not to mention that that bit is already taken:
> 
> #define CLONE_IO		0x80000000	/* Clone io context */

It wasn't taken a few months ago when the valgrind patches for UML were
first proposed.  The list of free bits in that flag word is now empty.
There may be some overlap of concept with CLONE_UNTRACED, which might
be used temporarily while figuring out an alternative.

> 
> Could you do this with an annotation that says "let the next clone run
> untraced"?

Why wouldn't that be a race between the next _NR_clone from this thread
and the next _NR_clone from any other existing thread [in the same process]?

Valgrind can pre-pend a block of code at the start of the new thread,
but almost immediately that code will want to "unvirtualize."
Doing so at _NR_clone itself is convenient all around.

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
