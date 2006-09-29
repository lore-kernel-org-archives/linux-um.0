Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTCcb-00015L-FI for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 00:17:21 -0700
Received: from picard.linux.it ([213.254.12.146])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTCca-0004PY-RX
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 29 Sep 2006 00:17:21 -0700
Message-ID: <56699.85.47.20.193.1159514238.squirrel@picard.linux.it>
In-Reply-To: <20060928201933.GA24770@saruman.uio.no>
References: <2flhcyrq2nr.fsf@saruman.uio.no>
	<20060928194727.GC8519@inferi.kami.home>
	<20060928201933.GA24770@saruman.uio.no>
Date: Fri, 29 Sep 2006 09:17:18 +0200 (CEST)
From: "Mattia Dongili" <malattia@linux.it>
MIME-Version: 1.0
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
To: Petter Reinholdtsen <pere@hungry.com>
Cc: User Mode Linux Maintainers <pkg-uml-pkgs@lists.alioth.debian.org>, Mattia Dongili <malattia@linux.it>, Paolo Giarrusso <blaisorblade@yahoo.it>, pkg-sysvinit-devel@lists.alioth.debian.org, UML-devel <user-mode-linux-devel@lists.sourceforge.net>

On Thu, September 28, 2006 10:19 pm, Petter Reinholdtsen said:
> [Mattia Dongili]
>> Well, I'd actually prefer if you could remove the noexec flag from
>> /dev/shm. I understand the security reasons given in the bugreport
>> but I'd prefer avoid having to deal with one more Debian-only (is
>> it?)  thing given the soon to come general freeze.
>
> I am considering this for etch only, and to reinsert it once etch is
> released.  I suspect it is better to break uml, dosemu and others
> misusing /dev/shm/ early in the etch+1 release cycle instead of late
> in the etch cycle.

absolutely seconded.

> But I might be too late, as base and sysvinit is already frozen,
> according to the email from Andreas. :( We will have to discuss it
> with the release managers, I guess.

I can still file a critical bug because sysvinit "breaks unrelated SW" :)
Let's submit the question to d-release then.

-- 
mattia
:wq!



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
