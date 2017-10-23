Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: um: Use common error handling code in port_listen_fd()
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
 <20171023084800.p26qcpb7iqyqrz4v@mwanda>
 <e248c905-eb76-d9bd-6e10-92be8b200590@users.sourceforge.net>
 <20171023091024.yxfva5p63zodj6bp@mwanda>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <64ed8a02-3158-38b7-b795-efdc7f63e7e5@users.sourceforge.net>
Date: Mon, 23 Oct 2017 11:17:51 +0200
MIME-Version: 1.0
In-Reply-To: <20171023091024.yxfva5p63zodj6bp@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

>> Could you become used to the proposed control flow structure
>> in the affected function?
>>
> 
> No.  Don't do this.

Thanks for your information.


> It's pointless obfuscation.

I disagree for this view.


>> There are some challenges around change acceptance as usual.
> 
> Yeah.  I knew it was pointless to ask you to stop this...  :(

The mixture of agreements and disagreements will evolve over time, won't they?

Regards,
Markus

