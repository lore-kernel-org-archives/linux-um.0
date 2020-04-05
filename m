Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jLAoE-0002pa-3j
 for linux-um@lists.infradead.org; Sun, 05 Apr 2020 19:19:55 +0000
Received: by mail-wr1-x42a.google.com with SMTP id 65so14878060wrl.1
 for <linux-um@lists.infradead.org>; Sun, 05 Apr 2020 12:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200405045030.sslbedviyt7zqwhi@lynus-laptop>
In-Reply-To: <20200405045030.sslbedviyt7zqwhi@lynus-laptop>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 5 Apr 2020 21:19:40 +0200
Message-ID: <CAFLxGvx0STbGdxevzJZJmtaOirednP=yDeCynoM1KXSWYcy78Q@mail.gmail.com>
Subject: Re: Clean up scripts/tags.sh
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
To: Lingyu Zhu <lynuszhu@gmail.com>
Cc: linux-um <linux-um@lists.infradead.org>

Hi!

On Sun, Apr 5, 2020 at 6:50 AM Lingyu Zhu <lynuszhu@gmail.com> wrote:
>
> Hello. Yesterday I asked on #kernelnewbies IRC channel whether um supports arch
> other than x86, and I got the answer that um right now only works on x86.
> I consider scripts/tags.sh needs a little cleaning up. First, this script fails
> to collect files under arch/x86/um to produce tags. Second, it collect the
> extra files from the arch/$SUBARCH, which I considered pointless. Since
> um only works on x86, it's better to collect arch/x86/um for x86 um build,
> and output error message for other cases.
> Also, I wonder is it proper to send the scripts/tags.sh patch to this list?

Did you test your assumptions?
UML shares code with $SUBARCH. And not just arch/$SUBARCH/um.
See arch/x86/um/Makefile as example.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

