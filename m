Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n4fc2-00Apww-J4
 for linux-um@lists.infradead.org; Tue, 04 Jan 2022 08:56:11 +0000
Message-ID: <6fad9c06ac08b60d9bfea703552712daf150a4f7.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: Run console exit code also upon kernel panic
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 04 Jan 2022 09:56:07 +0100
In-Reply-To: <20220101215810.13260-2-richard@nod.at>
References: <20220101215810.13260-1-richard@nod.at>
 <20220101215810.13260-2-richard@nod.at>
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
To: Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, anton.ivanov@cambridgegreys.com

On Sat, 2022-01-01 at 22:58 +0100, Richard Weinberger wrote:
> 
> diff --git a/arch/um/include/shared/uml_console.h b/arch/um/include/shared/uml_console.h
> new file mode 100644
> index 000000000000..aa8d02fe5e90
> --- /dev/null
> +++ b/arch/um/include/shared/uml_console.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2022 Richard Weinberger <richard@nod.at>
> + */
> +
> +#ifndef UML_CONSOLE_H
> +#define UML_CONSOLE_H
> +
> +extern void uml_console_exit(void);
> 

Not sure it's worth adding a whole new file just for this, but also
doesn't really matter :)

johannes

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

