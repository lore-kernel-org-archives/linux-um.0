Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYCF7-0005hw-8W
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 14:40:09 -0800
Received: from mta11.adelphia.net ([68.168.78.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1AYCF6-0005yk-Tm
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 14:40:09 -0800
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] 2.4.22-[67] problems
Message-ID: <20031221224001.GO9354@alcor.net>
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312211658.44353.blaisorblade_spam@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sun, 21 Dec 2003 14:40:01 -0800
To: user-mode-linux-devel@lists.sourceforge.net
Cc: 224431@bugs.debian.org, 224502@bugs.debian.org

On Sun, Dec 21, 2003 at 04:58:44PM +0100, BlaisorBlade wrote:

> Alle 01:47, domenica 21 dicembre 2003, Matt Zimmerman ha scritto:
> > Thanks for looking at it.  It's sounding more and more like the new
> > glibc/linux-kernel-headers packages have broken UML. 
> > Maybe something is
> > getting the host's kernel headers when it needs the ones from the UML build
> > tree?
> Something is getting the host's headers and it must get them, not the ones 
> from UML build tree.
> 
> Every UML arch file with its name ending in _user.c(+ quite a lot of other 
> ones, listed in USER_OBJS in Makefiles) are built against the host headers, 
> since they are the code interacting with the host.

Yes, I understand that.  Was my sentence unclear?  I was suggesting that
it was possible that the host's kernel headers were being used in a
situation where the UML tree kernel headers _should_ be used.

> But you need to actually compile UML against 2.4 host headers to see if this 
> is the reason; debugging it can be worst than an unnoticed wrong pointer or 
> buffer overrun, since probably a macro went in silently and it changed the 
> semantics of sources...

...which is one thing that I have tested.  I substituted 2.4.22 kernel
headers for the 2.6 ones provided by linux-kernel-headers and rebuilt UML,
and the problem persists.

I have heard reports that building the same source on Debian woody (glibc
2.2.5-11.5 with 2.4 kernel headers) works, however.  I am going to be
testing this myself shortly.  If it works, the cause is most likely
somewhere in glibc.

-- 
 - mdz


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
