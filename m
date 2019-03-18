Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h5ob1-0001GF-M3
 for linux-um@lists.infradead.org; Mon, 18 Mar 2019 09:30:17 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] hostfs: fix mismatch between link_file definition and
 declaration
Date: Mon, 18 Mar 2019 10:30:12 +0100
Message-ID: <2148931.zAvBH5bg2x@blindfold>
In-Reply-To: <fa1378b0-3048-8309-a152-8fdf5696731d@canonical.com>
References: <20190317230909.7373-1-colin.king@canonical.com>
 <1760676.zAVrM27zAz@blindfold>
 <fa1378b0-3048-8309-a152-8fdf5696731d@canonical.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Colin Ian King <colin.king@canonical.com>
Cc: kernel-janitors@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Anton Ivanov <anton.ivanov@cambridgegreys.com>

Am Montag, 18. M=E4rz 2019, 09:41:28 CET schrieb Colin Ian King:
> On 17/03/2019 23:49, Richard Weinberger wrote:
> > Am Montag, 18. M=E4rz 2019, 00:09:09 CET schrieb Colin King:
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> The function link_file declaration in the header file has the order
> >> of the two arguments (from, to) swapped when compared to the definition
> >> arguments of (to, from).  Fix this by swapping them around to match
> >> the definition.
> >>
> >> This error predates the git history, so no idea when this error
> >> was introduced.
> > =

> > commit bf4f804738544a95b8bc8d6a7e2629c3fc0240dd
> > Author: jdike <jdike>
> > Date:   Sat Dec 9 22:52:44 2000 +0000
> > =

> >     hostfs now mostly works.  Almost all of the common operations are n=
ow
> >     implemented, the main exceptions being mknod and executing files fr=
om
> >     a hostfs filesystem.
> > =

> > Enough archaeology for today. :-)
> =

> Nice. How do you find these ancient git commits?

This commit is from the old UML cvs tree.
I did a import to git some time ago and pushed it to:
https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml-history.git/

For classic pre-git stuff, check:
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

