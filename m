Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gK7ST-0002qO-63
 for linux-um@lists.infradead.org; Tue, 06 Nov 2018 19:56:18 +0000
From: Richard Weinberger <richard@nod.at>
Subject: Re: 4.20-rc1 looks broken for UML
Date: Tue, 06 Nov 2018 20:56:04 +0100
Message-ID: <6298063.A9SzxUBULK@blindfold>
In-Reply-To: <e5c51b9c-97d5-ae12-b06f-303f0469d46b@kot-begemot.co.uk>
References: <4a096c4f-6552-dbcb-676b-a87306dde07a@kot-begemot.co.uk>
 <2bebae3b-e7e3-8f2c-42bf-89fba1ca32b6@kot-begemot.co.uk>
 <e5c51b9c-97d5-ae12-b06f-303f0469d46b@kot-begemot.co.uk>
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
Cc: linux-um@lists.infradead.org

Anton,

Am Dienstag, 6. November 2018, 20:09:44 CET schrieb Anton Ivanov:
> 
> On 11/6/18 5:25 PM, Anton Ivanov wrote:
> > On 06/11/2018 17:04, Richard Weinberger wrote:
> >> Am Dienstag, 6. November 2018, 16:00:59 CET schrieb Anton Ivanov:
> >>> On 11/5/18 10:07 PM, Richard Weinberger wrote:
> >>>> Anton,
> >>>>
> >>>> Am Montag, 5. November 2018, 16:22:36 CET schrieb Anton Ivanov:
> >>>>> This looks like something specific to ttys - the io there gets
> >>>>> corruption and/or hangs.
> >>>>>
> >>>>> I cannot reproduce it when I ssh in.
> >>>>>
> >>>>> It does not look like it is the new write IRQ bugfix - that works 
> >>>>> fine
> >>>>> over 4.19.
> >>>>>
> >>>>> Still debugging...
> >>>> Hmm, I don't see this with my Debian userspace.
> >>>> What exactly is your setup/config?
> >>>
> >>> Gotcha.
> >>>
> >>> 8ebfe885c65ec82a0b1e955cf99ed62664e84414 is the guilty party.
> >>>
> >>> With it, I get tty corruption on UML. Any attempt to push a large 
> >>> amount
> >>> of data via the console results in spurious echoes or even a hang.
> >>>
> >>> Reverting it fixes things.
> >> Really?!
> >> This is "TTY: sn_console: Replace spin_is_locked() with spin_trylock()".
> >> sn_console is "SGI Altix L1 serial console"...
> >
> > OK. Then I am losing my mind.
> 
> Not fully. I stand by my earlier statement - 4.20-rc1 is not quite right.
> 
> The combination of debug options I had enabled hanged UML on boot with 
> 4.20-rc1 made it hang on boot or produce the aforementioned corruption 
> on tty later.
> 
> Turning all debug off gives me a kernel which boots. However, it fails 
> later at some point either on networking or or on disk.
> 
> The same images boot cleanly with 4.14 to 4.19 +/- various fixes.
> 
> I am going to rebuild everything from scratch including new clean Debian 
> images tomorrow and start digging again.

I did a test with your .config and indeed, UML hangs.

The offending commit is this one:
commit ecb0a83e3198f2c1142901687afacbc73602a13b
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 18 22:55:03 2018 +0200

    ubd: remove use of blk_rq_map_sg
    
    There is no good reason to create a scatterlist in the ubd driver,
    it can just iterate the request directly.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    [rw: Folded in improvements as discussed with hch and jens]
    Signed-off-by: Richard Weinberger <richard@nod.at>
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

Please check your root filesystem, it is possible that the broken block
driver broke it and you see further problems.
Let me figure what in your .config triggers the issue.

Thanks,
//richard



_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

