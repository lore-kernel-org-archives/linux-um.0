Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKV0g-0005h3-Bl for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 02:15:18 -0700
Received: from an-out-0708.google.com ([209.85.132.246])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKV0e-0007c2-VC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 02:15:18 -0700
Received: by an-out-0708.google.com with SMTP id b21so314240ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 20 Jul 2008 02:15:16 -0700 (PDT)
Message-ID: <804dabb00807200215n32b5171do97d344f2f954c490@mail.gmail.com>
Date: Sun, 20 Jul 2008 17:15:16 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
In-Reply-To: <20080718205532.GG13572@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <804dabb00807181222r2e80126fp75bf7bdd9c4cac73@mail.gmail.com>
	<20080718205532.GG13572@c2.user-mode-linux.org>
Subject: Re: [uml-devel] Kernel panic - not syncing: do_syscall_stub :
	PTRACE_SETREGS failed, errno = 5
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

The problem lies in the function:

static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
{
        int n, i;
        long ret, offset;
        unsigned long * data;
        unsigned long * syscall;
        int err, pid = mm_idp->u.pid;

        if (proc_mm)
                /* FIXME: Need to look up userspace_pid by cpu */
                pid = userspace_pid[0];

        multi_count++;

        n = ptrace_setregs(pid, syscall_regs);
        if (n < 0) {
                printk(UM_KERN_ERR "Registers - \n");
                for (i = 0; i < MAX_REG_NR; i++)
                        printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
                panic("do_syscall_stub : PTRACE_SETREGS failed, errno = %d\n",
                      -n);
        }

Where the ptrace_setregs() above returned a value less than zero.

Breakpoint 2, do_syscall_stub (mm_idp=0xfdaee9c, addr=0xfc5ce44) at
/mnt/hd0/download/linux-2.6-latest/arch/um/os-Linux/skas/mem.c:76
76                              printk(UM_KERN_ERR "\t%d\t0x%lx\n", i,
syscall_regs[i]);
(gdb)
        16      0x0
75                      for (i = 0; i < MAX_REG_NR; i++)
(gdb)
77                      panic("do_syscall_stub : PTRACE_SETREGS
failed, errno = %d\n",
(gdb)
Kernel panic - not syncing: do_syscall_stub : PTRACE_SETREGS failed, errno = 5

And ptrace_setregs() calling ptrace() seemed to returned -errno almost
immediately:

(gdb) s
ptrace_setregs (pid=19131, regs=0x820aae0) at
/mnt/hd0/download/linux-2.6-latest/arch/um/sys-i386/ptrace_user.c:18
18              if (ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
(gdb) s
19                      return -errno;
(gdb) s

Why is it so?

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
