Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXGo1-0000gs-A4
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 01:20:21 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AXGo0-0004pk-OA
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 19 Dec 2003 01:20:20 -0800
From: M A Young <m.a.young@durham.ac.uk>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
In-Reply-To: <Pine.LNX.4.58.0312181514140.7622@earth>
Message-ID: <Pine.GSO.4.58.0312190914170.8625@algedi.dur.ac.uk>
References: <Pine.LNX.4.58.0312171735540.8123@earth>
 <20031217174901.GA6709@ccure.user-mode-linux.org> <Pine.LNX.4.58.0312171924290.12482@earth>
  <Pine.LNX.4.58.0312172249020.19508@earth>  <200312180146.hBI1k1kS008213@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0312181036220.31295@earth> <Pine.LNX.4.58.0312181122070.32554@earth>
 <Pine.LNX.4.58.0312181209230.1327@earth> <Pine.LNX.4.58.0312181253460.2378@earth>
 <Pine.LNX.4.58.0312181514140.7622@earth>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 19 Dec 2003 09:20:11 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
Cc: UML devel list <user-mode-linux-devel@lists.sourceforge.net>

On Thu, 18 Dec 2003, Ingo Molnar wrote:

> the attached patch makes the combo 2.6.0 patch compile for the
> !CONFIG_PROC_MM case. (necessary if forcing TT mode by disabling skas.)
>
> This is also a small cleanup as it moves the architecture-independent
> ptrace functions into the generic kernel/ptrace.c file.
>
> i've also uploaded a new combo patch with the alignment fix plus these
> changes included:
>
>     redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2

I have one minor complaint with this patch, you hardwire ARCH=um into the
bottom level Makefile, which is fine in a pure uml patch, but horribly
confusing if you are using it to build a host kernel.

Also somewhat off topic, what package is the i386 command in which you
suggest as an alternate way to switch off exec-shield? I can't find it on
my system.

	Michael Young


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
