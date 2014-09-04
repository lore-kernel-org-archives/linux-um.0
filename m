Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1XPcUa-0005pt-8J
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:14:48 +0000
Received: from mail-vc0-f171.google.com ([209.85.220.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XPcUZ-0001LD-HH
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2014 19:14:48 +0000
Received: by mail-vc0-f171.google.com with SMTP id id10so11247173vcb.30
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Sep 2014 12:14:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
References: <1409857227-717756-1-git-send-email-anton.ivanov@kot-begemot.co.uk>
Date: Thu, 4 Sep 2014 21:14:41 +0200
Message-ID: <CAFLxGvziZuz1oYAittyKbgeLd24e38Nv05Bqu+KdJ4qRabhQcQ@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
To: anton.ivanov@kot-begemot.co.uk
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Thu, Sep 4, 2014 at 9:00 PM,  <anton.ivanov@kot-begemot.co.uk> wrote:
>
> Patch dependencies:
>
> [PATCH v3 01/10] Epoll based interrupt controller
>
> Full redesign of the existing UML poll based controller. The old
> poll controller incurs huge penalties for IRQ sharing and many devices
> setup due to the device list being walked twice.
>
> Additionally, the current controller has no notion of true Edge,
> Level and Write completion IRQs.
>
> This patch fixes the list walking bottleneck and adds all of
> the above alowing for UML to be scaled to 100s of devices
> (tested with 512+ network devices).
>
> [PATCH v3 02/10] Remove unnecessary 'reactivate' statements
>
> As a result of adding true Edge/Level semantics in the epoll
> controller there is no need to do the "reactivate fd" any more.
>
> This one is an enhancement of 1 and depends on it.
>
> [PATCH v3 03/10] High performance networking subsystem
>
> This patchset adds vector IO ops for xmit and receive. Xmit
> is optional (as it depends on a 3.0+ host), receive is always on.
>
> The result is that UML can now hit 1G+ rates for transports
> which have been enabled to use these. Presently this patchset
> is kept as "legacy" as possible without leveraging the possibility
> to do a true write completion poll from the new IRQ controller.
> This further performance improvement will be submitted separately.
>
> This patch has been tested extensively only with patchsets 1 and 2.
>
> [PATCH v3 04/10] L2TPv3 Transport Driver for UML
>
> This is an implementation of the Ethernet over L2TPv3 protocol
> leveraging both the epoll controller and the high perf vector IO.
> It has been extensively tested to interop versus a set of
> other implementations including Linux kernel, our port of the
> same concept to QEMU/KVM, routers, etc.
>
> Depends on 3.
>
> [PATCH v3 05/10] GRE transport for UML
>
> Same as L2TPv3 for GRE. Depends on 3
>
> [PATCH v3 06/10] RAW Ethernet transport for UML
>
> True raw driver (note - all TSO/GSO options in the NIC must
> be turned off). Breaks through the 1G barrier with a vengeance
> and CPU to spare. Depends on 3.
>
> [PATCH v3 07/10] Performance and NUMA improvements for ubd
>
> This is a well known issue/fix, qemu has the same one. If you
> do not use pwrite you can kill a machine on cache sync with
> ease. This patch is independent of the others.
>
> [PATCH v3 08/10] Minor performance optimization for ubd
>
> Obvious minor optimization, independent of the others.
>
> [PATCH v3 09/10] Better IPC for UBD
>
> Obvious optimization, independent of the others. Pipe has a
> very short queue which has 4k granularity. It is a bad IPC
> for passing a lot of small chunks one at a time as used in UBD.
>
> [PATCH v3 10/10] High Resolution Timer subsystem for UML
>
> This version of the patch applies only to the epoll controller.
> Otherwise, the patch with minimal modifications can be applied to
> stock UML. It fixes UML as far as its use for network appliance
> on all counts - TCP performance, QoS, traffic shaping, etc.
>
> The patch is not pretty (I would have preferred to kill itimer
> completely). It however does what it says on the tin and has been
> doing it in testing for 2 years or so now.
>
> Enjoy

Thanks a lot for your work!
As I'm horrible backlogged I'll at best have next week the time to
look at your patches.

Thanks,
//richard

------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

