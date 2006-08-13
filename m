Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCE5A-000601-Bp for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 04:24:40 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCE59-0003dA-IG
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 04:24:40 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 13 Aug 2006 13:24:28 +0200
References: <BAY101-F23508A11EBFB151C043062E2490@phx.gbl>
In-Reply-To: <BAY101-F23508A11EBFB151C043062E2490@phx.gbl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608131324.29081.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [ link to patch] resurrecting the uml-hcd
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: James McMechan <james_mcmechan@hotmail.com>, linux-usb-devel@lists.sourceforge.net

On Sunday 13 August 2006 06:10, James McMechan wrote:
> I am attempting to resurrect the uml-hcd driver
> this version is based off of the gadget/dummy_hcd.c driver.
>
> I am aiming at a 2.6.12.2 target where it will be used.
> I have forward ported it to 2.6.17.6 for testing and hopefully
> eventual inclusion.
>
> This patch has a #PLATFORM to deal with the issues between
> 2.6.17.6/2.6.12.2 since platform_register... is not present in older
> kernels and the new kernels don't work with the older registration.

That's ok in drivers, however if at all possible have that in headers rather 
than code (i.e. as CodingStyle says, it's better:
#ifdef a
#define func() func_old()
#else
#define func() func_new()
#endif
...
func()

rather than:

#ifdef a
	func_old();
#else
	func_new();
#endif

> For some reason the usb core is not sending hub urbs to my hcd
> all the control seems to run through hub_control and hub_status_data
> both of which are not checked before calling and so segfaults the kernel
> if not present rather than queuing a control urb to get the
> status as I would have expected...
>
> Now I realize, that in hub_control I can assemble a urb out of the data
> presented and call my enqueue method, but it looks like that would
> be unusually dense of me, since it appears that there should already be
> some way to get the urbs.
>
> Notes:
> I found that core/message.c does not include asm/scatterlist.h
> it appears to assume that linux/pci.h has the scatterlist stuff,
> but since UML has no PCI at all pci.h does not include it.
> I just added the scatterlist.h

> should I have removed pci.h? 
Not at all.

> On 2.6.17.6 it segfaults in the core at hub.c:2251 dev_dbg
> where udev->bus->controller->driver->name is used without checking
> if driver == NULL which it was in my version.  I have not figured out
> where that driver is supposed to be set since the controller appears to
> be created in the usb core somewhere...
> This patch now checks for that.

> Does anyone know where bus->controller->driver is supposed to be set?

I'm seeing in your base driver this code:

static struct platform_driver dummy_hcd_driver = {
        .probe          = dummy_hcd_probe,
        .remove         = dummy_hcd_remove,
        .suspend        = dummy_hcd_suspend,
        .resume         = dummy_hcd_resume,
        .driver         = {
                .name   = (char *) driver_name,
                .owner  = THIS_MODULE,
        },
};
.driver is a device_driver, and I suppose that udev->bus->controller->driver 
should point to it (if you are building a driver for the controller, i.e. the 
HCD driver).

I can provide a pointer to:
http://lwn.net/Kernel/

and some links you can find from it:

http://lwn.net/Articles/driver-porting/
http://lwn.net/Articles/2.6-kernel-api/
http://lwn.net/Kernel/LDD3/ (the complete Linux Device Drivers 3rd edition 
book).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
