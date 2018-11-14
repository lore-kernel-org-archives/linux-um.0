Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from verein.lst.de ([213.95.11.211] helo=newverein.lst.de)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMx66-00083G-Qi
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 15:28:55 +0000
Date: Wed, 14 Nov 2018 16:28:42 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/4] um: Clean-up command processing in UML UBD driver
Message-ID: <20181114152842.GA28557@lst.de>
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
 <20181113115947.19290-3-anton.ivanov@cambridgegreys.com>
 <8a1d3dcb-ea52-e745-b961-ea51224d2405@kernel.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a1d3dcb-ea52-e745-b961-ea51224d2405@kernel.dk>
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
To: Jens Axboe <axboe@kernel.dk>
Cc: richard@nod.at, linux-um@lists.infradead.org, hch@lst.de, anton.ivanov@cambridgegreys.com

On Tue, Nov 13, 2018 at 06:34:31AM -0700, Jens Axboe wrote:
> > +	/* operations with bio_vec arguments */
> > +	case REQ_OP_READ:
> > +	case REQ_OP_WRITE:
> > +		{
> > +			struct req_iterator iter;
> > +			struct bio_vec bvec;
> > +			u64 off = (u64)blk_rq_pos(req) << 9;
> > +
> > +			rq_for_each_segment(bvec, req, iter) {
> > +				ret = ubd_queue_one_vec(hctx, req, off, &bvec);
> > +				if (ret < 0)
> > +					goto out;
> > +				off += bvec.bv_len;
> > +			}
> >  		}
> > +		break;
> 
> This indentation is wrong/awkward. The usual style is:

And for extra point just split the code into a separate helper,
avoiding the whole switch scoping issue entirely.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

