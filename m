Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BBEwK-0003vM-Ks for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 08:26:08 -0700
Received: from catarina.tagus.ist.utl.pt ([193.136.166.72]
	helo=mail.tagus.ist.utl.pt)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BBEwK-0005to-0a
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Apr 2004 08:26:08 -0700
Reply-To: <pedro.estrela@inesc.pt>
From: "Pedro Estrela" <pedro.estrela@inesc.pt>
Subject: RE: [uml-devel] DDD 3.3.1 + UML_2.4.24 - can't debug
Message-ID: <001901c41cb4$9c071f60$902914ac@tagus.ist.utl.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0404071632190.27412-100000@filer.marasystems.com>
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
Date: Wed, 7 Apr 2004 16:25:46 +0100
To: user-mode-linux-devel@lists.sourceforge.net, 'Henrik Nordstrom' <uml@henrik.marasystems.com>
Cc: 'Pedro Estrela' <pedro.estrela@tagus.ist.utl.pt>

Thanks again for your help!

> > Back to my original problem: using ddd, with both "debug" or
> > "debug=parent" options the result is always this:
> > GNU DDD 3.3.1 (i686-pc-linux-gnu), by Dorothea L(gdb) run
> > ubd0=../Debian-3.0r0.ext2 debug gdb-pid=7343
> > Program received signal SIGTRAP, Trace/breakpoint trap.
> > 0xa000b000 in _start () at af_packet.c:1900
> > /root/linux-2.4.24/net/packet/af_packet.c:1900:42852:beg:0xa000b000
> > (gdb) att 1
> > ptrace: Operation not permitted.
> > (gdb) c
> > The program is not being run.
> 
> And you are positively sure 7343 is the pid of the gdb process below
ddd
> and not the pid of ddd or another process on your system?

Yes, I've triple checked several times on that. I've also checked on two
different environments (Debian 3.0 without root access, RH80 with root
access) and the results are always these explained on my emails.

> > In this situation, I would ask very politely if someone who have ddd
> > working to help me, possibly by recreating this simple environment,
as
> > I'm totally stuck.
> 
> ddd seems to work here with debug=parent gdb-pid=<pid-of-gdb>
> 
> it does not work with debug gdb-pid=<pid-of-gdb>. If I use this then
the
> gdb subprocess gets killed... (defunct in ps listing)
This kind of behaviour has never happened to me.

> This is on a RH7.3 kind of host with ddd-3.3.1-13. Linux-2.4.26-rc2
UML
> kernel (2.4.24-um1 patch I think.. current CVS tree of UML).
I have linux 2.4.24 + uml 2.4.24-1 (from download page) + ddd 3.3.1

As such, I would ask anyone for a brief help; I'm getting nuts with this
subject: Please download these components, and verify the
success/insuccess of DDD + UML.

Best Regards
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
