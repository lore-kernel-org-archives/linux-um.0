Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AAdH5-0005Ox-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 17 Oct 2003 15:40:47 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1AAdFI-0007n1-8a
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 17 Oct 2003 15:38:56 -0700
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] Hardening hostfs
In-Reply-To: <3F8F7C06.7080306@easyco.com>
Message-ID: <Pine.LNX.4.44.0310180026300.22559-100000@filer.marasystems.com>
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
Date: Sat, 18 Oct 2003 00:35:32 +0200 (CEST)
To: Doug Dumitru <doug@easyco.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 16 Oct 2003, Doug Dumitru wrote:

> I have been trying to build a reasonably bullet-proof UML kernel that 
> prevents users from doing hostfs mounts.
> 
> I have observed some behaviours which are non ideal.
> 
> 1.  If hostfs is compiled in as a module, then the hostfs=... 
> command-line arguments are not used.  Thus, trying to restrict access 
> with this does not appear to be effective.

There should be a module argument in this case.. but it seems there is no 
module arguments for the hostfs options..

> 2.  If hostfs is not compiled in at all, you can still load a hostfs 
> module assuming that you can build one off-line.  This would allow a 
> compromise of an underlying system by a "moderate" hacker with root 
> access to the virtual.

And also in a number of other ways. This is not a question about hardening 
hostfs, but a question about harderning your UML environment.

Note that even if you do not have hostfs at all, the hacker can just write 
his own kernel module performing whatever operations on the host he likes 
and this will be executed as the user who runs the uml kernel on the host 
with the same privileges as given to the uml kernel.

There is two approaches you can take in hardening this. Which depends on
your situation

a) You can hardening the UML kernel itself from user modifications. This
involves disabling the support for loading kernel modules, raw I/O etc
which would otherwise allow root (inside the UML) to modify the kernel
operation.

b) Or you harden the environment wherein the UML kernel runs. The most 
common method is chrooting the UML, but as discussed in this thread a 
number of other options exists depending on how hard you need to have the 
UML isolated from the host.

> A lot of device open/close on the fly, so chrooting all of UML might be 
> hard.  The best that I can think of is to build a chroot jail with only 
> those devices.

There should not be many devices used by UML in a hardened setup.

> You still have to deal with /proc/mm for SKAS mode (at least until the 
> next SKAS interface shift).

Yes, but not really a problem is it? It is kind of just another device and 
you can easily mount it into the uml chroot. (see --bind option to mount)

Regards
Henrik



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
