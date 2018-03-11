Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [RFC PATCH 25/35] hostfs: rename do_rmdir() to hostfs_do_rmdir()
Date: Sun, 11 Mar 2018 12:19:21 +0100
Message-ID: <3779476.NRYLIFElLR@blindfold>
In-Reply-To: <20180311105557.20807-26-linux@dominikbrodowski.net>
References: <20180311105557.20807-1-linux@dominikbrodowski.net> <20180311105557.20807-26-linux@dominikbrodowski.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, luto@kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sonntag, 11. M=EF=BF=BDrz 2018, 11:55:47 CET schrieb Dominik Brodowski:
> do_rmdir() is used in the VFS layer at fs/namei.c, so use a different
> name in hostfs.
>=20
> CC: Jeff Dike <jdike@addtoit.com>
> CC: Richard Weinberger <richard@nod.at>
> CC: user-mode-linux-devel@lists.sourceforge.net
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Acked-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

