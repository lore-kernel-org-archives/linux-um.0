Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLAWZ-0004nn-Ih for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 18:16:51 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CLAWY-00039w-KH for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 18:16:51 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <41795C77.1070101@fujitsu-siemens.com>
In-Reply-To: <41795C77.1070101@fujitsu-siemens.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410230316.17757.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: Unknown symbols
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
Date: Sat, 23 Oct 2004 03:16:16 +0200
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 22 October 2004 21:16, Bodo Stroesser wrote:
> Building 2.6.9 with vsyscall, I got problems with unknown symbols, e.g:

>      ext3: Unknown symbol vsyscall_end
>      ext3: Unknown symbol vsyscall_ehdr

> for (almost) all modules, my current config uses.
> The same problem exists for "end_iomem", but in the modules xfs.ko and
> ntfs.ko only.

> I tried to fix that for the vsyscall_xxx in arch/um/os-Linux/elf_aux.c. I
> inserted EXPORT_SYMBOLS for them, but it failed to compile, because it's
> not possible to include "linux/module.h" in this user-code module.

> What should I do to fix this? Move the variables to a kernel-source-file?
> Or moving the EXPORTs only? To what file do you think that it should be
> moved?

The EXPORT_SYMBOL can be in any kernel space file, if you have declared the 
function before.

Since the functions are in arch/um/os-Linux, they could go in 
arch/um/os-Linux/user_syms.c.

In general, if you have a kernelspace file related to the userspace file, you 
put the EXPORT_SYMBOLS in the kernel-space file.

> For end_iomem inserting a EXPORT_SYMBOLS in arch/um/kernel/um_arch.c seems
> to be enough.

Yes, I guess. Send the resulting patch to Jeff - as a separate one.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
