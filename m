Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Sun, 8 Nov 2009 16:50:00 +0000
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <20091108165000.374714cb@lxorguk.ukuu.org.uk>
In-Reply-To: <c7d3b02b5e28eaa54a5360d57dfd177c44320187.1257602781.git.andre.goddard@gmail.com>
References: <cover.1257602781.git.andre.goddard@gmail.com>
	<c7d3b02b5e28eaa54a5360d57dfd177c44320187.1257602781.git.andre.goddard@gmail.com>
Mime-Version: 1.0
Subject: Re: [uml-devel] [PATCH v4 10/12] string: factorize skip_spaces and
 export it to be generally available
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-14"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?ISO-8859-14?B?QW5kcuk=?= Goddard Rosa <andre.goddard@gmail.com>
Cc: Andreas Dilger <adilger@sun.com>, Mike Snitzer <snitzer@redhat.com>, Takashi Iwai <tiwai@suse.de>, Kysela <perex@perex.cz>, Jan@nerdnet.nl, Stefan Weinhuber <wein@de.ibm.com>, Eric Sandeen <sandeen@redhat.com>, "James E ."	J.Bottomley" <jejb@parisc-linux.org>,"        linux-cachefs@redhat.com, WANG Cong <wangcong@zeuux.org>, Len Brown <len.brown@intel.com>, Trond Myklebust <Trond.Myklebust@netapp.com>, Rusty Russell <rusty@rustcorp.com.au>, netfilter@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Engelhardt <jengelh@medozas.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, =?ISO-8859-14?B?QW5k?=@nerdnet.nl, "Martin K ."	Petersen" <martin.petersen@oracle.com>,"        linux-kernel@vger.kernel.org, Stoyan Gaydarov <stoyboyker@gmail.com>, Kyle McMartin <kyle@mcmartin.ca>, netfilter-devel@vger.kernel.org, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Patrick McHardy <kaber@trash.net>, alsa-devel@alsa-project.org, dm-devel@redhat.com, Jaroslav@nerdnet.nl, Kergon <agk@redhat.com>, Banks <gnb@melbourne.sgi.com>, linux-s390@vger.kernel.org, Helge Deller <deller@gmx.de>, Samuel@nerdnet.nl, coreteam@netfilter.org, Michael Holzheu <holzheu@linux.vnet.ibm.com>, van de Ven <arjan@linux.intel.com>, Theodore Ts'o <tytso@mit.edu>, Jason Baron <jbaron@redhat.com>, Steve@nerdnet.nl, Christof Schmitt <christof.schmitt@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Frederic Weisbecker <fweisbec@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, James Morris <jmorris@namei.org>, Andre Noll <maan@systemlinux.org>, ibm-acpi-devel@lists.sourceforge.net, Jens Axboe <jens.axboe@oracle.com>, Adam Belay <abelay@mit.edu>, Stefan Haberland <stefan.haberland@de.ibm.com>, Roman Hoog Antink <rha@open.ch>, linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Dike <jdike@addtoit.com>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Steven Rostedt <rostedt@goodmis.org>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-parisc@vger.kernel.org, Jeff@nerdnet.nl, =?ISO-8859-14?B?cuk=?= Goddard Rosa <andre.goddard@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>, "David S . Miller  <davem@davemloft.net>, Pavel Roskin" <proski@gnu.org>, Jan Kara <jack@suse.cz>, Neil Brown <neilb@suse.de>, "H . Peter Anvin" <hpa@zytor.com>, Dickson <steved@redhat.com>, David Howells <dhowells@redhat.com>, Julia Lawall <julia@diku.dk>, Alasdair@nerdnet.nl, Daire Byrne <Daire.Byrne@framestore.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Arjan@nerdnet.nl, Andrea Righi <righi.andrea@gmail.com>, Ortiz <samuel@sortiz.org>, user-mode-linux-devel@lists.sourceforge.net, Sitsofe Wheeler <sitsofe@yahoo.com>, linux-raid@vger.kernel.org, Greg@nerdnet.nl, Mikulas Patocka <mpatocka@redhat.com>, user-mode-linux-user@lists.sourceforge.net, netdev@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

On Sat,  7 Nov 2009 13:16:18 -0200
Andr=E9 Goddard Rosa <andre.goddard@gmail.com> wrote:

> On the following sentence:
>     while (*s && isspace(*s))
>         s++;

Looks fine but for one thing: it's actually shorter inline than moved
into /lib so at the very least it should be a header inline not a
function call.

Second minor comment. Although it never made it into the final ANSI C,
the proposed name (and the one used in a lot of other non Linux code for
this) is stpblk().

Alan

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

