Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 12:10:24 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: um: Use common error handling code in port_listen_fd()
Message-ID: <20171023091024.yxfva5p63zodj6bp@mwanda>
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
 <20171023084800.p26qcpb7iqyqrz4v@mwanda>
 <e248c905-eb76-d9bd-6e10-92be8b200590@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e248c905-eb76-d9bd-6e10-92be8b200590@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Mon, Oct 23, 2017 at 11:01:05AM +0200, SF Markus Elfring wrote:
> > This business of moving the error code to the bottom of the function
> > just makes the code less readable.
> 
> I got an other software development opinion on this aspect.
> Could you become used to the proposed control flow structure
> in the affected function?
> 

No.  Don't do this.  It's pointless obfuscation.

> 
> > I know you never listen to anyone,
> 
> My response times might not fir to your preferences.
> 
> 
> > but you should stop doing it.
> 
> I am going to offer suggestions for change patterns which I find useful.
> There are some challenges around change acceptance as usual.

Yeah.  I knew it was pointless to ask you to stop this...  :(

regards,
dan carpenter


