Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XVPEP-0000yQ-Ld
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 18:18:01 +0000
Received: from ivanoab3.miniserver.com ([89.200.143.206])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XVPEO-00037U-3M
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 18:18:01 +0000
Received: from tun252.maui-covenant.sigsegv.cx ([192.168.17.6]
	helo=falkor.sigsegv.cx) by ivanoab3.miniserver.com with esmtps
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.72)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1XVPDM-0003ui-AZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 18:16:56 +0000
Received: from angua.kot-begemot.co.uk ([192.168.18.13])
	by falkor.sigsegv.cx with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:128)
	(Exim 4.80) (envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1XVPEG-0003FZ-Ll for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 20 Sep 2014 19:17:52 +0100
Message-ID: <541DC4B9.5030202@kot-begemot.co.uk>
Date: Sat, 20 Sep 2014 18:17:29 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
	<CAFLxGvziZuz1oYAittyKbgeLd24e38Nv05Bqu+KdJ4qRabhQcQ@mail.gmail.com>
In-Reply-To: <CAFLxGvziZuz1oYAittyKbgeLd24e38Nv05Bqu+KdJ4qRabhQcQ@mail.gmail.com>
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
Subject: Re: [uml-devel] UML Performance improvement patchset
To: user-mode-linux-devel@lists.sourceforge.net

Hi list,

Some benchmarks (current version, I believe this can do more once it 
gains full epoll write support).

4 UMLs running in parallel, each pinned to a core, new raw driver - vlan 
per UML, 10G NIC on 4 core 3.5GHz A8 connected back to back to an 8 core 
machine running iperf server.

Server listening on TCP port 5001
TCP window size: 85.3 KByte (default)
------------------------------------------------------------
[  4] local 192.168.63.1 port 5001 connected with 192.168.63.18 port 36946
[  5] local 192.168.63.1 port 5001 connected with 192.168.63.3 port 33628
[  6] local 192.168.63.1 port 5001 connected with 192.168.63.34 port 50217
[  7] local 192.168.63.1 port 5001 connected with 192.168.63.50 port 40107
[ ID] Interval       Transfer     Bandwidth
[  4]  0.0-240.0 sec  40.8 GBytes  1.46 Gbits/sec
[  5]  0.0-240.0 sec  40.4 GBytes  1.44 Gbits/sec
[  6]  0.0-240.0 sec  39.9 GBytes  1.43 Gbits/sec
[  7]  0.0-240.0 sec  39.5 GBytes  1.41 Gbits/sec

For a nice rounded total of: 5.6GBit from a 4 core machine under virtualization, no offloads - true raw power as needed for network applications.

For comparative purposes one CPU with the other ones not loaded is:

root@Hive:~# iperf -t 240 -c 192.168.63.1
------------------------------------------------------------
Client connecting to 192.168.63.1, TCP port 5001
TCP window size: 22.5 KByte (default)
------------------------------------------------------------
[  3] local 192.168.63.3 port 33629 connected with 192.168.63.1 port 5001
[ ID] Interval       Transfer     Bandwidth
[  3]  0.0-240.0 sec  63.3 GBytes  2.26 Gbits/sec

If I use tap on the same machine I get significantly less than that. It 
is also more than I can get out kvm on the same machine (with offloads 
off so it something which is applicable to network applications).

A.

P.S. I think I have found all the issues that were introduced when 
porting the original 3.3.8 patch to the current linux tree, I will 
submit a new version which has the fixes on Monday.

A.

On 09/04/14 19:14, Richard Weinberger wrote:
> On Thu, Sep 4, 2014 at 9:00 PM,  <anton.ivanov@kot-begemot.co.uk> wrote:
>> Patch dependencies:
>>
>> [PATCH v3 01/10] Epoll based interrupt controller
>>
>> Full redesign of the existing UML poll based controller. The old
>> poll controller incurs huge penalties for IRQ sharing and many devices
>> setup due to the device list being walked twice.
>>
>> Additionally, the current controller has no notion of true Edge,
>> Level and Write completion IRQs.
>>
>> This patch fixes the list walking bottleneck and adds all of
>> the above alowing for UML to be scaled to 100s of devices
>> (tested with 512+ network devices).
>>
>> [PATCH v3 02/10] Remove unnecessary 'reactivate' statements
>>
>> As a result of adding true Edge/Level semantics in the epoll
>> controller there is no need to do the "reactivate fd" any more.
>>
>> This one is an enhancement of 1 and depends on it.
>>
>> [PATCH v3 03/10] High performance networking subsystem
>>
>> This patchset adds vector IO ops for xmit and receive. Xmit
>> is optional (as it depends on a 3.0+ host), receive is always on.
>>
>> The result is that UML can now hit 1G+ rates for transports
>> which have been enabled to use these. Presently this patchset
>> is kept as "legacy" as possible without leveraging the possibility
>> to do a true write completion poll from the new IRQ controller.
>> This further performance improvement will be submitted separately.
>>
>> This patch has been tested extensively only with patchsets 1 and 2.
>>
>> [PATCH v3 04/10] L2TPv3 Transport Driver for UML
>>
>> This is an implementation of the Ethernet over L2TPv3 protocol
>> leveraging both the epoll controller and the high perf vector IO.
>> It has been extensively tested to interop versus a set of
>> other implementations including Linux kernel, our port of the
>> same concept to QEMU/KVM, routers, etc.
>>
>> Depends on 3.
>>
>> [PATCH v3 05/10] GRE transport for UML
>>
>> Same as L2TPv3 for GRE. Depends on 3
>>
>> [PATCH v3 06/10] RAW Ethernet transport for UML
>>
>> True raw driver (note - all TSO/GSO options in the NIC must
>> be turned off). Breaks through the 1G barrier with a vengeance
>> and CPU to spare. Depends on 3.
>>
>> [PATCH v3 07/10] Performance and NUMA improvements for ubd
>>
>> This is a well known issue/fix, qemu has the same one. If you
>> do not use pwrite you can kill a machine on cache sync with
>> ease. This patch is independent of the others.
>>
>> [PATCH v3 08/10] Minor performance optimization for ubd
>>
>> Obvious minor optimization, independent of the others.
>>
>> [PATCH v3 09/10] Better IPC for UBD
>>
>> Obvious optimization, independent of the others. Pipe has a
>> very short queue which has 4k granularity. It is a bad IPC
>> for passing a lot of small chunks one at a time as used in UBD.
>>
>> [PATCH v3 10/10] High Resolution Timer subsystem for UML
>>
>> This version of the patch applies only to the epoll controller.
>> Otherwise, the patch with minimal modifications can be applied to
>> stock UML. It fixes UML as far as its use for network appliance
>> on all counts - TCP performance, QoS, traffic shaping, etc.
>>
>> The patch is not pretty (I would have preferred to kill itimer
>> completely). It however does what it says on the tin and has been
>> doing it in testing for 2 years or so now.
>>
>> Enjoy
> Thanks a lot for your work!
> As I'm horrible backlogged I'll at best have next week the time to
> look at your patches.
>
> Thanks,
> //richard
>
> ------------------------------------------------------------------------------
> Slashdot TV.
> Video for Nerds.  Stuff that matters.
> http://tv.slashdot.org/
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

