Return-Path: <richard.weinberger@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4CA2CCC3.8010307@fusionio.com>
References: <1285710456-4435-1-git-send-email-richard@nod.at>
	<20100928150000.f007f43e.akpm@linux-foundation.org>
	<201009290013.11332.richard@nod.at>
	<20100928225202.GA30352@foursquare.net>
	<4CA275CE.6060401@fusionio.com>
	<20100929012945.GA3324@foursquare.net>
	<4CA2CCC3.8010307@fusionio.com>
Date: Sat, 2 Oct 2010 19:27:22 +0200
Message-ID: <AANLkTikU4b5si0bA0QTqZWROHQkknKuwRSrtu-dV-Vzq@mail.gmail.com>
Subject: Re: [PATCH 1/1] um: ubd: Fix data corruption
From: richard -rw- weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Chris Frey <cdfrey@foursquare.net>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Sep 29, 2010 at 7:21 AM, Jens Axboe <jaxboe@fusionio.com> wrote:
> I think we need to find the real fix here, just disabling merging
> is not a fix (it's just a nasty work-around for the real bug).
>

Jens,

Do you have an idea which parts of the code are buggy?

-- 
Cheers,
//richard

