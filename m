Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AY5vN-0000Cq-Pm
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:55:21 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AY5vN-0004c9-8E
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 21 Dec 2003 07:55:21 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] 2.4.22-[67] problems
References: <20031220011323.GW18100@alcor.net> <20031220171450.GB10692@ccure.user-mode-linux.org> <20031221004742.GE9354@alcor.net>
In-Reply-To: <20031221004742.GE9354@alcor.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312211658.44353.blaisorblade_spam@yahoo.it>
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
Date: Sun, 21 Dec 2003 16:58:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net

Alle 01:47, domenica 21 dicembre 2003, Matt Zimmerman ha scritto:
> Thanks for looking at it.  It's sounding more and more like the new
> glibc/linux-kernel-headers packages have broken UML. 
> Maybe something is
> getting the host's kernel headers when it needs the ones from the UML build
> tree?
Something is getting the host's headers and it must get them, not the ones 
from UML build tree.

Every UML arch file with its name ending in _user.c(+ quite a lot of other 
ones, listed in USER_OBJS in Makefiles) are built against the host headers, 
since they are the code interacting with the host.

But you need to actually compile UML against 2.4 host headers to see if this 
is the reason; debugging it can be worst than an unnoticed wrong pointer or 
buffer overrun, since probably a macro went in silently and it changed the 
semantics of sources...
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
