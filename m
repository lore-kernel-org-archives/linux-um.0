Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 12:28:21 +0200
From: Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] um: Use common error handling code in port_listen_fd()
Message-ID: <20171023102821.GA238@x4>
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
 <20171023084800.p26qcpb7iqyqrz4v@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023084800.p26qcpb7iqyqrz4v@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 2017.10.23 at 11:48 +0300, Dan Carpenter wrote:
> This business of moving the error code to the bottom of the function
> just makes the code less readable.  I know you never listen to anyone,
> but you should stop doing it.

How long have we to put up with this?
He just keeps sending these crap patches without listening to anybody,
thereby wasting valuable developer time.

Even browsing LKML is no fun anymore, because his endless mindless patch
series drags everything down qualitywise.

David, would it be possible to simply ban him (SF Markus Elfring) from
vger.kernel.org?

-- 
Markus

