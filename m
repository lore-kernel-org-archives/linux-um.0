Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCLCQ-0001Gh-3i for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 12:00:38 -0700
Received: from mx2.rowland.org ([192.131.102.7])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCLCP-0003bl-Hv
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 12:00:38 -0700
Date: Sun, 13 Aug 2006 15:00:35 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <BAY101-F23508A11EBFB151C043062E2490@phx.gbl>
Message-ID: <Pine.LNX.4.44L0.0608131420250.26427-100000@netrider.rowland.org>
MIME-Version: 1.0
Subject: Re: [uml-devel] [linux-usb-devel] [ link to patch] resurrecting the
	uml-hcd
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
To: James McMechan <james_mcmechan@hotmail.com>
Cc: linux-usb-devel@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Sun, 13 Aug 2006, James McMechan wrote:

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
> 
> For some reason the usb core is not sending hub urbs to my hcd
> all the control seems to run through hub_control and hub_status_data
> both of which are not checked before calling and so segfaults the kernel
> if not present rather than queuing a control urb to get the
> status as I would have expected...

No.  These function pointers _must_ be set.

There's no point queuing an URB for the root hub.  Queued URBs are sent 
out over the USB bus... which makes no sense when the URB's destination is 
the HCD itself.

Or to put it another way: Why should an HCD have to work to unpack the 
request, request type, value, index, and length fields from the URB when 
usbcore has already done all that?  It's simpler to pass the values 
directly to a hub_control method than to force every HCD to repeat this
work.

> Now I realize, that in hub_control I can assemble a urb out of the data
> presented and call my enqueue method, but it looks like that would
> be unusually dense of me, since it appears that there should already be
> some way to get the urbs.

It is indeed possible to get at the original control URB.  Just follow the
linked list in hcd->self.root_hub->ep0.urb_list; there should be only one
entry in the list and it will be the URB.

> On 2.6.17.6 it segfaults in the core at hub.c:2251 dev_dbg
> where udev->bus->controller->driver->name is used without checking
> if driver == NULL which it was in my version.  I have not figured out
> where that driver is supposed to be set since the controller appears to
> be created in the usb core somewhere...
> This patch now checks for that.
> 
> Does anyone know where bus->controller->driver is supposed to be set?

It gets set when your HCD is bound to the platform device.  In dummy_hcd.c 
this occurs in the initialization routine, where the code calls

	retval = platform_driver_register (&dummy_hcd_driver);
	...
	retval = platform_device_register (&the_hcd_pdev);

This causes the driver core to set the_hcd_pdev.dev.driver equal to 
&dummy_hcd_driver.driver.  In your code this mechanism doesn't work 
because the names don't match: Your device's name is "uml-hcd" with a '-' 
and your driver's name is "uml_hcd" with an '_'.

> uml-hcd is currently partly operational
> I can enumerate the device, libusb will talk to it.
> Control URBs seem to go back and forth.
> and report status back correctly.
> 
> I have walked through the usbmon output on the host and the hub simulation
> is producing the same status in the same order as the host does
> the host appears to produce urbs for its root hub however.
> under uml usbmon does not show up in /sys/kernel/debug so
> I have not been able to test it there, my current spew level dev_info dumps
> all the hub control/status to my console.

Doesn't uml implement the debugfs filesystem?  Did you remember to set 
CONFIG_DEBUG_FS and to do "mount -t debugfs none /sys/kernel/debug"?

> Your thoughts are welcome, I would hate to have to fall back to creating a
> virtual proc files system that just forwards all the libusb calls down to 
> the
> host OS.  This was working a few years ago and it looks (from dummy_hcd.c
> and usbip) that it should be possible here. I know it was possible to write
> a complete usb from userspace without requiring a stub driver back in
> the bad old days of 2.4.18...
> 
> No doubt this version takes may liberties with the core and driver model
> if you could point out some of the more obvious ones to me,
> I still was thinking about the automatic interrupt urb submission when last
> this was current.

On a quick glance, it appears that your dequeue method does not try to 
cancel the URB on the host.  Shouldn't it do so?

> The patch can be fetched from 
> http://mysite.verizon.net/james.mcmechan/uml-hcd.2.6.17.6.patch
> or bzipped as 
> http://mysite.verizon.net/james.mcmechan/uml-hcd.2.6.17.6.patch.bz2
> it is 1104 lines long & 31K in size so I stuck it on a web page.

Your server doesn't set the MIME type correctly; everything appears to be 
text/html or something similar.

Alan Stern


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
