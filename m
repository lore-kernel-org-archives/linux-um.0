Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgTe1-0008E3-V0 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 10:52:05 -0800
Received: from mta10.adelphia.net ([68.168.78.202])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AgTe1-0002U4-A7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 10:52:05 -0800
From: Matt Zimmerman <mdz@debian.org>
Message-ID: <20040113185156.GW1514@alcor.net>
References: <20031228093317.GK17472@alcor.net>
	<20031228095115.GL17472@alcor.net>
	<20031228101240.GN17472@alcor.net>
	<20031228113042.GO17472@alcor.net>
	<20031230184330.GD1365@alcor.net>
	<200401060258.i062wWFI023087@ccure.user-mode-linux.org>
	<20040108070718.GI28393@alcor.net>
	<20040112183623.GB1436@alcor.net> <20040113152542.GD7072@seventeen>
	<200401131730.i0DHUMhg002358@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401131730.i0DHUMhg002358@ccure.user-mode-linux.org>
Subject: [uml-devel] Re: Panic with slirp transport and gcc 3.3
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
Date: Tue, 13 Jan 2004 10:51:57 -0800
To: Jeff Dike <jdike@addtoit.com>
Cc: Bill Allombert <allomber@math.u-bordeaux.fr>, user-mode-linux-devel@lists.sourceforge.net, 176485@bugs.debian.org

On Tue, Jan 13, 2004 at 12:30:22PM -0500, Jeff Dike wrote:

> allomber@math.u-bordeaux.fr said:
> >  Kernel panic: Segfault with no mm
> > Without the eth0=slirp parameter, there are no kernel panic. 
> 
> Can someone get a stack trace from this?

Certainly (this is from 2.4.23-1um).  Seems like something goes weird with
procfs, but I've no idea why this only happens with slirp (and newer gcc for
that matter).

(gdb) bt
#0  panic (fmt=0x0) at panic.c:58
#1  0xa00d769b in segv (address=8, ip=2685922193, is_write=0, is_user=0, 
    sc=0x0) at trap_kern.c:144
#2  0xa00d7af5 in segv_handler (sig=11, regs=0xa0350274) at trap_user.c:67
#3  0xa00df411 in sig_handler_common_skas (sig=11, sc_ptr=0x58)
    at trap_user.c:33
#4  0xa00d7c05 in sig_handler (sig=0, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2687843188, esi = 2688540673, ebp = 2687843100, esp = 2687843028, ebx = 2687843188, edx = 2687843188, ecx = 2687827968, eax = 0, trapno = 14, err = 4, eip = 2684641864, cs = 35, __csh = 0, eflags = 2163202, esp_at_signal = 2687843028, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 8})
    at trap_user.c:103
#5  <signal handler called>
#6  0xa0046248 in link_path_walk (name=0xa03fe001 "dev", nd=0xa0353b74)
    at namei.c:462
#7  0xa004674e in path_walk (name=0x0, nd=0xa0353b74) at namei.c:659
#8  0xa0046919 in path_lookup (path=0xa03fe000 "/dev", flags=2687843188, 
    nd=0xa0353b74) at namei.c:748
#9  0xa0047754 in sys_mkdir (pathname=0x0, mode=448) at namei.c:1345
#10 0xa000eafa in prepare_namespace () at init/do_mounts.c:917
#11 0xa000e613 in init (unused=0x0) at init/main.c:580
#12 0xa00d22f9 in run_kernel_thread (fn=0xa000e600 <init>, arg=0x0, 
#13 0xa00de930 in new_thread_handler (sig=10) at process_kern.c:70
#14 <signal handler called>
(gdb) i sym 2685922193
kill + 17 in section .text
(gdb) i line *2685922193
Line 155 of "proc_fs.h" starts at address 0xa0178e94 <svc_proc_register+68>
   and ends at 0xa01c3913.
(gdb) up 6
#6  0xa0046248 in link_path_walk (name=0xa03fe001 "dev", nd=0xa0353b74)
    at namei.c:462
462             inode = nd->dentry->d_inode;
(gdb) print *nd
$1 = {dentry = 0x0, mnt = 0x0, last = {
    name = 0x8124 <Address 0x8124 out of bounds>, len = 1, hash = 2686526256}, 
  flags = 16, last_type = 1}

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
