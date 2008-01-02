Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA7N6-0004mv-MV for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 09:27:16 -0800
Received: from pasmtpb.tele.dk ([80.160.77.98])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JA7N5-0007UL-Ac
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 09:27:16 -0800
Date: Wed, 2 Jan 2008 18:27:01 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Message-ID: <20080102172701.GB9772@uranus.ravnborg.org>
References: <20080101071311.GA2496@hacking> <20080101071846.GB2496@hacking>
	<20080101103342.GH28913@uranus.ravnborg.org>
	<20080101104942.GI28913@uranus.ravnborg.org>
	<20080101130125.GA2499@hacking>
	<20080102150255.GA5567@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080102150255.GA5567@c2.user-mode-linux.org>
Subject: Re: [uml-devel] (Try #2) [Patch 1/8] UML: Remove 'TOPDIR' from
	Makefiles
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
To: Jeff Dike <jdike@addtoit.com>
Cc: Andrew Morton <akpm@osdl.org>, WANG Cong <xiyou.wangcong@gmail.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kbuild@vger.kernel.org

On Wed, Jan 02, 2008 at 10:02:55AM -0500, Jeff Dike wrote:
> On Tue, Jan 01, 2008 at 09:01:25PM +0800, WANG Cong wrote:
> > TOPDIR is obsolete, use srctree instead.
> > This patch removes TOPDIR from all UML Makefiles.
> 
> Thanks, I'll send this to Andrew.

Thanks Jeff.

	Sam

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
