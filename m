Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzvC-0007JA-Ht for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:38:46 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BVzvB-00062U-Eh for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 03 Jun 2004 14:38:45 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] mlock discussion is back - was: Re: [uml-user] odd
	ping problems
In-Reply-To: <200406021258.56597.blaisorblade_spam@yahoo.it>
Message-ID: <Pine.LNX.4.44.0406032335180.22208-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 3 Jun 2004 23:38:32 +0200 (CEST)
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: roland <for_spam@gmx.de>, user-mode-linux-devel@lists.sourceforge.net, matthew-list@bytemark.co.uk, michel@pollet.net

On Wed, 2 Jun 2004, BlaisorBlade wrote:

> That is not very good - if the latency problem comes from UML being swapped 
> out, why do you disable swapping? Actually there is some "swapping", in a 
> certain sense, so you could observe the major page faults (major means 
> "requiring I/O", minor means "no IO": this can happen for COW pages, to mark 
> as dirty a clean page).
> 
> When swapping is disabled, the pages belonging to a memory mapping, that was 
> not modified since they were read from the disk, can be swapped out.

In case of UML the situation is even worse unless /dev/anon is used. As
UML then makes the kernel memory by mmap:ing some temporary files if
effectively makes a new swap space to where the UMLs will be swapped,
making UMLs or UML memory very likely candidates to go out of memory
should there be some memory pressure on the host.  Disabling the swap 
space only makes it less likely other non-UML applications gets swapped 
out.

If you run with the temporary files on tmpfs then this pageing of the UML 
data can be disabled I think, but not verified.

Regards
Henrik




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
