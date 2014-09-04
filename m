Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcGt-0008Cp-HN
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:39 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XPcGs-0000pG-0y
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:00:39 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab3.miniserver.com with esmtps
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcG4-0001cn-J5
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 18:59:48 +0000
Received: from [192.168.3.80] (helo=MonstrousNightmare.cisco.com)
	by falkor.sigsegv.cx with esmtp (Exim 4.80)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XPcGk-0007Ns-6W
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 20:00:30 +0100
From: anton.ivanov@kot-begemot.co.uk
Date: Thu,  4 Sep 2014 20:00:17 +0100
Message-Id: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] UML Performance improvement patchset
To: user-mode-linux-devel@lists.sourceforge.net


Patch dependencies:

[PATCH v3 01/10] Epoll based interrupt controller

Full redesign of the existing UML poll based controller. The old
poll controller incurs huge penalties for IRQ sharing and many devices
setup due to the device list being walked twice.

Additionally, the current controller has no notion of true Edge, 
Level and Write completion IRQs. 

This patch fixes the list walking bottleneck and adds all of 
the above alowing for UML to be scaled to 100s of devices 
(tested with 512+ network devices).

[PATCH v3 02/10] Remove unnecessary 'reactivate' statements

As a result of adding true Edge/Level semantics in the epoll 
controller there is no need to do the "reactivate fd" any more.

This one is an enhancement of 1 and depends on it.

[PATCH v3 03/10] High performance networking subsystem

This patchset adds vector IO ops for xmit and receive. Xmit
is optional (as it depends on a 3.0+ host), receive is always on.

The result is that UML can now hit 1G+ rates for transports
which have been enabled to use these. Presently this patchset
is kept as "legacy" as possible without leveraging the possibility
to do a true write completion poll from the new IRQ controller. 
This further performance improvement will be submitted separately.

This patch has been tested extensively only with patchsets 1 and 2.

[PATCH v3 04/10] L2TPv3 Transport Driver for UML

This is an implementation of the Ethernet over L2TPv3 protocol
leveraging both the epoll controller and the high perf vector IO.
It has been extensively tested to interop versus a set of
other implementations including Linux kernel, our port of the
same concept to QEMU/KVM, routers, etc.

Depends on 3.

[PATCH v3 05/10] GRE transport for UML

Same as L2TPv3 for GRE. Depends on 3

[PATCH v3 06/10] RAW Ethernet transport for UML

True raw driver (note - all TSO/GSO options in the NIC must
be turned off). Breaks through the 1G barrier with a vengeance
and CPU to spare. Depends on 3.

[PATCH v3 07/10] Performance and NUMA improvements for ubd

This is a well known issue/fix, qemu has the same one. If you 
do not use pwrite you can kill a machine on cache sync with 
ease. This patch is independent of the others.

[PATCH v3 08/10] Minor performance optimization for ubd

Obvious minor optimization, independent of the others.

[PATCH v3 09/10] Better IPC for UBD

Obvious optimization, independent of the others. Pipe has a 
very short queue which has 4k granularity. It is a bad IPC
for passing a lot of small chunks one at a time as used in UBD.

[PATCH v3 10/10] High Resolution Timer subsystem for UML

This version of the patch applies only to the epoll controller. 
Otherwise, the patch with minimal modifications can be applied to
stock UML. It fixes UML as far as its use for network appliance 
on all counts - TCP performance, QoS, traffic shaping, etc.

The patch is not pretty (I would have preferred to kill itimer
completely). It however does what it says on the tin and has been
doing it in testing for 2 years or so now.

Enjoy

--

A.R. Ivanov

anton.ivanov@kot-begemot.co.uk
antivano@cisco.com


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

