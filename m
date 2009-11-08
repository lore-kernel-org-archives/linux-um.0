Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <1257696303.4184.8.camel@mulgrave.site>
References: <cover.1257602781.git.andre.goddard@gmail.com> 
	<1257696303.4184.8.camel@mulgrave.site>
From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Date: Sun, 8 Nov 2009 14:52:18 -0200
Message-ID: <b8bf37780911080852l10d11f4ele5bf6a6aed94c5fe@mail.gmail.com>
Subject: Re: [uml-devel] [dm-devel] [PATCH v4 00/12] introduce skip_spaces(),
	reducing 	code size plus some clean-ups
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
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Pavel Roskin <proski@gnu.org>, Stefan Haberland <stefan.haberland@de.ibm.com>, Jan Kara <jack@suse.cz>, linux-cachefs@redhat.com, Mike Snitzer <snitzer@redhat.com>, Neil Brown <neilb@suse.de>, Frederic Weisbecker <fweisbec@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steve Dickson <steved@redhat.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, David Howells <dhowells@redhat.com>, ibm-acpi-devel@lists.sourceforge.net, device-mapper development <dm-devel@redhat.com>, Julia Lawall <julia@diku.dk>, "H . Peter Anvin" <hpa@zytor.com>, Daire Byrne <Daire.Byrne@framestore.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Banks <gnb@melbourne.sgi.com>, Stefan Weinhuber <wein@de.ibm.com>, Eric Sandeen <sandeen@redhat.com>, Adam Belay <abelay@mit.edu>, netfilter-devel@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, James Morris <jmorris@namei.org>, Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@redhat.com>, Alasdair G Kergon <agk@redhat.com>, WANG Cong <wangcong@zeuux.org>, Roman Hoog Antink <rha@open.ch>, linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, Andrea Righi <righi.andrea@gmail.com>, alsa-devel@alsa-project.org, Len Brown <len.brown@intel.com>, Samuel Ortiz <samuel@sortiz.org>, coreteam@netfilter.org, user-mode-linux-devel@lists.sourceforge.net, linux-s390@vger.kernel.org, Trond Myklebust <Trond.Myklebust@netapp.com>, Jeff Dike <jdike@addtoit.com>, Rusty Russell <rusty@rustcorp.com.au>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sitsofe Wheeler <sitsofe@yahoo.com>, Steven Rostedt <rostedt@goodmis.org>, linux-raid@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andreas Dilger <adilger@sun.com>, Pekka Enberg <penberg@cs.helsinki.fi>, Mikulas Patocka <mpatocka@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-user@lists.sourceforge.net, Jaroslav Kysela <perex@perex.cz>, Thomas Gleixner <tglx@linutronix.de>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Arjan van de Ven <arjan@linux.intel.com>, Jan Engelhardt <jengelh@medozas.de>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Andre Noll <maan@systemlinux.org>, Theodore Ts'o <tytso@mit.edu>, linux-parisc@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org, Jason Baron <jbaron@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>, Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org, Stoyan Gaydarov <stoyboyker@gmail.com>, Patrick McHardy <kaber@trash.net>, Kyle McMarti n <kyle@mcmartin.ca>, Chr istof Schmitt <christof.schmitt@de.ibm.com>, netfilter@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Joe Perches <joe@perches.com>, linux390@de.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, "David S . Miller" <davem@davemloft.net>

Hi, James!

On Sun, Nov 8, 2009 at 2:05 PM, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
> On Sat, 2009-11-07 at 13:16 -0200, Andr=E9 Goddard Rosa wrote:
>> This patch reduces lib.a code size by 173 bytes on my Core 2 with gcc 4.=
4.1
>> even considering that it exports a newly defined function skip_spaces()
>> to drivers:
>> =A0 =A0text =A0 =A0data =A0 =A0 bss =A0 =A0 dec =A0 =A0 hex filename
>> =A0 64867 =A0 =A0 840 =A0 =A0 592 =A0 66299 =A0 102fb (TOTALS-lib.a-befo=
re)
>> =A0 64954 =A0 =A0 584 =A0 =A0 588 =A0 66126 =A0 1024e (TOTALS-lib.a-afte=
r)
>> and implements some code tidy up.
>>
>> Besides reducing lib.a size, it converts many in-tree drivers to use the
>> newly defined function, which makes another small reduction on kernel si=
ze
>> overall when those drivers are used.
>
> Before we embark on something as massive as this, could we take a step
> back. =A0I agree that if I were coming up with the strstip() interface
> today I probably wouldn't have given it two overloaded uses.
>
> However, I think the function, in spite of this minor issue, is very
> usable. =A0I still don't understand why people thought adding a
> __must_check, which is what damaged one of the overloaded uses, is a
> good idea.

Differently of "static void strip(char *str)"@scripts/kconfig/conf.c ,
this function
does not moves the characters to the beginning of the string, so that if th=
at
string is going to be reused it should refer to the newly returned string s=
tart.

I've changed it to remove the const and return a "char *".

Do you think __must_check is not needed as well?

Thanks,
Andr=E9

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

