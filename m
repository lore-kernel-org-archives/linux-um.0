Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8O8n-0004bU-2Z for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:43:45 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D8O8m-00061Y-DV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:43:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200503061949.03819.blaisorblade@yahoo.it>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] SKAS leftovers: having fun with old code relicts (aka
	PTRACE_SIGPENDING)
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
Date: Sun, 6 Mar 2005 19:49:03 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Ok, what I discovered today is just funny...

A little, ignarious programmer (me) was porting the SKAS patch to x86_64, and 
proof-checking the sizes of vars.

While looking at PTRACE_SIGPENDING, he realized that in the i386 version we 
copy a sigset_t value (child->pending.signal), which is 64-bit wide, to a 
"unsigned long", i.e. 32-bit wide*.

        case PTRACE_SIGPENDING:
                ret = copy_to_user((unsigned long *) data,
                                   &child->pending.signal,
                                   sizeof(child->pending.signal));
                break;

"What the fuck!" said the ignarious programmer (me), and he went looking 
carefully to each and every usage of PTRACE_SIGPENDING in the Uml code, to 
check why nobody sees the world collapsing (maybe the callers are correct 
anyway, he thought):

 $ find arch/um/ include/asm-um/ |xargs grep PTRACE_SIGPENDING
arch/um/kernel/ptrace.c:        case PTRACE_SIGPENDING:
arch/um/include/skas_ptrace.h:#define PTRACE_SIGPENDING 53

He checked better, and better, distrusting the Truth discovered by his poor 
and liable mate, Lord Grep... but at last he couldn't ignore the Truth: 
PTRACE_SIGPENDING is a (broken) relict!

After this story, we come to the question: Jeff, what I missed (apart that 
probably it was used in releases before SKAS3)?

Could I delete PTRACE_SIGPENDING from the SKAS patch?

I wouldn't for the sake of compatibility, but since the interface has never 
been used by SKAS, and probably (if somebody else used it) it didn't work 
well, I'm not certain.

*Actually, even if we write 64-bit to a 32-bit pointer above, this is done 
also for PTRACE_LDT, so type of the cast is just cosmetical. The point is 
that it's misleading for the reader.
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
