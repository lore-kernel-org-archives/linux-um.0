Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGFD-0001Rw-KH for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:31:19 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DJGF8-0006c7-TX for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:31:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Broken compiling under 2.6.12-rc2 on my machine
References: <cbec11ac050405205173f18157@mail.gmail.com>
	<200504060145.24555.rob@landley.net>
In-Reply-To: <200504060145.24555.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062136.26895.blaisorblade@yahoo.it>
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
Date: Wed, 6 Apr 2005 21:36:26 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Ian McDonald <imcdnzl@gmail.com>

On Wednesday 06 April 2005 07:45, Rob Landley wrote:
> On Tuesday 05 April 2005 11:51 pm, Ian McDonald wrote:
> > Hi there,
> >

> I'm trying to track this down and fix it, but mine didn't even get that
> far, it died with:
>
>   CC      arch/um/kernel/ptrace.o
> arch/um/kernel/ptrace.c: In function `send_sigtrap':
> arch/um/kernel/ptrace.c:324: warning: implicit declaration of function
> `REGS_SP'
> arch/um/kernel/ptrace.c:324: error: union has no member named `skas'
> arch/um/kernel/ptrace.c:324: error: invalid lvalue in unary `&'
> arch/um/kernel/ptrace.c:324: warning: implicit declaration of function
> `REGS_IP'
> arch/um/kernel/ptrace.c:324: error: union has no member named `skas'
> arch/um/kernel/ptrace.c:324: error: invalid lvalue in unary `&'
> make[1]: *** [arch/um/kernel/ptrace.o] Error 1
Yes, that's true, the fix is in -mm, enable SKAS mode too during compilation 
(even if you don't use it) and it will work. See the answer to the latest 
"[uml-devel] [linux-2.6-bk] UML compile broken!" thread for this problem.

> > sed: -e expression #4, char 2: Extra characters after command
> > make[1]: *** [arch/um/kernel/config.c] Error 1
> > make: *** [arch/um/kernel] Error 2
> >
> > and here is the file arch/um/kernel/.config.tmp.cmd that gets created
> > which I am guessing has the sed error
> > cmd_arch/um/kernel/config.tmp := sed -e 's/"/\\"/g' -e 's/^/"/' -e
> > 's/$$/\\n"/' /home/iam4/linuxsrc/linux-2.6.12-rc2/.config >
> > arch/um/kernel/config.tmp
>
> There is no expression #4 in that.  It has three expressions (-e arguments)
> and a filename...
Ian, good catch, but you're quoting the wrong .cmd file. config.tmp is built 
correctly, config.c is not, so you should quote .config.c.cmd.

Anyway, from looking at what you quote, it's identical to the code in 
arch/um/kernel/Makefile. Quoting the correct code:

quiet_cmd_quote2 = QUOTE   $@
cmd_quote2 = sed -e '/CONFIG/{'          \
                  -e 's/"CONFIG"\;/""/'        \
                  -e 'r $(obj)/config.tmp'     \
                  -e 'a""\;'                   \
                  -e '}'                       \
                  $< > $@

As you see, there is a fourth expression, *here*. But it's -e '}'.

This patch went in after 2.6.11, I'm noticing - wow, are releases getting so 
slow?

> > System is Debian Woody,
Can you post your sed version? and Rob, can you then test it and fix the code? 
Please save the correct config.c currently created and check it for 
reference.
> > I don't know much yet about sed or the kernel build process but can
> > look into if nobody else makes sense of this. Just thought it was good
> > to get it out there considering it doesn't compile and rc2 has just
> > come out.

> I know sed.  I wrote and maintain the current busybox sed implementation. 
> I just don't know what the build's doing.
Explained above.
> Could you send me your .config?

> > And UML does compile under 2.6.11 with a patch for gcc
The __va_copy fix, right? I'm trying to merge that in 2.6.11.7, it's under 
review. The only problem is that somebody complains about the fact Linux 
still supports 2.95. Luckily for you, Linus already shut them off once, so 
the support won't go away soon.
> > (which is 
> > include in 2.6.12-rc4). Haven't yet tried 2.6.12-rc1 but can do later
> > if this will help.
You mean -rc2, ok.
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
