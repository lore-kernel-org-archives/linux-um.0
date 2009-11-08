Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Sun, 8 Nov 2009 13:47:22 -0500
From: Theodore Tso <tytso@mit.edu>
Message-ID: <20091108184722.GA1647@mit.edu>
References: <cover.1257602781.git.andre.goddard@gmail.com>
	<7d5883637aa976b54e944998f635d47a41618a75.1257602781.git.andre.goddard@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7d5883637aa976b54e944998f635d47a41618a75.1257602781.git.andre.goddard@gmail.com>
Subject: Re: [uml-devel] [PATCH v4 12/12] tree-wide: convert open calls to
	remove	spaces to skip_spaces() lib function
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: =?iso-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>
Cc: Pavel Roskin <proski@gnu.org>, Stefan Haberland <stefan.haberland@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-cachefs@redhat.com, Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steve Dickson <steved@redhat.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, dm-devel@redhat.com, Julia Lawall <julia@diku.dk>, "H . Peter Anvin" <hpa@zytor.com>, Daire Byrne <Daire.Byrne@framestore.com>, Alasdair G Kergon <agk@redhat.com>, Greg Banks <gnb@melbourne.sgi.com>, Stefan Weinhuber <wein@de.ibm.com>, Eric Sandeen <sandeen@redhat.com>, Adam Belay <abelay@mit.edu>, Helge Deller <deller@gmx.de>, x86@kernel.org, James Morris <jmorris@namei.org>, Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, WANG Cong <wangcong@zeuux.org>, Roman Hoog Antink <rha@open.ch>, linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrea Righi <righi.andrea@gmail.com>, alsa-devel@alsa-project.org, Len Brown <len.brown@intel.com>, Samuel Ortiz <samuel@sortiz.org>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sitsofe Wheeler <sitsofe@yahoo.com>, Steven Rostedt <rostedt@goodmis.org>, linux-raid@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andreas Dilger <adilger@sun.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Mikulas Patocka <mpatocka@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>, Thomas Gleixner <tglx@linutronix.de>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Arjan van de Ven <arjan@linux.intel.com>, Jan Engelhardt <jengelh@medozas.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andre Noll <maan@systemlinux.org>, netfilter-devel@vger.kernel.org, linux-parisc@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, Stoyan Gaydarov <stoyboyker@gmail.com>, Patrick McHardy <kaber@trash.net>, Kyle McMartin <kyle@mcmartin.ca>, Christof Schmitt <christof.schmitt@de.ibm.com>, netfilter@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Joe Perches <joe@perches.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, "David S . Miller" <davem@davemloft.net>

On Sat, Nov 07, 2009 at 01:16:20PM -0200, Andr=E9 Goddard Rosa wrote:
> Makes use of skip_spaces() defined in lib/string.c for removing leading
> spaces from strings all over the tree.
> =

> Also, while at it, if we see (*str && isspace(*str)), we can be sure to
> remove the first condition (*str) as the second one (isspace(*str)) also
> evaluates to 0 whenever *str =3D=3D 0, making it redundant. In other word=
s,
> "a char equals zero is never a space".

There are a number of places that have the pattern of skipping
whitespace, calling simpler_strtoul(), and then skipping whitespace
afterwards.  And thinkpad_acpi.c and fs/ext4/super.c both have an
indentical function, parse_strotul(), which basically does this plus
doing actual error checking (a number of callers of simple_strtoul
aren't checking to see if the user passed in a valid number or not,
boo.)

I would suggest that we should lift parse_strtoul() into lib/, both to
save a bit of code, as well as encouraging people to do proper input
validation, while we are doing this tree-wide cleanup.

						- Ted

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

