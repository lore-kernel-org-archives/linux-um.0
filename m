Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CL4nt-0006Bg-4l for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:10:21 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CL4nr-0008Bz-B9 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 12:10:21 -0700
Message-ID: <41795C77.1070101@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Unknown symbols
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
Date: Fri, 22 Oct 2004 21:16:07 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, BlaisorBlade <blaisorblade_spam@yahoo.it>

Building 2.6.9 with vsyscall, I got problems with unknown symbols, e.g:

     ext3: Unknown symbol vsyscall_end
     ext3: Unknown symbol vsyscall_ehdr

for (almost) all modules, my current config uses.
The same problem exists for "end_iomem", but in the modules xfs.ko and ntfs.ko only.

I tried to fix that for the vsyscall_xxx in arch/um/os-Linux/elf_aux.c. I inserted
EXPORT_SYMBOLS for them, but it failed to compile, because it's not possible to
include "linux/module.h" in this user-code module.

What should I do to fix this? Move the variables to a kernel-source-file?
Or moving the EXPORTs only? To what file do you think that it should be moved?

For end_iomem inserting a EXPORT_SYMBOLS in arch/um/kernel/um_arch.c seems to be
enough.

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
