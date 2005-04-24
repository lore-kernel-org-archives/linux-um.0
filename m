Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPiRl-0004ap-OD for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:50:57 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DPiRi-0000RH-3X for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 07:50:57 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050422013246.GA19730@ccure.user-mode-linux.org>
In-Reply-To: <20050422013246.GA19730@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504241644.38016.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: UML-patches to prepare UML/s390
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
Date: Sun, 24 Apr 2005 16:44:37 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

On Friday 22 April 2005 03:32, Jeff Dike wrote:
> On Wed, Apr 06, 2005 at 03:27:50PM +0200, Bodo Stroesser wrote:
> > Here are the patches (tarball attached), that I've applied to
> > UML 2.6.11 + incrementals, before adding s390-files.
> > These patches are tested a bit on x86, but not on x86_64.
>
> The COMMAND_LINE_SIZE patch was required because this was conflicting with
> the userspace s390 COMMAND_LINE_SIZE?  I think this is true because in the
> kernel, asm-s390/setup.h doesn't get pulled in.
>
> This stems from the fact that my tree had add_arg in os-Linux/util.c, which
> seems wrong.  Blaisorblade had it moved to um_arch.c, which is right, and
> where it is in my tree now.  So, I think UML_COMMAND_LINE_SIZE is not
> needed, and I've removed it.
The patch moving add_arg() was *before* the os-* work, so you might move (if 
needed, which I don't know) it again to os-Linux/util.c if you want (which 
didn't exist at that time). It came from arch/um/kernel/user_util.c, in fact.

Btw, many of the code movement things are just cut'n'paste things, so for them 
there is no reason to delay them. Now we are going to merge them for 
2.6.13-rc1 (for .12 it's too late), but every other delay increases the 
possibility that we fix somehow the code we are moving and forget to do the 
same on the moved code.

Finally, about the syscall table patches for s390: I'm going to merge into -mm 
the syscall table patches you can find in the last -devel snapshot I put on 
my page (the uploaded ones maybe are out-of-date, but I'll cc you on 
patches).

They entirely remove the UML syscall table to replace it with the $(SUBARCH) 
one (there is some hand-work to do for each subarch but it's much less than 
before). While doing this I also fixed various little bugs about this 
subject.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
