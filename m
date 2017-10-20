Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: um: Use common error handling code in port_listen_fd()
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
 <1508522803.30181.3.camel@perches.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <92e5fe7f-9c6f-82b4-75a3-e7ec86004092@users.sourceforge.net>
Date: Fri, 20 Oct 2017 20:22:20 +0200
MIME-Version: 1.0
In-Reply-To: <1508522803.30181.3.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> If you are going to use multiple labels,
> it'd be nicer to rename out: too.

Thanks for your suggestion.

I left this place untouched because such kind of renaming seemed to be unwanted
in some software areas for a while.
How long should I wait for corresponding feedback before another small
source code adjustment will be appropriate?

Regards,
Markus

