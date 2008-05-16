Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jx6tZ-0000sU-Bo for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 May 2008 13:51:17 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jx6tX-0003h7-GP
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 May 2008 13:51:17 -0700
Date: Fri, 16 May 2008 16:51:03 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080516205103.GA12573@c2.user-mode-linux.org>
References: <20080516123130.GA11808@coyote.octets.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080516123130.GA11808@coyote.octets.fr>
Subject: Re: [uml-devel] linux-next 20080516 build failure
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Philippe Roussel <p.o.roussel@free.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, May 16, 2008 at 02:31:30PM +0200, Philippe Roussel wrote:
> Hi
> 
> I got this while building randconfigs
> 
>   CC      arch/um/drivers/vde_user.o
> arch/um/drivers/vde_user.c:8:24: error: libvdeplug.h: No such file or directory
> arch/um/drivers/vde_user.c: In function 'vde_user_init':

If you config CONFIG_UML_NET_VDE and don't have the vde stuff
available, something's gotta break.  I understand the niceness of
randconfig always working, but this has to fail somehow.

The only way out that I can see is make CONFIG_UML_NET_VDE invisible
to randconfig if vde isn't installed - i.e. if randconfig doesn't
enable stuff that depends on BROKEN, possibly generate a Kconfig which
sniffs the environment and adds that dependency.

OTOH, this makes things magically disappear, whereas the build failure
you encountered makes it immediately obvious what needs to happen in
order to fix the problem.

      	     	 Jeff

-- 
Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
