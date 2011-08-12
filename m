Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 12 Aug 2011 10:19:28 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
Message-Id: <20110812101928.f34da400.rdunlap@xenotime.net>
In-Reply-To: <1313108903-7351-1-git-send-email-j.neuschaefer@gmx.net>
References: <1313108903-7351-1-git-send-email-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] UserModeLinux-HOWTO.txt: remove ^H characters
To: Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 12 Aug 2011 02:28:23 +0200 Jonathan Neusch=E4fer wrote:

> If you can't read this patch, please run:
>=20
> 	sed -i -e "s/[^\o10]\o10//g" \
> 		Documentation/virtual/uml/UserModeLinux-HOWTO.txt
>=20
> Signed-off-by: Jonathan Neusch=E4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/virtual/uml/UserModeLinux-HOWTO.txt |  530 ++++++++++-=
---------
>  1 files changed, 265 insertions(+), 265 deletions(-)

I like the patch, although the text file seems to be quite old and it
appears to be a generated file (from where?).

Acked-by: Randy Dunlap <rdunlap@xenotime.net>

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your cod=
e ***
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

