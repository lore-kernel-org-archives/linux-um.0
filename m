Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1YwYVq-00066T-7u
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 16:12:30 +0000
Received: from mail-vn0-f46.google.com ([209.85.216.46])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YwYVl-0000LD-6A
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 May 2015 16:12:30 +0000
Received: by vnbg7 with SMTP id g7so4033170vnb.12
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 24 May 2015 09:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1432473834-26391-1-git-send-email-hwhilse@gmail.com>
References: <1432473834-26391-1-git-send-email-hwhilse@gmail.com>
Date: Sun, 24 May 2015 18:12:19 +0200
Message-ID: <CAFLxGvyOANSecAV+paVqir17VcaCvWWYXiv6VTSWUni8yeXxHg@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] um: handle GCC 5.x like GCC 4.x
To: Hans-Werner Hilse <hwhilse@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, May 24, 2015 at 3:23 PM, Hans-Werner Hilse <hwhilse@gmail.com> wrote:
> Compiler compatibility macros were conditionally defined based on
> the compiler version. The it tested __GNUC__, but compared it to
> a maximum value of 4, breaking compilation on now current GCC 5.x.
> Thus, the check is extended to check for version 4.x and beyond.
>
> Signed-off-by: Hans-Werner Hilse <hwhilse@gmail.com>
> ---
>  arch/um/include/shared/init.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/include/shared/init.h b/arch/um/include/shared/init.h
> index b3906f8..ecdec48 100644
> --- a/arch/um/include/shared/init.h
> +++ b/arch/um/include/shared/init.h
> @@ -54,7 +54,7 @@ typedef void (*exitcall_t)(void);
>  #endif
>
>  #else
> -#if __GNUC__ == 4
> +#if __GNUC__ >= 4
>  # define __used                        __attribute__((__used__))
>  #endif
>  #endif

Hmm, instead of continue with that hack it would be much nicer to get rid
of the copy&pasted __user define.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

