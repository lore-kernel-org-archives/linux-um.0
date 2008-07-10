Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KH1Fq-0007yv-0i for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 11:52:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KH1Fo-0006nf-Tp
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 10 Jul 2008 11:52:34 -0700
Date: Thu, 10 Jul 2008 14:52:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080710185221.GI18429@c2.user-mode-linux.org>
References: <200807101619.54052.toralf.foerster@gmx.de>
	<20080710165811.GA18429@c2.user-mode-linux.org>
	<200807101934.33636.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200807101934.33636.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] UML kernel failed to start betvee 2.6.8-rc8
	and	current git sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jul 10, 2008 at 07:34:29PM +0200, Toralf F=F6rster wrote:
> At Thursday 10 July 2008 18:58:11 Jeff Dike wrote :
> > On Thu, Jul 10, 2008 at 04:19:51PM +0200, Toralf F=F6rster wrote:
> > > from v2.6.26-rc8 to v2.6.26-rc9-56-g6329d30 sth. affected UML, b/c my=
 user mode linux kernel produces this :
> > =

> > That UML runs fine here.  Did you also upgrade the host kernel between
> > rc8 and now?
> > =

> Yes, but that's not the reason. The UML crashes both under host kernel
> 2.6.24-gentoo-r8 and 2.6.25-gentoo-r6. The last (available) working UML k=
ernel
> is linux-v2.6.26-rc8-227 (tested under host kernel 2.6.25-gentoo-r6).

Can you send me your crashing UML binary?

Also, can you bisect this and see where something broke?

      	      	     	  Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
