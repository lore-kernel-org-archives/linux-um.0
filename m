Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-ID: <40AFA6E0.1040902@nessie.de>
From: Michael Roth <mroth@nessie.de>
MIME-Version: 1.0
References: <200405210556.i4L5uIX19375@lifewood.com>
	<004101c43f3b$497c26b0$dd02a8c0@ferraro>
	<20040521174707.GA7508@ccure.user-mode-linux.org>
	<005001c43f79$bcfce6e0$dd02a8c0@ferraro>
	<046001c43ffc$e9b52d90$2000000a@schlepptopp>
In-Reply-To: <046001c43ffc$e9b52d90$2000000a@schlepptopp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [uml-user] mem=64M, mem=128M, mem=ANYTHING ignored??
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
Date: Sat, 22 May 2004 21:15:44 +0200
To: roland <for_spam@gmx.de>
Cc: uml <uml@dot1q.net>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

roland wrote:
> success, too.
> 
> the error definitely seems  to be a compile issue.
> if i compile with -O2, uml just uses the 32M memory default
> if i compile with -O1, uml uses the param "mem=..." the right way

I'm not sure and I'm to lazy to check this out, but IIRC I had the same 
problems using gcc-3.4.0.

> mhhh - don`t know how much "improvement" does "O2" in favour of "O1" - but
> who should we ask now, to help hunting this "bug" ?
> gcc folks ?

Maybe the gcc manual? RTFM? ;-)

http://gcc.gnu.org/onlinedocs/gcc-3.3.3/gcc/Optimize-Options.html

O1 Options:

-fdefer-pop  -fmerge-constants  -fthread-jumps  -floop-optimize 
-fcrossjumping  -fif-conversion  -fif-conversion2  -fdelayed-branch 
-fguess-branch-probability  -fcprop-registers

O2 Options (O1 options plus the following):

-fforce-mem  -foptimize-sibling-calls  -fstrength-reduce 
-fcse-follow-jumps  -fcse-skip-blocks  -frerun-cse-after-loop 
-frerun-loop-opt -fgcse  -fgcse-lm  -fgcse-sm 
-fdelete-null-pointer-checks  -fexpensive-optimizations  -fregmov 
-fschedule-insns  -fschedule-insns2  -fsched-interblock  -fsched-spec 
-fcaller-saves  -fpeephole2  -freorder-blocks  -freorder-functions 
-fstrict-aliasing  -falign-functions  -falign-jumps  -falign-loops 
-falign-labels

Note: First, gcc-3.4.0 is slighlty different. Second, if the problem 
states only with gcc-3.x (x>=1) and not with gcc-3.0.0 or gcc-2.x, then 
maybe the bug in uml is triggered by the opcode scheduler in the newer 
gcc. IIRC correctly, the scheduler changed somewhere in the gcc-3.x 
line. But as always, I'm not sure. ;-)


Michael Roth




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
