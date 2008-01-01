Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J9egq-0003x4-Jp for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Jan 2008 02:49:45 -0800
Received: from pasmtpb.tele.dk ([80.160.77.98])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J9egp-0001MG-8g
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Jan 2008 02:49:44 -0800
Date: Tue, 1 Jan 2008 11:49:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20080101104942.GI28913@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101071846.GB2496@hacking>
	<20080101103342.GH28913@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080101103342.GH28913@uranus.ravnborg.org>
Subject: Re: [uml-devel] [Patch 1/8] UML: Remove 'TOPDIR' from Makefiles
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
To: WANG Cong <xiyou.wangcong@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org

On Tue, Jan 01, 2008 at 11:33:42AM +0100, Sam Ravnborg wrote:
> On Tue, Jan 01, 2008 at 03:18:46PM +0800, WANG Cong wrote:
> > 
> > TOPDIR is obsolete, use objtree instead.
> > This patch removes TOPDIR from all UML Makefiles.
> > 
> 
> I do not feel confident with these changes.
> In some places I had expected to see srctree and not objtree.
> I would like to see this tested before applying it.
> 
> Building a ppc toolchain now to test it...

It seems that building a ppc based um kernel is not supported
in mainline.
Kconfig.ppc is missing and when creating it um build fails
in sys-ppc/ due to user-offset.c is missing.

As most of your patch touches ppc specific code I suggest
to just replace TOPDIR with srctree all over (no semantic change)
and the the um people can figure out the ppc stuff when they get to it.

	Sam

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
