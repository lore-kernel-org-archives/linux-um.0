Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GhCXu-00008t-8J for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 14:02:22 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GhCXs-00034E-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 14:02:22 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GhCXT-0002SC-Ul for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Nov 2006 23:01:55 +0100
Received: from dhcp65-62.ietf67.org ([130.129.65.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 23:01:55 +0100
Received: from mcr by dhcp65-62.ietf67.org with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 06 Nov 2006 23:01:55 +0100
From: Michael Richardson <mcr@sandelman.ca>
Date: Mon, 06 Nov 2006 14:01:20 -0800
Message-ID: <eiobbh$oq4$1@sea.gmane.org>
References: <eilvlj$b5r$1@sea.gmane.org> <eioacp$m4r$1@sea.gmane.org>
Mime-Version: 1.0
In-Reply-To: <eioacp$m4r$1@sea.gmane.org>
Subject: Re: [uml-devel] problems with ifup-a on etch compiled kernels
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Michael Richardson wrote:
> in uml_inetaddr_event.
> 
> sure enough, ifa->ifa_dev was NULL. Naturally, if I run things manually, or under GDB, it fails.
> Furthermore, this happens with 2.6.15 and 2.6.17.13 (patched to compile on etch), and
> with 2.6.19-rc3 (which I'm using as my debug base).  I tried with gcc-3.3 and with gcc-4.1.2.

On a hunch, I replaced /sbin/ifup in my UML tree with the one from etch.
ifup-a finishes now, but:

Configuring network interfaces: + ifup -a
ifup: failed to open statefile /etc/network/run/ifstate: No such file or directory
+ echo done.
done.
+ exit 0
Cleaning: /tmp /var/lock Trying to vfree() bad address (08978f40)
BUG: warning at mm/vmalloc.c:322/__vunmap()
0839bd04:  [<0805def2>] dump_stack+0x22/0x30
0839bd1c:  [<080b5d29>] __vunmap+0xb9/0x150
0839bd3c:  [<080b5dee>] vfree+0x2e/0x70
0839bd58:  [<080b6000>] __vmalloc_area_node+0x110/0x170
0839bd84:  [<080b60f6>] __vmalloc_node+0x66/0x70
0839bda0:  [<080b6128>] __vmalloc+0x28/0x30
0839bdb8:  [<080b6153>] vmalloc+0x23/0x30
0839bdcc:  [<0805ca61>] um_vmalloc+0x11/0x20
0839bdd8:  [<0806e278>] __wrap_malloc+0x38/0x60
0839bde8:  [<081cbaac>] __opendir+0xbc/0x120
0839be70:  [<081117a2>] open_dir+0x12/0x30
0839be80:  [<0811007b>] hostfs_readdir+0x3b/0xf0
0839becc:  [<080ce584>] vfs_readdir+0x74/0x90
0839bef0:  [<080cebf4>] sys_getdents64+0x84/0x110
0839bf28:  [<08060542>] handle_syscall+0x92/0xc0
0839bf7c:  [<08073a92>] userspace+0x202/0x370
0839bfe4:  [<080601b4>] fork_handler+0x74/0x90
0839bffc:  [<00352025>] 0x352025


> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?

I am not adding that. Maybe gmane.org or sf.net is doing that?
sf.net, I guess.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
