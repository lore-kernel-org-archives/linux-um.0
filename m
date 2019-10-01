Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iFM17-0006BC-OU
 for linux-um@lists.infradead.org; Tue, 01 Oct 2019 17:32:55 +0000
Message-ID: <6e5e87abcf0fa6453239678524be6049598dc080.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: Loadable BPF "Firmware" for vector drivers
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 01 Oct 2019 19:32:48 +0200
In-Reply-To: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
References: <20191001165537.3386-1-anton.ivanov@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Cc: richard@nod.at


> +/*
> + * We cannot use the firmware.c loader API here because this is not a module
> + *  and we do not have a proper device structure to pass to it as required
> + *  by the firmware API
> + */

I think you should delete the comment now :)

[...]

> +	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
> +		goto flash_fail;

That is the standard firmware loader now after all.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

