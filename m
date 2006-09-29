Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTOPL-0002Vf-5w for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 12:52:27 -0700
Received: from out1.smtp.messagingengine.com ([66.111.4.25])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GTOPJ-0005nl-Jl
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 12:52:27 -0700
Date: Fri, 29 Sep 2006 16:52:12 -0300
From: Henrique de Moraes Holschuh <hmh@debian.org>
Message-ID: <20060929195212.GA3656@khazad-dum.debian.net>
References: <2flhcyrq2nr.fsf@saruman.uio.no>
	<20060928194727.GC8519@inferi.kami.home>
	<20060928215143.GC6327@ccure.user-mode-linux.org>
	<20060929174601.GF13444@inferi.kami.home>
	<20060929185934.GB8051@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060929185934.GB8051@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] [Pkg-sysvinit-devel] Re: [Pkg-uml-pkgs] How is
	user-mode-linux using /dev/shm/?
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
To: Jeff Dike <jdike@addtoit.com>
Cc: User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, Mattia Dongili <malattia@linux.it>, Paolo Giarrusso <blaisorblade@yahoo.it>, pkg-sysvinit-devel@lists.alioth.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 29 Sep 2006, Jeff Dike wrote:
> On Fri, Sep 29, 2006 at 07:46:01PM +0200, Mattia Dongili wrote:
> > Thinking of a Debian only fix for the above, does simply playing with
> > default_tmpdir in arch/um/os-Linux/mem.c (probably in which_tmpdir())
> > suffice to use /lib/init/rw/.ramfs as default?
> > 
> > (Yes I should try it... will try to find some time next week)
> 
> What difference would this make?  You still have some world-writable place
> not mounted noexec that nasty people could try to take advantage of.  You're
> just changing the name of that place.

It does not intrude in SYSV shm namespace anymore.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
