Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GqA7z-0007Xo-9w for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 07:16:39 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user50734)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GqA7w-0006In-8F
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 01 Dec 2006 07:16:36 -0800
References: <87wt5h9azl.fsf@hades.wkstn.nix>
	<200611291706.42798.blaisorblade@yahoo.it>
From: Nix <nix@esperi.org.uk>
Date: Fri, 01 Dec 2006 15:16:33 +0000
In-Reply-To: <200611291706.42798.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Wed,
	29 Nov 2006 17:06:42 +0100")
Message-ID: <873b7zy7ce.fsf@hades.wkstn.nix>
MIME-Version: 1.0
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
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 29 Nov 2006, blaisorblade@yahoo.it uttered the following:

> On Sunday 26 November 2006 22:03, Nix wrote:
>> This diff removes references to the conflicting-with-kernel-headers
>> skas_ptrace.h, and moves skas_ptrace.h into the um header
>> tree.
> Unaccurate - you move skas_ptrace.h into include/asm-i386, right?

Gah. Yes. Sorry, brainfart.

>> There are still some trees (PPC, IA64) with a copy of a 
>> skas_ptrace.h left and without ptrace-skas.h broken off from
>> ptrace.h: these may be broken by this change, but I can't test
>> them so I can't tell.
> This change is plain wrong this way, if my reasoning is correct. 
>
> arch/um/os-Linux/start_up.o is in USER_OBJS, so it is compiled against host 
> headers.
> You cannot _depend_ on them including the SKAS patch, as I said. And that 
> header is in arch/um/include to be includable by both kernelspace and 
> userspace files...

Oh, hell, true. The problem is that we'll have to cater for people who
*have* included the skas headers, including the old ones...

... fixed patch coming in a bit (shopping and 2.6.19 upgrade first).

-- 
`The main high-level difference between Emacs and (say) UNIX, Windows,
 or BeOS... is that Emacs boots quicker.' --- PdS

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
