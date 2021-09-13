Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPiBZ-0012b6-66
 for linux-um@lists.infradead.org; Mon, 13 Sep 2021 09:23:34 +0000
Subject: Re: [PATCH] um: gitignore: add kernel/capflags.c
References: <20210913101728.73cbc025c093.Ic498b3ba9b0af569c18f88e5c1084ab182c722e0@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <170f7a09-74fc-03a6-5a80-a58a25d47318@cambridgegreys.com>
Date: Mon, 13 Sep 2021 09:46:56 +0100
MIME-Version: 1.0
In-Reply-To: <20210913101728.73cbc025c093.Ic498b3ba9b0af569c18f88e5c1084ab182c722e0@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>

On 13/09/2021 09:17, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This file is generated, we should ignore it.
> 
> Fixes: d8fb32f4790f ("um: Add support for host CPU flags and alignment")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/.gitignore b/arch/um/.gitignore
> index 6323e5571887..d69ea5b562ce 100644
> --- a/arch/um/.gitignore
> +++ b/arch/um/.gitignore
> @@ -2,3 +2,4 @@
>   kernel/config.c
>   kernel/config.tmp
>   kernel/vmlinux.lds
> +kernel/capflags.c
> 
Acked-By: anton.ivanov@cambridgegreys.com

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

