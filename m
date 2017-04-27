Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [BUG] um: initramfs doesn't work on uml
Date: Thu, 27 Apr 2017 12:14:00 +0900
Message-Id: <149326283034.18877.3371130154502733533.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

I found that user-mode-linux kernel doesn't boot with initramfs
(or initrd) as below. I've investigated the reason and found that
the read_initrd@arch/um/kernel/initrd.c tried to allocate memory
for initrd by using alloc_bootmem, but since init_bootmem will
be called from setup_arch afterwards, that alloc_bootmem always
failed.

$ ./vmlinux.um initrd=./initramfs.um 
Core dump limits :
	soft - 0
	hard - NONE
Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking environment variables for a tempdir...none found
Checking if /dev/shm is on tmpfs...OK
Checking PROT_EXEC mmap in /dev/shm...OK
Adding 28401664 bytes to physical memory to account for exec-shield gap
kmsg_dump:
<1>[    0.000000] bootmem alloc of 1654667 bytes failed!
<0>[    0.000000] Kernel panic - not syncing: Out of memory
<4>[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc6-00200-gd5ff081 #1
<6>[    0.000000] Stack:
<4>[    0.000000]  60385e20 6006d399 00000000 6031d32b
<4>[    0.000000]  6009b81e 601c710b 60385e30 601bcb75
<4>[    0.000000]  60385f50 6009b5ec 0000002e 00000000
<6>[    0.000000] Call Trace:
<6>[    0.000000]  [<6009b81e>] ? 
<4>[    0.000000] printk+0x0/0x94
<6>[    0.000000]  [<60020fe0>] 
<4>[    0.000000] show_stack+0x108/0x15e
<6>[    0.000000]  [<6006d399>] ? 
<4>[    0.000000] dump_stack_print_info+0xe4/0xed
<6>[    0.000000]  [<6009b81e>] ? 
<4>[    0.000000] printk+0x0/0x94
<6>[    0.000000]  [<601c710b>] ? 
<4>[    0.000000] bust_spinlocks+0x0/0x3b
<6>[    0.000000]  [<601bcb75>] 
<4>[    0.000000] dump_stack+0x2a/0x2c
<6>[    0.000000]  [<6009b5ec>] 
<4>[    0.000000] panic+0x170/0x321
<6>[    0.000000]  [<6009b47c>] ? 
<4>[    0.000000] panic+0x0/0x321
<6>[    0.000000]  [<6009b81e>] ? 
<4>[    0.000000] printk+0x0/0x94
<6>[    0.000000]  [<60030aec>] ? 
<4>[    0.000000] os_file_size+0x27/0x12d
<6>[    0.000000]  [<6000de0c>] ? 
<4>[    0.000000] alloc_bootmem_core+0x2a/0x10b
<6>[    0.000000]  [<6000dde2>] ? 
<4>[    0.000000] alloc_bootmem_core+0x0/0x10b
<6>[    0.000000]  [<6000daab>] 
<4>[    0.000000] alloc_bootmem_bdata+0x0/0x337
<6>[    0.000000]  [<6000e456>] 
<4>[    0.000000] __alloc_bootmem+0x49/0x52
<6>[    0.000000]  [<600048d5>] 
<4>[    0.000000] read_initrd+0x77/0x132
<6>[    0.000000]  [<60022ada>] 
<4>[    0.000000] uml_finishsetup+0x42/0x59
<6>[    0.000000] 
Aborted

I've tried to make a patch to fix this issue by calling
read_initrd after init_bootmem in setup_arch, but not sure
that follows correctly the design of uml boot process.

Could anyone review that?

Thank you,

---

Masami Hiramatsu (1):
      um: Fix to call read_initrd after init_bootmem


 arch/um/kernel/initrd.c  |    4 +---
 arch/um/kernel/um_arch.c |    6 ++++++
 2 files changed, 7 insertions(+), 3 deletions(-)

--
Masami Hiramatsu <mhiramat@kernel.org>

