Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GD4JR-000851-V1 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 12:10:54 -0700
Received: from iolanthe.rowland.org ([192.131.102.54])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GD4JN-0002pi-Ca
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Aug 2006 12:10:53 -0700
Date: Tue, 15 Aug 2006 15:10:47 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <BAY101-F74585E12217E6CC82D90FE24F0@phx.gbl>
Message-ID: <Pine.LNX.4.44L0.0608151428260.3832-100000@iolanthe.rowland.org>
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

On Tue, 15 Aug 2006, James McMechan wrote:

> Yep, two hub threads one in the UML and one in the host system
> which is why it will need a hub proxy. I don't know what it is legal
> to do from userspace, the usbdevfs documentation sparse notably
> on async urbs and reaping.

For hubs, it's legal to submit pretty much any URB through usbfs except 
for Clear-Halt.

> >You can't have UML and the host both trying to drive the same hub; that
> >way madness lies.  Your only choice is to invent a totally virtual
> >root-hub device, existing only within UML.  In fact, you would want to
> >replace most of the standard hub driver with a version customized for the
> >UML kernel; basically it wouldn't have to do much of anything.  Then you
> >could have UML grab control of various real USB devices, importing them
> >within its own space.

By the way, your reply would be a _lot_ easier to read if you divided it 
up into regular English sentences...

> Yes, madness or in this case emulation, a proxy hub that just sits there
> to receive the commands and decide which ones to pass on to the real
> hub and how to fake the status on the others

It's not just hubs.  For example, from within UML you can't really send a
Set-Configuration request to any device.  Or rather, you can send it but
it will badly confuse the host kernel.  You would have to translate such a 
request into a USBDEVFS_SETCONFIGURATION ioctl.  Similar considerations 
apply to port resets and suspend/resume requests.

Let's face it, the USB stack in Linux is designed in such a way that USB 
devices cannot effectively be virtualized without using a host-kernel 
driver.

Within these limitations, the UML hub driver won't have to do anything, 
really.  It won't generate requests or pass anything through to the host 
kernel.  The hub_control routine in uml_hcd would simply send all URBs 
through to the host's root hub.

> (and for the ones being
> forwarded while waiting for the real hub to complete its business) note
> it is not just the root hub that is a problem all hubs will need
> to do this

That's true.  You should be able to use the same driver for all hubs, 
since it won't have to do anything.

> and I would really prefer to do it only one way, which is why
> I was asking about the hub urbs, since the hub emulation will need to
> unpack urbs for non-root hubs

Without the ability to do port resets, you can't have much of a hub 
emulator.  You might as well simply pass through all URBs that don't refer 
to the reset, suspend, or enable features.

> it might be easier to have the proxy
> be called from wrappers in hub_control/status_data and the urb handler
> It will then decide e.g. that the PORT_RESET should be sent and then
> start faking the status returns for the UML hub thread while waiting for
> the real hardware to execute the RESET and clear C_RESET but that
> has the race: will I even see the RESET status or C_RESET status at all?

I don't think you can make port resets from UML work at all.

> The 2.4 version sat in the timer and walked the list of hubs each tick
> checking for port status changes via the HUB_PORT_INFO ioctl
> and then rescanned the usb bus to determine if the topology had
> changes and updated the simulated hubs and I seem to recall
> added busses & hcd's as it was updated.
> 
> This should be better in 2.6 /proc/bus/usb/devices is documented
> as giving a poll status change on device changes.
> 
> If you have a suggestion on how I should override the hub thread
> so UML would work better I would be quite happy hear suggestions.

You need to do a lot more than override the hub thread.  To do what you
want would basically require a new general-purpose USB device driver in
the host kernel, one that could relay URBs and other information back and
forth between the UML kernel and the host's stack.  And you would need a
better conduit than usbfs for doing the relaying.

> currently UML does not touch the USB core where the hub thread is
> is it even a good idea to do so? I admit the proxy hubs are somewhat
> of a messy design with both simulated and real status and urbs going
> back and forth on both the UML and the host.

Have you seen the changes to usbcore in the -mm kernel series?  They 
introduce the notion of a USB device driver (as opposed to interface 
driver).  You would have to write you own new device driver for the host 
kernel and somehow get it to override the standard generic driver.  It 
would be a big job.

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
