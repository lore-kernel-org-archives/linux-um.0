Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMx8M-00085b-OU
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:31:15 +0000
Subject: Re: [PATCH 2/4] um: Clean-up command processing in UML UBD driver
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-3-anton.ivanov@cambridgegreys.com>
 <8a1d3dcb-ea52-e745-b961-ea51224d2405@kernel.dk>
 <20181114152842.GA28557@lst.de>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <191d9b97-23e0-c5e3-1755-b8fc1fc28cf3@cambridgegreys.com>
Date: Wed, 14 Nov 2018 15:31:01 +0000
MIME-Version: 1.0
In-Reply-To: <20181114152842.GA28557@lst.de>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: richard@nod.at, linux-um@lists.infradead.org

On 14/11/2018 15:28, Christoph Hellwig wrote:
> On Tue, Nov 13, 2018 at 06:34:31AM -0700, Jens Axboe wrote:
>>> +	/* operations with bio_vec arguments */
>>> +	case REQ_OP_READ:
>>> +	case REQ_OP_WRITE:
>>> +		{
>>> +			struct req_iterator iter;
>>> +			struct bio_vec bvec;
>>> +			u64 off = (u64)blk_rq_pos(req) << 9;
>>> +
>>> +			rq_for_each_segment(bvec, req, iter) {
>>> +				ret = ubd_queue_one_vec(hctx, req, off, &bvec);
>>> +				if (ret < 0)
>>> +					goto out;
>>> +				off += bvec.bv_len;
>>> +			}
>>>   		}
>>> +		break;
>> This indentation is wrong/awkward. The usual style is:
> And for extra point just split the code into a separate helper,
> avoiding the whole switch scoping issue entirely.
>
I thought about it :) And forgot as I was fighting with the origin of 
the crashes at the time.

Do you want me to reissue the series or I can do an incremental?

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

