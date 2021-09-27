Return-Path: <jcmvbkbc@gmail.com>
MIME-Version: 1.0
References: <20210927220110.1066271-1-mcgrof@kernel.org> <20210927220110.1066271-7-mcgrof@kernel.org>
In-Reply-To: <20210927220110.1066271-7-mcgrof@kernel.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 27 Sep 2021 15:50:36 -0700
Message-ID: <CAMo8BfLX84HBuVe=FyqWkVU5Ek-aKFk++omnqsmf9wO6fdVpMQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] xtensa/platforms/iss/simdisk: add error handling
 support for add_disk()
Content-Type: text/plain; charset="UTF-8"
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, justin@coraid.com, Geert Uytterhoeven <geert@linux-m68k.org>, Ulf Hansson <ulf.hansson@linaro.org>, hare@suse.de, Tejun Heo <tj@kernel.org>, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, johannes.berg@intel.com, chris.obbard@collabora.com, krisman@collabora.com, zhuyifei1999@gmail.com, thehajime@gmail.com, Chris Zankel <chris@zankel.net>, tim@cyberelk.net, "open list:TENSILICA XTENSA PORT (xtensa)" <linux-xtensa@linux-xtensa.org>, linux-um@lists.infradead.org, "open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-um.lists.infradead.org>

On Mon, Sep 27, 2021 at 3:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  arch/xtensa/platforms/iss/simdisk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

