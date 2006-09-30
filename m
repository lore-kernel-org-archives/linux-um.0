Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTe5s-0001Zw-0J for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 05:37:24 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GTe5p-00013n-2P
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 05:37:23 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 30 Sep 2006 14:34:49 +0200
References: <2flhcyrq2nr.fsf@saruman.uio.no>
	<20060928215143.GC6327@ccure.user-mode-linux.org>
	<20060929174601.GF13444@inferi.kami.home>
In-Reply-To: <20060929174601.GF13444@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609301434.50261.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [Pkg-uml-pkgs] How is user-mode-linux using /dev/shm/?
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
To: Mattia Dongili <malattia@linux.it>
Cc: pkg-sysvinit-devel@lists.alioth.debian.org, Henrique de Moraes Holschuh <hmh@debian.org>, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, Petter Reinholdtsen <pere@hungry.com>

On Friday 29 September 2006 19:46, Mattia Dongili wrote:
> On Thu, Sep 28, 2006 at 05:51:43PM -0400, Jeff Dike wrote:
> > On Thu, Sep 28, 2006 at 09:47:27PM +0200, Mattia Dongili wrote:
> > > On Thu, Sep 28, 2006 at 08:14:32PM +0200, Petter Reinholdtsen wrote:
> > > > To make some writable tmpfs available to those in need of such
> > > > system, and to avoid using /dev/shm/ which is reserved for the
> > > > shm-functions, I just uploaded sysvinit version 2.86.ds1-26.  It will
> > > > mount a tmpfs on /lib/init/rw/ that can be used instead.  If
> > > > /lib/init/rw/.ramfs exist, that mount point is a tmpfs.  I'm not sure
> > > > if this last change will make it into Etch or not, but I hope so, to
> > > > solve any problems with packages previously using /dev/shm/ as a
> > > > generic tmpfs file system.
> > >
> > > Well, I'd actually prefer if you could remove the noexec flag from
> > > /dev/shm. I understand the security reasons given in the bugreport but
> > > I'd prefer avoid having to deal with one more Debian-only (is it?)
> > > thing given the soon to come general freeze.
> >
> > UML needs a non-noexec place to keep a file that will be used as its
> > physical memory.  A tmpfs mount is greatly preferred for performance
> > reasons as well as tmpfs being the only filesystem supporting
> > MADV_REMOVE, which is used for memory hotplug.
>
> Thinking of a Debian only fix for the above, does simply playing with
> default_tmpdir in arch/um/os-Linux/mem.c (probably in which_tmpdir())
> suffice to use /lib/init/rw/.ramfs as default?
Is it world-writable with the sticky bit set as /tmp and /dev/shm? I do not 
know 

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
