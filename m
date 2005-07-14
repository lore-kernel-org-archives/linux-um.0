Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dst49-0000nv-3v	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 19:03:09 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by sc8-sf-mx2.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1Dst47-0006dZ-Gs
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 13 Jul 2005 19:03:09 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Am I doing something wrong with -skas0?
References: <200507122346.40320.rob@landley.net>
	<200507131656.37695.rob@landley.net>
	<20050713232934.GB16051@ccure.user-mode-linux.org>
In-Reply-To: <20050713232934.GB16051@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507132102.46910.rob@landley.net>
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
Date: Wed, 13 Jul 2005 21:02:46 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 13 July 2005 18:29, Jeff Dike wrote:

> This is the maps for the UML kernel, I think, rather than the maps for the
> process under ptrace.
>
> Was 7292 the value of pid at the point of the panic?

There's only one pid, the ./linux process gdb fired off.  The breakpoint you 
mentioned was accepted (it said breakpoint set and gave me an address), but 
it was never reached.

It broke several times on SIGUSR1 (I continued each time) but that was before 
it had printed out anything at all.  After a dozen or so continues, it 
printed out all the init stuff at once and the panic stuff, all at once.

I typed "ps" in another window before each "cont" (for the SIGUSR1's), but no 
child process had been spawned yet.

>     Jeff

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
