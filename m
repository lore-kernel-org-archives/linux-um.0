Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DLYb9-0007uq-0E for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 20:31:27 -0700
Received: from zproxy.gmail.com ([64.233.162.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DLYb6-0002oh-1W for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Apr 2005 20:31:26 -0700
Received: by zproxy.gmail.com with SMTP id 9so169837nzo
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 12 Apr 2005 20:31:18 -0700 (PDT)
Message-ID: <cbec11ac05041220314fa52041@mail.gmail.com>
From: Ian McDonald <imcdnzl@gmail.com>
Reply-To: Ian McDonald <imcdnzl@gmail.com>
Subject: Re: [uml-devel] My personal -devel tree snapshotted out on my
	homepage!
In-Reply-To: <200504121923.34999.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_381_29201489.1113363078556"
References: <200504082020.18943.blaisorblade@yahoo.it>
	<cbec11ac0504101619cfd1bf1@mail.gmail.com>
	<200504121923.34999.blaisorblade@yahoo.it>
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
Date: Wed, 13 Apr 2005 15:31:18 +1200
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

------=_Part_381_29201489.1113363078556
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Comments below:

On 13/04/05, Blaisorblade <blaisorblade@yahoo.it> wrote:
> On Monday 11 April 2005 01:19, Ian McDonald wrote:
> > With this patch applied to 2.6.11.7 it is my first kernel that
> > compiles straight off :-)
> Ok, that's the -bs tree, not the one I announced here (the -devel one) bu=
t
> it's ok anyway.
> > It does not apply one patch because it is already applied which is fine=
.
> Yes, I merged that, it's the va_copy fix.

Sorry about that...

> > I did a quick test against 2.6.12-rc2 and it didn't like that at all
> > (many rejected patches). That is to be expected though as that is not
> > the target but it does mean a reasonable amount of work ahead for
> > Paolo :-(
> No; luckily, I'm mainly working on -rc2 and I've backported the needed st=
uff
> to 2.6.11.

Found the development snapshot and found the following problems:
One patch did not apply. Documented in patch.out which is attached.

Problem with arch/um/include/mode_kern.h as below
In file included from arch/um/kernel/exec_kern.c:23:
arch/um/include/mode_kern.h:12: unterminated string or character constant
It doesn't like the #error on gcc 2.95.4 - if I do a remove of this
line it compiles... will need a better fix than this though....

Problem with arch/um/kernel/init_task.c as below
arch/um/kernel/init_task.c:30: duplicate initializer
arch/um/kernel/init_task.c:30: (near initialization for
`init_task.thread.arch.debugregs')
This is probably a duplication in initialisation of struct just like
the problem we had with enum in syscalls and again due to gcc 2.95.4.
I haven't tracked this one down fully yet but can if needed buy may
take a while...

I then hacked half that line out and got further compile errors in
arch/um/kernel/process_kern.c as per attached file err.out. I then
stopped as this looked a little more complicated...

If you need any further information please tell me... I have also
checked that 2.6.12-rc2 without the patch does compile and it does
with the addition of the sed patch.

If you want me to help I can apply the patches one by one but this
will take some time...

Regards,

Ian

------=_Part_381_29201489.1113363078556
Content-Type: application/octet-stream; name=patch.out
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="patch.out"

patching file arch/i386/kernel/entry.S
Hunk #4 succeeded at 665 (offset 9 lines).
patching file arch/i386/kernel/ptrace.c
patching file include/asm-i386/thread_info.h
patching file include/linux/ptrace.h
patching file kernel/fork.c
patching file include/linux/mm.h
patching file include/linux/proc_mm.h
patching file mm/Makefile
patching file mm/mmap.c
patching file mm/mprotect.c
patching file mm/proc_mm.c
patching file arch/um/include/skas_ptrace.h
patching file arch/i386/Kconfig
patching file arch/i386/kernel/ldt.c
patching file arch/i386/kernel/sys_i386.c
patching file include/asm-i386/desc.h
patching file include/asm-i386/ptrace.h
patching file include/asm-i386/mmu_context.h
patching file arch/x86_64/mm/proc_mm.c
patching file include/asm-x86_64/proc_mm.h
patching file arch/x86_64/Kconfig
patching file arch/x86_64/ia32/ptrace32.c
patching file include/asm-x86_64/mmu_context.h
patching file arch/x86_64/ia32/sys_ia32.c
patching file arch/x86_64/kernel/ldt.c
patching file include/asm-x86_64/desc.h
patching file include/asm-x86_64/ptrace.h
patching file arch/x86_64/mm/Makefile
patching file arch/x86_64/kernel/ptrace.c
patching file arch/x86_64/kernel/sys_x86_64.c
Hunk #5 succeeded at 167 (offset 7 lines).
patching file include/asm-i386/proc_mm.h
patching file localversion-skas
patching file include/asm-x86_64/unistd.h
patching file arch/um/sys-x86_64/syscalls.c
patching file include/linux/sched.h
patching file fs/exec.c
patching file Documentation/kbuild/makefiles.txt
patching file scripts/kconfig/zconf.y
patching file arch/um/os-Linux/user_syms.c
patching file arch/um/include/choose-mode.h
patching file include/asm-um/processor-generic.h
patching file arch/um/kernel/process_kern.c
Hunk #3 FAILED at 167.
1 out of 3 hunks FAILED -- saving rejects to file arch/um/kernel/process_kern.c.rej
patching file arch/um/kernel/skas/uaccess.c
patching file include/linux/compiler-gcc2.h
patching file fs/hostfs/hostfs_kern.c
patching file crypto/Kconfig
patching file arch/um/Kconfig_i386
patching file arch/um/Kconfig_x86_64
patching file arch/um/Makefile-i386
patching file arch/um/kernel/Makefile
patching file fs/reiserfs/super.c
patching file arch/um/Makefile
patching file arch/um/sys-i386/util/Makefile
patching file arch/um/util/Makefile
patching file arch/um/include/sysdep-i386/checksum.h
patching file arch/um/sys-i386/ptrace.c
patching file arch/um/kernel/skas/process_kern.c
patching file arch/um/sys-i386/ptrace_user.c
patching file arch/um/include/sysdep-i386/ptrace.h
patching file arch/um/sys-i386/syscalls.c
patching file arch/um/kernel/tt/process_kern.c
patching file arch/um/kernel/syscall_kern.c
patching file arch/um/drivers/line.c
patching file arch/um/include/line.h
patching file arch/um/drivers/ssl.c
patching file arch/um/drivers/stdio_console.c
patching file arch/um/drivers/chan_kern.c
patching file arch/i386/kernel/syscall_table.S
patching file arch/um/include/sysdep-i386/syscalls.h
patching file arch/um/include/sysdep-x86_64/syscalls.h
patching file arch/um/kernel/sys_call_table.c
patching file arch/um/sys-i386/Makefile
patching file arch/um/sys-i386/sys_call_table.S
patching file arch/um/sys-x86_64/Makefile
patching file arch/um/sys-x86_64/syscall_table.c
patching file arch/um/kernel/ptrace.c
patching file arch/um/sys-i386/ldt.c
patching file include/asm-um/ldt.h
patching file include/asm-um/processor-i386.h
patching file include/asm-um/ptrace-i386.h
patching file include/asm-um/segment.h
patching file include/asm-um/desc.h
patching file arch/um/sys-i386/tls.c
patching file arch/um/include/kern_util.h
patching file arch/um/include/mode_kern.h
patching file arch/um/kernel/time.c
patching file arch/um/kernel/time_kern.c
patching file arch/um/include/time_user.h


------=_Part_381_29201489.1113363078556
Content-Type: application/octet-stream; name=err.out
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="err.out"

arch/um/kernel/process_kern.c:168: redefinition of `prepare_to_copy'
include/asm/processor-generic.h:98: `prepare_to_copy' previously defined here
arch/um/kernel/process_kern.c: In function `copy_thread':
arch/um/kernel/process_kern.c:175: duplicate initializer
arch/um/kernel/process_kern.c:175: (near initialization for `(anonymous).arch.debugregs')
arch/um/kernel/process_kern.c: At top level:
arch/um/kernel/process_kern.c:181: redefinition of `initial_thread_cb'
arch/um/include/kern_util.h:16: `initial_thread_cb' previously defined here

------=_Part_381_29201489.1113363078556--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
