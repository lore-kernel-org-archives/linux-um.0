Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1XYhRI-0007K2-3e
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Sep 2014 20:20:56 +0000
Received: from mail-vc0-f179.google.com ([209.85.220.179])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1XYhRH-0002az-BY
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Sep 2014 20:20:56 +0000
Received: by mail-vc0-f179.google.com with SMTP id im17so3368541vcb.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 29 Sep 2014 13:20:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1412015343.9609.13.camel@localhost.localdomain>
References: <1412015343.9609.13.camel@localhost.localdomain>
Date: Mon, 29 Sep 2014 22:20:49 +0200
Message-ID: <CAFLxGvxD=+VxJeGkKS_Ukq5m3KvV5femmhVWYdm1XFYGHauBqw@mail.gmail.com>
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
Subject: Re: [uml-devel] [systemd-devel] Timed out waiting for device
	dev-disk-by...
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "systemd-devel@lists.freedesktop.org" <systemd-devel@lists.freedesktop.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Sep 29, 2014 at 8:29 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> Hi,
>
> I get a timeout in the Fedora 21 alpha:
>
> [ TIME ] Timed out waiting for device dev-disk-by\x2duuid-008af19d\x2d2562\x2d49bd\x2d8907\x2d721ea08f3e14.device.
>
> But all devices are available from early kernel start:
> # ls -l /dev/disk/by-uuid/
> total 0
> lrwxrwxrwx 1 root root 11 Sep 29 20:17 008af19d-2562-49bd-8907-721ea08f3e14 -> ../../ubda1
> lrwxrwxrwx 1 root root 11 Sep 29 20:17 e2bffa45-d84f-47bc-81ba-e7a395751fa6 -> ../../ubda3
> lrwxrwxrwx 1 root root 11 Sep 29 20:17 f452f020-a446-41ed-93c0-ee5ce56d6ea4 -> ../../ubda2
>
> It feels like some event notification is lost in the boot process or something like this?!
>
> What exactly makes the device unit go into the state active/plugged?
>
> This is a boot of the Fedora 21 alpha under user mode linux.
>
> Any ideas what could be wrong here?

Please always CC me and/or the UML mailinglist in case of UML related issues.
I'm very interested in having UML work with systemd.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

