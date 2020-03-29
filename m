Return-Path: <richard@nod.at>
Date: Sun, 29 Mar 2020 23:54:07 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <606921391.56755.1585518847045.JavaMail.zimbra@nod.at>
In-Reply-To: <7f8b86f1-3759-c9ff-6216-a7104edb8030@cambridgegreys.com>
References: <20200124221401.210449-1-brendanhiggins@google.com> <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com> <7f8b86f1-3759-c9ff-6216-a7104edb8030@cambridgegreys.com>
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: Brendan Higgins <brendanhiggins@google.com>, Jeff Dike <jdike@addtoit.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James McMechan <james_mcmechan@hotmail.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>
List-ID: <linux-um.lists.infradead.org>

----- Urspr=C3=BCngliche Mail -----
> Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> An: "Brendan Higgins" <brendanhiggins@google.com>, "Jeff Dike" <jdike@add=
toit.com>, "richard" <richard@nod.at>, "Geert
> Uytterhoeven" <geert@linux-m68k.org>, "James McMechan" <james_mcmechan@ho=
tmail.com>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kern=
el@vger.kernel.org>, "davidgow"
> <davidgow@google.com>
> Gesendet: Samstag, 8. Februar 2020 08:56:58
> Betreff: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static

> On 08/02/2020 01:07, Brendan Higgins wrote:
>> On Fri, Jan 24, 2020 at 2:14 PM Brendan Higgins
>> <brendanhiggins@google.com> wrote:
>>>
>>> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
>>> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
>>> UML_NET_PCAP; this is because glibc tries to load NSS which does not
>>> support being statically linked. So make CONFIG_STATIC_LINK depend on
>>> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>>>
>>> Link:
>>> https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambr=
idgegreys.com/#t
>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>>> ---
>>=20
>> Ping.
>=20
> ICMP echo reply,
>=20
> I thought I acked it :)
>=20
> If not - apologies.

Applied, thanks!

Thanks,
//richard

