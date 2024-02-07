Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5BCC4828D
	for <linux-um@archiver.kernel.org>; Wed,  7 Feb 2024 00:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=baJvcfh2d5K+Em7xs4mnjX+k4FKta+zMPcd+Ztd7ZXw=; b=vcez5hXM7qJUUBHfwhAPmODlGD
	zv3DVM3JkVgPBAccQZs2yJg886UVmX8MxLdjpSOCR98GSQQlfJZ8d2HcByFBjC3NiH6EqkIumLWpS
	KMMQ8NyvRbs5pBUqMiH0DsfSo/wxTfTFys+/Uv1Yhsqd9iZWuahzyKsuYBO74G69ms3oR1GVVU14i
	03vRxFdA6LHGmc5jJzl3+9GY0uBepJ4W0yX7KfEXUTn5nGKi5pZ5rGCfEffAosg1Qfr3/Y65zxK7W
	gKbwMkPhmmhWR259pJwA/jyskyKTmawg+vgwom4CnB9r3WmelopNFYdLEX0gpmzTzpNToXasGBPT7
	U1uza65Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXWAS-00000009IqN-48j4;
	Wed, 07 Feb 2024 00:52:00 +0000
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXWAP-00000009Iow-2W3u
	for linux-um@lists.infradead.org;
	Wed, 07 Feb 2024 00:51:58 +0000
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-363b2cc93a8so213525ab.3
        for <linux-um@lists.infradead.org>; Tue, 06 Feb 2024 16:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707267115; x=1707871915; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=baJvcfh2d5K+Em7xs4mnjX+k4FKta+zMPcd+Ztd7ZXw=;
        b=ORe5/nDMit0Bemr0+ol0jE5DYLbm0gc2B0kfwb+HWqH3aT+/8jtdxtSYVqJNae7140
         Hfmv492idCCoDdHavWAcLMb2wLFmN7Ms7BK3kNBBd/f2XW+X3uf6H23JKWs2Z0P1yO0B
         uiJylwOkzZgf49jDAoGk4iMybvTl2pm+NDODXGPsy18Y2KjQJ+zon/aqTd2AMvPTglU2
         kurMj0sc+zkpukoP3ponCcrAH9NM+8Wj6uSXs5PRDlKMXZz0SYEm4GPU2phbw1Ae24od
         x2tMCaHqHfDVs5uRAIFrAaPAJTnEj3yuywhYkpdlKBj+rFeZAVZdpSVmBxN6X4tOxTju
         w5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707267115; x=1707871915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baJvcfh2d5K+Em7xs4mnjX+k4FKta+zMPcd+Ztd7ZXw=;
        b=v/io0l9BJ2ITJ450CWdpjXi5Nr4e/OZV5QYhOvB1R6NimJZ12SM1zY3Sr0pNivHr6F
         xCvK2b5lIo/VALC5W3ytY3pva/Wp2g8pG/pfZibkiCgopr9A128Rj1ctEPB/9XgGdx9z
         5KqORl/AT3edK124gN2M53zD7MANTMCnnqKYhEJ1/pI92oQ4SczS2HXjxH3DHoOnwteW
         vjXxJjMCYD6RWbFRtJA/rTN8fO6Fu+GNWmRTeU7l+T2+a6lhrv0skN3TY3HK/EOospGV
         bUF5Rar5V5hBMM4iKQhFDEOCU7MMoYK4yvtwIx8UzKrTu+PAo0BRpm/smSyjXbyYPUyQ
         zYIA==
X-Gm-Message-State: AOJu0YzlQejXcOgEXNTosn/8odmDANA9cJDwVyu2B8B6aye2Vy/QXUSA
	Incs3YuJBSerQDTuY/QO+dtxIYkObJwQpmPK4fhvmKsQCWYZbBtazzzXymYcHw==
X-Google-Smtp-Source: AGHT+IGa9tcSPup65Y2Ws5SFq33Iafx0c5ApEjnuekYBaJ/6NAEsvxGWsB8LTJVVfveSZlywMiHiZg==
X-Received: by 2002:a92:dc10:0:b0:363:d953:a129 with SMTP id t16-20020a92dc10000000b00363d953a129mr1746208iln.25.1707267115441;
        Tue, 06 Feb 2024 16:51:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWpfl7GfkjIT0OB4pGx9trasISF1+iPcKlXo1qDPQknWfHTqtIbJi2f5hVj0rQc5zx9SI2rbEy6dlI9jc0ym4OplbpgDs0c7/V1T1zwDOvK54r0fHyUQYCMYBtEJr44LRlMYz+c/W8ayPxf/rYquE/tE3ohp4I479wCwJV0w7YtikLrgny0+iT9LQUzB/lEx6BODMPoCybksTOYvFpsH05O2AzufbmZVubZKjt5z6tJmnssldAWpRywZv6mKuApFCNvglLZPnHE0HTHGrcySkGu7JKK8flu97ZuctM3Bm27WC3HTyplvO9zmh7HfkHjsmaulEzmwvz2lNdR6SbFZsn0WwNqpr//Tc+L225b1ybsDJD2idpsa/RV7gMuPgqFuvLAi9oRCnY15hprI6LDu6uaJYeFUiTucUuSJWVzgGO1f7rKa3Oo4T9P
Received: from google.com (20.10.132.34.bc.googleusercontent.com. [34.132.10.20])
        by smtp.gmail.com with ESMTPSA id s5-20020a92cc05000000b00363c8e5a1a1sm28357ilp.44.2024.02.06.16.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 16:51:54 -0800 (PST)
Date: Wed, 7 Feb 2024 00:51:51 +0000
From: Justin Stitt <justinstitt@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>, kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH v3 3/4] string: Allow 2-argument strscpy_pad()
Message-ID: <20240207005151.lyrtgqd4wekolwe7@google.com>
References: <20240206142027.make.107-kees@kernel.org>
 <20240206142221.2208763-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206142221.2208763-3-keescook@chromium.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_165157_684846_1C514FC9 
X-CRM114-Status: GOOD (  19.92  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Tue, Feb 06, 2024 at 06:22:18AM -0800, Kees Cook wrote:
> Similar to strscpy(), update strscpy_pad()'s 3rd argument to be
> optional when the destination is a compile-time known size array.

This patch is diff'd against Patch 1/4 in this series, right? I wonder
why you split them up. If I hadn't literally just read that patch I
would be mildly confused.

I suppose one reason may be that 1/4 is a standalone change with a high
percentage chance of landing whilst this overloading magic may not land
as easily?

At any rate,
Reviewed-by: Justin Stitt <justinstitt@google.com>

>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/string.h | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 79b875de615e..9bd421ad92a4 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -79,6 +79,10 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>  	sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst))
>  #define __strscpy1(dst, src, size)	sized_strscpy(dst, src, size)
>
> +#define __strscpy_pad0(dst, src, ...)	\
> +	sized_strscpy_pad(dst, src, sizeof(dst) + __must_be_array(dst))
> +#define __strscpy_pad1(dst, src, size)	sized_strscpy_pad(dst, src, size)
> +
>  /**
>   * strscpy - Copy a C-string into a sized buffer
>   * @dst: Where to copy the string to
> @@ -104,6 +108,18 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>  #define strscpy(dst, src, ...)	\
>  	CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>
> +#define sized_strscpy_pad(dest, src, count)	({			\
> +	char *__dst = (dest);						\
> +	const char *__src = (src);					\
> +	const size_t __count = (count);					\
> +	ssize_t __wrote;						\
> +									\
> +	__wrote = sized_strscpy(__dst, __src, __count);			\
> +	if (__wrote >= 0 && __wrote < __count)				\
> +		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> +	__wrote;							\
> +})
> +
>  /**
>   * strscpy_pad() - Copy a C-string into a sized buffer
>   * @dest: Where to copy the string to
> @@ -124,17 +140,8 @@ ssize_t sized_strscpy(char *, const char *, size_t);
>   * * The number of characters copied (not including the trailing %NULs)
>   * * -E2BIG if count is 0 or @src was truncated.
>   */
> -#define strscpy_pad(dest, src, count)	({			\
> -	char *__dst = (dest);						\
> -	const char *__src = (src);					\
> -	const size_t __count = (count);					\
> -	ssize_t __wrote;						\
> -									\
> -	__wrote = strscpy(__dst, __src, __count);			\
> -	if (__wrote >= 0 && __wrote < __count)				\
> -		memset(__dst + __wrote + 1, 0, __count - __wrote - 1);	\
> -	__wrote;							\
> -})
> +#define strscpy_pad(dst, src, ...)	\
> +	CONCATENATE(__strscpy_pad, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
> --
> 2.34.1
>

Thanks
Justin

