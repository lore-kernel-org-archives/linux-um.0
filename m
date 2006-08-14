Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GCduO-0007iG-6l for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 07:59:16 -0700
Received: from iolanthe.rowland.org ([192.131.102.54])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GCduN-0005bX-Hp
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Aug 2006 07:59:16 -0700
Date: Mon, 14 Aug 2006 10:59:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <BAY101-F2051F69E88491FC63209CBE24E0@phx.gbl>
Message-ID: <Pine.LNX.4.44L0.0608141042030.6352-100000@iolanthe.rowland.org>
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

On Mon, 14 Aug 2006, James McMechan wrote:

> >There's no point queuing an URB for the root hub.  Queued URBs are sent
> >out over the USB bus... which makes no sense when the URB's destination is
> >the HCD itself.
> >
> >Or to put it another way: Why should an HCD have to work to unpack the
> >request, request type, value, index, and length fields from the URB when
> >usbcore has already done all that?  It's simpler to pass the values
> >directly to a hub_control method than to force every HCD to repeat this
> >work.
> 
> On real hardware I agree there seems be no need, nor on a fully simulated
> device, UML is a odd case of half simulated half real hardware
> where it will be sending a urb off to the real root hub while
> simulating the UML root hub which proxies for the real root hub

Yes.  And UML is even odder in that it runs entirely in userspace, with no
(or minimal) host-kernel component.

> >It is indeed possible to get at the original control URB.  Just follow the
> >linked list in hcd->self.root_hub->ep0.urb_list; there should be only one
> >entry in the list and it will be the URB.
> 
> Would sending hub control stuff through usbdevfs to the hub break things
> e.g. what can user space do without upsetting the hub thread on
> the host, or conversely is there a set of safe commands to send?

It's a tough situation.  If you're not careful, you will end up with two
hub drivers (one in the host kernel and one in the UML kernel) both
trying to drive the same device!  That can't possibly work.

> USB_PORT_FEAT_CONNECTION,ENABLE,SUSPEND,OVER_CURRENT
> RESET,POWER should be doable but I am not sure UML hub thread will
> see the corresponding USB_PORT_FEAT_C bit before the host hub
> thread clears it.
> 
> As I recall the last time I worked on this one of the biggest problems
> was maintaining the proxy hub's state in UML to match what
> the real hub (or hubs) was doing. UML would be perfectly happy if
> it could just claim a hub as it own,  or yield all hub control down
> to the host system.  Neither of which was doable in 2.4 nor do I
> see a obvious way in 2.6 yet, perhaps convince the host the hub
> is quiescing? but leave it running or some other havoc with the
> hub thread.

Well, you can't have UML take total control of the root hub because then
there would be no way to tell the host kernel about the existence of any
child devices.  (usbfs doesn't provide any means of doing this.)  If the
host doesn't know about child devices, it can't send URBs to them.  So
you'd be stuck.

You can't have UML and the host both trying to drive the same hub; that
way madness lies.  Your only choice is to invent a totally virtual
root-hub device, existing only within UML.  In fact, you would want to
replace most of the standard hub driver with a version customized for the
UML kernel; basically it wouldn't have to do much of anything.  Then you
could have UML grab control of various real USB devices, importing them
within its own space.

> >This causes the driver core to set the_hcd_pdev.dev.driver equal to
> >&dummy_hcd_driver.driver.  In your code this mechanism doesn't work
> >because the names don't match: Your device's name is "uml-hcd" with a '-'
> >and your driver's name is "uml_hcd" with an '_'.
> 
> Ah, Thank you, I had been chaseing usb initializion through the core
> for several days without finding that point.
> Though fixing that now causes the devices to show up twice,
> two host controllers & two usb devices.

Maybe this is because the standard mechanisms are now operating in
addition to whatever workaround you installed.  I haven't looked at your
code closely enough to be able to tell.

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
