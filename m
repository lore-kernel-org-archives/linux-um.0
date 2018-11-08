Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKk3X-0006Wt-5h
 for linux-um@lists.infradead.org; Thu, 08 Nov 2018 13:09:09 +0000
Received: by mail-pf1-x436.google.com with SMTP id v68-v6so5696131pfk.0
 for <linux-um@lists.infradead.org>; Thu, 08 Nov 2018 05:08:56 -0800 (PST)
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
 <2067083.opUWeOxqyK@blindfold>
 <fe020526-ac24-0279-ca27-7ccabba7a6cc@kernel.dk>
 <4373302.HifUKF8Eoy@blindfold>
 <edaa00ed-7e65-7303-1034-7672d1ecd8cb@kernel.dk>
 <c1e0f38d-3af9-eaeb-6b63-26ad32c3824a@kot-begemot.co.uk>
 <22344260-70ab-0f31-3526-e30251a06d1c@kot-begemot.co.uk>
 <0313653c-af30-95ad-6841-30d1476d8b7d@kot-begemot.co.uk>
 <435177aa-ef45-ee3d-0432-16b94daf8797@kot-begemot.co.uk>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b2bc4879-ecae-7b5c-fc81-21c22b6e4f88@kernel.dk>
Date: Thu, 8 Nov 2018 06:08:50 -0700
MIME-Version: 1.0
In-Reply-To: <435177aa-ef45-ee3d-0432-16b94daf8797@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org, hch@lst.de

>> printks are reordered (not surprising, two threads trying to write).
>>
>> It is not going in twice. Simply, error is uninitialized for SYNC and 
>> set to a non-zero value only upon an error.

That makes more sense, since the io_req is allocted every time. That
would have placed the error in the allocator, which would be extremely
unlikely.

>> The error is from SYNC, not from the write.
> 
> And the spinlock needs to be irqsave/irqrestore after all.
> 
> I will send a patch to finish this one off shortly.

The lock does NOT need to be save/restore, I already explained why.

-- 
Jens Axboe


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

