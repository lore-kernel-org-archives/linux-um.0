Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDKtW-0006Gb-1u for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Mar 2005 03:16:26 -0800
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDKtU-0003g9-9b for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 21 Mar 2005 03:16:25 -0800
Message-ID: <423EAD03.70706@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
References: <200503182202.52723.blaisorblade@yahoo.it>
In-Reply-To: <200503182202.52723.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: Fixing fp-state handling
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
Date: Mon, 21 Mar 2005 12:16:19 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

Blaisorblade wrote:
> From arch/um/os-Linux/sys-i386/registers.c:
> 
> /* XXX These need to use [GS]ETFPXREGS and copy_sc_{to,from}_user_skas needs
>  * to pass in a sufficiently large buffer
>  */
> 
> Could fixing this be the real fix instead of "fp-state" in the incrementals?
Sorry, no, it could't.

fp-state fixes a wrong handling of fp-/fpx-regs in arch/um/sys-i386/signal.c,
which causes fp-regs of user's "main" routine to be modified, if a signal-handler
interrupting "main" uses fp.

IMHO, the patch is OK in that it fixes the problem (Please note, Jeff had a
currupted version of the patch in his incrementals for some weeks, that didn't
work and even resulted in worse behavior. The current one is OK.).

What I don't like in the patch, is the duplicated code for fp to fpx conversion
(and vice versa). That code is stolen and modified from arch/um/sys-i386/ptrace.c
resp. arch/i386/kernel/i387.c. I think, arch/um/sys-i386/ptrace.c should be
reworked to do fp/fpx conversions in memory as signal.c now does. Doing the rework
ptrace.c also should be extended to support coredumping fp/fpx-regs. All this
were the reasons to call fp-state a "quick and dirty" patch.
Unfortunately I can't do this myself for the moment, because I have to bring up
UML-s390 as fast as possible. So maybe the best thing currently is to use fp-state.

BTW: having fp-state applied, save_fp_registers and restore_fp_registers in
arch/um/os-Linux/sys-i386/registers.c are no longer needed and might be removed.

		Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
