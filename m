Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCI5b-000881-0P for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 08:41:23 -0700
Received: from bay0-omc1-s32.bay0.hotmail.com ([65.54.246.104])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GCI5X-0000ID-IF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 13 Aug 2006 08:41:23 -0700
Message-ID: <BAY101-F3556FC13777163E2ABDF69E2490@phx.gbl>
In-Reply-To: <200608131324.29081.blaisorblade@yahoo.it>
From: "James McMechan" <james_mcmechan@hotmail.com>
Date: Sun, 13 Aug 2006 15:41:10 +0000
Mime-Version: 1.0
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
To: blaisorblade@yahoo.it, user-mode-linux-devel@lists.sourceforge.net
Cc: James_McMechan@hotmail.com




>From: Blaisorblade <blaisorblade@yahoo.it>
>To: user-mode-linux-devel@lists.sourceforge.net
>CC: "James McMechan" <james_mcmechan@hotmail.com>, 
>linux-usb-devel@lists.sourceforge.net
>Subject: Re: [uml-devel] [ link to patch] resurrecting the uml-hcd
>Date: Sun, 13 Aug 2006 13:24:28 +0200
>
>On Sunday 13 August 2006 06:10, James McMechan wrote:
> > I am attempting to resurrect the uml-hcd driver
> > this version is based off of the gadget/dummy_hcd.c driver.
> >
> > I am aiming at a 2.6.12.2 target where it will be used.
> > I have forward ported it to 2.6.17.6 for testing and hopefully
> > eventual inclusion.
> >
> > This patch has a #PLATFORM to deal with the issues between
> > 2.6.17.6/2.6.12.2 since platform_register... is not present in older
> > kernels and the new kernels don't work with the older registration.
>
>That's ok in drivers, however if at all possible have that in headers 
>rather
>than code (i.e. as CodingStyle says, it's better:
>#ifdef a
>#define func() func_old()
>#else
>#define func() func_new()
>#endif
>...
>func()
>
>rather than:
>
>#ifdef a
>	func_old();
>#else
>	func_new();
>#endif

No problem, I don't like it either, if the registration functions
still worked I would have kept using the old ones and defered the
platform update. this is the result of mad typeing to get the silly thing
working under 2.6.17

it is not too hard to just delete the !PLATFORM sections but I will
be needing them in 2.6.12 later so I had left them in
the struct redefs and function arg changes don't seem to fit well
into a header abstraction unless you want #RETURNVALUE1
#ARGLIST1 and simliar oddness.

If I understood you correctly my problem would be
in .h
#ifdef KERN2_6_17
#define func old_func
#else
#define func new_func
#endif
and in .c
#ifdef PLATFORM
new_return new_func(new_arg)
{}
#else
old_return old_func(old_arg)
{}
#endif
since the new and old version won't compile due to
renaming arguments and return values that don't exist
in the other version I think I would just end up duplicating
the code in a bigger ifdef.
>
> > For some reason the usb core is not sending hub urbs to my hcd
> > all the control seems to run through hub_control and hub_status_data
> > both of which are not checked before calling and so segfaults the kernel
> > if not present rather than queuing a control urb to get the
> > status as I would have expected...
> >
> > Now I realize, that in hub_control I can assemble a urb out of the data
> > presented and call my enqueue method, but it looks like that would
> > be unusually dense of me, since it appears that there should already be
> > some way to get the urbs.
> >
> > Notes:
> > I found that core/message.c does not include asm/scatterlist.h
> > it appears to assume that linux/pci.h has the scatterlist stuff,
> > but since UML has no PCI at all pci.h does not include it.
> > I just added the scatterlist.h
>
> > should I have removed pci.h?
>Not at all.

Well the comment suggests that the only reason it was present
was for the scatterlist functions ;)

>
> > On 2.6.17.6 it segfaults in the core at hub.c:2251 dev_dbg
> > where udev->bus->controller->driver->name is used without checking
> > if driver == NULL which it was in my version.  I have not figured out
> > where that driver is supposed to be set since the controller appears to
> > be created in the usb core somewhere...
> > This patch now checks for that.
>
> > Does anyone know where bus->controller->driver is supposed to be set?
>
>I'm seeing in your base driver this code:
>
>static struct platform_driver dummy_hcd_driver = {
>         .probe          = dummy_hcd_probe,
>         .remove         = dummy_hcd_remove,
>         .suspend        = dummy_hcd_suspend,
>         .resume         = dummy_hcd_resume,
>         .driver         = {
>                 .name   = (char *) driver_name,
>                 .owner  = THIS_MODULE,
>         },
>};
>.driver is a device_driver, and I suppose that 
>udev->bus->controller->driver
>should point to it (if you are building a driver for the controller, i.e. 
>the
>HCD driver).

yes, but I have set that one, and the problem does not occur under 2.6.12 
with
the same dev_dbg statement.

I have looked at this, the the udev was usb_alloc_dev from hub->hdev->bus
just before hub_port_init in hub_port_change which is called from hub_events 
from
hub_thread which is spawned at the start of usbcore and the hub device is 
now
automaticlly created from hdev from interface_to_usbdev(~current_altsetting) 
in
hub_probe called indirectly from the hub_driver.probe function pointer

I think it is a usb_bus *bus -> struct device *controller -> struct 
device_driver *driver
but for some reason a different driver...
just as a example I can add in uml_hcd_start

hcd->self.controller->driver=&uml_hcd_driver.driver;
which even works...

But I am pretty sure I am not supposed to do it like that.
is it even my driver or is it supposed to be the hub driver?

it is the only line in the entire drivers/usb tree that uses 
controller->driver
grep -r "controller->driver" linux-2.6.17.6/drivers/usb/
drivers/usb/core/hub.c:                 udev->bus->controller->driver->name,

It is a maze of calls and I have not been able to use breakpoints with gdb
much less the module symbols

I set the usual

b sys_init_module
b panic

and on modprobe I just get

[42949532.180000] Kernel panic - not syncing: Segfault with no mm
[42949532.180000]  [42949532.180000]
Program exited with code 01.
(gdb)


>
>I can provide a pointer to:
>http://lwn.net/Kernel/
>
>and some links you can find from it:
>
>http://lwn.net/Articles/driver-porting/
>http://lwn.net/Articles/2.6-kernel-api/
>http://lwn.net/Kernel/LDD3/ (the complete Linux Device Drivers 3rd edition
>book).
>--
>Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
>Paolo Giarrusso, aka Blaisorblade
>http://www.user-mode-linux.org/~blaisorblade
>Chiacchiera con i tuoi amici in tempo reale!
>  http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com

Thank you for your comments,
I may get arround to a non #PLATFORM edit later

Regards,

James McMechan



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
