Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cx2EI-0002vr-Ac for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:06:30 -0800
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1Cx2EH-0003LO-2e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 04:06:30 -0800
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Cx2DO-0002tM-69 for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 04 Feb 2005 13:05:34 +0100
Received: from naked.iki.fi ([62.142.249.112])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Feb 2005 13:05:34 +0100
Received: from naked by naked.iki.fi with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 04 Feb 2005 13:05:34 +0100
From: Nuutti Kotivuori <naked@iki.fi>
Message-ID: <87hdks5y35.fsf@aka.i.naked.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Subject: [uml-devel] UML tuntap driver problem with queueing
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
Date: Fri, 04 Feb 2005 14:06:06 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org

--=-=-=

I will first briefly outline here how tun/tap device queueing works.

Each tap device has two ends - one is the network device lookalike
'tap0' and the other is the fd received by opening '/dev/net/tun' and
running some ioctls. With UML, the host kernel has the 'tap0' device
and the UML process opens up '/dev/net/tun' side, showing it as 'eth0'
inside the UML kernel. Right now, we are only interested in how
packets travel from the host to the guest, eg. packets sent to the
'tap0' device travelling to the UML kernel.

There are two queues involved in this process. One is the normal
network device send queue attached to the 'tap0'. It can be
manipulated by the QoS tools, like 'tc'. I will call this
'txqueue'. The other is an internal queue of the tun/tap driver, an
skb queue, in the tun_struct as readq. I will call this simply
'readq'.

There are two alternatives on how packets are queued, controlled by
IFF_ONE_QUEUE flag when creating the tap device. The default is that
IFF_ONE_QUEUE is off. In that case, packets are first queued to the
'readq'. When 'readq' grows to 10 packets, netif_stop_queue is called
on the device, which causes the 'txqueue' to start accumulating the
following packets. When packets are read from the fd side, the queue
is started again, which starts filling 'readq' again. So, this
alternative should keep the queue mostly on the device side and allow
normal QoS routines to handle packet dropping and such.

The other alternative, when IFF_ONE_QUEUE is set, uses just a single
queue. Packets are queued to 'readq' always, the net device queue is
never stopped. If 'readq' grows to the interface 'txqueuelen', packets
are simply tail dropped. This means that the normal QoS tools cannot
affect how packets are dropped and the packet queue is 'hidden' inside
the kernel as there is no simple way to see it.

Now, here comes the actual bug report.

If the UML kernel is sent more packets than it can handle, and
IFF_ONE_QUEUE is not set (as it isn't by default), packets first fill
the 'readq' and then start amassing at 'txqueue', as they should. But
when no more packets are being sent, the queue does not start growing
smaller. If no packets are sent to the device, the queue stays there
indefinitely. When single packets are sent, the queue always decreases
by 10 packets (so 11 packets in total arrive on the guest side).

If I understood correctly from the code, UML uses SIGIO to trigger
packet reading. So, either SIGIO is not delivered properly in the case
of the two queues - or UML's SIGIO handling is broken.

If IFF_ONE_QUEUE is set, everything works fine, packets are delivered
in a timely manner and queue is never stalled.

As a workaround to the problem, I've added the IFF_ONE_QUEUE option to
all the places that open a tap device (namely tunctl, uml_net and
uml_router). The patch is attached. But the actual problem should most
likely be fixed once found.

-- Naked

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=tuntap_one_queue.diff

Index: uml-utilities-20040406/uml_net/tuntap.c
===================================================================
--- uml-utilities-20040406.orig/uml_net/tuntap.c
+++ uml-utilities-20040406/uml_net/tuntap.c
@@ -44,7 +44,7 @@
     return(-1);
   }
   memset(ifr, 0, sizeof(*ifr));
-  ifr->ifr_flags = IFF_TAP | IFF_NO_PI;
+  ifr->ifr_flags = IFF_TAP | IFF_NO_PI | IFF_ONE_QUEUE;
   ifr->ifr_name[0] = '\0';
   if(ioctl(tap_fd, TUNSETIFF, (void *) ifr) < 0){
     output_errno(output, "TUNSETIFF : ");
Index: uml-utilities-20040406/tunctl/tunctl.c
===================================================================
--- uml-utilities-20040406.orig/tunctl/tunctl.c
+++ uml-utilities-20040406/tunctl/tunctl.c
@@ -81,7 +81,7 @@
 
   memset(&ifr, 0, sizeof(ifr));
 
-  ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+  ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_ONE_QUEUE;
   strncpy(ifr.ifr_name, tun, sizeof(ifr.ifr_name) - 1);
   if(ioctl(tap_fd, TUNSETIFF, (void *) &ifr) < 0){
     perror("TUNSETIFF");
Index: uml-utilities-20040406/uml_router/tuntap.c
===================================================================
--- uml-utilities-20040406.orig/uml_router/tuntap.c
+++ uml-utilities-20040406/uml_router/tuntap.c
@@ -28,7 +28,7 @@
     return(-1);
   }
   memset(&ifr, 0, sizeof(ifr));
-  ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+  ifr.ifr_flags = IFF_TAP | IFF_NO_PI | IFF_ONE_QUEUE;
   strncpy(ifr.ifr_name, dev, sizeof(ifr.ifr_name) - 1);
   if(ioctl(fd, TUNSETIFF, (void *) &ifr) < 0){
     perror("TUNSETIFF failed");

--=-=-=--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
