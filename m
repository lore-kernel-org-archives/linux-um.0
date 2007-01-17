Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7Fgd-0007Vv-Pa for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 10:39:03 -0800
Received: from mail.nagafix.co.uk ([194.145.196.85])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7Fga-00015O-8H
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 Jan 2007 10:39:03 -0800
Message-ID: <45AE67C0.5080003@nagafix.co.uk>
Date: Wed, 17 Jan 2007 18:15:28 +0000
From: Antoine Martin <antoine@nagafix.co.uk>
MIME-Version: 1.0
References: <200701171715.35504.blaisorblade@yahoo.it>
	<45AE684D.7070802@theshore.net>
In-Reply-To: <45AE684D.7070802@theshore.net>
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
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

>> ptrace(PTRACE_SETREGS, 31586, 0, 0x6096dac8) = 0
>> ptrace(PTRACE_SETFPREGS, 31586, 0, 0x6096dba0) = 0
>> ptrace(PTRACE_SYSCALL, 31586, 0, SIG_0) = 0
>>
>> I'll have to verify whether some code in the stubs is miscompiled. But not 
>> until... well, I dunno when I'll be back...
>>
>> Anybody else with the same problem?
> 
> 
> Isn't this is the same problem we discussed a few months back?  What 
> I've discovered since then is this is a regression introduced after 
> 2.6.16 on the _host_.  Any post-2.6.16 host kernel, either skas v8.2 or 
> v9.pre causes Ubuntu (and other distros, I believe) to hang after "VFS 
> mounting root".
> 
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116008558424368&w=2
> http://marc.theaimsgroup.com/?l=user-mode-linux-devel&m=116711159414443&w=2
Indeed it is.

A fix would be more than welcome. (2.6.16 is a bit dated)
I believe a lot of users are hitting this bug now too (and it is a 
regression) as a lot of distros ship recent kernels.

Another regression in 2.6.16 (or later?) is the inability to run 32-bit 
guests on 64-bit hosts (the same binaries that used to work before - 
statically compiled). The boot stops very early during the "checking 
ptrace" step.

Antoine

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
