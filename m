Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZCuE-0004YG-OO
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:46 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AZCuE-00051t-4z
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:46 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.4.22-[67] problems
References: <20031220011323.GW18100@alcor.net> <200312211658.44353.blaisorblade_spam@yahoo.it> <20031221224001.GO9354@alcor.net>
In-Reply-To: <20031221224001.GO9354@alcor.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312241348.02720.blaisorblade_spam@yahoo.it>
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
Date: Wed, 24 Dec 2003 13:48:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 23:40, domenica 21 dicembre 2003, Matt Zimmerman ha scritto:
> > > Thanks for looking at it.  It's sounding more and more like the new
> > > glibc/linux-kernel-headers packages have broken UML.
> > > Maybe something is
> > > getting the host's kernel headers when it needs the ones from the UML
> > > build tree?
> >
> > Something is getting the host's headers and it must get them, not the
> > ones from UML build tree.
> >
> > Every UML arch file with its name ending in _user.c(+ quite a lot of
> > other ones, listed in USER_OBJS in Makefiles) are built against the host
> > headers, since they are the code interacting with the host.
>
> Yes, I understand that.  Was my sentence unclear?

No, just I don't think that situation can happen. Maybe the problem is just 
that glibc is built against 2.6(i.e. you should try not only replacing 
headers, but also rebuilding glibc after that). Maybe this could be related 
with new things from glibc and 2.6, i.e. vsyscall or NPTL(I am just shooting 
in the middle, I don't even have ideas of what vsyscall is).

I've tried even if any of the header-generator programs use some changed 
headers, but for I saw is that every definition stayed the same
(except
#define PTRACE_OLDSETOPTIONS         21
which had same number but was named PTRACE_SETOPTIONS in 2.4).

> I was suggesting that
> it was possible that the host's kernel headers were being used in a
> situation where the UML tree kernel headers _should_ be used.
I understood this; only I think this doesn't happen...
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
