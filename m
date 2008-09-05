Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbiCg-0002Hh-Hq for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 13:46:50 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KbiCe-0008Bw-1I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 13:46:50 -0700
Date: Fri, 5 Sep 2008 12:37:18 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080905163718.GA11455@c2.user-mode-linux.org>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291614430.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0808291614430.15543@abydos.NerdBox.Net>
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
To: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
Cc: jiayingz@google.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, dkegel@google.com

On Fri, Aug 29, 2008 at 04:15:24PM -0700, Steve VanDeBogart wrote:
> Add a flag to tell Valgrind to run the forked child natively.  Necessary
> because Valgrind makes additional system calls to instrumented processes,
> which confuse UML.

> +#ifdef UML_CONFIG_VALGRIND_SUPPORT
> +		flags |= VALGRIND_CLONE_LETGO;
> +#endif
> +	}

I keep forgetting that I have a really bad feeling about this:

+#define VALGRIND_CLONE_LETGO   0x80000000      /* do not track fork like childr
en*/

This is effectively appropriating part of the kernel's ABI for
valgrind's use.  Not to mention that that bit is already taken:

#define CLONE_IO		0x80000000	/* Clone io context */

Could you do this with an annotation that says "let the next clone run
untraced"?

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
