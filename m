Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] mtd: allow mtd and jffs2 when ARCH=um
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
In-Reply-To: <201012150031.21417.rob@landley.net>
References: <22c797d00709272118i33d32b9dy93d5f5ec8f8edd30@mail.gmail.com>
	 <201012141849.03926.rob@landley.net> <20101215011904.GA24292@falooley.org>
	 <201012150031.21417.rob@landley.net>
Content-Type: text/plain; charset="utf-8"
Date: Thu, 16 Dec 2010 17:18:31 +0200
Message-ID: <1292512711.2364.85.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Landley <rob@landley.net>
Cc: Jason Lunz <lunz@acm.org>, Denys Vlasenko <vda.linux@googlemail.com>, richard -rw- weinberger <richard.weinberger@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, David Woodhouse <dwmw2@infradead.org>, atom ota <atomota@sleepyhammer.com>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, 2010-12-15 at 00:31 -0600, Rob Landley wrote:
> That is awesome and I'm not finding any documentation on it...  Ah:
> 
>   http://wiki.maemo.org/Modifying_the_root_image#Block_device_emulating_an_MTD_device
> 
> Wow that's awkward.  Let's see, that says...
> 
>   mknod /tmp/mtdblock0 b 31 0
>   modprobe loop
>   losetup /dev/loop0 rootfs.jffs2
>   modprobe mtdblock
>   modprobe block2mtd
>   # Note the ,128KiB is needed (on 2.6.26 at least) to set the
>   # eraseblock  size.
>   echo "/dev/loop0,128KiB" > /sys/module/block2mtd/parameters/block2mtd
>   modprobe jffs2
>   mount -t jffs2 /tmp/mtdblock0 /media/jffs2

You should not need mtdblock in modern kernels, it is legacy. You should
be abole to mount jffs2 on top of mtd0 with

mount -t jffs2 mtd0 /media/jffs2

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)

