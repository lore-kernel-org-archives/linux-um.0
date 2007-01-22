Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H96Mt-0006rj-VB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 13:06:20 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H96Mo-00057P-Cb
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Jan 2007 13:06:19 -0800
Date: Mon, 22 Jan 2007 15:59:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070122205945.GB5203@ccure.user-mode-linux.org>
References: <200701171715.35504.blaisorblade@yahoo.it>
	<20070117232644.GC15745@ccure.user-mode-linux.org>
	<200701200018.30165.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200701200018.30165.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] UML/64bit is miscompiled by gcc 4.0.3 on Ubuntu
	6.06 LTS
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

On Sat, Jan 20, 2007 at 12:18:30AM +0100, Blaisorblade wrote:
> Ok, I hope I remembered correctly how to debug such faults (I'm posting the 
> full procedure so you can give a look)

Correct.

> 0x00000000619a592f:     mov    %edx,%fs:(%rcx)  #faulting instruction.

This and the registers involved are usually all you need.

> RCX there is (long)regs->skas.regs[11] = -64, and for FS, since HOST_FS = 25,
> I get:
> 
> print/x regs->skas.regs[25]
> $45 = 0x63

The presence of %fs in the instruction immediately suggests a TLS problem.

Also, the trap number in cases like this should be 13, rather than the
14 you get with a normal page fault.

%fs isn't 0, so that's one thing that's not wrong.  What's in the
corresponding segment?

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
