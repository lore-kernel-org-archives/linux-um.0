Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Kvpjw-0001tx-BF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Oct 2008 08:52:20 +0000
Received: from nelson.telenet-ops.be ([195.130.133.66])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Kvpjt-0008Fl-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 31 Oct 2008 08:52:20 +0000
Date: Fri, 31 Oct 2008 09:52:08 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
In-Reply-To: <20081031103820.7e81f7f1.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0810310951200.22521@anakin>
References: <804dabb00810291851xc617690wac1404176437fb84@mail.gmail.com>
	<Pine.LNX.4.64.0810300925590.4898@anakin>
	<20081031103820.7e81f7f1.sfr@canb.auug.org.au>
MIME-Version: 1.0
Subject: Re: [uml-devel] =?utf-8?q?=22warning=3A_passing_argument_1_of_?=
	=?utf-8?q?=E2=80=98um=5Fexecve=E2=80=99_discards_qualifiers_from_pointer_?=
	=?utf-8?q?target_type=22?=
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Fri, 31 Oct 2008, Stephen Rothwell wrote:
> On Thu, 30 Oct 2008 09:31:04 +0100 (CET) Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > I see there are no UML builds yet on
> > http://kisskb.ellerman.id.au/kisskb/matrix/.
> > Perhaps it would be a good idea to add them?
> 
> We would love to, but we can't figure out how to cross build an x86 based
> uml kernel on a powerpc machine.  Any hints?

Haven't tried it, but something like ARCH=um SUBARCH=x86 should work...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
