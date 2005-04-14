Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMBMK-0004gc-Fq for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:54:44 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DMBMI-0003r4-1R for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 14 Apr 2005 13:54:44 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Problems with UML on Debian Sarge 64 host
References: <cbec11ac0504132125779afc07@mail.gmail.com>
In-Reply-To: <cbec11ac0504132125779afc07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504142307.11927.blaisorblade@yahoo.it>
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
Date: Thu, 14 Apr 2005 23:07:11 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Ian McDonald <imcdnzl@gmail.com>

On Thursday 14 April 2005 06:25, Ian McDonald wrote:
> Hi there,

> In my continuing saga (which some are becoming familiar with) to get
> UML 2.6.x working at all I have been given access to another machine
> to develop on and my old machine is going to disappear.

> This machine is Debian Sarge with gcc 3.3.5 on an AMD64 with 32 bit
> userspace although 64 bit compiles can also occur.

> I am doing all my UML builds with ARCH=um SUBARCH=i386 at this point in
> time.

> The problem is that my bootup dies very early on and this is the total
> output: Checking for /proc/mm...not found
> Checking PROT_EXEC mmap in /tmp...OK
> tracing thread pid = 20981
> OP_FORK failed to attach pid

> I suspect that this is something to do with my mixed 32/64 bit
> environment but I am not sure... Can anybody shed some light on this?

I've seen that *sometimes* too on 64-bit envs., tried doing a "setarch i386 
linux" or something like that, to force a 32-bit emulation?

At least sometimes it *does* make a difference.

> BTW I have also written a patch which I think is worth submitting into
> the kernel tree as it gives better debugging of error messages in
> arch/um/kernel/tt/tracer.c for where my process is dying.

> When I run with my patch it shows that it is dying on the
> PTRACE_ATTACH with an error EPERM but I can run other processes etc
> like gdb which attach to processes.
Tried disabling the ptrace proxy in compilation, as the first thing?

Remember me and I'll go merging this patchlet (it's just matter of not 
forgetting this).
> Any help would be greatly appreciated.
I hope I can help on this...
> Ian

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
