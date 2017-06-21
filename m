Return-Path: <arndbergmann@gmail.com>
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <93cf1943-8206-d648-54ce-067c464cb0f6@deltatee.com>
References: <1495726955-27497-1-git-send-email-logang@deltatee.com>
 <3c36765c-9e23-7947-b6d9-29ca892bd348@nod.at> <1bffdbbd-a317-d9a3-88d2-d02501d2fae1@deltatee.com>
 <CAMuHMdUrDPvNoZ5UpS-qu4JOyq+JSy2tpxttKiUPFexB6yhTYw@mail.gmail.com>
 <8ad31524-dfc3-4fc4-f725-a8899aea9234@deltatee.com> <348baf8d-b42f-13a7-3398-cb0268d7c693@deltatee.com>
 <996ae534-92d6-ab7d-df90-7052b86f8039@nod.at> <1d4d3148-fc88-f834-3881-16b85dafc8ef@deltatee.com>
 <feb62ff1-2f1d-d6f6-208a-4c948bb8c479@nod.at> <93cf1943-8206-d648-54ce-067c464cb0f6@deltatee.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Jun 2017 23:36:06 +0200
Message-ID: <CAK8P3a35Y90dS-A+q8KHFMR+d+nJCkmWq9b1NVPpDb2UyfK=ew@mail.gmail.com>
Subject: Re: [PATCH v2] um: add dummy ioremap and iounmap functions
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Stephen Bates <sbates@raithlin.com>, Jeff Dike <jdike@addtoit.com>, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Jun 21, 2017 at 11:31 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 21/06/17 03:30 PM, Richard Weinberger wrote:
>> Since Arnd stays silent and um is the only remaining odd-ball, let's merge this
>> in v4.13.
>
> Great! Thanks!

Sorry for missing most of the discussion earlier. The last proposed version
(returning NULL to always fail) seems fine to me, too.

       Arnd

