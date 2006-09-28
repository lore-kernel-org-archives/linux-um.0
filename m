Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GT2MI-0005LQ-JI for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Sep 2006 13:19:50 -0700
Received: from pat.uio.no ([129.240.10.4] ident=7411)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GT2MH-0001e3-5o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 28 Sep 2006 13:19:50 -0700
Date: Thu, 28 Sep 2006 22:19:33 +0200
From: Petter Reinholdtsen <pere@hungry.com>
Message-ID: <20060928201933.GA24770@saruman.uio.no>
References: <2flhcyrq2nr.fsf@saruman.uio.no>
	<20060928194727.GC8519@inferi.kami.home>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20060928194727.GC8519@inferi.kami.home>
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
Cc: User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, pkg-sysvinit-devel@lists.alioth.debian.org, Paolo Giarrusso <blaisorblade@yahoo.it>, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

[Mattia Dongili]
> Well, I'd actually prefer if you could remove the noexec flag from
> /dev/shm. I understand the security reasons given in the bugreport
> but I'd prefer avoid having to deal with one more Debian-only (is
> it?)  thing given the soon to come general freeze.

I am considering this for etch only, and to reinsert it once etch is
released.  I suspect it is better to break uml, dosemu and others
misusing /dev/shm/ early in the etch+1 release cycle instead of late
in the etch cycle.

But I might be too late, as base and sysvinit is already frozen,
according to the email from Andreas. :( We will have to discuss it
with the release managers, I guess.

Friendly,
-- 
Petter Reinholdtsen

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
