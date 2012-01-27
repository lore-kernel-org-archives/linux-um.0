Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 26 Jan 2012 17:08:38 -0800
From: Greg KH <gregkh@suse.de>
Message-ID: <20120127010838.GA27899@suse.de>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
 <58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
 <CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
 <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
To: Kay Sievers <kay.sievers@vrfy.org>, richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: stian@nixia.no, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Thu, Jan 26, 2012 at 11:56:50PM +0100, richard -rw- weinberger wrote=
:
> On Thu, Jan 26, 2012 at 11:12 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
> > On Thu, Jan 26, 2012 at 11:11 PM, =A0<stian@nixia.no> wrote:
> >>> Hi!
> >>>
> >>> systemd goes nuts on UML.
> >>> While hunting down all issues I found out that systemd wants to r=
ead from
> >>> /sys/class/tty/tty0/active.
> >>
> >> Kernel version?
> >
> > Linus' tree as of today.
>=20
> Hmm, fbc92a34 introduced it.
> But it depends on CONFIG_VT. :-\

Is that a problem for UML somehow?

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

