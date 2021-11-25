Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mq4wK-006ITo-FY
 for linux-um@lists.infradead.org; Thu, 25 Nov 2021 02:56:49 +0000
Received: by mail-wr1-x436.google.com with SMTP id i5so8274287wrb.2
 for <linux-um@lists.infradead.org>; Wed, 24 Nov 2021 18:56:44 -0800 (PST)
MIME-Version: 1.0
References: <CANn89i+hQTn26hK-4CA=cAwCxEMzogqD30PYdqz4NP8kjmH2gg@mail.gmail.com>
 <CANn89i+K6=Kc0weayD_phAPn9YT=2UUje+1BZfg=kUiLp7ELqQ@mail.gmail.com>
 <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
In-Reply-To: <619eee05.1c69fb81.4b686.4bbc@mx.google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Nov 2021 18:56:31 -0800
Message-ID: <CANn89iJdQ1VTLYUKu1hYNm4wF__ZzrwNYr28v_vGM0MCybJpxg@mail.gmail.com>
Subject: Re: [tip:x86/core 1/1] arch/x86/um/../lib/csum-partial_64.c:98:12:
 error: implicit declaration of function 'load_unaligned_zeropad'
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
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, alexanderduyck@fb.com, kbuild-all@lists.01.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, lkp@intel.com, peterz@infradead.org, x86@kernel.org

On Wed, Nov 24, 2021 at 5:59 PM Noah Goldstein <goldstein.w.n@gmail.com> wrote:
>

>
> Hi, I'm not sure if this is intentional or not, but I noticed that the output
> of 'csum_partial' is different after this patch. I figured that the checksum
> algorithm is fixed so just wanted mention it incase its a bug. If not sorry
> for the spam.
>
> Example on x86_64:
>
> Buff: [ 87, b3, 92, b7, 8b, 53, 96, db, cd, 0f, 7e, 7e ]
> len : 11
> sum : 0
>
> csum_partial new : 2480936615
> csum_partial HEAD: 2472089390

No worries.

skb->csum is 32bit, but really what matters is the 16bit folded value.

So make sure to apply csum_fold() before comparing the results.

A minimal C and generic version of csum_fold() would be something like

static unsigned short csum_fold(u32 csum)
{
  u32 sum = csum;
  sum = (sum & 0xffff) + (sum >> 16);
  sum = (sum & 0xffff) + (sum >> 16);
  return ~sum;
}

I bet that csum_fold(2480936615) == csum_fold(2472089390)

It would be nice if we had a csum test suite, hint, hint ;)

Thanks !

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

