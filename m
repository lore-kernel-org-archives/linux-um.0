Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGk2-000382-St for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 13:03:10 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJGk1-0001G2-6N for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 13:03:10 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [linux-2.6-bk] UML compile broken!
References: <1112793369.32726.4.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1112793369.32726.4.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062201.41991.blaisorblade@yahoo.it>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 6 Apr 2005 22:01:41 +0200
To: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, jdike@karaya.com, lkml <linux-kernel@vger.kernel.org>

On Wednesday 06 April 2005 15:16, Anton Altaparmakov wrote:
> Uml compile is btoken in current linus bk 2.6:
>
>   CC      arch/um/kernel/ptrace.o
> arch/um/kernel/ptrace.c: In function `send_sigtrap':
> arch/um/kernel/ptrace.c:324: warning: implicit declaration of function
> `SC_IP'
> arch/um/kernel/ptrace.c:324: error: union has no member named `tt'
> arch/um/kernel/ptrace.c:324: error: union has no member named `tt'
> arch/um/kernel/ptrace.c:324: error: invalid lvalue in unary `&'
> make[1]: *** [arch/um/kernel/ptrace.o] Error 1
> make: *** [arch/um/kernel] Error 2
>
> My .config is attached.  I suspect it is because I am not compiling in
> TT support and only SKAS...
Well, good guess - you're getting more and more used with UML!

Yes, the fix is in -mm.

Quoting from -rc2-mm1 announce:

+uml-fix-compilation-for-__choose_mode-addition.patch

 UML fix

Andrew, can you merge it now, if you want, after Anton verifies it's the 
correct fix indeed for his problem? I *do* expect his situation to fail 
without the patch, but just to be more sure.

However, I recall with 2.6.11-bk7 a slightly different problem, when compiling 
only SKAS mode in, and I don't think this has been fixed:

[uml-devel] [UML/2.6] -bk7 tree does not run when compiled as SKAS-only

I'm forwarding that mail to LKML and you, Andrew - for your -rc regressions 
mail folder.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
