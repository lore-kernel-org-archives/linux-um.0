Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpSPx-00070S-Q5 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 08:36:17 -0800
Received: from smtp006.mail.ukl.yahoo.com ([217.12.11.95])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GpSPt-0007EY-G6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Nov 2006 08:36:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Wed, 29 Nov 2006 17:06:42 +0100
References: <87wt5h9azl.fsf@hades.wkstn.nix>
In-Reply-To: <87wt5h9azl.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200611291706.42798.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] PATCH [02/03]: eliminate skas_ptrace.h
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Nix <nix@esperi.org.uk>

On Sunday 26 November 2006 22:03, Nix wrote:
> This diff removes references to the conflicting-with-kernel-headers
> skas_ptrace.h, and moves skas_ptrace.h into the um header
> tree.
Unaccurate - you move skas_ptrace.h into include/asm-i386, right?

> There are still some trees (PPC, IA64) with a copy of a 
> skas_ptrace.h left and without ptrace-skas.h broken off from
> ptrace.h: these may be broken by this change, but I can't test
> them so I can't tell.
This change is plain wrong this way, if my reasoning is correct. 

arch/um/os-Linux/start_up.o is in USER_OBJS, so it is compiled against host 
headers.
You cannot _depend_ on them including the SKAS patch, as I said. And that 
header is in arch/um/include to be includable by both kernelspace and 
userspace files...
-- 
Inform me of my mistakes, so I can add them to my list!
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
