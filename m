Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <david.francisco.rodriguez@gmail.com>)
	id 1Lhpi2-0005sA-QW for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Mar 2009 18:32:46 +0000
Received: from mail-qy0-f107.google.com ([209.85.221.107])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lhphy-0003S5-6C for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Mar 2009 18:32:46 +0000
Received: by qyk5 with SMTP id 5so2343017qyk.28
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 12 Mar 2009 11:32:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090311202221.GB5419@cs.unibo.it>
References: <20090311202221.GB5419@cs.unibo.it>
Date: Thu, 12 Mar 2009 11:32:39 -0700
Message-ID: <d875c4ca0903121132h8c38d7ase1182b0e2264526f@mail.gmail.com>
From: David Francisco Rodriguez Perez <david.francisco.rodriguez@gmail.com>
Subject: Re: [uml-devel] 2.6.29: IRQF_DISABLED is not guaranteed on shared
	IRQs
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6840484336581507080=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Renzo Davoli <renzo@cs.unibo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

--===============6840484336581507080==
Content-Type: multipart/alternative; boundary=001636e90f1d850ada0464f03562

--001636e90f1d850ada0464f03562
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Renzo


The patch seems to work for multicast interface between multiple VM.
vmlinux mem=128M eth0=mcast,,239.0.1.1
...
Configured mcast device: 239.0.1.1:1102-1
Choosing a random ethernet address for device eth0
Netdevice 0 (d6:26:50:fd:f8:ef) : mcast backend multicast address:
239.0.1.1:1102, TTL:1
eth0 (uml-netdev): not using net_device_ops yet

I can ping between different umls.

But in the case of tuntap networking It does not work.
./vmlinux umid=CMM mem=128M eth1=tuntap,,,192.168.1.1
...
Choosing a random ethernet address for device eth1
Netdevice 1 (aa:ba:ea:1b:93:c6) : <6>TUN/TAP backend - IP = 192.168.1.1
eth1 (uml-netdev): not using net_device_ops yet

Inside the uml

#ifconfig eth1 up
* modprobe tun
* ifconfig tap6 192.168.1.1 netmask 255.255.255.255 up
* bash -c echo 1 > /proc/sys/net/ipv4/ip_forward
IRQ 5/eth1: IRQF_DISABLED is not guaranteed on shared IRQs
# ifconfig eth1 192.168.1.2 up
* route add -host 192.168.1.2 dev tap6
* bash -c echo 1 > /proc/sys/net/ipv4/conf/tap6/proxy_arp

But then I can not ping from host to UML, neither from UML to host.

David



On Wed, Mar 11, 2009 at 1:22 PM, Renzo Davoli <renzo@cs.unibo.it> wrote:

> User-Mode Linux 2.6.29-rc* gives a lot of warnings during the boot:
>
> IRQ 2/console: IRQF_DISABLED is not guaranteed on shared IRQs
> IRQ 3/console-write: IRQF_DISABLED is not guaranteed on shared IRQs
> IRQ 5/eth0: IRQF_DISABLED is not guaranteed on shared IRQs
> IRQ 6/ssl: IRQF_DISABLED is not guaranteed on shared IRQs
> IRQ 7/ssl-write: IRQF_DISABLED is not guaranteed on shared IRQs
> IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs
> ...
>
> In fact there is a warning in kernel/irq/manage.c:682.
>  if ((irqflags & (IRQF_SHARED|IRQF_DISABLED))
>      == (IRQF_SHARED|IRQF_DISABLED))
>    pr_warning("IRQ %d/%s: IRQF_DISABLED is not "
>        "guaranteed on shared IRQs\n",
>        irq, devname);
>
> Jeff,
> It is necessary to have IRQF_DISABLED for shared IRQs?
> Can IRQF_DISABLED be switched off for all shared IRQ?
> Given that the masking policy is not guaranteed already, nothing
> should change, if it works it should continue to work.
>
> VDE networking does not work on 2.6.29-rc*.
> The patch here attached seems to fix the problem.
> Is it correct to switch off the IRQF_DISABLED flag for networking IRQ?
>
>        renzo
> -----
> --- arch/um/drivers/net_kern.c.orig     2009-03-11 21:16:36.000000000 +0100
> +++ arch/um/drivers/net_kern.c  2009-03-11 21:16:46.000000000 +0100
> @@ -165,7 +165,7 @@
>        }
>
>        err = um_request_irq(dev->irq, lp->fd, IRQ_READ, uml_net_interrupt,
> -                            IRQF_DISABLED | IRQF_SHARED, dev->name, dev);
> +                            IRQF_SHARED, dev->name, dev);
>        if (err != 0) {
>                printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n",
> err);
>                err = -ENETUNREACH;
>
>
>
>
> ------------------------------------------------------------------------------
> Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
> powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
> easily build your RIAs with Flex Builder, the Eclipse(TM)based development
> software that enables intelligent coding and step-through debugging.
> Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>

--001636e90f1d850ada0464f03562
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Renzo<br><br><br>The patch seems to work for multicast interface between=
 multiple VM.<br>vmlinux mem=3D128M eth0=3Dmcast,,239.0.1.1 <br>...<br>Conf=
igured mcast device: 239.0.1.1:1102-1<br>Choosing a random ethernet address=
 for device eth0<br>
Netdevice 0 (d6:26:50:fd:f8:ef) : mcast backend multicast address: <a href=
=3D"http://239.0.1.1:1102">239.0.1.1:1102</a>, TTL:1<br>eth0 (uml-netdev): =
not using net_device_ops yet<br><br>I can ping between different umls.<br>
<br>But in the case of tuntap networking It does not work.<br>./vmlinux umi=
d=3DCMM mem=3D128M eth1=3Dtuntap,,,192.168.1.1<br>...<br>Choosing a random =
ethernet address for device eth1<br>Netdevice 1 (aa:ba:ea:1b:93:c6) : &lt;6=
&gt;TUN/TAP backend - IP =3D 192.168.1.1<br>
eth1 (uml-netdev): not using net_device_ops yet<br><br>Inside the uml<br><b=
r>#ifconfig eth1 up<br>* modprobe tun<br>* ifconfig tap6 192.168.1.1 netmas=
k 255.255.255.255 up<br>* bash -c echo 1 &gt; /proc/sys/net/ipv4/ip_forward=
<br>
IRQ 5/eth1: IRQF_DISABLED is not guaranteed on shared IRQs<br># ifconfig et=
h1 192.168.1.2 up<br>* route add -host 192.168.1.2 dev tap6<br>* bash -c ec=
ho 1 &gt; /proc/sys/net/ipv4/conf/tap6/proxy_arp<br><br>But then I can not =
ping from host to UML, neither from UML to host.<br>
<br>David<br><br><br><br><div class=3D"gmail_quote">On Wed, Mar 11, 2009 at=
 1:22 PM, Renzo Davoli <span dir=3D"ltr">&lt;<a href=3D"mailto:renzo@cs.uni=
bo.it">renzo@cs.unibo.it</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0p=
t 0pt 0.8ex; padding-left: 1ex;">
User-Mode Linux 2.6.29-rc* gives a lot of warnings during the boot:<br>
<br>
IRQ 2/console: IRQF_DISABLED is not guaranteed on shared IRQs<br>
IRQ 3/console-write: IRQF_DISABLED is not guaranteed on shared IRQs<br>
IRQ 5/eth0: IRQF_DISABLED is not guaranteed on shared IRQs<br>
IRQ 6/ssl: IRQF_DISABLED is not guaranteed on shared IRQs<br>
IRQ 7/ssl-write: IRQF_DISABLED is not guaranteed on shared IRQs<br>
IRQ 10/winch: IRQF_DISABLED is not guaranteed on shared IRQs<br>
...<br>
<br>
In fact there is a warning in kernel/irq/manage.c:682.<br>
 =A0if ((irqflags &amp; (IRQF_SHARED|IRQF_DISABLED))<br>
 =A0 =A0 =A0=3D=3D (IRQF_SHARED|IRQF_DISABLED))<br>
 =A0 =A0pr_warning(&quot;IRQ %d/%s: IRQF_DISABLED is not &quot;<br>
 =A0 =A0 =A0 =A0&quot;guaranteed on shared IRQs\n&quot;,<br>
 =A0 =A0 =A0 =A0irq, devname);<br>
<br>
Jeff,<br>
It is necessary to have IRQF_DISABLED for shared IRQs?<br>
Can IRQF_DISABLED be switched off for all shared IRQ?<br>
Given that the masking policy is not guaranteed already, nothing<br>
should change, if it works it should continue to work.<br>
<br>
VDE networking does not work on 2.6.29-rc*.<br>
The patch here attached seems to fix the problem.<br>
Is it correct to switch off the IRQF_DISABLED flag for networking IRQ?<br>
<br>
 =A0 =A0 =A0 =A0renzo<br>
-----<br>
--- arch/um/drivers/net_kern.c.orig =A0 =A0 2009-03-11 21:16:36.000000000 +=
0100<br>
+++ arch/um/drivers/net_kern.c =A02009-03-11 21:16:46.000000000 +0100<br>
@@ -165,7 +165,7 @@<br>
 =A0 =A0 =A0 =A0}<br>
<br>
 =A0 =A0 =A0 =A0err =3D um_request_irq(dev-&gt;irq, lp-&gt;fd, IRQ_READ, um=
l_net_interrupt,<br>
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_DISABLED | IR=
QF_SHARED, dev-&gt;name, dev);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0IRQF_SHARED, dev-&=
gt;name, dev);<br>
 =A0 =A0 =A0 =A0if (err !=3D 0) {<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR &quot;uml_net_open: failed =
to get irq(%d)\n&quot;, err);<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D -ENETUNREACH;<br>
<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are<br>
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and<br=
>
easily build your RIAs with Flex Builder, the Eclipse(TM)based development<=
br>
software that enables intelligent coding and step-through debugging.<br>
Download the free 60 day trial. <a href=3D"http://p.sf.net/sfu/www-adobe-co=
m" target=3D"_blank">http://p.sf.net/sfu/www-adobe-com</a><br>
_______________________________________________<br>
User-mode-linux-devel mailing list<br>
<a href=3D"mailto:User-mode-linux-devel@lists.sourceforge.net">User-mode-li=
nux-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/user-mode-linux-dev=
el" target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/user-mod=
e-linux-devel</a><br>
</blockquote></div><br>

--001636e90f1d850ada0464f03562--


--===============6840484336581507080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
--===============6840484336581507080==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============6840484336581507080==--


