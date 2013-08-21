Return-Path: <hpa@zytor.com>
In-Reply-To: <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <alpine.DEB.2.10.1308211452260.31430@tglase.lan.tarent.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
From: "H. Peter Anvin" <hpa@zytor.com>
Date: Wed, 21 Aug 2013 14:58:04 +0200
Message-ID: <7813eeb3-8f96-4d3d-87ec-f2a880122804@email.android.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC] Get rid of SUBARCH
To: Thorsten Glaser <t.glaser@tarent.de>, Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, mmarek@suse.cz, geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org, jdike@addtoit.com, gxt@mprc.pku.edu.cn, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-mips@linux-mips.org, linux-sh@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

If ARCH doesn't match uname for some definition of match?

Thorsten Glaser <t.glaser@tarent.de> wrote:
>On Wed, 21 Aug 2013, Richard Weinberger wrote:
>
>> The series touches also m68k, sh, mips and unicore32.
>> These architectures magically select a cross compiler if ARCH !=3D
>SUBARCH.
>> Do really need that behavior?
>
>Not precisely that, but it=E2=80=99s very common in m68k land
>to just cross-build kernels with
>
>$ make ARCH=3Dm68k menuconfig
>$ make ARCH=3Dm68k
>
>Maybe a generalising of that feature, and making it
>independent of SUBARCH (which can then die)?
>
>bye,
>//mirabilos

--=20
Sent from my mobile phone. Please excuse brevity and lack of formatting.

