Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AM9hw-0007wR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Tue, 18 Nov 2003 09:32:08 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AM9hv-00066m-CH
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 18 Nov 2003 09:32:07 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] University project on UML
In-Reply-To: <1265.141.165.213.235.1069170899.squirrel@email.georgiasouthern.edu>
Message-ID: <Pine.LNX.4.44.0311181808000.10426-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 18 Nov 2003 18:32:02 +0100 (CET)
To: "Matthew E. Dugan" <matthew_e_dugan@GeorgiaSouthern.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Tue, 18 Nov 2003, Matthew E. Dugan wrote:

> 1) Strip UML down to a compilable state containing only the virtual machine

UML does not have a virtual machine. It uses the HOST CPU directly for
running both the UML kernel and applications ontop of the kernel.

UML is an abstract hardware layer to the Linux kernel, allowing it to run
as an ordinary Linux application with no dedicated hardware (real or
emulated).

This abstraction layer consists of several components

 * Various device drivers using host Linux system calls instead of 
hardware (serial devices, networking, console, etc). Many of these are 
optional and not required for operation.

 * Memory management using virtual memory rather than physical memory

 * Interception of system calls from applications running ontop of the UML 
kernel to have these calls executed by the UML kernel rather than the host 
kernel. Note: Between system calls and interrupts the application executes 
on the host CPU just like an application running outside the UML.

 * Interrupt "emulation" layer, allowing various events (filedescriptor
ready for reading/writing etc) from the host kernel to be translated into
a "interrupt" within the UML kernel to fit the device driver model of
Linux.

 * Timer interrupts for context switching etc using the itimer function 
provided by the host kernel as interrupt source rather than a hardware 
timer.

 * Virtual filesystem driver providing transparent access to files on the 
host. (optional)

 * and many other components I have forgotten above...

> 2) Perform any clean ups and re-organizations
> 3) Take one of the removed pieces, verify its function
> 4) Perform any clean ups and re-organizations on the removed piece
> 5) Add the piece back into the build process
> 6) Repeat steps 3-5 until finished.


What I see most interesting with the UML hardware layer in the above is
that it easily allows the above process to be applied to large parts of
the Linux kernel in general a lot easier than if using real or even
emulated hardware.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
