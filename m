Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <berrange@redhat.com>) id 1KqRgJ-0000r3-Nd
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Oct 2008 12:10:19 +0000
Received: from mx1.redhat.com ([66.187.233.31])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KqRgB-0001Hx-Qx for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Oct 2008 12:10:19 +0000
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com
	[172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m9GBoD7s027896
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Oct 2008 07:50:13 -0400
Received: from file.fab.redhat.com (file.fab.redhat.com [10.33.63.6])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m9GBoC1k011549
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Oct 2008 07:50:12 -0400
Received: from file.fab.redhat.com (localhost.localdomain [127.0.0.1])
	by file.fab.redhat.com (8.13.1/8.13.1) with ESMTP id m9GBoCmC016351
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 16 Oct 2008 12:50:12 +0100
Received: (from berrange@localhost)
	by file.fab.redhat.com (8.13.1/8.13.1/Submit) id m9GBoC6h016347
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Oct 2008 12:50:12 +0100
Date: Thu, 16 Oct 2008 12:50:12 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20081016115012.GK27881@redhat.com>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [FW: [libvirt] PATCH: Experimental User Mode Linux
	driver for libvirt]
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Support for User Mode Linux in libvirt[1] may be of interest to people
on this list.

Regards,
Daniel

[1] http://libvirt.org/

----- Forwarded message from "Daniel P. Berrange" <berrange@redhat.com> -----

> Date: Thu, 16 Oct 2008 12:42:17 +0100
> From: "Daniel P. Berrange" <berrange@redhat.com>
> To: libvir-list@redhat.com
> Cc: jdike@karaya.com
> Subject: [libvirt] PATCH: Experimental User Mode Linux driver for libvirt
> 
> This patch implements a driver supporting User Mode Linux guests. User mode
> linux is a kind of paravirtualized kernel which runs on a plain Linux host.
> It requires no elevated privileges at all, except for some of the network
> integration. It is a pretty straightforward thing to invoke, so I figured
> it would be easy to write a driver to support it. I was right :-)
> 
> As with the QEMU driver, there are two styles of invocation
> 
>   uml:///system  - a single privileged, per host driver instance as root
>   uml:///session - a per-user unprivileged instance
> 
> The user mode linux docs recommend against running as root, so naturally
> I recommend use of uml:///session, though my testing is so far with
> uml:///system.
> 
> It supports the bare minimum  neccessary for a libvirt driver, namely start,
> stop, define, create, destroy, undefine against domains. For configuration
> it supports setting of memory limit, virtual disk devices, and paravirt
> console devices - good enough to get 'virsh console' working over a PTY,
> and dump XML config.
> 
> Like QEMU, UML has an admin monitor console. It is a little different
> though, using a UNIX domain socket, in datagram mode, sending command
> strings back & forth. This actaully makes it a little easier to deal
> with in libvirt. User mode linux has a uml_mconsole command line tool
> to interact with it, but I directly implement the socket support in
> libvirt instead, so this driver does not (yet) have any dependancy on
> the UML utilities.
> 
> The driver is largely a clone of the QEMU driver, replacing the bit which
> builds the command line argv, and all code dealing with the QEMU monitor.
> Since the monitor socket is datagram based, we can't make use of it for
> detecting VM shutdown  as we do with QEMU/LXC. So instead, I make use of
> inotify, to monitor $HOME/.uml which is populated witha directory for
> each VM. When we see a directory created, libvirt marks the corresponding
> VM as running, finds it PID & probes the monitor for the PTY config. When
> we see a directory deleted, libvirt makes the VM as shutoff and frees any
> resources its holding. This actually works very nicely & simply.
> 
> An example config I'm using for testing is
> 
> <domain type='uml'>
>   <name>demo</name>
>   <uuid>b4433fc2-a22e-ffb3-0a3d-9c173b395800</uuid>
>   <memory>500000</memory>
>   <os>
>     <type arch='x86_64'>uml</type>
>     <kernel>/home/berrange/linux</kernel>
>   </os>
>   <devices>
>     <disk type='file' device='disk'>
>       <source file='/home/berrange/FedoraCore6-AMD64-root_fs'/>
>       <target dev='ubd0' bus='uml'/>
>     </disk>
>     <console type='pty'>
>        <target port='0'/>
>     </console>
>     <serial type='tcp'>
>        <source mode='bind' host='localhost' service='9000'/>
>        <target port='0'/>
>     </serial>
>     <serial type='pty'>
>        <target port='3'/>
>     </serial>
>   </devices>
> </domain>
> 
> The user mode linux kernel, has the device emulator built-in, so there's no
> need to specify the device emulator path explicitly. The kernel I built
> straight from latest 2.6.27 sources, and the root filesystem I downloaded
> from the UML website. I've been testing with latest libvirt CVS, on  a
> Fedora 9 x86_64 host.
> 
> If you save that config to a file 'demo.xml', you ought to be able todo
> 
>    virsh --connect uml:///system define demo.xml
>    virsh --connect uml:///system start demo
>    virsh --connect uml:///system console demo
> 
> Though  there is still a small race whereby we can ask for the PTY device
> before its been created, causing console to fail.
> 
> If things go wrong /var/log/libvirt/uml/$NAME.log contains log messages,
> The configuration is stored in /etc/libvirt/uml/$NAME.xml, or in
> $HOME/.libvirt/uml/$NAME.xml, and you can also query stuff with mconsole
> by doing  'uml_mconsole $NAME'
> 
> This isn't quite ready to merge, but I thought I'd send it here to make
> people aware of it.
> 
>  configure.in                |    8 
>  include/libvirt/virterror.h |    1 
>  src/Makefile.am             |    9 
>  src/domain_conf.c           |   47 -
>  src/domain_conf.h           |    1 
>  src/driver.h                |    3 
>  src/libvirt.c               |    6 
>  src/qemu_conf.c             |    3 
>  src/remote_internal.c       |   16 
>  src/uml_conf.c              |  404 ++++++++++
>  src/uml_conf.h              |   72 +
>  src/uml_driver.c            | 1771 ++++++++++++++++++++++++++++++++++++++++++++
>  src/uml_driver.h            |   34 
>  src/virterror.c             |    4 
>  14 files changed, 2355 insertions(+), 24 deletions(-)
> 
> 
> Daniel
----- End forwarded message -----

-- 
|: Red Hat, Engineering, London   -o-   http://people.redhat.com/berrange/ :|
|: http://libvirt.org  -o-  http://virt-manager.org  -o-  http://ovirt.org :|
|: http://autobuild.org       -o-         http://search.cpan.org/~danberr/ :|
|: GnuPG: 7D3B9505  -o-  F3C9 553F A1DA 4AC2 5648 23C1 B3DF F742 7D3B 9505 :|

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
