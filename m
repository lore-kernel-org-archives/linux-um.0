Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMYnO-00029u-QF
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 13:32:00 +0000
Received: by mail-pl1-x644.google.com with SMTP id t13so3055916ply.13
 for <linux-um@lists.infradead.org>; Tue, 13 Nov 2018 05:31:47 -0800 (PST)
Subject: Re: [PATCH 3/4] um: Remove unsafe printks from the io thread
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-4-anton.ivanov@cambridgegreys.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <985e1e06-e779-047f-3ce3-fbd3c67a15de@kernel.dk>
Date: Tue, 13 Nov 2018 06:31:44 -0700
MIME-Version: 1.0
In-Reply-To: <20181113115947.19290-4-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: richard@nod.at, hch@lst.de

On 11/13/18 4:59 AM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Printk out of the io thread has been proven to be unsafe. It is
> safer to pass the error to the block IO layer nad let it print
> it if need be.

As per previous message, I don't think this is a good idea at all.
It'd be much better to fix the real issue, not work around it.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

