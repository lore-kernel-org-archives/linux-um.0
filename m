Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTNbg-0006Ed-Ek for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 12:01:08 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTNbe-0001Ma-VM
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 12:01:08 -0700
Date: Fri, 29 Sep 2006 14:59:34 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20060929185934.GB8051@ccure.user-mode-linux.org>
References: <2flhcyrq2nr.fsf@saruman.uio.no>
	<20060928194727.GC8519@inferi.kami.home>
	<20060928215143.GC6327@ccure.user-mode-linux.org>
	<20060929174601.GF13444@inferi.kami.home>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060929174601.GF13444@inferi.kami.home>
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
Cc: User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, pkg-sysvinit-devel@lists.alioth.debian.org, Paolo Giarrusso <blaisorblade@yahoo.it>, UML-devel <user-mode-linux-devel@lists.sourceforge.net>, Petter Reinholdtsen <pere@hungry.com>

On Fri, Sep 29, 2006 at 07:46:01PM +0200, Mattia Dongili wrote:
> Thinking of a Debian only fix for the above, does simply playing with
> default_tmpdir in arch/um/os-Linux/mem.c (probably in which_tmpdir())
> suffice to use /lib/init/rw/.ramfs as default?
> 
> (Yes I should try it... will try to find some time next week)

What difference would this make?  You still have some world-writable place
not mounted noexec that nasty people could try to take advantage of.  You're
just changing the name of that place.

				Jeff

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
