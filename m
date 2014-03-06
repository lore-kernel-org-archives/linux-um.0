Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <antivano@cisco.com>) id 1WLSAW-0002TN-9I
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Mar 2014 06:52:36 +0000
Received: from rcdn-iport-3.cisco.com ([173.37.86.74])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WLSAS-00081C-IC
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Mar 2014 06:52:36 +0000
From: "Anton Ivanov (antivano)" <antivano@cisco.com>
Date: Thu, 6 Mar 2014 06:52:25 +0000
Message-ID: <53181B01.4020209@cisco.com>
References: <53104888.8040404@cisco.com> <531049CD.7050502@nod.at>
	<53104ED5.10007@cisco.com>
In-Reply-To: <53104ED5.10007@cisco.com>
Content-Language: en-US
MIME-Version: 1.0
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0585308242175188299=="
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Contribution - Bug fixes and contributions to UML
To: Richard Weinberger <richard@nod.at>
Cc: "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

--===============0585308242175188299==
Content-Language: en-US
Content-Type: multipart/alternative; boundary="_000_53181B014020209ciscocom_"

--_000_53181B014020209ciscocom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

HI Richard, hi list.

I will reformat these (as well as the new drivers), clean them up to the cu=
rrent coding standard and resubmit so it will be easier to review them and =
consider form merging.

Apology for not coming back to this earlier - I was busy with the qemu coun=
terparts of the transport patches (I will also apply the "lessons learned" =
from there to these).

A.

On 28/02/14 08:54, Anton Ivanov (antivano) wrote:

Bugfixes.

I need to pull actual changesets for the drivers, etc properly and
verify that they build so those will be coming next week. You will be
getting them one by one.

1. Memory corruption.

The reverse case of this race (you need to msync, before you do non-mmap
fileops) is well known and textbook. This is the first and only time I
have seen this one (fsync before mmap). I have not heard it mentioned
either. It is however fairly easy to reproduce. If you run 200+ UML on a
system ~0.2-0.5% will always die at startup with a memory corruption
warning. While this does not happen every time (0.2-0.5% and only on
startup) it is very reproducible for systems running lots of UMLs.

Once this fix went in we stopped seeing that one. Observed on 3.2, 3.3
and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

2. SIGPIPE.

Linux actually produces SIGPIPE ane EPIPE not only on missing reader. It
will produce it under some circumstances on a stalled reader. Discovered
when running UML under expect and/or trying to use fds and other virtual
serials to do management transactions.

While I have  not seen it on UML internal pipes I would not be surprised
if you can reproduce it there too (f.e. if ubd thread is too slow). So
SIGPIPE needs to be disabled. From there on, for most drivers have
correct error handling for this.

Observed on 3.2, 3.3 and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

A.


On 28/02/14 08:33, Richard Weinberger wrote:


Am 28.02.2014 09:27, schrieb Anton Ivanov (antivano):


Hi Richard, Hi Jeff, hi list,

On behalf of Cisco systems, I am authorized to make a offer a set bug
fixes as well as contribute several additional features and performance
improvements to UML. All of these have been used internally for a couple
of years and will ship as parts of product(s) in the near future. Some
of these improve performance by up to 8 times on use cases which are of
interest to us and are likely to be of interest to the community.

As the full patchset is now in the 100k+ zone, so I am going to do only
the announcement now and submit the patches one by one after that over
the next 1-2 weeks.

We will submit separately bug fixes for:

1. Critical memory corruption on startup observed on heavily loaded
machines (especially when multiple UMLs run simultaneously).
2. Fix(es) for incorrect handling of error conditions when UML is run
under expect and conX=3Dfd: is used to communicate with another process.
The same error may be observed on internal UML IPCs too leading to
immediate crash.

I will also file bugs for both vs Debian UML package so that patches for
both can go in ASAP.

In addition to the bug fixes, the new features include:

1. Several transports. All can do up to multi-gigabit throughput on some
scenarios. We are contributing their counterparts to qemu/kvm as well.

1.1. Direct connection of UML to overlay networks/L2 VPNs using L2TPv3.

This has a number of advantages compared to the existing UML "multicast"
and qemu "socket" transports.

    * Standard compliant - RFC 3931 updated recently by RFC 5641
    * Supported on most network equipment
    * Allowing to move virtual switching off-host to an NPU or high
performance physical switch
    * Allowing to mix virtual and physical switching (well supported on
modern Linuxes and other OSes)
    * Well researched security profile as well as established
interactions with IPSEC allowing to extend virtual networks outside the
datacenter to remote physical devices and/or VMs.

1.2. Raw transport which allows both bi-directional communication with
any network device which looks like Ethernet as well as in-span
listening at speeds in the multi-gigabit range.

1.3. We intend to contribute other key overlay transports like GRE, etc
as well. The ones we are contributing at this point are the ones which
we have used most extensively and have had the most testing (~ 1.5-2 years)=
.

2. New high res timer subsystem

Adding these new network transports to UML revealed a key issue - it
cannot meter or shape any traffic correctly as its internal timer system
is way off. Personally, I consider it a bug, however there is no "easy"
fix here. The only way to fix it is a new timer driver. Unfortunately,
it does not fix uml userspace - timers there remain off. It does fix all
kernel timer functionality - traffic shaping (both qdisc and iptables
traffic limits).

As a side effect, this provides performance improvements for tcp and
other protocols which rely on kernel high res timers for their state
machines.

We have further scalability contributions lined up which improve network
and IO performance between 1.5 and 8 times (depending on use case),
allow hundreds of virtual interfaces per UML without performance
penalties, allow to run several hundreds (if not thousands) of UMLs per
machine, etc. All in all, it can no go where no virtualization and no
virtual networking has gone before.

However, I would prefer to take it one step at a time and get through
these first (even these are quite a lot for one "sitting").


Sounds awesome!

Please send the patches as soon as possible.
I'm eager to test and merge them.

Thanks,
//richard







---------------------------------------------------------------------------=
---
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=3D126839071&iu=3D/4140/ostg.c=
lktrk



_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net<mailto:User-mode-linux-devel@li=
sts.sourceforge.net>
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



--_000_53181B014020209ciscocom_
Content-Type: text/html; charset="iso-8859-1"
Content-ID: <0C840C84272B9843B6D0B93EA2BC7CCB@emea.cisco.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
</head>
<body bgcolor=3D"#FFFFFF" text=3D"#000000">
HI Richard, hi list.<br>
<br>
I will reformat these (as well as the new drivers), clean them up to the cu=
rrent coding standard and resubmit so it will be easier to review them and =
consider form merging.<br>
<br>
Apology for not coming back to this earlier - I was busy with the qemu coun=
terparts of the transport patches (I will also apply the &quot;lessons lear=
ned&quot; from there to these).<br>
<br>
A.<br>
<br>
On 28/02/14 08:54, Anton Ivanov (antivano) wrote:
<blockquote cite=3D"mid:53104ED5.10007@cisco.com" type=3D"cite">
<pre wrap=3D"">Bugfixes.

I need to pull actual changesets for the drivers, etc properly and
verify that they build so those will be coming next week. You will be
getting them one by one.

1. Memory corruption.

The reverse case of this race (you need to msync, before you do non-mmap
fileops) is well known and textbook. This is the first and only time I
have seen this one (fsync before mmap). I have not heard it mentioned
either. It is however fairly easy to reproduce. If you run 200&#43; UML on =
a
system ~0.2-0.5% will always die at startup with a memory corruption
warning. While this does not happen every time (0.2-0.5% and only on
startup) it is very reproducible for systems running lots of UMLs.

Once this fix went in we stopped seeing that one. Observed on 3.2, 3.3
and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

2. SIGPIPE.

Linux actually produces SIGPIPE ane EPIPE not only on missing reader. It
will produce it under some circumstances on a stalled reader. Discovered
when running UML under expect and/or trying to use fds and other virtual
serials to do management transactions.

While I have  not seen it on UML internal pipes I would not be surprised
if you can reproduce it there too (f.e. if ubd thread is too slow). So
SIGPIPE needs to be disabled. From there on, for most drivers have
correct error handling for this.

Observed on 3.2, 3.3 and 3.8, fix tested on 3.2, 3.3, 3.4 and 3.8.

A.


On 28/02/14 08:33, Richard Weinberger wrote:
</pre>
<blockquote type=3D"cite">
<pre wrap=3D"">Am 28.02.2014 09:27, schrieb Anton Ivanov (antivano):
</pre>
<blockquote type=3D"cite">
<pre wrap=3D"">Hi Richard, Hi Jeff, hi list,

On behalf of Cisco systems, I am authorized to make a offer a set bug
fixes as well as contribute several additional features and performance
improvements to UML. All of these have been used internally for a couple
of years and will ship as parts of product(s) in the near future. Some
of these improve performance by up to 8 times on use cases which are of
interest to us and are likely to be of interest to the community.

As the full patchset is now in the 100k&#43; zone, so I am going to do only
the announcement now and submit the patches one by one after that over
the next 1-2 weeks.

We will submit separately bug fixes for:

1. Critical memory corruption on startup observed on heavily loaded
machines (especially when multiple UMLs run simultaneously).
2. Fix(es) for incorrect handling of error conditions when UML is run
under expect and conX=3Dfd: is used to communicate with another process.
The same error may be observed on internal UML IPCs too leading to
immediate crash.

I will also file bugs for both vs Debian UML package so that patches for
both can go in ASAP.

In addition to the bug fixes, the new features include:

1. Several transports. All can do up to multi-gigabit throughput on some
scenarios. We are contributing their counterparts to qemu/kvm as well.

1.1. Direct connection of UML to overlay networks/L2 VPNs using L2TPv3.

This has a number of advantages compared to the existing UML &quot;multicas=
t&quot;
and qemu &quot;socket&quot; transports.

    * Standard compliant - RFC 3931 updated recently by RFC 5641
    * Supported on most network equipment
    * Allowing to move virtual switching off-host to an NPU or high
performance physical switch
    * Allowing to mix virtual and physical switching (well supported on
modern Linuxes and other OSes)
    * Well researched security profile as well as established
interactions with IPSEC allowing to extend virtual networks outside the
datacenter to remote physical devices and/or VMs.

1.2. Raw transport which allows both bi-directional communication with
any network device which looks like Ethernet as well as in-span
listening at speeds in the multi-gigabit range.

1.3. We intend to contribute other key overlay transports like GRE, etc
as well. The ones we are contributing at this point are the ones which
we have used most extensively and have had the most testing (~ 1.5-2 years)=
.

2. New high res timer subsystem

Adding these new network transports to UML revealed a key issue - it
cannot meter or shape any traffic correctly as its internal timer system
is way off. Personally, I consider it a bug, however there is no &quot;easy=
&quot;
fix here. The only way to fix it is a new timer driver. Unfortunately,
it does not fix uml userspace - timers there remain off. It does fix all
kernel timer functionality - traffic shaping (both qdisc and iptables
traffic limits).

As a side effect, this provides performance improvements for tcp and
other protocols which rely on kernel high res timers for their state
machines.

We have further scalability contributions lined up which improve network
and IO performance between 1.5 and 8 times (depending on use case),
allow hundreds of virtual interfaces per UML without performance
penalties, allow to run several hundreds (if not thousands) of UMLs per
machine, etc. All in all, it can no go where no virtualization and no
virtual networking has gone before.

However, I would prefer to take it one step at a time and get through
these first (even these are quite a lot for one &quot;sitting&quot;).
</pre>
</blockquote>
<pre wrap=3D"">Sounds awesome!

Please send the patches as soon as possible.
I'm eager to test and merge them.

Thanks,
//richard
</pre>
</blockquote>
<pre wrap=3D"">
</pre>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre wrap=3D"">------------------------------------------------------------=
------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis &amp; security monitoring. All-in-one tool.
<a class=3D"moz-txt-link-freetext" href=3D"http://pubads.g.doubleclick.net/=
gampad/clk?id=3D126839071&amp;iu=3D/4140/ostg.clktrk">http://pubads.g.doubl=
eclick.net/gampad/clk?id=3D126839071&amp;iu=3D/4140/ostg.clktrk</a></pre>
<br>
<fieldset class=3D"mimeAttachmentHeader"></fieldset> <br>
<pre wrap=3D"">_______________________________________________
User-mode-linux-devel mailing list
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:User-mode-linux-devel@=
lists.sourceforge.net">User-mode-linux-devel@lists.sourceforge.net</a>
<a class=3D"moz-txt-link-freetext" href=3D"https://lists.sourceforge.net/li=
sts/listinfo/user-mode-linux-devel">https://lists.sourceforge.net/lists/lis=
tinfo/user-mode-linux-devel</a>
</pre>
</blockquote>
<br>
</body>
</html>

--_000_53181B014020209ciscocom_--


--===============0585308242175188299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Subversion Kills Productivity. Get off Subversion & Make the Move to Perforce.
With Perforce, you get hassle-free workflows. Merge that actually works. 
Faster operations. Version large binaries.  Built-in WAN optimization and the
freedom to use Git, Perforce or both. Make the move to Perforce.
http://pubads.g.doubleclick.net/gampad/clk?id=122218951&iu=/4140/ostg.clktrk
--===============0585308242175188299==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0585308242175188299==--


