Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Fri, 12 Aug 2011 02:28:23 +0200
Message-Id: <1313108903-7351-1-git-send-email-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: [PATCH] UserModeLinux-HOWTO.txt: remove ^H characters
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Randy Dunlap <rdunlap@xenotime.net>, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If you can't read this patch, please run:

	sed -i -e "s/[^\o10]\o10//g" \
		Documentation/virtual/uml/UserModeLinux-HOWTO.txt

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
---
 Documentation/virtual/uml/UserModeLinux-HOWTO.txt |  530 ++++++++++---=
-------
 1 files changed, 265 insertions(+), 265 deletions(-)

diff --git a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt b/Docume=
ntation/virtual/uml/UserModeLinux-HOWTO.txt
index 5d0fc8b..a7af9cf 100644
--- a/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
+++ b/Documentation/virtual/uml/UserModeLinux-HOWTO.txt
@@ -134,13 +134,13 @@
=20
   ____________________________________________________________________=
__
=20
-  1=081.=08.  I=08In=08nt=08tr=08ro=08od=08du=08uc=08ct=08ti=08io=08on=
=08n
+  1.  Introduction
=20
   Welcome to User Mode Linux.  It's going to be fun.
=20
=20
=20
-  1=081.=08.1=081.=08.  H=08Ho=08ow=08w i=08is=08s U=08Us=08se=08er=08=
r M=08Mo=08od=08de=08e L=08Li=08in=08nu=08ux=08x D=08Di=08if=08ff=08fe=08=
er=08re=08en=08nt=08t?=08?
+  1.1.  How is User Mode Linux Different?
=20
   Normally, the Linux Kernel talks straight to your hardware (video
   card, keyboard, hard drives, etc), and any programs which run ask th=
e
@@ -181,7 +181,7 @@
=20
=20
=20
-  1=081.=08.2=082.=08.  W=08Wh=08hy=08y W=08Wo=08ou=08ul=08ld=08d I=08=
I W=08Wa=08an=08nt=08t U=08Us=08se=08er=08r M=08Mo=08od=08de=08e L=08Li=
=08in=08nu=08ux=08x?=08?
+  1.2.  Why Would I Want User Mode Linux?
=20
=20
   1. If User Mode Linux crashes, your host kernel is still fine.
@@ -206,12 +206,12 @@
=20
=20
=20
-  2=082.=08.  C=08Co=08om=08mp=08pi=08il=08li=08in=08ng=08g t=08th=08h=
e=08e k=08ke=08er=08rn=08ne=08el=08l a=08an=08nd=08d m=08mo=08od=08du=08=
ul=08le=08es=08s
+  2.  Compiling the kernel and modules
=20
=20
=20
=20
-  2=082.=08.1=081.=08.  C=08Co=08om=08mp=08pi=08il=08li=08in=08ng=08g =
t=08th=08he=08e k=08ke=08er=08rn=08ne=08el=08l
+  2.1.  Compiling the kernel
=20
=20
   Compiling the user mode kernel is just like compiling any other
@@ -322,7 +322,7 @@
   bug fixes and enhancements that have gone into subsequent releases.
=20
=20
-  2=082.=08.2=082.=08.  C=08Co=08om=08mp=08pi=08il=08li=08in=08ng=08g =
a=08an=08nd=08d i=08in=08ns=08st=08ta=08al=08ll=08li=08in=08ng=08g k=08=
ke=08er=08rn=08ne=08el=08l m=08mo=08od=08du=08ul=08le=08es=08s
+  2.2.  Compiling and installing kernel modules
=20
   UML modules are built in the same way as the native kernel (with the
   exception of the 'ARCH=3Dum' that you always need for UML):
@@ -386,19 +386,19 @@
=20
=20
=20
-  2=082.=08.3=083.=08.  C=08Co=08om=08mp=08pi=08il=08li=08in=08ng=08g =
a=08an=08nd=08d i=08in=08ns=08st=08ta=08al=08ll=08li=08in=08ng=08g u=08=
um=08ml=08l_=08_u=08ut=08ti=08il=08li=08it=08ti=08ie=08es=08s
+  2.3.  Compiling and installing uml_utilities
=20
   Many features of the UML kernel require a user-space helper program,
   so a uml_utilities package is distributed separately from the kernel
   patch which provides these helpers. Included within this is:
=20
-  +=08o  port-helper - Used by consoles which connect to xterms or por=
ts
+  o  port-helper - Used by consoles which connect to xterms or ports
=20
-  +=08o  tunctl - Configuration tool to create and delete tap devices
+  o  tunctl - Configuration tool to create and delete tap devices
=20
-  +=08o  uml_net - Setuid binary for automatic tap device configuratio=
n
+  o  uml_net - Setuid binary for automatic tap device configuration
=20
-  +=08o  uml_switch - User-space virtual switch required for daemon
+  o  uml_switch - User-space virtual switch required for daemon
      transport
=20
      The uml_utilities tree is compiled with:
@@ -423,11 +423,11 @@
=20
=20
=20
-  3=083.=08.  R=08Ru=08un=08nn=08ni=08in=08ng=08g U=08UM=08ML=08L a=08=
an=08nd=08d l=08lo=08og=08gg=08gi=08in=08ng=08g i=08in=08n
+  3.  Running UML and logging in
=20
=20
=20
-  3=083.=08.1=081.=08.  R=08Ru=08un=08nn=08ni=08in=08ng=08g U=08UM=08M=
L=08L
+  3.1.  Running UML
=20
   It runs on 2.2.15 or later, and all 2.4 kernels.
=20
@@ -454,7 +454,7 @@
=20
=20
=20
-  3=083.=08.2=082.=08.  L=08Lo=08og=08gg=08gi=08in=08ng=08g i=08in=08n
+  3.2.  Logging in
=20
=20
=20
@@ -468,7 +468,7 @@
=20
   There are a couple of other ways to log in:
=20
-  +=08o  On a virtual console
+  o  On a virtual console
=20
=20
=20
@@ -480,7 +480,7 @@
=20
=20
=20
-  +=08o  Over the serial line
+  o  Over the serial line
=20
=20
      In the boot output, find a line that looks like:
@@ -503,7 +503,7 @@
=20
=20
=20
-  +=08o  Over the net
+  o  Over the net
=20
=20
      If the network is running, then you can telnet to the virtual
@@ -514,13 +514,13 @@
   down and the process will exit.
=20
=20
-  3=083.=08.3=083.=08.  E=08Ex=08xa=08am=08mp=08pl=08le=08es=08s
+  3.3.  Examples
=20
   Here are some examples of UML in action:
=20
-  +=08o  A login session <http://user-mode-linux.sourceforge.net/login=
=2Ehtml>
+  o  A login session <http://user-mode-linux.sourceforge.net/login.htm=
l>
=20
-  +=08o  A virtual network <http://user-mode-linux.sourceforge.net/net=
=2Ehtml>
+  o  A virtual network <http://user-mode-linux.sourceforge.net/net.htm=
l>
=20
=20
=20
@@ -528,12 +528,12 @@
=20
=20
=20
-  4=084.=08.  U=08UM=08ML=08L o=08on=08n 2=082G=08G/=08/2=082G=08G h=08=
ho=08os=08st=08ts=08s
+  4.  UML on 2G/2G hosts
=20
=20
=20
=20
-  4=084.=08.1=081.=08.  I=08In=08nt=08tr=08ro=08od=08du=08uc=08ct=08ti=
=08io=08on=08n
+  4.1.  Introduction
=20
=20
   Most Linux machines are configured so that the kernel occupies the
@@ -546,7 +546,7 @@
=20
=20
=20
-  4=084.=08.2=082.=08.  T=08Th=08he=08e p=08pr=08ro=08ob=08bl=08le=08e=
m=08m
+  4.2.  The problem
=20
=20
   The prebuilt UML binaries on this site will not run on 2G/2G hosts
@@ -558,7 +558,7 @@
=20
=20
=20
-  4=084.=08.3=083.=08.  T=08Th=08he=08e s=08so=08ol=08lu=08ut=08ti=08i=
o=08on=08n
+  4.3.  The solution
=20
=20
   The fix for this is to rebuild UML from source after enabling
@@ -576,7 +576,7 @@
=20
=20
=20
-  5=085.=08.  S=08Se=08et=08tt=08ti=08in=08ng=08g u=08up=08p s=08se=08=
er=08ri=08ia=08al=08l l=08li=08in=08ne=08es=08s a=08an=08nd=08d c=08co=08=
on=08ns=08so=08ol=08le=08es=08s
+  5.  Setting up serial lines and consoles
=20
=20
   It is possible to attach UML serial lines and consoles to many types
@@ -586,12 +586,12 @@
   You can attach them to host ptys, ttys, file descriptors, and ports.
   This allows you to do things like
=20
-  +=08o  have a UML console appear on an unused host console,
+  o  have a UML console appear on an unused host console,
=20
-  +=08o  hook two virtual machines together by having one attach to a =
pty
+  o  hook two virtual machines together by having one attach to a pty
      and having the other attach to the corresponding tty
=20
-  +=08o  make a virtual machine accessible from the net by attaching a
+  o  make a virtual machine accessible from the net by attaching a
      console to a port on the host.
=20
=20
@@ -599,7 +599,7 @@
=20
=20
=20
-  5=085.=08.1=081.=08.  S=08Sp=08pe=08ec=08ci=08if=08fy=08yi=08in=08ng=
=08g t=08th=08he=08e d=08de=08ev=08vi=08ic=08ce=08e
+  5.1.  Specifying the device
=20
   Devices are specified with "con" or "ssl" (console or serial line,
   respectively), optionally with a device number if you are talking
@@ -626,13 +626,13 @@
=20
=20
=20
-  5=085.=08.2=082.=08.  S=08Sp=08pe=08ec=08ci=08if=08fy=08yi=08in=08ng=
=08g t=08th=08he=08e c=08ch=08ha=08an=08nn=08ne=08el=08l
+  5.2.  Specifying the channel
=20
   There are a number of different types of channels to attach a UML
   device to, each with a different way of specifying exactly what to
   attach to.
=20
-  +=08o  pseudo-terminals - device=3Dpty pts terminals - device=3Dpts
+  o  pseudo-terminals - device=3Dpty pts terminals - device=3Dpts
=20
=20
      This will cause UML to allocate a free host pseudo-terminal for t=
he
@@ -640,20 +640,20 @@
      log.  You access it by attaching a terminal program to the
      corresponding tty:
=20
-  +=08o  screen /dev/pts/n
+  o  screen /dev/pts/n
=20
-  +=08o  screen /dev/ttyxx
+  o  screen /dev/ttyxx
=20
-  +=08o  minicom -o -p /dev/ttyxx - minicom seems not able to handle p=
ts
+  o  minicom -o -p /dev/ttyxx - minicom seems not able to handle pts
      devices
=20
-  +=08o  kermit - start it up, 'open' the device, then 'connect'
+  o  kermit - start it up, 'open' the device, then 'connect'
=20
=20
=20
=20
=20
-  +=08o  terminals - device=3Dtty:tty device file
+  o  terminals - device=3Dtty:tty device file
=20
=20
      This will make UML attach the device to the specified tty (i.e
@@ -672,7 +672,7 @@
=20
=20
=20
-  +=08o  xterms - device=3Dxterm
+  o  xterms - device=3Dxterm
=20
=20
      UML will run an xterm and the device will be attached to it.
@@ -681,7 +681,7 @@
=20
=20
=20
-  +=08o  Port - device=3Dport:port number
+  o  Port - device=3Dport:port number
=20
=20
      This will attach the UML devices to the specified host port.
@@ -725,7 +725,7 @@
=20
=20
=20
-  +=08o  already-existing file descriptors - device=3Dfile descriptor
+  o  already-existing file descriptors - device=3Dfile descriptor
=20
=20
      If you set up a file descriptor on the UML command line, you can
@@ -743,7 +743,7 @@
=20
=20
=20
-  +=08o  Nothing - device=3Dnull
+  o  Nothing - device=3Dnull
=20
=20
      This allows the device to be opened, in contrast to 'none', but
@@ -754,7 +754,7 @@
=20
=20
=20
-  +=08o  None - device=3Dnone
+  o  None - device=3Dnone
=20
=20
      This causes the device to disappear.
@@ -785,7 +785,7 @@
=20
=20
=20
-  5=085.=08.3=083.=08.  E=08Ex=08xa=08am=08mp=08pl=08le=08es=08s
+  5.3.  Examples
=20
   There are a number of interesting things you can do with this
   capability.
@@ -838,7 +838,7 @@
   prompt of the other virtual machine.
=20
=20
-  6=086.=08.  S=08Se=08et=08tt=08ti=08in=08ng=08g u=08up=08p t=08th=08=
he=08e n=08ne=08et=08tw=08wo=08or=08rk=08k
+  6.  Setting up the network
=20
=20
=20
@@ -858,19 +858,19 @@
   There are currently five transport types available for a UML virtual
   machine to exchange packets with other hosts:
=20
-  +=08o  ethertap
+  o  ethertap
=20
-  +=08o  TUN/TAP
+  o  TUN/TAP
=20
-  +=08o  Multicast
+  o  Multicast
=20
-  +=08o  a switch daemon
+  o  a switch daemon
=20
-  +=08o  slip
+  o  slip
=20
-  +=08o  slirp
+  o  slirp
=20
-  +=08o  pcap
+  o  pcap
=20
      The TUN/TAP, ethertap, slip, and slirp transports allow a UML
      instance to exchange packets with the host.  They may be directed
@@ -893,28 +893,28 @@
   With so many host transports, which one should you use?  Here's when
   you should use each one:
=20
-  +=08o  ethertap - if you want access to the host networking and it i=
s
+  o  ethertap - if you want access to the host networking and it is
      running 2.2
=20
-  +=08o  TUN/TAP - if you want access to the host networking and it is
+  o  TUN/TAP - if you want access to the host networking and it is
      running 2.4.  Also, the TUN/TAP transport is able to use a
      preconfigured device, allowing it to avoid using the setuid uml_n=
et
      helper, which is a security advantage.
=20
-  +=08o  Multicast - if you want a purely virtual network and you don'=
t want
+  o  Multicast - if you want a purely virtual network and you don't wa=
nt
      to set up anything but the UML
=20
-  +=08o  a switch daemon - if you want a purely virtual network and yo=
u
+  o  a switch daemon - if you want a purely virtual network and you
      don't mind running the daemon in order to get somewhat better
      performance
=20
-  +=08o  slip - there is no particular reason to run the slip backend =
unless
+  o  slip - there is no particular reason to run the slip backend unle=
ss
      ethertap and TUN/TAP are just not available for some reason
=20
-  +=08o  slirp - if you don't have root access on the host to setup
+  o  slirp - if you don't have root access on the host to setup
      networking, or if you don't want to allocate an IP to your UML
=20
-  +=08o  pcap - not much use for actual network connectivity, but grea=
t for
+  o  pcap - not much use for actual network connectivity, but great fo=
r
      monitoring traffic on the host
=20
      Ethertap is available on 2.4 and works fine.  TUN/TAP is preferre=
d
@@ -926,7 +926,7 @@
      exploit the helper's root privileges.
=20
=20
-  6=086.=08.1=081.=08.  G=08Ge=08en=08ne=08er=08ra=08al=08l s=08se=08e=
t=08tu=08up=08p
+  6.1.  General setup
=20
   First, you must have the virtual network enabled in your UML.  If ar=
e
   running a prebuilt kernel from this site, everything is already
@@ -995,7 +995,7 @@
=20
=20
=20
-  6=086.=08.2=082.=08.  U=08Us=08se=08er=08rs=08sp=08pa=08ac=08ce=08e =
d=08da=08ae=08em=08mo=08on=08ns=08s
+  6.2.  Userspace daemons
=20
   You will likely need the setuid helper, or the switch daemon, or bot=
h.
   They are both installed with the RPM and deb, so if you've installed
@@ -1011,7 +1011,7 @@
=20
=20
=20
-  6=086.=08.3=083.=08.  S=08Sp=08pe=08ec=08ci=08if=08fy=08yi=08in=08ng=
=08g e=08et=08th=08he=08er=08rn=08ne=08et=08t a=08ad=08dd=08dr=08re=08e=
s=08ss=08se=08es=08s
+  6.3.  Specifying ethernet addresses
=20
   Below, you will see that the TUN/TAP, ethertap, and daemon interface=
s
   allow you to specify hardware addresses for the virtual ethernet
@@ -1023,11 +1023,11 @@
   sufficient to guarantee a unique hardware address for the device.  A
   couple of exceptions are:
=20
-  +=08o  Another set of virtual ethernet devices are on the same netwo=
rk and
+  o  Another set of virtual ethernet devices are on the same network a=
nd
      they are assigned hardware addresses using a different scheme whi=
ch
      may conflict with the UML IP address-based scheme
=20
-  +=08o  You aren't going to use the device for IP networking, so you =
don't
+  o  You aren't going to use the device for IP networking, so you don'=
t
      assign the device an IP address
=20
      If you let the driver provide the hardware address, you should ma=
ke
@@ -1049,7 +1049,7 @@
=20
=20
=20
-  6=086.=08.4=084.=08.  U=08UM=08ML=08L i=08in=08nt=08te=08er=08rf=08f=
a=08ac=08ce=08e s=08se=08et=08tu=08up=08p
+  6.4.  UML interface setup
=20
   Once the network devices have been described on the command line, yo=
u
   should boot UML and log in.
@@ -1131,7 +1131,7 @@
=20
=20
=20
-  6=086.=08.5=085.=08.  M=08Mu=08ul=08lt=08ti=08ic=08ca=08as=08st=08t
+  6.5.  Multicast
=20
   The simplest way to set up a virtual network between multiple UMLs i=
s
   to use the mcast transport.  This was written by Harald Welte and is
@@ -1194,7 +1194,7 @@
=20
=20
=20
-  6=086.=08.6=086.=08.  T=08TU=08UN=08N/=08/T=08TA=08AP=08P w=08wi=08i=
t=08th=08h t=08th=08he=08e u=08um=08ml=08l_=08_n=08ne=08et=08t h=08he=08=
el=08lp=08pe=08er=08r
+  6.6.  TUN/TAP with the uml_net helper
=20
   TUN/TAP is the preferred mechanism on 2.4 to exchange packets with t=
he
   host.  The TUN/TAP backend has been in UML since 2.4.9-3um.
@@ -1247,10 +1247,10 @@
   There are a couple potential problems with running the TUN/TAP
   transport on a 2.4 host kernel
=20
-  +=08o  TUN/TAP seems not to work on 2.4.3 and earlier.  Upgrade the =
host
+  o  TUN/TAP seems not to work on 2.4.3 and earlier.  Upgrade the host
      kernel or use the ethertap transport.
=20
-  +=08o  With an upgraded kernel, TUN/TAP may fail with
+  o  With an upgraded kernel, TUN/TAP may fail with
=20
=20
        File descriptor in bad state
@@ -1269,7 +1269,7 @@
=20
=20
=20
-  6=086.=08.7=087.=08.  T=08TU=08UN=08N/=08/T=08TA=08AP=08P w=08wi=08i=
t=08th=08h a=08a p=08pr=08re=08ec=08co=08on=08nf=08fi=08ig=08gu=08ur=08=
re=08ed=08d t=08ta=08ap=08p d=08de=08ev=08vi=08ic=08ce=08e
+  6.7.  TUN/TAP with a preconfigured tap device
=20
   If you prefer not to have UML use uml_net (which is somewhat
   insecure), with UML 2.4.17-11, you can set up a TUN/TAP device
@@ -1277,7 +1277,7 @@
   there is no need for root assistance.  Setting up the device is done
   as follows:
=20
-  +=08o  Create the device with tunctl (available from the UML utiliti=
es
+  o  Create the device with tunctl (available from the UML utilities
      tarball)
=20
=20
@@ -1291,7 +1291,7 @@
   where uid is the user id or username that UML will be run as.  This
   will tell you what device was created.
=20
-  +=08o  Configure the device IP (change IP addresses and device name =
to
+  o  Configure the device IP (change IP addresses and device name to
      suit)
=20
=20
@@ -1303,7 +1303,7 @@
=20
=20
=20
-  +=08o  Set up routing and arping if desired - this is my recipe, the=
re are
+  o  Set up routing and arping if desired - this is my recipe, there a=
re
      other ways of doing the same thing
=20
=20
@@ -1338,7 +1338,7 @@
   utility which reads the information from a config file and sets up
   devices at boot time.
=20
-  +=08o  Rather than using up two IPs and ARPing for one of them, you =
can
+  o  Rather than using up two IPs and ARPing for one of them, you can
      also provide direct access to your LAN by the UML by using a
      bridge.
=20
@@ -1417,7 +1417,7 @@
   Note that 'br0' should be setup using ifconfig with the existing IP
   address of eth0, as eth0 no longer has its own IP.
=20
-  +=08o
+  o
=20
=20
      Also, the /dev/net/tun device must be writable by the user runnin=
g
@@ -1438,11 +1438,11 @@
   devices and chgrp /dev/net/tun to that group with mode 664 or 660.
=20
=20
-  +=08o  Once the device is set up, run UML with 'eth0=3Dtuntap,device=
 name'
+  o  Once the device is set up, run UML with 'eth0=3Dtuntap,device nam=
e'
      (i.e. 'eth0=3Dtuntap,tap0') on the command line (or do it with th=
e
      mconsole config command).
=20
-  +=08o  Bring the eth device up in UML and you're in business.
+  o  Bring the eth device up in UML and you're in business.
=20
      If you don't want that tap device any more, you can make it non-
      persistent with
@@ -1465,7 +1465,7 @@
=20
=20
=20
-  6=086.=08.8=088.=08.  E=08Et=08th=08he=08er=08rt=08ta=08ap=08p
+  6.8.  Ethertap
=20
   Ethertap is the general mechanism on 2.2 for userspace processes to
   exchange packets with the kernel.
@@ -1561,9 +1561,9 @@
=20
=20
=20
-  6=086.=08.9=089.=08.  T=08Th=08he=08e s=08sw=08wi=08it=08tc=08ch=08h=
 d=08da=08ae=08em=08mo=08on=08n
+  6.9.  The switch daemon
=20
-  N=08No=08ot=08te=08e: This is the daemon formerly known as uml_route=
r, but which was
+  Note: This is the daemon formerly known as uml_router, but which was
   renamed so the network weenies of the world would stop growling at m=
e.
=20
=20
@@ -1649,7 +1649,7 @@
=20
=20
=20
-  6=086.=08.1=0810=080.=08.  S=08Sl=08li=08ip=08p
+  6.10.  Slip
=20
   Slip is another, less general, mechanism for a process to communicat=
e
   with the host networking.  In contrast to the ethertap interface,
@@ -1681,7 +1681,7 @@
=20
=20
=20
-  6=086.=08.1=0811=081.=08.  S=08Sl=08li=08ir=08rp=08p
+  6.11.  Slirp
=20
   slirp uses an external program, usually /usr/bin/slirp, to provide I=
P
   only networking connectivity through the host. This is similar to IP
@@ -1737,7 +1737,7 @@
=20
=20
=20
-  6=086.=08.1=0812=082.=08.  p=08pc=08ca=08ap=08p
+  6.12.  pcap
=20
   The pcap transport is attached to a UML ethernet device on the comma=
nd
   line or with uml_mconsole with the following syntax:
@@ -1777,7 +1777,7 @@
=20
=20
=20
-  6=086.=08.1=0813=083.=08.  S=08Se=08et=08tt=08ti=08in=08ng=08g u=08u=
p=08p t=08th=08he=08e h=08ho=08os=08st=08t y=08yo=08ou=08ur=08rs=08se=08=
el=08lf=08f
+  6.13.  Setting up the host yourself
=20
   If you don't specify an address for the host side of the ethertap or
   slip device, UML won't do any setup on the host.  So this is what is
@@ -1785,7 +1785,7 @@
   192.168.0.251 and a UML-side IP of 192.168.0.250 - adjust to suit yo=
ur
   own network):
=20
-  +=08o  The device needs to be configured with its IP address.  Tap d=
evices
+  o  The device needs to be configured with its IP address.  Tap devic=
es
      are also configured with an mtu of 1484.  Slip devices are
      configured with a point-to-point address pointing at the UML ip
      address.
@@ -1805,7 +1805,7 @@
=20
=20
=20
-  +=08o  If a tap device is being set up, a route is set to the UML IP=
=2E
+  o  If a tap device is being set up, a route is set to the UML IP.
=20
=20
        UML# route add -host 192.168.0.250 gw 192.168.0.251
@@ -1814,7 +1814,7 @@
=20
=20
=20
-  +=08o  To allow other hosts on your network to see the virtual machi=
ne,
+  o  To allow other hosts on your network to see the virtual machine,
      proxy arp is set up for it.
=20
=20
@@ -1824,7 +1824,7 @@
=20
=20
=20
-  +=08o  Finally, the host is set up to route packets.
+  o  Finally, the host is set up to route packets.
=20
=20
        host#  echo 1 > /proc/sys/net/ipv4/ip_forward
@@ -1838,12 +1838,12 @@
=20
=20
=20
-  7=087.=08.  S=08Sh=08ha=08ar=08ri=08in=08ng=08g F=08Fi=08il=08le=08e=
s=08sy=08ys=08st=08te=08em=08ms=08s b=08be=08et=08tw=08we=08ee=08en=08n=
 V=08Vi=08ir=08rt=08tu=08ua=08al=08l M=08Ma=08ac=08ch=08hi=08in=08ne=08=
es=08s
+  7.  Sharing Filesystems between Virtual Machines
=20
=20
=20
=20
-  7=087.=08.1=081.=08.  A=08A w=08wa=08ar=08rn=08ni=08in=08ng=08g
+  7.1.  A warning
=20
   Don't attempt to share filesystems simply by booting two UMLs from t=
he
   same file.  That's the same thing as booting two physical machines
@@ -1851,7 +1851,7 @@
=20
=20
=20
-  7=087.=08.2=082.=08.  U=08Us=08si=08in=08ng=08g l=08la=08ay=08ye=08e=
r=08re=08ed=08d b=08bl=08lo=08oc=08ck=08k d=08de=08ev=08vi=08ic=08ce=08=
es=08s
+  7.2.  Using layered block devices
=20
   The way to share a filesystem between two virtual machines is to use
   the copy-on-write (COW) layering capability of the ubd block driver.
@@ -1896,7 +1896,7 @@
=20
=20
=20
-  7=087.=08.3=083.=08.  N=08No=08ot=08te=08e!=08!
+  7.3.  Note!
=20
   When checking the size of the COW file in order to see the gobs of
   space that you're saving, make sure you use 'ls -ls' to see the actu=
al
@@ -1926,7 +1926,7 @@
=20
=20
=20
-  7=087.=08.4=084.=08.  A=08An=08no=08ot=08th=08he=08er=08r w=08wa=08a=
r=08rn=08ni=08in=08ng=08g
+  7.4.  Another warning
=20
   Once a filesystem is being used as a readonly backing file for a COW
   file, do not boot directly from it or modify it in any way.  Doing s=
o
@@ -1952,7 +1952,7 @@
=20
=20
=20
-  7=087.=08.5=085.=08.  u=08um=08ml=08l_=08_m=08mo=08oo=08o :=08: M=08=
Me=08er=08rg=08gi=08in=08ng=08g a=08a C=08CO=08OW=08W f=08fi=08il=08le=08=
e w=08wi=08it=08th=08h i=08it=08ts=08s b=08ba=08ac=08ck=08ki=08in=08ng=08=
g f=08fi=08il=08le=08e
+  7.5.  uml_moo : Merging a COW file with its backing file
=20
   Depending on how you use UML and COW devices, it may be advisable to
   merge the changes in the COW file into the backing file every once i=
n
@@ -2001,7 +2001,7 @@
=20
=20
=20
-  8=088.=08.  C=08Cr=08re=08ea=08at=08ti=08in=08ng=08g f=08fi=08il=08l=
e=08es=08sy=08ys=08st=08te=08em=08ms=08s
+  8.  Creating filesystems
=20
=20
   You may want to create and mount new UML filesystems, either because
@@ -2015,7 +2015,7 @@
   should be easy to translate to the filesystem of your choice.
=20
=20
-  8=088.=08.1=081.=08.  C=08Cr=08re=08ea=08at=08te=08e t=08th=08he=08e=
 f=08fi=08il=08le=08es=08sy=08ys=08st=08te=08em=08m f=08fi=08il=08le=08=
e
+  8.1.  Create the filesystem file
=20
   dd is your friend.  All you need to do is tell dd to create an empty
   file of the appropriate size.  I usually make it sparse to save time
@@ -2032,7 +2032,7 @@
=20
=20
=20
-  8=088.=08.2=082.=08.  A=08As=08ss=08si=08ig=08gn=08n t=08th=08he=08e=
 f=08fi=08il=08le=08e t=08to=08o a=08a U=08UM=08ML=08L d=08de=08ev=08vi=
=08ic=08ce=08e
+  8.2.  Assign the file to a UML device
=20
   Add an argument like the following to the UML command line:
=20
@@ -2045,7 +2045,7 @@
=20
=20
=20
-  8=088.=08.3=083.=08.  C=08Cr=08re=08ea=08at=08ti=08in=08ng=08g a=08a=
n=08nd=08d m=08mo=08ou=08un=08nt=08ti=08in=08ng=08g t=08th=08he=08e f=08=
fi=08il=08le=08es=08sy=08ys=08st=08te=08em=08m
+  8.3.  Creating and mounting the filesystem
=20
   Make sure that the filesystem is available, either by being built in=
to
   the kernel, or available as a module, then boot up UML and log in.  =
If
@@ -2096,7 +2096,7 @@
=20
=20
=20
-  9=089.=08.  H=08Ho=08os=08st=08t f=08fi=08il=08le=08e a=08ac=08cc=08=
ce=08es=08ss=08s
+  9.  Host file access
=20
=20
   If you want to access files on the host machine from inside UML, you
@@ -2112,7 +2112,7 @@
   files contained in it just as you would on the host.
=20
=20
-  9=089.=08.1=081.=08.  U=08Us=08si=08in=08ng=08g h=08ho=08os=08st=08t=
f=08fs=08s
+  9.1.  Using hostfs
=20
   To begin with, make sure that hostfs is available inside the virtual
   machine with
@@ -2151,7 +2151,7 @@
=20
=20
=20
-  9=089.=08.2=082.=08.  h=08ho=08os=08st=08tf=08fs=08s a=08as=08s t=08=
th=08he=08e r=08ro=08oo=08ot=08t f=08fi=08il=08le=08es=08sy=08ys=08st=08=
te=08em=08m
+  9.2.  hostfs as the root filesystem
=20
   It's possible to boot from a directory hierarchy on the host using
   hostfs rather than using the standard filesystem in a file.
@@ -2194,20 +2194,20 @@
   UML should then boot as it does normally.
=20
=20
-  9=089.=08.3=083.=08.  B=08Bu=08ui=08il=08ld=08di=08in=08ng=08g h=08h=
o=08os=08st=08tf=08fs=08s
+  9.3.  Building hostfs
=20
   If you need to build hostfs because it's not in your kernel, you hav=
e
   two choices:
=20
=20
=20
-  +=08o  Compiling hostfs into the kernel:
+  o  Compiling hostfs into the kernel:
=20
=20
      Reconfigure the kernel and set the 'Host filesystem' option under
=20
=20
-  +=08o  Compiling hostfs as a module:
+  o  Compiling hostfs as a module:
=20
=20
      Reconfigure the kernel and set the 'Host filesystem' option under
@@ -2228,7 +2228,7 @@
=20
=20
=20
-  1=0810=080.=08.  T=08Th=08he=08e M=08Ma=08an=08na=08ag=08ge=08em=08m=
e=08en=08nt=08t C=08Co=08on=08ns=08so=08ol=08le=08e
+  10.  The Management Console
=20
=20
=20
@@ -2240,15 +2240,15 @@
=20
   There are a number of things you can do with the mconsole interface:
=20
-  +=08o  get the kernel version
+  o  get the kernel version
=20
-  +=08o  add and remove devices
+  o  add and remove devices
=20
-  +=08o  halt or reboot the machine
+  o  halt or reboot the machine
=20
-  +=08o  Send SysRq commands
+  o  Send SysRq commands
=20
-  +=08o  Pause and resume the UML
+  o  Pause and resume the UML
=20
=20
   You need the mconsole client (uml_mconsole) which is present in CVS
@@ -2300,28 +2300,28 @@
=20
   You'll get a prompt, at which you can run one of these commands:
=20
-  +=08o  version
+  o  version
=20
-  +=08o  halt
+  o  halt
=20
-  +=08o  reboot
+  o  reboot
=20
-  +=08o  config
+  o  config
=20
-  +=08o  remove
+  o  remove
=20
-  +=08o  sysrq
+  o  sysrq
=20
-  +=08o  help
+  o  help
=20
-  +=08o  cad
+  o  cad
=20
-  +=08o  stop
+  o  stop
=20
-  +=08o  go
+  o  go
=20
=20
-  1=0810=080.=08.1=081.=08.  v=08ve=08er=08rs=08si=08io=08on=08n
+  10.1.  version
=20
   This takes no arguments.  It prints the UML version.
=20
@@ -2342,7 +2342,7 @@
=20
=20
=20
-  1=0810=080.=08.2=082.=08.  h=08ha=08al=08lt=08t a=08an=08nd=08d r=08=
re=08eb=08bo=08oo=08ot=08t
+  10.2.  halt and reboot
=20
   These take no arguments.  They shut the machine down immediately, wi=
th
   no syncing of disks and no clean shutdown of userspace.  So, they ar=
e
@@ -2357,7 +2357,7 @@
=20
=20
=20
-  1=0810=080.=08.3=083.=08.  c=08co=08on=08nf=08fi=08ig=08g
+  10.3.  config
=20
   "config" adds a new device to the virtual machine.  Currently the ub=
d
   and network drivers support this.  It takes one argument, which is t=
he
@@ -2378,7 +2378,7 @@
=20
=20
=20
-  1=0810=080.=08.4=084.=08.  r=08re=08em=08mo=08ov=08ve=08e
+  10.4.  remove
=20
   "remove" deletes a device from the system.  Its argument is just the
   name of the device to be removed. The device must be idle in whateve=
r
@@ -2397,7 +2397,7 @@
=20
=20
=20
-  1=0810=080.=08.5=085.=08.  s=08sy=08ys=08sr=08rq=08q
+  10.5.  sysrq
=20
   This takes one argument, which is a single letter.  It calls the
   generic kernel's SysRq driver, which does whatever is called for by
@@ -2407,14 +2407,14 @@
=20
=20
=20
-  1=0810=080.=08.6=086.=08.  h=08he=08el=08lp=08p
+  10.6.  help
=20
   "help" returns a string listing the valid commands and what each one
   does.
=20
=20
=20
-  1=0810=080.=08.7=087.=08.  c=08ca=08ad=08d
+  10.7.  cad
=20
   This invokes the Ctl-Alt-Del action on init.  What exactly this ends
   up doing is up to /etc/inittab.  Normally, it reboots the machine.
@@ -2432,7 +2432,7 @@
=20
=20
=20
-  1=0810=080.=08.8=088.=08.  s=08st=08to=08op=08p
+  10.8.  stop
=20
   This puts the UML in a loop reading mconsole requests until a 'go'
   mconsole command is received. This is very useful for making backups
@@ -2448,7 +2448,7 @@
=20
=20
=20
-  1=0810=080.=08.9=089.=08.  g=08go=08o
+  10.9.  go
=20
   This resumes a UML after being paused by a 'stop' command. Note that
   when the UML has resumed, TCP connections may have timed out and if
@@ -2462,10 +2462,10 @@
=20
=20
=20
-  1=0811=081.=08.  K=08Ke=08er=08rn=08ne=08el=08l d=08de=08eb=08bu=08u=
g=08gg=08gi=08in=08ng=08g
+  11.  Kernel debugging
=20
=20
-  N=08No=08ot=08te=08e:=08: The interface that makes debugging, as des=
cribed here, possible
+  Note: The interface that makes debugging, as described here, possibl=
e
   is present in 2.4.0-test6 kernels and later.
=20
=20
@@ -2485,7 +2485,7 @@
=20
=20
=20
-  1=0811=081.=08.1=081.=08.  S=08St=08ta=08ar=08rt=08ti=08in=08ng=08g =
t=08th=08he=08e k=08ke=08er=08rn=08ne=08el=08l u=08un=08nd=08de=08er=08=
r g=08gd=08db=08b
+  11.1.  Starting the kernel under gdb
=20
   You can have the kernel running under the control of gdb from the
   beginning by putting 'debug' on the command line.  You will get an
@@ -2498,7 +2498,7 @@
   There is a transcript of a debugging session  here <debug-
   session.html> , with breakpoints being set in the scheduler and in a=
n
   interrupt handler.
-  1=0811=081.=08.2=082.=08.  E=08Ex=08xa=08am=08mi=08in=08ni=08in=08ng=
=08g s=08sl=08le=08ee=08ep=08pi=08in=08ng=08g p=08pr=08ro=08oc=08ce=08e=
s=08ss=08se=08es=08s
+  11.2.  Examining sleeping processes
=20
   Not every bug is evident in the currently running process.  Sometime=
s,
   processes hang in the kernel when they shouldn't because they've
@@ -2516,7 +2516,7 @@
=20
   Now what you do is this:
=20
-  +=08o  detach from the current thread
+  o  detach from the current thread
=20
=20
        (UML gdb)  det
@@ -2525,7 +2525,7 @@
=20
=20
=20
-  +=08o  attach to the thread you are interested in
+  o  attach to the thread you are interested in
=20
=20
        (UML gdb)  att <host pid>
@@ -2534,7 +2534,7 @@
=20
=20
=20
-  +=08o  look at its stack and anything else of interest
+  o  look at its stack and anything else of interest
=20
=20
        (UML gdb)  bt
@@ -2545,7 +2545,7 @@
   Note that you can't do anything at this point that requires that a
   process execute, e.g. calling a function
=20
-  +=08o  when you're done looking at that process, reattach to the cur=
rent
+  o  when you're done looking at that process, reattach to the current
      thread and continue it
=20
=20
@@ -2569,12 +2569,12 @@
=20
=20
=20
-  1=0811=081.=08.3=083.=08.  R=08Ru=08un=08nn=08ni=08in=08ng=08g d=08d=
d=08dd=08d o=08on=08n U=08UM=08ML=08L
+  11.3.  Running ddd on UML
=20
   ddd works on UML, but requires a special kludge.  The process goes
   like this:
=20
-  +=08o  Start ddd
+  o  Start ddd
=20
=20
        host% ddd linux
@@ -2583,14 +2583,14 @@
=20
=20
=20
-  +=08o  With ps, get the pid of the gdb that ddd started.  You can as=
k the
+  o  With ps, get the pid of the gdb that ddd started.  You can ask th=
e
      gdb to tell you, but for some reason that confuses things and
      causes a hang.
=20
-  +=08o  run UML with 'debug=3Dparent gdb-pid=3D<pid>' added to the co=
mmand line
+  o  run UML with 'debug=3Dparent gdb-pid=3D<pid>' added to the comman=
d line
      - it will just sit there after you hit return
=20
-  +=08o  type 'att 1' to the ddd gdb and you will see something like
+  o  type 'att 1' to the ddd gdb and you will see something like
=20
=20
        0xa013dc51 in __kill ()
@@ -2602,12 +2602,12 @@
=20
=20
=20
-  +=08o  At this point, type 'c', UML will boot up, and you can use dd=
d just
+  o  At this point, type 'c', UML will boot up, and you can use ddd ju=
st
      as you do on any other process.
=20
=20
=20
-  1=0811=081.=08.4=084.=08.  D=08De=08eb=08bu=08ug=08gg=08gi=08in=08ng=
=08g m=08mo=08od=08du=08ul=08le=08es=08s
+  11.4.  Debugging modules
=20
   gdb has support for debugging code which is dynamically loaded into
   the process.  This support is what is needed to debug kernel modules
@@ -2823,7 +2823,7 @@
=20
=20
=20
-  1=0811=081.=08.5=085.=08.  A=08At=08tt=08ta=08ac=08ch=08hi=08in=08ng=
=08g g=08gd=08db=08b t=08to=08o t=08th=08he=08e k=08ke=08er=08rn=08ne=08=
el=08l
+  11.5.  Attaching gdb to the kernel
=20
   If you don't have the kernel running under gdb, you can attach gdb t=
o
   it later by sending the tracing thread a SIGUSR1.  The first line of
@@ -2857,7 +2857,7 @@
=20
=20
=20
-  1=0811=081.=08.6=086.=08.  U=08Us=08si=08in=08ng=08g a=08al=08lt=08t=
e=08er=08rn=08na=08at=08te=08e d=08de=08eb=08bu=08ug=08gg=08ge=08er=08r=
s=08s
+  11.6.  Using alternate debuggers
=20
   UML has support for attaching to an already running debugger rather
   than starting gdb itself.  This is present in CVS as of 17 Apr 2001.
@@ -2886,7 +2886,7 @@
   An example of an alternate debugger is strace.  You can strace the
   actual kernel as follows:
=20
-  +=08o  Run the following in a shell
+  o  Run the following in a shell
=20
=20
        host%
@@ -2894,10 +2894,10 @@
=20
=20
=20
-  +=08o  Run UML with 'debug' and 'gdb-pid=3D<pid>' with the pid print=
ed out
+  o  Run UML with 'debug' and 'gdb-pid=3D<pid>' with the pid printed o=
ut
      by the previous command
=20
-  +=08o  Hit return in the shell, and UML will start running, and stra=
ce
+  o  Hit return in the shell, and UML will start running, and strace
      output will start accumulating in the output file.
=20
      Note that this is different from running
@@ -2917,9 +2917,9 @@
=20
=20
=20
-  1=0812=082.=08.  K=08Ke=08er=08rn=08ne=08el=08l d=08de=08eb=08bu=08u=
g=08gg=08gi=08in=08ng=08g e=08ex=08xa=08am=08mp=08pl=08le=08es=08s
+  12.  Kernel debugging examples
=20
-  1=0812=082.=08.1=081.=08.  T=08Th=08he=08e c=08ca=08as=08se=08e o=08=
of=08f t=08th=08he=08e h=08hu=08un=08ng=08g f=08fs=08sc=08ck=08k
+  12.1.  The case of the hung fsck
=20
   When booting up the kernel, fsck failed, and dropped me into a shell
   to fix things up.  I ran fsck -y, which hung:
@@ -3154,9 +3154,9 @@
=20
   The interesting things here are :
=20
-  +=08o  There are two segfaults on this stack (frames 9 and 14)
+  o  There are two segfaults on this stack (frames 9 and 14)
=20
-  +=08o  The first faulting address (frame 11) is 0x50000800
+  o  The first faulting address (frame 11) is 0x50000800
=20
   (gdb) p (void *)1342179328
   $16 =3D (void *) 0x50000800
@@ -3399,7 +3399,7 @@
   on will be somewhat clearer.
=20
=20
-  1=0812=082.=08.2=082.=08.  E=08Ep=08pi=08is=08so=08od=08de=08e 2=082=
:=08: T=08Th=08he=08e c=08ca=08as=08se=08e o=08of=08f t=08th=08he=08e h=
=08hu=08un=08ng=08g f=08fs=08sc=08ck=08k
+  12.2.  Episode 2: The case of the hung fsck
=20
   After setting a trap in the SEGV handler for accesses to the signal
   thread's stack, I reran the kernel.
@@ -3788,12 +3788,12 @@
=20
=20
=20
-  1=0813=083.=08.  W=08Wh=08ha=08at=08t t=08to=08o d=08do=08o w=08wh=08=
he=08en=08n U=08UM=08ML=08L d=08do=08oe=08es=08sn=08n'=08't=08t w=08wo=08=
or=08rk=08k
+  13.  What to do when UML doesn't work
=20
=20
=20
=20
-  1=0813=083.=08.1=081.=08.  S=08St=08tr=08ra=08an=08ng=08ge=08e c=08c=
o=08om=08mp=08pi=08il=08la=08at=08ti=08io=08on=08n e=08er=08rr=08ro=08o=
r=08rs=08s w=08wh=08he=08en=08n y=08yo=08ou=08u b=08bu=08ui=08il=08ld=08=
d f=08fr=08ro=08om=08m s=08so=08ou=08ur=08rc=08ce=08e
+  13.1.  Strange compilation errors when you build from source
=20
   As of test11, it is necessary to have "ARCH=3Dum" in the environment=
 or
   on the make command line for all steps in building UML, including
@@ -3824,8 +3824,8 @@
=20
=20
=20
-  1=0813=083.=08.3=083.=08.  A=08A v=08va=08ar=08ri=08ie=08et=08ty=08y=
 o=08of=08f p=08pa=08an=08ni=08ic=08cs=08s a=08an=08nd=08d h=08ha=08an=08=
ng=08gs=08s w=08wi=08it=08th=08h /=08/t=08tm=08mp=08p o=08on=08n a=08a =
r=08re=08ei=08is=08se=08er=08rf=08fs=08s  f=08fi=08il=08le=08es=08sy=08=
ys=08s-=08-
-  t=08te=08em=08m
+  13.3.  A variety of panics and hangs with /tmp on a reiserfs  filesy=
s-
+  tem
=20
   I saw this on reiserfs 3.5.21 and it seems to be fixed in 3.5.27.
   Panics preceded by
@@ -3842,8 +3842,8 @@
=20
=20
=20
-  1=0813=083.=08.4=084.=08.  T=08Th=08he=08e c=08co=08om=08mp=08pi=08i=
l=08le=08e f=08fa=08ai=08il=08ls=08s w=08wi=08it=08th=08h e=08er=08rr=08=
ro=08or=08rs=08s a=08ab=08bo=08ou=08ut=08t c=08co=08on=08nf=08fl=08li=08=
ic=08ct=08ti=08in=08ng=08g t=08ty=08yp=08pe=08es=08s f=08fo=08or=08r
-  '=08'o=08op=08pe=08en=08n'=08',=08, '=08'd=08du=08up=08p'=08',=08, a=
=08an=08nd=08d '=08'w=08wa=08ai=08it=08tp=08pi=08id=08d'=08'
+  13.4.  The compile fails with errors about conflicting types for
+  'open', 'dup', and 'waitpid'
=20
   This happens when you build in /usr/src/linux.  The UML build makes
   the include/asm link point to include/asm-um.  /usr/include/asm poin=
ts
@@ -3854,14 +3854,14 @@
=20
=20
=20
-  1=0813=083.=08.5=085.=08.  U=08UM=08ML=08L d=08do=08oe=08es=08sn=08n=
'=08't=08t w=08wo=08or=08rk=08k w=08wh=08he=08en=08n /=08/t=08tm=08mp=08=
p i=08is=08s a=08an=08n N=08NF=08FS=08S f=08fi=08il=08le=08es=08sy=08ys=
=08st=08te=08em=08m
+  13.5.  UML doesn't work when /tmp is an NFS filesystem
=20
   This seems to be a similar situation with the ReiserFS problem above=
=2E
   Some versions of NFS seems not to handle mmap correctly, which UML
   depends on.  The workaround is have /tmp be a non-NFS directory.
=20
=20
-  1=0813=083.=08.6=086.=08.  U=08UM=08ML=08L h=08ha=08an=08ng=08gs=08s=
 o=08on=08n b=08bo=08oo=08ot=08t w=08wh=08he=08en=08n c=08co=08om=08mp=08=
pi=08il=08le=08ed=08d w=08wi=08it=08th=08h g=08gp=08pr=08ro=08of=08f s=08=
su=08up=08pp=08po=08or=08rt=08t
+  13.6.  UML hangs on boot when compiled with gprof support
=20
   If you build UML with gprof support and, early in the boot, it does
   this
@@ -3878,7 +3878,7 @@
=20
=20
=20
-  1=0813=083.=08.7=087.=08.  s=08sy=08ys=08sl=08lo=08og=08gd=08d d=08d=
i=08ie=08es=08s w=08wi=08it=08th=08h a=08a S=08SI=08IG=08GT=08TE=08ER=08=
RM=08M o=08on=08n s=08st=08ta=08ar=08rt=08tu=08up=08p
+  13.7.  syslogd dies with a SIGTERM on startup
=20
   The exact boot error depends on the distribution that you're booting=
,
   but Debian produces this:
@@ -3897,17 +3897,17 @@
=20
=20
=20
-  1=0813=083.=08.8=088.=08.  T=08TU=08UN=08N/=08/T=08TA=08AP=08P n=08n=
e=08et=08tw=08wo=08or=08rk=08ki=08in=08ng=08g d=08do=08oe=08es=08sn=08n=
'=08't=08t w=08wo=08or=08rk=08k o=08on=08n a=08a 2=082.=08.4=084 h=08ho=
=08os=08st=08t
+  13.8.  TUN/TAP networking doesn't work on a 2.4 host
=20
   There are a couple of problems which were
   <http://www.geocrawler.com/lists/3/SourceForge/597/0/> name=3D"point=
ed
   out">  by Tim Robinson <timro at trkr dot net>
=20
-  +=08o  It doesn't work on hosts running 2.4.7 (or thereabouts) or ea=
rlier.
+  o  It doesn't work on hosts running 2.4.7 (or thereabouts) or earlie=
r.
      The fix is to upgrade to something more recent and then read the
      next item.
=20
-  +=08o  If you see
+  o  If you see
=20
=20
        File descriptor in bad state
@@ -3921,8 +3921,8 @@
=20
=20
=20
-  1=0813=083.=08.9=089.=08.  Y=08Yo=08ou=08u c=08ca=08an=08n n=08ne=08=
et=08tw=08wo=08or=08rk=08k t=08to=08o t=08th=08he=08e h=08ho=08os=08st=08=
t b=08bu=08ut=08t n=08no=08ot=08t t=08to=08o o=08ot=08th=08he=08er=08r =
m=08ma=08ac=08ch=08hi=08in=08ne=08es=08s o=08on=08n t=08th=08he=08e
-  n=08ne=08et=08t
+  13.9.  You can network to the host but not to other machines on the
+  net
=20
   If you can connect to the host, and the host can connect to UML, but
   you cannot connect to any other machines, then you may need to enabl=
e
@@ -3972,7 +3972,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0810=080.=08.  I=08I h=08ha=08av=08ve=08e n=08no=08=
o r=08ro=08oo=08ot=08t a=08an=08nd=08d I=08I w=08wa=08an=08nt=08t t=08t=
o=08o s=08sc=08cr=08re=08ea=08am=08m
+  13.10.  I have no root and I want to scream
=20
   Thanks to Birgit Wahlich for telling me about this strange one.  It
   turns out that there's a limit of six environment variables on the
@@ -3987,7 +3987,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0811=081.=08.  U=08UM=08ML=08L b=08bu=08ui=08il=08l=
d=08d c=08co=08on=08nf=08fl=08li=08ic=08ct=08t b=08be=08et=08tw=08we=08=
ee=08en=08n p=08pt=08tr=08ra=08ac=08ce=08e.=08.h=08h a=08an=08nd=08d u=08=
uc=08co=08on=08nt=08te=08ex=08xt=08t.=08.h=08h
+  13.11.  UML build conflict between ptrace.h and ucontext.h
=20
   On some older systems, /usr/include/asm/ptrace.h and
   /usr/include/sys/ucontext.h define the same names.  So, when they're
@@ -4007,7 +4007,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0812=082.=08.  T=08Th=08he=08e U=08UM=08ML=08L B=08=
Bo=08og=08go=08oM=08Mi=08ip=08ps=08s i=08is=08s e=08ex=08xa=08ac=08ct=08=
tl=08ly=08y h=08ha=08al=08lf=08f t=08th=08he=08e h=08ho=08os=08st=08t'=08=
's=08s B=08Bo=08og=08go=08oM=08Mi=08ip=08ps=08s
+  13.12.  The UML BogoMips is exactly half the host's BogoMips
=20
   On i386 kernels, there are two ways of running the loop that is used
   to calculate the BogoMips rating, using the TSC if it's there or usi=
ng
@@ -4019,7 +4019,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0813=083.=08.  W=08Wh=08he=08en=08n y=08yo=08ou=08u=
 r=08ru=08un=08n U=08UM=08ML=08L,=08, i=08it=08t i=08im=08mm=08me=08ed=08=
di=08ia=08at=08te=08el=08ly=08y s=08se=08eg=08gf=08fa=08au=08ul=08lt=08=
ts=08s
+  13.13.  When you run UML, it immediately segfaults
=20
   If the host is configured with the 2G/2G address space split, that's
   why.  See ``UML on 2G/2G hosts''  for the details on getting UML to
@@ -4027,7 +4027,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0814=084.=08.  x=08xt=08te=08er=08rm=08ms=08s a=08a=
p=08pp=08pe=08ea=08ar=08r,=08, t=08th=08he=08en=08n i=08im=08mm=08me=08=
ed=08di=08ia=08at=08te=08el=08ly=08y d=08di=08is=08sa=08ap=08pp=08pe=08=
ea=08ar=08r
+  13.14.  xterms appear, then immediately disappear
=20
   If you're running an up to date kernel with an old release of
   uml_utilities, the port-helper program will not work properly, so
@@ -4039,7 +4039,7 @@
=20
=20
=20
-  1=0813=083.=08.1=0815=085.=08.  A=08An=08ny=08y o=08ot=08th=08he=08e=
r=08r p=08pa=08an=08ni=08ic=08c,=08, h=08ha=08an=08ng=08g,=08, o=08or=08=
r s=08st=08tr=08ra=08an=08ng=08ge=08e b=08be=08eh=08ha=08av=08vi=08io=08=
or=08r
+  13.15.  Any other panic, hang, or strange behavior
=20
   If you're seeing truly strange behavior, such as hangs or panics tha=
t
   happen in random places, or you try running the debugger to see what=
's
@@ -4059,7 +4059,7 @@
=20
   If you want to be super-helpful, read ``Diagnosing Problems'' and
   follow the instructions contained therein.
-  1=0814=084.=08.  D=08Di=08ia=08ag=08gn=08no=08os=08si=08in=08ng=08g =
P=08Pr=08ro=08ob=08bl=08le=08em=08ms=08s
+  14.  Diagnosing Problems
=20
=20
   If you get UML to crash, hang, or otherwise misbehave, you should
@@ -4078,7 +4078,7 @@
   ``Kernel debugging''  UML first.
=20
=20
-  1=0814=084.=08.1=081.=08.  C=08Ca=08as=08se=08e 1=081 :=08: N=08No=08=
or=08rm=08ma=08al=08l k=08ke=08er=08rn=08ne=08el=08l p=08pa=08an=08ni=08=
ic=08cs=08s
+  14.1.  Case 1 : Normal kernel panics
=20
   The most common case is for a normal thread to panic.  To debug this=
,
   you will need to run it under the debugger (add 'debug' to the comma=
nd
@@ -4128,7 +4128,7 @@
   to get that information from the faulting ip.
=20
=20
-  1=0814=084.=08.2=082.=08.  C=08Ca=08as=08se=08e 2=082 :=08: T=08Tr=08=
ra=08ac=08ci=08in=08ng=08g t=08th=08hr=08re=08ea=08ad=08d p=08pa=08an=08=
ni=08ic=08cs=08s
+  14.2.  Case 2 : Tracing thread panics
=20
   The less common and more painful case is when the tracing thread
   panics.  In this case, the kernel debugger will be useless because i=
t
@@ -4161,7 +4161,7 @@
   backtrace in and wait for our crack debugging team to fix the proble=
m.
=20
=20
-  1=0814=084.=08.3=083.=08.  C=08Ca=08as=08se=08e 3=083 :=08: T=08Tr=08=
ra=08ac=08ci=08in=08ng=08g t=08th=08hr=08re=08ea=08ad=08d p=08pa=08an=08=
ni=08ic=08cs=08s c=08ca=08au=08us=08se=08ed=08d b=08by=08y o=08ot=08th=08=
he=08er=08r t=08th=08hr=08re=08ea=08ad=08ds=08s
+  14.3.  Case 3 : Tracing thread panics caused by other threads
=20
   However, there are cases where the misbehavior of another thread
   caused the problem.  The most common panic of this type is:
@@ -4227,7 +4227,7 @@
=20
=20
=20
-  1=0814=084.=08.4=084.=08.  C=08Ca=08as=08se=08e 4=084 :=08: H=08Ha=08=
an=08ng=08gs=08s
+  14.4.  Case 4 : Hangs
=20
   Hangs seem to be fairly rare, but they sometimes happen.  When a han=
g
   happens, we need a backtrace from the offending process.  Run the
@@ -4257,7 +4257,7 @@
=20
=20
=20
-  1=0815=085.=08.  T=08Th=08ha=08an=08nk=08ks=08s
+  15.  Thanks
=20
=20
   A number of people have helped this project in various ways, and thi=
s
@@ -4274,20 +4274,20 @@
   bookkeeping lapses and I forget about contributions.
=20
=20
-  1=0815=085.=08.1=081.=08.  C=08Co=08od=08de=08e a=08an=08nd=08d D=08=
Do=08oc=08cu=08um=08me=08en=08nt=08ta=08at=08ti=08io=08on=08n
+  15.1.  Code and Documentation
=20
   Rusty Russell <rusty at linuxcare.com.au>  -
=20
-  +=08o  wrote the  HOWTO <http://user-mode-
+  o  wrote the  HOWTO <http://user-mode-
      linux.sourceforge.net/UserModeLinux-HOWTO.html>
=20
-  +=08o  prodded me into making this project official and putting it o=
n
+  o  prodded me into making this project official and putting it on
      SourceForge
=20
-  +=08o  came up with the way cool UML logo <http://user-mode-
+  o  came up with the way cool UML logo <http://user-mode-
      linux.sourceforge.net/uml-small.png>
=20
-  +=08o  redid the config process
+  o  redid the config process
=20
=20
   Peter Moulder <reiter at netspace.net.au>  - Fixed my config and bui=
ld
@@ -4296,18 +4296,18 @@
=20
   Bill Stearns <wstearns at pobox.com>  -
=20
-  +=08o  HOWTO updates
+  o  HOWTO updates
=20
-  +=08o  lots of bug reports
+  o  lots of bug reports
=20
-  +=08o  lots of testing
+  o  lots of testing
=20
-  +=08o  dedicated a box (uml.ists.dartmouth.edu) to support UML devel=
opment
+  o  dedicated a box (uml.ists.dartmouth.edu) to support UML developme=
nt
=20
-  +=08o  wrote the mkrootfs script, which allows bootable filesystems =
of
+  o  wrote the mkrootfs script, which allows bootable filesystems of
      RPM-based distributions to be cranked out
=20
-  +=08o  cranked out a large number of filesystems with said script
+  o  cranked out a large number of filesystems with said script
=20
=20
   Jim Leu <jleu at mindspring.com>  - Wrote the virtual ethernet drive=
r
@@ -4375,176 +4375,176 @@
=20
   David Coulson <http://davidcoulson.net>  -
=20
-  +=08o  Set up the usermodelinux.org <http://usermodelinux.org>  site=
,
+  o  Set up the usermodelinux.org <http://usermodelinux.org>  site,
      which is a great way of keeping the UML user community on top of
      UML goings-on.
=20
-  +=08o  Site documentation and updates
+  o  Site documentation and updates
=20
-  +=08o  Nifty little UML management daemon  UMLd
+  o  Nifty little UML management daemon  UMLd
      <http://uml.openconsultancy.com/umld/>
=20
-  +=08o  Lots of testing and bug reports
+  o  Lots of testing and bug reports
=20
=20
=20
=20
-  1=0815=085.=08.2=082.=08.  F=08Fl=08lu=08us=08sh=08hi=08in=08ng=08g =
o=08ou=08ut=08t b=08bu=08ug=08gs=08s
+  15.2.  Flushing out bugs
=20
=20
=20
-  +=08o  Yuri Pudgorodsky
+  o  Yuri Pudgorodsky
=20
-  +=08o  Gerald Britton
+  o  Gerald Britton
=20
-  +=08o  Ian Wehrman
+  o  Ian Wehrman
=20
-  +=08o  Gord Lamb
+  o  Gord Lamb
=20
-  +=08o  Eugene Koontz
+  o  Eugene Koontz
=20
-  +=08o  John H. Hartman
+  o  John H. Hartman
=20
-  +=08o  Anders Karlsson
+  o  Anders Karlsson
=20
-  +=08o  Daniel Phillips
+  o  Daniel Phillips
=20
-  +=08o  John Fremlin
+  o  John Fremlin
=20
-  +=08o  Rainer Burgstaller
+  o  Rainer Burgstaller
=20
-  +=08o  James Stevenson
+  o  James Stevenson
=20
-  +=08o  Matt Clay
+  o  Matt Clay
=20
-  +=08o  Cliff Jefferies
+  o  Cliff Jefferies
=20
-  +=08o  Geoff Hoff
+  o  Geoff Hoff
=20
-  +=08o  Lennert Buytenhek
+  o  Lennert Buytenhek
=20
-  +=08o  Al Viro
+  o  Al Viro
=20
-  +=08o  Frank Klingenhoefer
+  o  Frank Klingenhoefer
=20
-  +=08o  Livio Baldini Soares
+  o  Livio Baldini Soares
=20
-  +=08o  Jon Burgess
+  o  Jon Burgess
=20
-  +=08o  Petru Paler
+  o  Petru Paler
=20
-  +=08o  Paul
+  o  Paul
=20
-  +=08o  Chris Reahard
+  o  Chris Reahard
=20
-  +=08o  Sverker Nilsson
+  o  Sverker Nilsson
=20
-  +=08o  Gong Su
+  o  Gong Su
=20
-  +=08o  johan verrept
+  o  johan verrept
=20
-  +=08o  Bjorn Eriksson
+  o  Bjorn Eriksson
=20
-  +=08o  Lorenzo Allegrucci
+  o  Lorenzo Allegrucci
=20
-  +=08o  Muli Ben-Yehuda
+  o  Muli Ben-Yehuda
=20
-  +=08o  David Mansfield
+  o  David Mansfield
=20
-  +=08o  Howard Goff
+  o  Howard Goff
=20
-  +=08o  Mike Anderson
+  o  Mike Anderson
=20
-  +=08o  John Byrne
+  o  John Byrne
=20
-  +=08o  Sapan J. Batia
+  o  Sapan J. Batia
=20
-  +=08o  Iris Huang
+  o  Iris Huang
=20
-  +=08o  Jan Hudec
+  o  Jan Hudec
=20
-  +=08o  Voluspa
+  o  Voluspa
=20
=20
=20
=20
-  1=0815=085.=08.3=083.=08.  B=08Bu=08ug=08gl=08le=08et=08ts=08s a=08a=
n=08nd=08d c=08cl=08le=08ea=08an=08n-=08-u=08up=08ps=08s
+  15.3.  Buglets and clean-ups
=20
=20
=20
-  +=08o  Dave Zarzycki
+  o  Dave Zarzycki
=20
-  +=08o  Adam Lazur
+  o  Adam Lazur
=20
-  +=08o  Boria Feigin
+  o  Boria Feigin
=20
-  +=08o  Brian J. Murrell
+  o  Brian J. Murrell
=20
-  +=08o  JS
+  o  JS
=20
-  +=08o  Roman Zippel
+  o  Roman Zippel
=20
-  +=08o  Wil Cooley
+  o  Wil Cooley
=20
-  +=08o  Ayelet Shemesh
+  o  Ayelet Shemesh
=20
-  +=08o  Will Dyson
+  o  Will Dyson
=20
-  +=08o  Sverker Nilsson
+  o  Sverker Nilsson
=20
-  +=08o  dvorak
+  o  dvorak
=20
-  +=08o  v.naga srinivas
+  o  v.naga srinivas
=20
-  +=08o  Shlomi Fish
+  o  Shlomi Fish
=20
-  +=08o  Roger Binns
+  o  Roger Binns
=20
-  +=08o  johan verrept
+  o  johan verrept
=20
-  +=08o  MrChuoi
+  o  MrChuoi
=20
-  +=08o  Peter Cleve
+  o  Peter Cleve
=20
-  +=08o  Vincent Guffens
+  o  Vincent Guffens
=20
-  +=08o  Nathan Scott
+  o  Nathan Scott
=20
-  +=08o  Patrick Caulfield
+  o  Patrick Caulfield
=20
-  +=08o  jbearce
+  o  jbearce
=20
-  +=08o  Catalin Marinas
+  o  Catalin Marinas
=20
-  +=08o  Shane Spencer
+  o  Shane Spencer
=20
-  +=08o  Zou Min
+  o  Zou Min
=20
=20
-  +=08o  Ryan Boder
+  o  Ryan Boder
=20
-  +=08o  Lorenzo Colitti
+  o  Lorenzo Colitti
=20
-  +=08o  Gwendal Grignou
+  o  Gwendal Grignou
=20
-  +=08o  Andre' Breiler
+  o  Andre' Breiler
=20
-  +=08o  Tsutomu Yasuda
+  o  Tsutomu Yasuda
=20
=20
=20
-  1=0815=085.=08.4=084.=08.  C=08Ca=08as=08se=08e S=08St=08tu=08ud=08d=
i=08ie=08es=08s
+  15.4.  Case Studies
=20
=20
-  +=08o  Jon Wright
+  o  Jon Wright
=20
-  +=08o  William McEwan
+  o  William McEwan
=20
-  +=08o  Michael Richardson
+  o  Michael Richardson
=20
=20
=20
-  1=0815=085.=08.5=085.=08.  O=08Ot=08th=08he=08er=08r c=08co=08on=08n=
t=08tr=08ri=08ib=08bu=08ut=08ti=08io=08on=08ns=08s
+  15.5.  Other contributions
=20
=20
   Bill Carr <Bill.Carr at compaq.com>  made the Red Hat mkrootfs scrip=
t
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

