Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Quentin Lambert <lambert.quentin@gmail.com>
Subject: Unable to boot linux-next build
Date: Fri,  9 Sep 2016 10:31:34 +0200
Message-Id: <20160909083134.999-1-lambert.quentin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
Cc: Quentin Lambert <lambert.quentin@gmail.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

 I have been trying to build and boot the last version available on linux-next.
 During the build I am being prompted with "has no CRC!" warnings for a bunch
 of modules.

 Has a result I get the following lines in the Module.symvers:

 [qlambert@sloth linux-next]$ grep 0x00000 Module.symvers
 0x00000000	phys_base	vmlinux	EXPORT_SYMBOL
 0x00000000	memmove	vmlinux	EXPORT_SYMBOL
 0x00000000	__copy_user_nocache	vmlinux	EXPORT_SYMBOL
 0x00000000	__get_user_4	vmlinux	EXPORT_SYMBOL
 0x00000000	__put_user_4	vmlinux	EXPORT_SYMBOL
 0x00000000	__memcpy	vmlinux	EXPORT_SYMBOL
 0x00000000	__fentry__	vmlinux	EXPORT_SYMBOL
 0x00000000	memset	vmlinux	EXPORT_SYMBOL
 0x00000000	__sw_hweight64	vmlinux	EXPORT_SYMBOL
 0x00000000	__sw_hweight32	vmlinux	EXPORT_SYMBOL
 0x00000000	memcpy_mcsafe_unrolled	vmlinux	EXPORT_SYMBOL_GPL
 0x00000000	memcpy	vmlinux	EXPORT_SYMBOL
 0x00000000	copy_user_enhanced_fast_string	vmlinux	EXPORT_SYMBOL
 0x00000000	clear_page	vmlinux	EXPORT_SYMBOL
 0x00000000	__put_user_2	vmlinux	EXPORT_SYMBOL
 0x00000000	__get_user_2	vmlinux	EXPORT_SYMBOL
 0x00000000	copy_page	vmlinux	EXPORT_SYMBOL
 0x00000000	copy_user_generic_string	vmlinux	EXPORT_SYMBOL
 0x00000000	_copy_to_user	vmlinux	EXPORT_SYMBOL
 0x00000000	___preempt_schedule	vmlinux	EXPORT_SYMBOL
 0x00000000	__memmove	vmlinux	EXPORT_SYMBOL
 0x00000000	empty_zero_page	vmlinux	EXPORT_SYMBOL
 0x00000000	__get_user_8	vmlinux	EXPORT_SYMBOL
 0x00000000	__put_user_8	vmlinux	EXPORT_SYMBOL
 0x00000000	_copy_from_user	vmlinux	EXPORT_SYMBOL
 0x00000000	native_load_gs_index	vmlinux	EXPORT_SYMBOL
 0x00000000	__memset	vmlinux	EXPORT_SYMBOL
 0x00000000	___preempt_schedule_notrace	vmlinux	EXPORT_SYMBOL
 0x00000000	__put_user_1	vmlinux	EXPORT_SYMBOL
 0x00000000	__get_user_1	vmlinux	EXPORT_SYMBOL
 0x00000000	copy_user_generic_unrolled	vmlinux	EXPORT_SYMBOL

 If I ignore these and go on to boot the resulting kernel. I am left with:

 ERROR: Unable to find root device 'UUID=<omitted>'

 I am then dropped to a recovery shell where the keyboard is not answering.

 The UUID is valid and is the same being used when I boot the HEAD of the linux
 tree. In fact, I am sending this message from the same machine, running
 that very kernel.
 Prior to failing to find the root device, the kernel prints a series of
 messages for each of the above symbol:

 scsi_mod: no symbol version for <foo>
 scsi_mod: Unknown symbol <foo> (err -22)

 Therefore, I suspect that the missing CRC messages are linked to the issue.

 I have git bisected this behavior to the patch 784d5699edd. 

 Simply reverting this patch results in different issues.
 The errors I am having due to no CRC are fixed but I receive another error at
 boot time:
 failed command: WRITE LOG DMA EXT

 I mostly asking for help as to what to do next.
 Could someone point me toward documentation that would help me understand and
 fix this issue?

