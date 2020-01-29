Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwdCw-0003e1-1k
 for linux-um@lists.infradead.org; Wed, 29 Jan 2020 02:35:59 +0000
Received: by mail-lf1-x129.google.com with SMTP id y19so10699755lfl.9
 for <linux-um@lists.infradead.org>; Tue, 28 Jan 2020 18:35:56 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com.
 [209.85.208.172])
 by smtp.gmail.com with ESMTPSA id r10sm177543ljk.9.2020.01.28.18.35.53
 for <linux-um@lists.infradead.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2020 18:35:53 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id q8so12692773ljb.2
 for <linux-um@lists.infradead.org>; Tue, 28 Jan 2020 18:35:53 -0800 (PST)
MIME-Version: 1.0
References: <1224347843.24297.1579473209765.JavaMail.zimbra@nod.at>
In-Reply-To: <1224347843.24297.1579473209765.JavaMail.zimbra@nod.at>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 Jan 2020 18:35:37 -0800
Message-ID: <CAHk-=wjupwymAN-aOytdtxz4EfyKH7MirmJJw40chDGzFQT9wQ@mail.gmail.com>
Subject: Re: Upcomming UBI/UBIFS/UML pull requests
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
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>, Johannes Berg <johannes@sipsolutions.net>, anton ivanov <anton.ivanov@cambridgegreys.com>, linux-mtd <linux-mtd@lists.infradead.org>, Miquel Raynal <miquel.raynal@bootlin.com>

On Sun, Jan 19, 2020 at 2:33 PM Richard Weinberger <richard@nod.at> wrote:
>
> due to traveling I won't be able to send you pull requests
> for UBI/UBIFS and UML this time.
>
> Therefore I've already prepared my next branches and one of my colleges will
> send you an PR as soon as the merge window opens.
>
> Miquel: UBI/UBIFS
> Anton or Johannes: UML

Heh. I just pulled from Anton's pull request, and noticed that the tag
was actually signed by you.

That's all fine, and this worked, and I have no complaints. But I
would like to point out that it's perfectly ok to just send pull
requests for the merge window early, since it was clearly all done and
ready to go. Just make it very clear that it's an early pull request
for the next merge window so that I don't get upset if I think I
should pull it during the rc series and it's not just fixes.

Delegating somebody else to send the pull request later obviously also
worked, but I thought I'd mention this "send it early" option. It's
not hugely common, but quite often I actually have one or two pull
requests that come in before the window even opens (exactly because of
travel or other timing issues), so it's also not exactly unheard of.

                Linus

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

