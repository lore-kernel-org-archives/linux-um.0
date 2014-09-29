Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1XYiR7-0003Ec-Ep
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Sep 2014 21:24:49 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XYiR5-00016Y-H4
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Sep 2014 21:24:49 +0000
Message-ID: <1412025877.9609.14.camel@localhost.localdomain>
From: Thomas Meyer <thomas@m3y3r.de>
Date: Mon, 29 Sep 2014 23:24:37 +0200
In-Reply-To: <CAFLxGvxGarwQK-mOMQ=RSjtRLmjy0YP6bBQUND+mqX+S7uWkYA@mail.gmail.com>
References: <1412012167.9609.7.camel@localhost.localdomain>
	<CAFLxGvxGarwQK-mOMQ=RSjtRLmjy0YP6bBQUND+mqX+S7uWkYA@mail.gmail.com>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] Remove default root?
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Am Montag, den 29.09.2014, 22:17 +0200 schrieb Richard Weinberger:
> On Mon, Sep 29, 2014 at 7:36 PM, Thomas Meyer <thomas@m3y3r.de> wrote:
> > Hi,
> >
> > I tried to install the latest Fedora 21 from the Network Install Image
> > DVD (
> > https://fedoraproject.org/get-prerelease#server
> > http://download.fedoraproject.org/pub/fedora/linux/releases/test/21-Alpha/Server/x86_64/iso/Fedora-Server-netinst-x86_64-21_Alpha.iso )
> >
> > I did these step to install the distribution:
> >
> > 1.) Extract the initrd and boot options from the DVD via a loop device
> > mount
> > 2.) Boot UML with:
> >
> > linux mem=800M umid=fedora21 eth0=tuntap,,,192.168.1.150
> > ubd0=images/Fedora21-Root.img
> > ubd1=images/Fedora-Server-netinst-x86_64-21_Alpha.iso plymouth.enable=0
> > initrd=images/initrd.img inst.stage2=hd:LABEL=Fedora-S-21_A-x86_64
> > ip=192.168.1.151::192.168.1.150:255.255.255.0:servername:eth0:off
> > nameserver=8.8.8.8
> >
> > 3.) I only added the option "plymouth.enable=0" because the plymouth
> > get's confused by the missing KMS(?!)
> >
> > The problem is, that this only works when I remove the default root
> > option from UML, as the dracut, get's confused by the root= option.
> >
> > So as many modern distributions boot via an initramfs image and
> > autodetect the root partition automatically, I want to know what do you
> > think about the removal of the default root option from UML?
> 
> This would break many existing setups.
> Does your setup work if you just pass "root=" as command line?
> In this case UML would not append the default root.

I think I did run into the same timeout issue in systemd waiting forever
to the device to appear.
So, it's maybe better to fix the real underlying bug here.

> 



------------------------------------------------------------------------------
Slashdot TV.  Videos for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

