Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [uml-devel] [PATCH] uml: Fix build with recent glibc
Date: Fri, 02 Mar 2018 09:39:48 +0100
Message-ID: <2427974.ifqE8EITFz@blindfold>
In-Reply-To: <20180301183023.00002ddf@intel.com>
References: <20180301030844.23448-1-andi@firstfloor.org> <20180301183023.00002ddf@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Freitag, 2. M=EF=BF=BDrz 2018, 03:30:23 CET schrieb Jesse Brandeburg:
> On Wed, 28 Feb 2018 19:08:44 -0800
>=20
> Andi Kleen <andi@firstfloor.org> wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> >=20
> > Newer glibc did some include namespace "cleanups" and removed
> > struct ucontext and friends. This already broke a lot of software,
> > and UML seems to be the latest victim.
> >=20
> > Use the typedefs which are still available. They also work on
> > older glibcs.
> >=20
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
>=20
> same patch that I sent on Feb 1st.  Hope you can get more traction than
> I did.
>=20
> https://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/=
msg
> 10071.html
>=20
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Sorry guys, due to various reasons in the last months I had not much time f=
or=20
UML. But things get better now.
The fix from the first sender is in -next and will hit Linus' tree soon.

Thanks,
//richard

