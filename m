Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bt9ep-0003UX-9A for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:41:35 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Bt9ep-0002w8-1x for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 06 Aug 2004 11:41:35 -0700
Message-Id: <s1136e9c.066@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Subject: [uml-devel] SKAS on AMD 64-Bit
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
Date: Fri, 06 Aug 2004 11:41:52 -0700
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net

I would like to implement SKAS on my AMD 64-bit host. However, the current patch applies to files within the i386 arch directory:

# patch -p0 < ../host-skas3-2.6.7-v1.patch 
patching file ./arch/i386/kernel/sys_i386.c
patching file ./arch/i386/kernel/ptrace.c
patching file ./arch/i386/kernel/ldt.c
patching file ./arch/i386/Kconfig
patching file ./include/linux/mm.h
patching file ./include/linux/proc_mm.h
patching file ./include/asm-i386/desc.h
patching file ./include/asm-i386/processor.h
patching file ./include/asm-i386/ptrace.h
patching file ./include/asm-i386/mmu_context.h
patching file ./mm/mmap.c
patching file ./mm/mprotect.c
patching file ./mm/proc_mm.c
patching file ./mm/Makefile

Has anyone converted this patch to apply against the x86_64 architecture? Should the changes be relatively transparent (merely a matter of figuring out how to impose them, or do I need to worry about functional changes...)? Any help is greatly appreciated!

Tony



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
