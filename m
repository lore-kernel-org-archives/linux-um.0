Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from web2.default.djames.uk0.bigv.io ([2001:41c8:51:1f6::246])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kvhb0-0006M8-Iw
 for linux-um@lists.infradead.org; Sat, 02 Jan 2021 14:09:31 +0000
Received: from mail-io1-f42.google.com ([209.85.166.42])
 by web2.default.djames.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <chris@64studio.com>) id 1kvhaa-0000Qc-8V
 for linux-um@lists.infradead.org; Sat, 02 Jan 2021 14:09:04 +0000
Received: by mail-io1-f42.google.com with SMTP id p187so20905283iod.4
 for <linux-um@lists.infradead.org>; Sat, 02 Jan 2021 06:09:04 -0800 (PST)
MIME-Version: 1.0
References: <0c7b460e-1929-bf42-2ade-f99f97d45428@gmail.com>
In-Reply-To: <0c7b460e-1929-bf42-2ade-f99f97d45428@gmail.com>
From: Christopher Obbard <chris@64studio.com>
Date: Sat, 2 Jan 2021 14:08:52 +0000
Message-ID: <CAP03Xep=BNW_K4S5QNLOmgvzMK4yr=Y2P_qYOkK9MsU41jvJew@mail.gmail.com>
Subject: Re: [PATCH] um: Fix null pointer dereference when parsing ubd
 commandline arguments
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
To: Joshua Hawking <joshuahawking1@gmail.com>
Cc: linux-um@lists.infradead.org

Hi Joshua,
See http://lists.infradead.org/pipermail/linux-um/2020-December/000983.html
this patch hasn't yet been applied to linux-next, it will probably
arrive for 5.11rc2

Thanks!
Chris

On Sat, 2 Jan 2021 at 14:04, Joshua Hawking <joshuahawking1@gmail.com> wrote:
>
> From: Adam Watson (aw414141@gmail.com)
>
> When passing one or two arguments to ubd during UML setup - i.e.
> ubd0=File or ubd0=File,Backing_File - the parsing code introduced in commit
> ef3ba87cb7c9 ("um: ubd: Set device serial attribute from cmdline") does
> not check
> whether strsep consumed the entire string without finding a delimeter
> last time
> it was called (and so has set str to NULL, causing the next output of strsep
> on that string to be NULL) before attempting to dereference the output of it
> inside the if statements. For example, with two arguments (and only 1
> comma/colon), serial will be NULL, and (*serial == '\0') causes a null
> pointer
> dereference.
>
> Signed-off-by: Adam Watson (aw414141@gmail.com)
> Signed-off-by: Joshua Hawking (joshuahawking1@gmail.com)
> Tested-by: Joshua Hawking (joshuahawking1@gmail.com)
> Fixes: ef3ba87cb7c9 ("um: ubd: Set device serial attribute from cmdline")
> ---
> --- b/arch/um/drivers/ubd_kern.c    2021-01-02 13:13:55.995018942 +0000
> +++ a/arch/um/drivers/ubd_kern.c    2021-01-02 13:16:16.847023905 +0000
> @@ -375,11 +375,11 @@ break_loop:
>          file = NULL;
>
>      backing_file = strsep(&str, ",:");
> -    if (*backing_file == '\0')
> +    if (backing_file && *backing_file == '\0')
>          backing_file = NULL;
>
>      serial = strsep(&str, ",:");
> -    if (*serial == '\0')
> +    if (serial && *serial == '\0')
>          serial = NULL;
>
>      if (backing_file && ubd_dev->no_cow) {
>
>
>
>
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

