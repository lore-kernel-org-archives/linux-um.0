Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPU0y-0005dC-Br
 for linux-um@lists.infradead.org; Tue, 29 Oct 2019 16:06:37 +0000
Received: by mail-io1-xd41.google.com with SMTP id p6so15369312iod.7
 for <linux-um@lists.infradead.org>; Tue, 29 Oct 2019 09:06:35 -0700 (PDT)
Subject: Re: [PATCH v2] um: Entrust re-queue to the upper layers
References: <20191029091334.3095-1-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <71002768-3887-5af1-5dd3-7e691aa3f656@kernel.dk>
Date: Tue, 29 Oct 2019 10:06:32 -0600
MIME-Version: 1.0
In-Reply-To: <20191029091334.3095-1-anton.ivanov@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, rrs@researchut.com, hch@lst.de, stable@vger.kernel.org

On 10/29/19 3:13 AM, Anton Ivanov wrote:
> Fixes crashes due to ubd requeue logic conflicting with the block-mq
> logic. Crash is reproducible in 5.0 - 5.3.
> 
> Fixes: 53766defb8c860a47e2a965f5b4b05ed2848e2d0
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

I can pick this one up, I'll fix up the Fixes and stable stuff too.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

