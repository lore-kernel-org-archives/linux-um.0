Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AZCtu-0004Y4-FR
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:26 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AZCtt-0002I2-VA
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 24 Dec 2003 09:34:26 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [UML patch] fixes for !CONFIG_PROC_MM, 2.6.0
References: <Pine.LNX.4.58.0312171735540.8123@earth> <Pine.LNX.4.58.0312181514140.7622@earth> <Pine.LNX.4.58.0312191232230.29584@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.58.0312191232230.29584@boston.corp.fedex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200312241225.52103.blaisorblade_spam@yahoo.it>
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
Date: Wed, 24 Dec 2003 12:25:52 +0100
Content-Transfer-Encoding: quoted-printable
To: Jeff Chua <jchua@fedex.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Alle 05:35, venerd=EC 19 dicembre 2003, Jeff Chua ha scritto:
> On Thu, 18 Dec 2003, Ingo Molnar wrote:
> >     redhat.com/~mingo/UML-patches/uml-combo-2.6.0-A2
>
> Can't compile. Got the following error ...
This is known to be a problem with module support in 2.6.

> include/asm/processor.h:66: `CONFIG_X86_L1_CACHE_SHIFT' undeclared here
> (not in a function)
> include/asm/processor.h:66: requested alignment is not a constant
> arch/um/util/mk_task_kern.c: In function `main':
> arch/um/util/mk_task_kern.c:13: structure has no member named `regs'

Onto plain -test9 patch(and even 2.6.0 kernel) or Ingo's combo, apply patch=
es=20
number 1, 2 and 3 from here and disable CONFIG_MODVERSIONS if it's enabled:

http://web.tiscali.it/no-redirect-tiscali/blaisorblade/linux/archives/UML/v=
1/index.html

If you get any "unresolved symbol" message, post it here, so the appropriat=
e,=20
straightforward fix(adding an EXPORT_SYMBOL(name_of_the_missing_symbol) in =

some .c file) will be included next time.
Bye
--=20
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
