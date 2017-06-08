Return-Path: <richard@nod.at>
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
 <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at>
 <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
 <CAMuHMdUrDPvNoZ5UpS-qu4JOyq+JSy2tpxttKiUPFexB6yhTYw@mail.gmail.com>
 <8ad31524-dfc3-4fc4-f725-a8899aea9234@deltatee.com>
 <348baf8d-b42f-13a7-3398-cb0268d7c693@deltatee.com>
From: Richard Weinberger <richard@nod.at>
Message-ID: <996ae534-92d6-ab7d-df90-7052b86f8039@nod.at>
Date: Thu, 8 Jun 2017 21:17:21 +0200
MIME-Version: 1.0
In-Reply-To: <348baf8d-b42f-13a7-3398-cb0268d7c693@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Logan Gunthorpe <logang@deltatee.com>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 08.06.2017 um 20:53 schrieb Logan Gunthorpe:
> Any thoughts on this? My patches for the other architectures are already
> in linux-next. um is the only one that remains.

IMHO an ifdef in scatterlist code does not hurt.
It is equally ugly than mocking ioremap for UML.

So, I'm puzzled.
Arnd, what do you think?
Shall !HAS_IOMEM archs just mock these functions?

Thanks,
//richard

