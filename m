Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBE37-0007Qn-Ef for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 07:29:05 -0700
Received: from catarina.tagus.ist.utl.pt ([193.136.166.72]
	helo=mail.tagus.ist.utl.pt)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBE36-0002wm-No
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 07:29:04 -0700
Reply-To: <pedro.estrela@inesc.pt>
From: "Pedro Estrela" <pedro.estrela@inesc.pt>
Subject: RE: [uml-devel] DDD 3.3.1 + UML_2.4.24 - can't debug
Message-ID: <000901c41cac$a14ae810$902914ac@tagus.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0404070931130.22817-100000@filer.marasystems.com>
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
Date: Wed, 7 Apr 2004 15:28:38 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 'Henrik Nordstrom' <uml@henrik.marasystems.com>, 'Pedro Estrela' <pedro.estrela@tagus.ist.utl.pt>


Hello, and thanks for your quick reply.

I've tried just as you said, but the problem remains the same.

Also, I've now switched to an environment where I can be root on host,
but the situation hasn't changed. 

///////////////////////////////////

However, I've managed successfully to attach linux to an already running
gdb:

1 - start "gdb linux"
2 - check its gdb pid
3 - start "linux root=<...> debug gdb-pid=<pid>"  
(the execution of linux stops very early)

4 - in gdb: do an "att 1" 
(gdb attaches to linux, and I can check breakpoints, list code, etc,
exactly as spawning an xterm + gdb.)

5 - in gdb: "c" to continue linux.

///////////////////////////////////

Back to my original problem: using ddd, with both "debug" or
"debug=parent" options the result is always this:

GNU DDD 3.3.1 (i686-pc-linux-gnu), by Dorothea L(gdb) run
ubd0=../Debian-3.0r0.ext2 debug gdb-pid=7343
Program received signal SIGTRAP, Trace/breakpoint trap.
0xa000b000 in _start () at af_packet.c:1900
/root/linux-2.4.24/net/packet/af_packet.c:1900:42852:beg:0xa000b000
(gdb) att 1
ptrace: Operation not permitted.
(gdb) c
The program is not being run.

///////////////////////////////////

A variation is that, if I don't try to "att 1", and do only "c" instead,
gives this result:

GNU DDD 3.3.1 (i686-pc-linux-gnu), by Dorothea L(gdb) run
ubd0=../Debian-3.0r0.ext2 debug gdb-pid=20877
Program received signal SIGTRAP, Trace/breakpoint trap.
0xa000b000 in _start () at af_packet.c:1900
/root/linux-2.4.24/net/packet/af_packet.c:1900:42852:beg:0xa000b000
(gdb) c
Checking for the skas3 patch in the host...not found
Checking for /proc/mm...not found
tracing thread pid = 20884
^C^C^C
<no response from uml linux>

As it can be seen, linux continues to boot, but hangs, and ddd's gdb
can't attach to it. In this situation, after closing ddd, it remains 2
linux and 1 gdb processes that must be killed with "killall -9 linux"

////////////////////////////////////

To be completely sure, I've started all over again, with the simplest
environment that I could do to check this problem:
1 - get linux 2.4.24
2 - patch it with uml-2.4.24-1
3 - compile it
4 - install latest uml_tools
5 - run "ddd linux"
6 - run program with options "udb0=<...> debug gdb-pid=<pid>"

In this situation, I would ask very politely if someone who have ddd
working to help me, possibly by recreating this simple environment, as
I'm totally stuck.

Thanks, 
Pedro Estrela



> > 1 - started "ddd linux" on the host
> > 2 - i've noted the gdb pid that ddd swapned
> > 3 - started program with arguments: "root=<my-root-fs> debug=parent
gdb-
> pid=<pid>"
> 
> Try with just
> 
>   root=<rootfs> debug gdb-pid=<pid>
> 
> Also try the same on a stand-alone GDB.
> 
> Regards
> Henrik





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
