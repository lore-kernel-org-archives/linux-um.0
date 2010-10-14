Return-Path: <htejun@gmail.com>
Message-ID: <4CB745FC.5090504@gmail.com>
Date: Thu, 14 Oct 2010 20:03:40 +0200
From: Tejun Heo <htejun@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] um: ubd: Fix data corruption
References: <20100928225202.GA30352@foursquare.net> <4CA275CE.6060401@fusionio.com> <20100929012945.GA3324@foursquare.net> <4CA2CCC3.8010307@fusionio.com> <20100929063452.GA13290@foursquare.net> <4CAA02D0.7040901@gmail.com> <20101004195152.GA31583@foursquare.net> <4CAAE077.9010500@gmail.com> <20101005203137.GA594@foursquare.net> <4CAD7D98.7080808@fusionio.com> <20101007202339.GA8338@foursquare.net> <4CB70234.3030308@gmail.com> <AANLkTi=ni-zEfCMXLR8BJyPQcwzEKAUKYs4uH7ur12Fk@mail.gmail.com>
In-Reply-To: <AANLkTi=ni-zEfCMXLR8BJyPQcwzEKAUKYs4uH7ur12Fk@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Chris Frey <cdfrey@foursquare.net>, Jens Axboe <jaxboe@fusionio.com>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello,

On 10/14/2010 04:20 PM, richard -rw- weinberger wrote:
> It does not work for me.
> But the error is a different one. :-)
> Without your patch I've never got this kernel trace.
> 
> [   59.850000] kworker/0:1: page allocation failure. order:0, mode:0x20

Hmm... you're seeing out of memory condition.  If the code screws up
filesystem access, I suppose it could make that happen too but can you
please check the configuration just in case (especially the memory
size)?  Also, if you can reliably reproduce the filesystem corruption
w/o the patch, can you please tell me how to do it?

Thanks.

-- 
tejun

