Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Csv11-00070v-2n for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 19:35:47 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Csv0w-0005Ii-Gy for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 19:35:47 -0800
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
Message-ID: <Pine.LNX.4.61.0501232231380.6197@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] x86_64 compile on 2.6.11-rc2
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
Date: Sun, 23 Jan 2005 22:35:50 -0500 (EST)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: William Stearns <wstearns@pobox.com>

Good evening, all,
 	I'm trying to get 2.6.11-rc2 to compile.  Applying x86_64-fixes 
helps it get further, but I still run into:


gcc -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing 
-fno-common -ffreestanding -O2 -fno-omit-frame-pointer -g -U__x86_64__ 
-fno-builtin -D__arch_um__ -DSUBARCH=\"x86_64\" -Iarch/um/include 
-I/usr/src/linux-2.6.11-rc2/arch/um/kernel/tt/include 
-I/usr/src/linux-2.6.11-rc2/arch/um/kernel/skas/include -D__x86_64__ 
-D_GNU_SOURCE -D_LARGEFILE64_SOURCE  -c -o arch/um/kernel/process.o 
arch/um/kernel/process.c
   CC      arch/um/kernel/process_kern.o
   CC      arch/um/kernel/ptrace.o
arch/um/kernel/ptrace.c: In function `sys_ptrace':
arch/um/kernel/ptrace.c:104: error: structure has no member named 
`debugregs'
make[1]: *** [arch/um/kernel/ptrace.o] Error 1
make: *** [arch/um/kernel] Error 2


 	None of the other patches in Jeff's 2.6 tar looked relevant to 
this untrained eye.  Could anyone suggest either an additional patch 
(/patchset) that would get x86_64 to compile?  If not, could someone 
suggest a kernel that will compile on x86_64?  The last one I have that I 
got to compile was 2.6.4, but to be fair, I'm just getting back into 
kernel compiles.
 	Cheers,
 	- Bill

---------------------------------------------------------------------------
         "A man's character is his fate."
 	-- The Emperor's Club
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
