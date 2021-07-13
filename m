Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3POi-00BMLb-MO
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 20:52:57 +0000
Received: by mail-yb1-xb29.google.com with SMTP id x192so37100952ybe.6
 for <linux-um@lists.infradead.org>; Tue, 13 Jul 2021 13:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <CABqSeAQpb+wEM03knfmDHwtpM6vdfrpuaTwDHA35KY0PHa92cw@mail.gmail.com>
 <3343f1643f7f2c6f85e1c446d30c453d@codeaurora.org>
 <CABqSeAQV8m=64+qENaWD-nDvCgdnC0sRN8JxvAr0Ww2Px0OkDQ@mail.gmail.com>
 <e39b8c62-0dd4-356a-c87c-89da967e9bf0@cambridgegreys.com>
 <675205198.21885.1626185036367.JavaMail.zimbra@nod.at>
 <5a30a105b004c98186883182e7e4f56a@codeaurora.org>
 <66cdf3de4a10308be633b1dc40567857c55df9aa.camel@sipsolutions.net>
 <5a402bd444a2c9926f9b3945beb4b5a2@codeaurora.org>
 <f6a53d9531996a10d29aaae16ecda60afd290769.camel@sipsolutions.net>
 <ca337f4b5e3e60fc0701be00f6546f2e@codeaurora.org>
In-Reply-To: <ca337f4b5e3e60fc0701be00f6546f2e@codeaurora.org>
From: YiFei Zhu <zhuyifei1999@gmail.com>
Date: Tue, 13 Jul 2021 15:52:43 -0500
Message-ID: <CABqSeARhjVWwX3YnaUZtvn1-8a6c46oxCj6BnpDirVMP9jjEgA@mail.gmail.com>
Subject: Re: UML kernel panic on initialization
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: subashab@codeaurora.org
Cc: Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, anton ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, stranche@codeaurora.org

On Tue, Jul 13, 2021 at 3:00 PM <subashab@codeaurora.org> wrote:
>
> > Wasn't compatible with my system ... can you describe the host system?
> >
> > johannes
>
> Its an Intel 8th gen i7 with Ubuntu 16.04 LTS.
> Kernel version is 4.15.0-70-generic.
> gcc version is 5.4.

FWIW, for me, compiling UML with defconfig inside a Ubuntu 16.04
docker is enough to produce a binary that could trigger a crash even
outside docker, using hostfs root mount (so no special ld.so).

This is some sort of compiler difference.

YiFei Zhu

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

