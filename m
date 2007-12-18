Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J4jPl-0003Nl-13 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Dec 2007 12:51:45 -0800
Received: from smtp.bluecom.no ([193.75.75.28])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J4jPi-0002E6-CU
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Dec 2007 12:51:44 -0800
From: Stian Skjelstad <stian@nixia.no>
In-Reply-To: <200712181245.23753.rob@landley.net>
References: <200712181245.23753.rob@landley.net>
Date: Tue, 18 Dec 2007 20:14:15 +0100
Message-Id: <1198005255.7293.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [uml-devel] Loopback mounting jffs2 under UML?
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

I did try UML + blkmtd and jffs statically compiled in a couple of years
ago and it then almost worked out of the box. It failed then for me due
to a very small issue: the initializers in the different drivers
initialized in the wrong order, so I got a panic due to a
null-dereference. (driver initialization does/didn't have depencies).

Just me five cents :-)

Stian

On Tue, 2007-12-18 at 12:45 -0600, Rob Landley wrote:
> I want to loopback mount a jffs2 filesystem, and this filesystem has 
> incestuous knowledge of flash devices for wear levelling and stuff, so it 
> will only mount an actual flash device and not a normal block device.
> 
> There's a way to make a loopback device look like a flash device, letting you 
> loopback mount jffs2, but it involves recompiling the kerenel to add support 
> for it, and of course I went "User Mode Linux"...  Except that UML disables 
> the flash menu entirely.
> 
> Basically, I need to be able to enable MTD_BLOCK so I can go:
> 
>   losetup /dev/loop0 /path/to/imagefile.jffs2
>   insmod blkmtd erasesz=256 device=/dev/loop0
>   mount -t jffs2 /dev/mtdblock0 /mnt
> 
> This shouldn't need any actual flash hardware.  It's just layering another 
> translation layer on top of loopback.
> 
> Suggestions?
> 
> Rob


-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
