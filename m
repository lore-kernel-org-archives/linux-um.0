Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BB1ZI-0003Bu-5u for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 18:09:28 -0700
Received: from beatriz.tagus.ist.utl.pt ([193.136.166.71]
	helo=mail.tagus.ist.utl.pt)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BB1ZH-0004xn-Ff
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 06 Apr 2004 18:09:27 -0700
Received: from unknown (HELO localhost) ([172.20.11.20])
	(envelope-sender <pedro.estrela@tagus.ist.utl.pt>)
	by mail.tagus.ist.utl.pt (qmail-ldap-1.03) with SMTP
	for <user-mode-linux-devel@lists.sourceforge.net>;
	7 Apr 2004 01:09:18 -0000
From: Pedro Estrela <pedro.estrela@tagus.ist.utl.pt>
Reply-To: pedro.estrela@tagus.ist.utl.pt
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Message-ID: <E1BB1ZH-0004xn-Ff@sc8-sf-mx1.sourceforge.net>
Subject: [uml-devel] DDD 3.3.1 + UML_2.4.24 - can't debug
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
Date: Wed,  7 Apr 2004 02:09:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: pedro.estrela@inesc.pt



Hello All,

I'm getting a very strange problem trying to debug UML under DDD.

I'm running uml linux in a host system (Debian Woody 3.0) which i don't have root access.

For the guest, i'm running linux-2.4.24 + uml-patch-2.4.24-1 + uml_utilities_20040114. As i don't have root on the host, I've changed the location of the port_helper library, as it is decribed in (https://wiki.clusterfs.com/lustre/LustreUML).

With these steps, i can debug the kernel and its modules exactly as it is said using plain gdb. It succesfully spawns a xterm, where a gdb lives that can control the kernel and its modules.



The problem is using ddd (version 3.3.1) to debug the kernel. I've done step by step as it is explaned in 
http://user-mode-linux.sourceforge.net/debugging.html:

1 - started "ddd linux" on the host
2 - i've noted the gdb pid that ddd swapned
3 - started program with arguments: "root=<my-root-fs> debug=parent gdb-pid=<pid>"

4- then, the program stops at af_packet.c:9000; gdb inside ddd gives this output:

...
run ubd0=../../uml/Debian-3.0r0.ext2 debug=parent gdb-pid=24953
Program received signal SIGTRAP, Trace/breakpoint trap.
0xa000c000 in _start () at af_packet.c:1900
home/pmsrve/dccp/work/linux-2.4.24/net/packet/af_packet.c:1900:42852:beg:0xa000c000

5 - then tying to attach to an invalid thread gives this result:

(gdb) att 1
ptrace: Operation not permitted.
(gdb) c
The program is not being run.
(gdb) 



I've tryed several other combinations, but the results are always these depicted above.
Do anyone can run UML with DDD? any insight will be most appreciated!

Thanks,
Pedro Estrela








-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
