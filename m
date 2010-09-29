Return-Path: <cdfrey@foursquare.net>
Date: Wed, 29 Sep 2010 02:34:52 -0400
From: Chris Frey <cdfrey@foursquare.net>
Subject: Re: [PATCH 1/1] um: ubd: Fix data corruption
Message-ID: <20100929063452.GA13290@foursquare.net>
References: <1285710456-4435-1-git-send-email-richard@nod.at> <20100928150000.f007f43e.akpm@linux-foundation.org> <201009290013.11332.richard@nod.at> <20100928225202.GA30352@foursquare.net> <4CA275CE.6060401@fusionio.com> <20100929012945.GA3324@foursquare.net> <4CA2CCC3.8010307@fusionio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4CA2CCC3.8010307@fusionio.com>
To: Jens Axboe <jaxboe@fusionio.com>
Cc: Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jdike@addtoit.com" <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, "janjaap@bos.nl" <janjaap@bos.nl>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "martin.petersen@oracle.com" <martin.petersen@oracle.com>, "adobriyan@gmail.com" <adobriyan@gmail.com>, "syzop@vulnscan.org" <syzop@vulnscan.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed, Sep 29, 2010 at 02:21:07PM +0900, Jens Axboe wrote:
> This seems to imply that the original commit pin pointed is not
> the only issue we have in that code atm.
> 
> I think we need to find the real fix here, just disabling merging
> is not a fix (it's just a nasty work-around for the real bug).

You're probably right, and I'm quite willing to help test further patches
to help get to the bottom of this.

- Chris


