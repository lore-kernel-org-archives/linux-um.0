Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CsvWh-0008BS-TJ for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 20:08:31 -0800
Received: from mail10.mdx.safepages.com ([216.127.133.33])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CsvWh-0007bs-8p for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 23 Jan 2005 20:08:31 -0800
Received: from host3 (1Cust7339.an1.lax32.da.uu.net [63.16.156.171])
	by mail10.mdx.safepages.com (Postfix) with ESMTP id F3066206D5
	for <User-mode-linux-devel@lists.sourceforge.net>;
	Mon, 24 Jan 2005 04:08:20 +0000 (GMT)
From: James McMechan <mcmechan@isp.com>
References: <41DD9FA6.3010208@cpe.fr>
	<200501220726.19866.James_McMechan@hotmail.com>
	<1049.82.228.193.91.1106484701.squirrel@altern.org>
In-Reply-To: <1049.82.228.193.91.1106484701.squirrel@altern.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <200501232006.47536.mcmechan@isp.com>
Subject: [uml-devel] Re: news for uml_hcd driver ?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 23 Jan 2005 20:06:47 -0800
Content-Transfer-Encoding: quoted-printable
To: User-mode-linux-devel@lists.sourceforge.net

On Sunday 23 January 2005 04:51 am, Hubert FONGARNAND wrote:
> Hello!!!
> The Umusb driver works now on the 2.4.27 kernel... I can use now, my=20
force
> feedback joystick and my usbmouse on the 2.4.27-1um kernel... But I'm in
> very beta testing phase and I experience many "kernel panic : Kernel mode
> fault"
> I try to run : ./linux debug
> A window with gdb appear, but the kernel looks like stopped... in there
> another way to debug the kernel?
> Your's sincerely
It did not start up when you entered "c" to continue after setting your
breakpoints?

It would appear that you are running in TT mode "tracing thread" not
SKAS mode.

Have you looked at http://user-mode-linux.sf.net/debugging.html the
debugging tutorial? or checked on the mailing lists?
>
> > On Tuesday 18 January 2005 09:41 am, Hubert FONGARNAND wrote:
> >> James McMechan a =E9crit :
> >> > On Thursday 06 January 2005 12:29 pm, you wrote:
> >> >>Hello
> >> >>I'm a french student, (engineer school). I work on a very=20
interessant
> >> >>project. We want to develop a USB kernel driver for a joystick. In
> >>
> >> order
> >>
> >> >>to test our driver, we'd want to run it in user space (with UML and
> >> >>UML_HCD), doing this way we are sure not to crash the host kernel...
> >> >>We success to compile a 2.4.18 kernel with your patch, but the=20
uml_hcd
> >> >>module don't seem to work (we don't see anything in /proc/bus/usb,
> >>
> >> when
> >>
> >> >>usbdevfs in mounted).
> >> >>Is there any developement on this driver today?
> >> >>Is there a way to port this driver for the 2.6 kernel ?
> >> >>Does it exist a way to run a device driver in user space=20
(emulation ?)
> >> >>
> >> >>Thank you in advance
> >> >>your sincerelly
> >> >>
> >> >>Hubert FONGARNAND
> >> >>CPE Student
> >> >
> >> > It should still work what was your host kernel (the one you were
> >>
> >> running
> >>
> >> > UML on top of)
> >> >
> >> > I think that 2.4.19-39um as a guest kernel also worked but about
> >>
> >> 2.4.20
> >>
> >> > Greg Kroh back-ported the 2.5/2.6 USB structures to 2.4 and broke=20
the
> >> > umusb-2.4.19-39 patch. Later 2.4.19-XXum versions should also work=20
but
> >> > are untested.
> >> >
> >> > From the web page (which seems to be down?)
> >> > Operation of the user mode linux host controller requires that the
> >>
> >> host
> >>
> >> > system has /proc/bus/usb mounted and writable by the user running=20
the
> >> > user mode linux kernel.
> >> >
> >> > Usually when I had problems it was that user mcmechan could not=20
write
> >>
> >> to
> >>
> >> > the /proc/bus/usb files or that the host kernel driver had found a
> >>
> >> driver
> >>
> >> > for the device on the host kernel which caused the host USB driver=20
to
> >>
> >> run
> >>
> >> > not the UML USB driver
> >> >
> >> > As to porting the uml-hcd to 2.6 it should be possible but there has
> >>
> >> not
> >>
> >> > been that much interest in running USB from UML though it seems to=20
be
> >> > picking up again.
> >> >
> >> > As I recall it will enumerate the devices on the host but has a
> >>
> >> problem
> >>
> >> > creating the /proc/bus/usb files in the UML
> >> > The proper solution was to setup a new style HCD in the 2.6 tree but
> >>
> >> UML
> >>
> >> > is rather different than USB expected e.g. no DMA and at the time
> >> > creating the absent DMA infrastructure seemed like much work to hit =

a
> >> > moving target.
> >> >
> >> > As to emulation:
> >> > UML is my preferred way to work on USB or I would have done it
> >> > differently. VMWARE might have a way to run USB also but I don't
> >>
> >> remember
> >>
> >> > seeing any last time I looked at the web pages, and it would not=20
help
> >> > nearly as much for debugging.
> >>
> >> I use your umusb driver with some success on the 2.4.19 kernel!
> >
> > I am glad to see a report of your success
> >
> >> I've done some modifications for interrupt transfer.
> >> now I can use my usb mouse very well.
> >> usb-storage driver works well too!
> >
> > Good, I had not thought to try with a USB mouse, I think I tried USB
> > storage, a smart card reader, and a USB Ethernet adapter
> >
> >> I've modified the 2.4.19 um kernel in order it could run on a 2.6 host
> >> kernel... and it works too.
> >
> > Ah, very good... you are I hope contemplating sharing your fixes,
> > I have CC'ed the user-mode-linux-devel@lists.sf.net
> >
> >> I've problem with unloading usb modules, sometimes i have some "Kernel
> >> Mode Fault at ip 0x...." how could I debug that?
> >
> > That is where UML shines, you can use the debugger on a UML kernel and
> > put a breakpoint at the panic/Oops and then do back-traces/examine
> > symbols
> >
> > The UML sites even include examples of getting the symbols from modules
> > All of which makes tracing down "Kernel Mode Fault..." much easier
> > I usually have those sort of errors happen when I forget to unregister
> > part of the module and then one of the kernel subsystems is still=20
trying
> > to use the module after the rmmod.
> >
> >> We are looking to use the driver on a 2.4.27 kernel, but we=20
experienced
> >> some problem with dma. We are making a fake dma support (we use your
> >> um_pci driver for the 2.5 kernel)... I hope it will work!
> >> I will send you our patches if it works!
> >>
> >> Your's sincerely
> >
> > It is a pleasure to see that you are finding it useful
> >
> > James McMechan


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
