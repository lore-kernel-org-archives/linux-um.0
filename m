Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8RNq-0004L0-RJ
 for linux-um@lists.infradead.org; Wed, 19 Aug 2020 16:56:20 +0000
Received: by mail-pj1-x1042.google.com with SMTP id e4so1391658pjd.0
 for <linux-um@lists.infradead.org>; Wed, 19 Aug 2020 09:56:16 -0700 (PDT)
Subject: Re: [PATCH] block: convert tasklets to use new tasklet_setup() API
References: <20200817091617.28119-1-allen.cryptic@gmail.com>
 <20200817091617.28119-2-allen.cryptic@gmail.com>
 <b5508ca4-0641-7265-2939-5f03cbfab2e2@kernel.dk>
 <202008171228.29E6B3BB@keescook>
 <161b75f1-4e88-dcdf-42e8-b22504d7525c@kernel.dk>
 <202008171246.80287CDCA@keescook>
 <df645c06-c30b-eafa-4d23-826b84f2ff48@kernel.dk>
 <1597780833.3978.3.camel@HansenPartnership.com>
 <f3312928-430c-25f3-7112-76f2754df080@kernel.dk>
 <1597849185.3875.7.camel@HansenPartnership.com>
 <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <2b1a5987-9b54-d63e-b3da-d3024505776c@kernel.dk>
Date: Wed, 19 Aug 2020 10:56:08 -0600
MIME-Version: 1.0
In-Reply-To: <CAOMdWSJRR0BhjJK1FxD7UKxNd5sk4ycmEX6TYtJjRNR6UFAj6Q@mail.gmail.com>
Content-Language: en-US
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
To: Allen <allen.lkml@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-atm-general@lists.sourceforge.net, manohar.vanga@gmail.com, airlied@linux.ie, linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kys@microsoft.com, anton.ivanov@cambridgegreys.com, devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux1394-devel@lists.sourceforge.net, maximlevitsky@gmail.com, richard@nod.at, deller@gmx.de, jassisinghbrar@gmail.com, 3chas3@gmail.com, intel-gfx@lists.freedesktop.org, Jakub Kicinski <kuba@kernel.org>, mporter@kernel.crashing.org, jdike@addtoit.com, Kees Cook <keescook@chromium.org>, oakad@yahoo.com, s.hauer@pengutronix.de, linux-input@vger.kernel.org, linux-um@lists.infradead.org, linux-block@vger.kernel.org, broonie@kernel.org, openipmi-developer@lists.sourceforge.net, mitch@sfgoth.com, linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, netdev@vger.kernel.org, martyn@welchs.me.uk, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, sre@kernel.org, linux-spi@vger.kernel.org, alex.bou9@gmail.com, Allen Pais <allen.cryptic@gmail.com>, stefanr@s5r6.in-berlin.de, Daniel Vetter <daniel@ffwll.ch>, linux-ntb@googlegroups.com, Romain Perier <romain.perier@gmail.com>, shawnguo@kernel.org, David Miller <davem@davemloft.net>

On 8/19/20 9:24 AM, Allen wrote:
>> [...]
>>>> Since both threads seem to have petered out, let me suggest in
>>>> kernel.h:
>>>>
>>>> #define cast_out(ptr, container, member) \
>>>>     container_of(ptr, typeof(*container), member)
>>>>
>>>> It does what you want, the argument order is the same as
>>>> container_of with the only difference being you name the containing
>>>> structure instead of having to specify its type.
>>>
>>> Not to incessantly bike shed on the naming, but I don't like
>>> cast_out, it's not very descriptive. And it has connotations of
>>> getting rid of something, which isn't really true.
>>
>> Um, I thought it was exactly descriptive: you're casting to the outer
>> container.  I thought about following the C++ dynamic casting style, so
>> out_cast(), but that seemed a bit pejorative.  What about outer_cast()?
>>
>>> FWIW, I like the from_ part of the original naming, as it has some
>>> clues as to what is being done here. Why not just from_container()?
>>> That should immediately tell people what it does without having to
>>> look up the implementation, even before this becomes a part of the
>>> accepted coding norm.
>>
>> I'm not opposed to container_from() but it seems a little less
>> descriptive than outer_cast() but I don't really care.  I always have
>> to look up container_of() when I'm using it so this would just be
>> another macro of that type ...
>>
> 
>  So far we have a few which have been suggested as replacement
> for from_tasklet()
> 
> - out_cast() or outer_cast()
> - from_member().
> - container_from() or from_container()
> 
> from_container() sounds fine, would trimming it a bit work? like from_cont().

I like container_from() the most, since it's the closest to contain_of()
which is a well known idiom for years. The lines will already be shorter
without the need to specify the struct, so don't like the idea of
squeezing container into cont for any of them. For most people, cont is
usually short for continue, not container.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

