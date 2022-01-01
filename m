Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from zeniv-ca.linux.org.uk ([2607:5300:60:148a::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n3S0w-006bJK-PA
 for linux-um@lists.infradead.org; Sat, 01 Jan 2022 00:12:52 +0000
Date: Sat, 1 Jan 2022 00:12:24 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: remove set_fs for UML
Message-ID: <Yc+caOi47BbzlPw6@zeniv-ca.linux.org.uk>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>, x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Tue, Dec 21, 2021 at 10:05:03PM +0100, Richard Weinberger wrote:
> Christoph,
> =

> ----- Urspr=FCngliche Mail -----
> > Von: "hch" <hch@lst.de>
> > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgeg=
reys.com>
> > CC: "x86" <x86@kernel.org>, "linux-um" <linux-um@lists.infradead.org>, =
"linux-kernel" <linux-kernel@vger.kernel.org>
> > Gesendet: Mittwoch, 15. Dezember 2021 17:56:10
> > Betreff: remove set_fs for UML
> =

> > Hi Richard and Anton,
> > =

> > this series removes address space overrides using set_fs for UML.
> > =

> > Diffstat:
> > um/Kconfig                   |    1 -
> > um/include/asm/thread_info.h |    4 ----
> > um/include/asm/uaccess.h     |   21 +++++++++++++++++++--
> > um/kernel/skas/uaccess.c     |   25 -------------------------
> > x86/include/asm/mtrr.h       |    8 +-------
> > x86/kernel/setup.c           |    7 ++++++-
> > x86/um/asm/segment.h         |    8 --------
> >  7 files changed, 26 insertions(+), 48 deletions(-)
> =

> So far UML seems to work with these changes applied. :-)
> I have applied both patches to my UML tree for now, I assume x86 maintain=
ers are fine with
> patch 1/2?

Hmmm...  AFAICS, the right thing to do would be to have __get_kernel_nofault
and __put_kernel_nofault in arch/x86/um/asm/something.  The question is how
to avoid duplicating the x86 implementation of those (along with the asm-go=
to
fun, etc.)...

But Christoph is right, it's not a new problem.  As far as I'm concerned,
that series looks fine.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

