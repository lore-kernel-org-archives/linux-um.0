Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kc61T-00052j-T0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 15:12:51 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kc61S-00035f-7S
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 06 Sep 2008 15:12:51 -0700
Date: Sat, 6 Sep 2008 18:12:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080906221231.GA9359@c2.user-mode-linux.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291614430.15543@abydos.NerdBox.Net>
	<20080905163718.GA11455@c2.user-mode-linux.org>
	<48C2EE46.2060509@BitWagon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <48C2EE46.2060509@BitWagon.com>
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
To: John Reiser <jreiser@BitWagon.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, dkegel@google.com, linux-kernel@vger.kernel.org, jiayingz@google.com, Steve VanDeBogart <vandebo-lkml@NerdBox.Net>

On Sat, Sep 06, 2008 at 01:55:34PM -0700, John Reiser wrote:
> > This is effectively appropriating part of the kernel's ABI for
> > valgrind's use.  
> 
> UML is part of the kernel, so getting a memory reference checker (valgrind)
> running in UML is part of the kernel, too.  The concept of "escape from the
> virtualizer" eventually occurs to more than just memory reference checkers.

Irrelevant - what if UML, or anything else for that matter, starts
using CLONE_IO?  All of a sudden, valgrind will start letting those
threads go.

> Why wouldn't that be a race between the next _NR_clone from this thread
> and the next _NR_clone from any other existing thread [in the same
> process]?

Yeah, if you cloned in a signal handler, that would be a problem.

How about sticking the annotation in the thread itself?  This may be
what you're suggesting here - I can't really tell.

> Valgrind can pre-pend a block of code at the start of the new thread,
> but almost immediately that code will want to "unvirtualize."
> Doing so at _NR_clone itself is convenient all around.

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
