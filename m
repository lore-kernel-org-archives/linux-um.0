Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBERM-0004nh-GI for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 07:54:08 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBERL-0006VH-VS for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 07:54:08 -0700
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: RE: [uml-devel] DDD 3.3.1 + UML_2.4.24 - can't debug
In-Reply-To: <000901c41cac$a14ae810$902914ac@tagus.ist.utl.pt>
Message-ID: <Pine.LNX.4.44.0404071632190.27412-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Wed, 7 Apr 2004 16:54:04 +0200 (CEST)
To: Pedro Estrela <pedro.estrela@inesc.pt>
Cc: user-mode-linux-devel@lists.sourceforge.net, 'Henrik Nordstrom' <uml@henrik.marasystems.com>, 'Pedro Estrela' <pedro.estrela@tagus.ist.utl.pt>

On Wed, 7 Apr 2004, Pedro Estrela wrote:

> Back to my original problem: using ddd, with both "debug" or
> "debug=parent" options the result is always this:
> 
> GNU DDD 3.3.1 (i686-pc-linux-gnu), by Dorothea L(gdb) run
> ubd0=../Debian-3.0r0.ext2 debug gdb-pid=7343
> Program received signal SIGTRAP, Trace/breakpoint trap.
> 0xa000b000 in _start () at af_packet.c:1900
> /root/linux-2.4.24/net/packet/af_packet.c:1900:42852:beg:0xa000b000
> (gdb) att 1
> ptrace: Operation not permitted.
> (gdb) c
> The program is not being run.

And you are positively sure 7343 is the pid of the gdb process below ddd 
and not the pid of ddd or another process on your system?

> In this situation, I would ask very politely if someone who have ddd
> working to help me, possibly by recreating this simple environment, as
> I'm totally stuck.

ddd seems to work here with debug=parent gdb-pid=<pid-of-gdb>

it does not work with debug gdb-pid=<pid-of-gdb>. If I use this then the 
gdb subprocess gets killed... (defunct in ps listing)

I don't know why "debug=parent" would be needed, but I guess there is some 
good reason to this.

This is on a RH7.3 kind of host with ddd-3.3.1-13. Linux-2.4.26-rc2 UML 
kernel (2.4.24-um1 patch I think.. current CVS tree of UML).

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
