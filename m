Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CniFF-0000R8-Sm for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 10:56:57 -0800
Received: from mail6.mdx.safepages.com ([216.127.133.49])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CniFE-0005SI-Dq for User-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Jan 2005 10:56:57 -0800
From: James McMechan <James_McMechan@hotmail.com>
References: <41DD9FA6.3010208@cpe.fr>
In-Reply-To: <41DD9FA6.3010208@cpe.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200501091045.49962.James_McMechan@hotmail.com>
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
Date: Sun, 9 Jan 2005 10:45:49 -0800
Content-Transfer-Encoding: 8bit
To: Hubert FONGARNAND <hubert.fongarnand@cpe.fr>
Cc: User-mode-linux-devel@lists.sourceforge.net, mcmechan@isp.com

On Thursday 06 January 2005 12:29 pm, you wrote:
> Hello
> I'm a french student, (engineer school). I work on a very interessant
> project. We want to develop a USB kernel driver for a joystick. In order
> to test our driver, we'd want to run it in user space (with UML and
> UML_HCD), doing this way we are sure not to crash the host kernel...
> We success to compile a 2.4.18 kernel with your patch, but the uml_hcd
> module don't seem to work (we don't see anything in /proc/bus/usb, when
> usbdevfs in mounted).
> Is there any developement on this driver today?
> Is there a way to port this driver for the 2.6 kernel ?
> Does it exist a way to run a device driver in user space (emulation ?)
>
> Thank you in advance
> your sincerelly
>
> Hubert FONGARNAND
> CPE Student
It should still work what was your host kernel (the one you were running UML 
on top of)

I think that 2.4.19-39um as a guest kernel also worked but about 2.4.20 Greg 
Kroh back-ported the 2.5/2.6 USB structures to 2.4 and broke the 
umusb-2.4.19-39 patch. Later 2.4.19-XXum versions should also work but are 
untested.

From the web page (which seems to be down?)
Operation of the user mode linux host controller requires that the host system 
has /proc/bus/usb mounted and writable by the user running the user mode 
linux kernel.

Usually when I had problems it was that user mcmechan could not write to 
the /proc/bus/usb files or that the host kernel driver had found a driver for 
the device on the host kernel which caused the host USB driver to run not the 
UML USB driver

As to porting the uml-hcd to 2.6 it should be possible but there has not been 
that much interest in running USB from UML though it seems to be picking up 
again.

As I recall it will enumerate the devices on the host but has a problem 
creating the /proc/bus/usb files in the UML
The proper solution was to setup a new style HCD in the 2.6 tree but UML is 
rather different than USB expected e.g. no DMA and at the time creating the 
absent DMA infrastructure seemed like much work to hit a moving target.

As to emulation:
UML is my preferred way to work on USB or I would have done it differently.
VMWARE might have a way to run USB also but I don't remember seeing any last 
time I looked at the web pages, and it would not help nearly as much for 
debugging.



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
