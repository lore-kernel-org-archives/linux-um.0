Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AgSam-0002uu-Qb for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 09:44:40 -0800
Received: from [81.56.154.251] (helo=yellowpig.yi.org ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AgSam-00075Q-8g for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jan 2004 09:44:40 -0800
Message-ID: <20040113174409.GO25935@seventeen>
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
From: Bill Allombert <allomber@math.u-bordeaux.fr>
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
Date: Tue, 13 Jan 2004 18:44:09 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, 176485@bugs.debian.org, mdz@debian.org

On Tue, Jan 13, 2004 at 12:30:22PM -0500, Jeff Dike wrote:
> allomber@math.u-bordeaux.fr said:
> >  Kernel panic: Segfault with no mm
> > Without the eth0=slirp parameter, there are no kernel panic. 
> 
> Can someone get a stack trace from this?

Here what I get:

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.

Program received signal SIGSEGV, Segmentation fault.
walk_init_root (name=0xf4a33ee8 <Address 0xf4a33ee8 out of bounds>,
    nd=0xa08f7b74) at atomic.h:107
107             __asm__ __volatile__(
(gdb) bt
#0  walk_init_root (name=0xf4a33ee8 <Address 0xf4a33ee8 out of bounds>,
    nd=0xa08f7b74) at atomic.h:107
(gdb) c
Continuing.

Breakpoint 1, segv (address=4104339216, ip=2685837537, is_write=2, is_user=0,
    sc=0xf4a33f10) at trap_kern.c:124
124             if(!is_user && (address >= start_vm) && (address < end_vm)){
(gdb) bt
#0  segv (address=4104339216, ip=2685837537, is_write=2, is_user=0,
    sc=0xf4a33f10) at trap_kern.c:124
(gdb) bt
#0  segv (address=4104339216, ip=2685837537, is_write=2, is_user=0,
    sc=0xf4a33f10) at trap_kern.c:124
(gdb) c
Continuing.

Breakpoint 2, panic (fmt=0xa08f4000 "") at panic.c:58
58              machine_paniced = 1;
(gdb) bt
#0  panic (fmt=0xa08f4000 "") at panic.c:58
(gdb) c
Continuing.
Kernel panic: Segfault with no mm


Program exited normally.

Cheers,
-- 
Bill. <ballombe@debian.org>

Imagine a large red swirl here. 


-------------------------------------------------------
This SF.net email is sponsored by: Perforce Software.
Perforce is the Fast Software Configuration Management System offering
advanced branching capabilities and atomic changes on 50+ platforms.
Free Eval! http://www.perforce.com/perforce/loadprog.html
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
