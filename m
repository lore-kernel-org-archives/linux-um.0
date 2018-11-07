Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gKSxJ-0006zK-5R
 for linux-um@lists.infradead.org; Wed, 07 Nov 2018 18:53:34 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: Summary so far - ubd breakage in 4.20-rc1
Date: Wed, 07 Nov 2018 19:53:14 +0100
Message-ID: <1553895.q7DRUMsJH8@blindfold>
In-Reply-To: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
References: <94397e9b-36a6-92b0-b074-ce3640cee00e@kot-begemot.co.uk>
MIME-Version: 1.0
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-um@lists.infradead.org, hch@lst.de

[CC'ing hch and jens again.]

Am Mittwoch, 7. November 2018, 19:40:13 CET schrieb Anton Ivanov:
> Hi list, hi Richard.
> 
> I spent some time digging into the 4.20-rc1 issue today, and unless I am 
> missing something it looks like UBD breakage and it looks like memory 
> corruption. I cannot pin down where it is coming from.
> 
> These are my finding so far:
> 
> 1. It happens only for write requests - I have not picked up a case 
> where a read req breaks in any way so far. UML boots fine until it tries 
> to remount the root fs read only and then fails with an IO error.
> 
> 2. In my config it looks like it is introduced by the "um: Convert ubd 
> driver to blk-mq" commit. It appears in 4.19 if I cherry-pick it and 
> disappears in 4.20-rc1 if I revert it.
> 
> 3. The write req is correctly passed as far as the actual io handler and 
> correctly processed by the io thread. Upon finishing the request in the 
> io thread the value of req->error is 0 and all values look OK.
> 
> 4. The moment the req is read back by the irq handler req->error is 
> something which looks like data from elsewhere instead of the request. 
> F.e error may contain 55AA55AA
> 
> 5. Other bits of the req are also zapped in a similar manner.
> 
> 6. The pointer to the req passed along the IPC pipe is correct. If a req 
> at 00000000deafe300 is given for execution to the IO thread, that is 
> what is in the io_req variable in the handler. It is just contents of 
> that req by that time are scrambled.
> 
> 7.  I see it only for write reqs.
> 
> I just do not see where it can be zapped. At all. I did a prototype to 
> add the BLK_STS_AGAIN return code and continue from half-x-mitted req 
> logic similar to the one in nbd driver. It is not that. There is 
> something else which causes this and I just do not see it :(
> 
> A.
> 
> 





_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

