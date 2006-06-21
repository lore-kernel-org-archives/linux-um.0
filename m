Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtBwQ-0002W0-Dq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 16:17:07 -0700
Received: from web25225.mail.ukl.yahoo.com ([217.146.176.211])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FtBwN-0004bz-Rh
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Jun 2006 16:16:58 -0700
Message-ID: <20060621231649.25378.qmail@web25225.mail.ukl.yahoo.com>
Date: Thu, 22 Jun 2006 01:16:49 +0200 (CEST)
From: Paolo Giarrusso <blaisorblade@yahoo.it>
In-Reply-To: <CA52872BEA6FD41182A50008C724B23003F2FFD2@corp01uk.bordersgroupinc.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Another cause for UML
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
To: "Carl Radford (DC0854-IT)" <CRADFORD@bordersgroupinc.com>, Laurent@lvivier.info, for@gmx.de, Jeff Dike <jdike@addtoit.com>, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

"Carl Radford (DC0854-IT)" <CRADFORD@bordersgroupinc.com> ha scritto:


> Any chance I can interest the UML developers

I've included some more address (including Jeff, UML 1st author and
maintainer).

> in fixing UML to
> support openMosix (for the purposes of debugging) ?

> I applied the openMosix patch to a stock kernel (2.6.16) and then
> tried to build a um kernel (yes I should know better :>),
> but there are (obviously) inconsistencies between the would-be-used
> include/arch-i386 header files and the actually-used
> include/um header files (seem to be mostly ptrace/regs stuff).

> For
> someone who knows their way around UML, it should
> be quite trivial to sort the compilation issues  (yes I'm
> simplifying, but I'm trying to get you on my side).
> I am not trying to recruit you, from there on it would be up to the
> openMosix development team not to break it again, unless
> you wanted to contribute, of course...... :>).

> Being able to debug the kernel this way would be of great benefit
> to openMosix development and earn UML yet another gold star.
Having helped NTFS (and probably FUSE) to get going is one of the UML
merits, but we likely should advertise this (we know this indirectly,
by having seen those projects' authors using UML for debug).

Start posting some of these errors and we'll look at how trivial it
is (unless the compiler is flooding you). If they look trivial to us
we may try it...

But my 1st question is: does OpenMosix currently support anything
else than x86? If not a little compatibility layer may be needed and
this may hinder significantly the porting - however they'll have to
fix this anyway to support x86_64 at the very least.

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
