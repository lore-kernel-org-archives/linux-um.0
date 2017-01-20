Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Jan 2017 00:11:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 0/5] UM: Fine-tuning for some function implementations
Message-ID: <20170120051124.GA9786@parts.user-mode-linux.org>
References: <c10b7f33-f573-aa9f-239e-ccca5540f264@users.sourceforge.net>
 <2585eee4-c3cf-229f-1603-a29d404db618@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2585eee4-c3cf-229f-1603-a29d404db618@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: SF Markus Elfring <elfring@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Anton Ivanov <aivanov@kot-begemot.co.uk>, Dan Williams <dan.j.williams@intel.com>, Hannes Reinecke <hare@suse.com>, Jens Axboe <axboe@fb.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The kmalloc(sizeof(struct foo), ...) => kmalloc(sizeof(*foo), ...)
ones are OK.

The rest is cargo-cult programming.

				Jeff
-- 
Jeff Dike
AddToIt
978-254-0789 (o)
978-394-8986 (c)

