Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cji5n-0000j2-Vx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 09:58:39 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cji5m-0006H9-66 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Dec 2004 09:58:39 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] 2.4 series include path confusion
References: <41C8D3BF.6070609@enterasys.com>
In-Reply-To: <41C8D3BF.6070609@enterasys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412291849.49156.blaisorblade@yahoo.it>
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
Date: Wed, 29 Dec 2004 18:49:49 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "D. Bahi" <dbahi@enterasys.com>

On Wednesday 22 December 2004 02:54, D. Bahi wrote:
> so, trying to build 3rd party tools against the UML kernel headers and run
> into things like "can't find sysdep/ptrace.h"
>
> poking around a bit - i wonder why there are headers under the
> arch/um/include directory when we have a perfectly good seperate
> include/asm-um area to play in?
Not the whole of UML can include kernelspace headers (*_user.c files for 
instance), and include/asm-um ones are kernelspace. Those files need to 
include things from /usr/include on the host... and they can still include 
things from arch/um/include.

And this applies to 2.6, too.
> things that want to build against a set of kernel headers shouldn't know
> about the arch, right? they should be able to follow UML include paths that
> are setup during the build stage that does the soft linking of asm and
> such.
Well, they shouldn't try to do the build themselves... that is the only 
solution in 2.4, in 2.6 the kernel allows external modules to use Kbuild.

Well, there is something about workarounding this in the web-site... 
> unimportant compared to the scope of 2.6 work i understand, but i thought
> i'd bring it up and see if you think i'm way off my rocker or if i have a
> point.

> thank you all for keeping at it.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
