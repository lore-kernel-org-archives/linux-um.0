Return-Path: <axboe@kernel.dk>
Message-ID: <4CB8336B.9030400@kernel.dk>
Date: Fri, 15 Oct 2010 12:56:43 +0200
From: Jens Axboe <axboe@kernel.dk>
MIME-Version: 1.0
Subject: Re: [PATCH v2.6.36-rc7] ubd: fix incorrect sector handling during
 request  restart
References: <4CB81C91.7070406@kernel.org>
In-Reply-To: <4CB81C91.7070406@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Tejun Heo <tj@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Richard Weinberger <richard@nod.at>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, Geert Uytterhoeven <geert@linux-m68k.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Alexey Dobriyan <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>, Chris Frey <cdfrey@foursquare.net>, stable <stable@kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 2010-10-15 11:19, Tejun Heo wrote:
> Commit f81f2f7c (ubd: drop unnecessary rq->sector manipulation)
> dropped request->sector manipulation in preparation for global request
> handling cleanup; unfortunately, it incorrectly assumed that the
> updated sector wasn't being used.
> 
> ubd tries to issue as many requests as possible to io_thread.  When
> issuing fails due to memory pressure or other reasons, the device is
> put on the restart list and issuing stops.  On IO completion, devices
> on the restart list are scanned and IO issuing is restarted.
> 
> ubd issues IOs sg-by-sg and issuing can be stopped in the middle of a
> request, so each device on the restart queue needs to remember where
> to restart in its current request.  ubd needs to keep track of the
> issue position itself because,
> 
> * blk_rq_pos(req) is now updated by the block layer to keep track of
>   _completion_ position.
> 
> * Multiple io_req's for the current request may be in flight, so it's
>   difficult to tell where blk_rq_pos(req) currently is.
> 
> Add ubd->rq_pos to keep track of the issue position and use it to
> correctly restart io_req issue.

Thanks Tejun, good to see this one resolved.

-- 
Jens Axboe


